--Lista di query del database

-- #1 Query che riporta il numero di artisti per ogni agente
SELECT	ag.AgentKey		AS IDAgente,
		CONCAT(ag.Firstname, ' ', ag.lastname) AS NameAgent,
		COUNT(ar.AgentKey)	AS TotalArtistRapresented
		
FROM Agent ag
JOIN Artist ar	--potremmo usare una left join nel caso in cui un agente avesse 0 artisti,
				--essendo il db costruito apposta, è un ipotesi che non dobbiamo tenere a mente
ON ag.AgentKey = ar.AgentKey
GROUP BY ag.AgentKey, CONCAT(ag.Firstname, ' ', ag.lastname)


---------------------------------------------------------------------------------------------------

-- #2 Totale opere in database
SELECT COUNT(*)		AS TotalWorks
FROM Artset

---------------------------------------------------------------------------------------------------

-- #3 Totale opere suddivise per Genere
SELECT	z.GenreKey			AS ID,
		z.EnglishGenreName	AS Genre,
		COUNT(x.namework)*100/(SELECT COUNT(*) FROM Artset)	AS 'Total%'
FROM Artset x
JOIN SubGenre y
ON x.SubGenreKey = y.SubGenreKey
JOIN Genre z
ON y.GenreKey = z.GenreKey
GROUP BY z.GenreKey, z.EnglishGenreName
ORDER BY z.EnglishGenreName

---------------------------------------------------------------------------------------------------

-- #4 Denormalizziamo la tabella artset e artsetselling details
SELECT *
FROM Artset x
JOIN ArtSetSellingDetail y
ON x.Namework = y.NameWork
WHERE y.SoldStatus = 'yes' -- primo processo opzionale di "scrematura del dato", la consegna sopracitata non richiede il WHERE

-----------------------------------------------------------------------------------------------------

-- #5 Individuiamo quegli eventi dove è stata venduta più di un opera
SELECT	x.EventDate			AS EventDate,
		y.EventName			AS EventName,
		COUNT(x.Namework)	AS TotalWorksSold
FROM ArtSetSellingDetail x
JOIN Eventart y
ON x.EventDate = y.EventDate
Where SoldStatus = 'yes'
GROUP BY x.EventDate, y.EventName
HAVING COUNT(x.NameWork) > 1
ORDER BY EventDate

-------------------------------------------------------------------------------------------------------

--  #6 Tutte le persone che collaborano/lavorano con la galleria
SELECT	ArtistKey	AS ID,
		FirstName,
		LastName,
		1			AS Riconoscitore
		
FROM Artist
UNION ALL
SELECT	Agentkey	AS ID,
		FirstName,
		LastName,
		2			AS Riconoscitore
		
FROM Agent

--------------------------------------------------------------------------------------------------------

-- #7 le opere vendute negli ultimi 3 eventi
SELECT*
FROM ArtSetSellingDetail
WHERE EventDate IN (SELECT TOP 3 EventDate
					FROM Eventart
					ORDER BY EventDate DESC)

----------------------------------------------------------------------------------------------------------

--#8 Query che riporta la classifica degli artisti con più vendite
SELECT	x.ArtistKey									AS ID,
		CONCAT(x.FirstName, ' ',x.LastName)			AS Artist,
		SUM(z.FinalPrice)							AS Total_Profit,
		COUNT(y.ArtistKey)							AS NumberofWorksSold,
		FLOOR(SUM(z.FinalPrice)/COUNT(y.ArtistKey))	AS AVG_EarnbyArtist,
		SUM(z.FinalPrice)-SUM(z.StartingPrice)		AS ProfitfromAuction
		
FROM Artist x
LEFT JOIN Artset y
ON x.ArtistKey = y.ArtistKey
LEFT JOIN ArtSetSellingDetail z
ON y.Namework = z.NameWork
WHERE z.SoldStatus = 'yes'
GROUP BY x.ArtistKey, CONCAT(x.FirstName, ' ',x.LastName)
ORDER BY Total_Profit DESC

-----------------------------------------------------------------------------------------------------------

--#9 Query che riporta la classifica degli agenti con più ricavo dalle percentuali
SELECT	x.AgentKey									AS ID,
		CONCAT(x.FirstName, ' ',x.LastName)			AS Agent,
		FLOOR(SUM(w.FinalPrice)*x.Commission/100)	AS Total_Profit
FROM Agent x
LEFT JOIN Artist y
ON x.AgentKey = y.AgentKey
LEFT JOIN Artset z
ON y.ArtistKey = z.ArtistKey
LEFT JOIN ArtSetSellingDetail w
ON z.Namework = w.NameWork
WHERE w.SoldStatus = 'yes'
GROUP BY x.AgentKey, x.Commission,  CONCAT(x.FirstName, ' ',x.LastName)
ORDER BY Total_Profit DESC

----------------------------------------------------------------------------------------------------------

-- #10 Troviamo il cliente
SELECT x.NameWork,
		CONCAT(y.firstname, ' ', y.LastName)	AS Owner
FROM ArtSetSellingDetail x
JOIN Clients y
ON x.OwnerID = y.ClientID
WHERE	x.SoldStatus = 'yes'  
		-- ESEMPIO LOGICO --
		-- AND ClientID = 18 -> con questa condizione possiamo cercare specifici clienti e le opere che hanno acquistato
