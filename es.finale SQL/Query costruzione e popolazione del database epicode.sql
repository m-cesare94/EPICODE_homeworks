/**
Creazione Datbase "Neue Erfahrungen"
**/

CREATE DATABASE NeueErfahrungenDB

/*
Creazione Tabelle
*/

--Tabella contenente i vari procuratori che rappresentano gli artisti
CREATE TABLE Agent (
AgentKey INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
Commission INT
)

--Tabella che contiene i vari artisti che hanno esposto (attualmente o in passato) nella galleria
CREATE TABLE Artist (
ArtistKey INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
AgentKey INT,
CONSTRAINT NeueErfahrungenDB_Agent_AgentKey
	FOREIGN KEY	(AgentKey)
	REFERENCES	 Agent (AgentKey)
)

--Generi (tipo) di opere d'arte
CREATE TABLE Genre (
GenreKey INT PRIMARY KEY,
EnglishGenreName VARCHAR(20)
)


--Sottogenere (tipo) di generi
CREATE TABLE SubGenre (
SubGenreKey INT PRIMARY KEY,
EnglishSubGenreName VARCHAR(20),
GenreKey INT,
CONSTRAINT NeueErfahrungenDB_Genre_GenreKey
	FOREIGN KEY	(GenreKey)
	REFERENCES	 Genre (GenreKey)
)

--Tabella contenente tutte le opere d'arte esposte (attualmente o precedentemente) in galleria
CREATE TABLE Artset (
Namework VARCHAR(50) PRIMARY KEY,
DataMade DATE,
ArtistKey INT,
SubGenreKey INT,
CONSTRAINT NeueErfahrungenDB_Artist_ArtistKey
	FOREIGN KEY	(ArtistKey)
	REFERENCES	 Artist (ArtistKey),
CONSTRAINT NeueErfahrungenDB_SubGenre_SubGenreKey
	FOREIGN KEY	(SubGenreKey)
	REFERENCES	 SubGenre (SubGenreKey)
)

--Cronologia dei clienti che hanno acquistato presso l' Atelier
CREATE TABLE Clients (
ClientID INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
)

--Tabella contenente la cronologia di tutti gli eventi organizzati dalla galleria
CREATE TABLE Eventart (
EventDate DATE PRIMARY KEY,
EventName VARCHAR(50),
)

--Tabella contenente i dettagli di vendita di ogni singola opera
CREATE TABLE ArtSetSellingDetail (
NameWork VARCHAR(50) PRIMARY KEY,
SoldStatus VARCHAR(3) CHECK (SoldStatus = 'yes' OR SoldStatus = 'no'), --NON ESISTE BOOL TYPE --> INSERIAMO UN CHECK
StartingPrice DECIMAL(8,2),
FinalPrice DECIMAL(8,2),
EventDate Date,
OwnerID INT,
CONSTRAINT NeueErfahrungenDB_Artset_NameWork
	FOREIGN KEY	(NameWork)
	REFERENCES	 Artset (NameWork),
CONSTRAINT NeueErfahrungenDB_Eventart_EventDate
	FOREIGN KEY	(EventDate)
	REFERENCES	 Eventart (EventDate),
CONSTRAINT NeueErfahrungenDB_Clients_ClientID
	FOREIGN KEY (OwnerID)
	REFERENCES	 Clients (ClientID)
)

/*
Popoliamo Le Tabelle
*/

INSERT INTO Agent
VALUES	(10, 'Sophie', 'Toxy', 4),
		(11, 'Mark','Vorevsky', 6),
		(12, 'Miky','Red', 6),
		(13, 'Kathrin','Lehmann', 9), 
		(14, 'Kyler','Stumpf', 7);

INSERT INTO Artist
VALUES	(20, 'Ola', 'Hansen', 10),
		(21, 'Tavi', 'Svendon', 11),
		(22, 'Kari', 'Patterson', 11),
		(23, 'Rudi', 'Sauer', 12),
		(24, 'Heinz', 'Grosse', 10),
		(25, 'Merten', 'Meier', 14),
		(26, 'Elisa', 'Weis', 14),
		(27, 'Wilfreda', 'Leitz', 13),
		(28, 'Zensi', 'Schlimme', 12),
		(29, 'Marco', 'Cesare', 10),
		(30, 'Francesca', 'Rossi', 11),
		(31, 'Aloisia', 'Horn', 12);

INSERT INTO Genre
VALUES	(1,'Photography'),
		(2, 'Drawing'),
		(3, 'Scultupre');

INSERT INTO SubGenre
VALUES	(100, 'BlackeGrey', 1),
		(101, 'ArtisticPortrait', 1),
		(102, 'StreetPhotography', 1),
		(103, 'PopArt',2),
		(104, 'ModernArt', 2),
		(105, 'ArtNoveau', 2),
		(106, 'Cubism', 2),
		(107, 'Realism', 2),
		(108, 'Abstract', 3),
		(109, 'NeoRealism', 3),
		(110, 'Modern', 3);

INSERT INTO Artset
VALUES	('Miracles of Pleasure', '2022-01-18', 31, 107),
		('Invisible Mistake', '2021-12-13', 30, 106),
		('Weekend', '2023-05-30', 21, 103),
		('Guiltless Friendship','2022-04-27',22, 103),
		('Tranquil Slave', '2022-05-13', 22, 107),
		('Chain of Perseverance', '2022-12-21', 27, 110),
		('Scintillating Laughter', '2023-06-23', 24, 106),
		('Celebrated Tradition', '2023-06-19', 22, 109),
		('Equable Feeling', '2023-05-24', 21, 110),
		('False Motions', '2023-02-07', 26, 107),
		('Wandering Relief', '2022-06-14', 30, 105),
		('Outrageous Moments', '2022-10-07', 29, 102),
		('False Cobweb', '2023-01-11', 23, 106),
		('Anchored Tradition', '2021-12-03', 24, 104),
		('Tawdry Blame', '2022-02-14', 25, 109),
		('Fluttering Slave', '2022-03-30', 26, 104),
		('Drive', '2022-04-06', 26, 105),
		('Climate', '2023-03-17', 29, 101),
		('Voiceless Price', '2023-03-01', 20, 104),
		('Enlightened Preparation', '2022-06-14', 21, 106),
		('Dynamic Cobweb', '2022-10-12', 25, 109),
		('Union of Passion', '2023-01-20', 28, 105),
		('Charity of Philosophy', '2022-08-15', 31, 107),
		('Tolerance of Curiosity', '2022-06-10', 23, 106),
		('Support of Religion', '2022-01-26', 20, 106);

INSERT INTO Clients
VALUES	(10, 'Danica', 'Cooke'),
		(11, 'Valentina', 'Todd'),
		(12, 'Riley', 'Bartlett'),
		(13, 'Zariah', 'Thomas'),
		(14, 'Angel', 'Hogan'),
		(15, 'Jamiya', 'Preston'),
		(16, 'Karissa', 'Bowman'),
		(17, 'Alejandra', 'Chung'),
		(18, 'Ella', 'Murray'),
		(19, 'Noelle', 'Lopez'),
		(20, 'Sierra', 'Meyer'),
		(21, 'Allisson', 'Faulkner');

INSERT INTO Eventart
VALUES	('2022-01-13', 'New Gallery Neue Erfahrungen Big Opening'),
		('2022-02-17', 'NE: Art in Covid Era'),
		('2022-03-13', 'NE: Art in Covid Era II'),
		('2022-04-19', 'NE: Bloom'),
		('2022-05-13', 'NE: WIlkommen Internationale Kunster'),
		('2022-06-13', 'NE: June Summer Night'),
		('2022-10-01', 'NE: Autumn Reopening'),
		('2022-11-11', 'NE: Berlin History'),
		('2022-12-18', 'NE: Weihnachten'),
		('2023-01-14', 'NE: New Year, New Experiences'),
		('2023-02-15', 'NE: Kunst trifft Mode'),
		('2023-03-15', 'NE: Kunst Trifft Mode II'),
		('2023-04-23', 'NE: Bloom 2023'),
		('2023-05-15', 'NE: Before Summer'),
		('2023-06-03', 'NE: Neue Erfahrungen Last Call');

INSERT INTO ArtSetSellingDetail
VALUES	('Miracles of Pleasure','yes', 40000.00, 47000.00, '2022-10-01', 11),
		('Invisible Mistake','yes', 20000.00, 55000.00, '2022-02-17', 15),
		('Weekend', 'no', NULL, NULL, NULL, NULL),
		('Guiltless Friendship', 'yes', 75000.00, 150000.00, '2022-11-11', 15),
		('Tranquil Slave', 'yes', 12000.00, 22000.00, '2022-05-13', 18),
		('Chain of Perseverance', 'yes', 40000.00, 50000.00, '2023-04-23', 14),
		('Scintillating Laughter', 'no', NULL, NULL, NULL, NULL),
		('Celebrated Tradition', 'no', NULL, NULL, NULL, NULL),
		('Equable Feeling', 'no', NULL, NULL, NULL, NULL),
		('False Motions', 'yes', 100000.00, 255000.00, '2023-06-03', 12),
		('Wandering Relief', 'no', NULL, NULL, NULL, NULL),
		('Outrageous Moments', 'yes', 45000.00, 60000.00, '2022-12-18', 16),
		('False Cobweb', 'yes', 80000.00, 278000.00, '2023-03-15', 20),
		('Anchored Tradition', 'yes', 35000.00, 93000.00, '2022-01-13', 19),
		('Tawdry Blame', 'no', NULL, NULL, NULL, NULL),
		('Fluttering Slave', 'no', NULL, NULL, NULL, NULL),
		('Drive', 'yes', 55000.00, 110000.00, '2022-10-01', 21),
		('Climate', 'yes',35000.00, 55000.00, '2023-05-15', 17),
		('Voiceless Price', 'no', NULL, NULL, NULL, NULL),
		('Enlightened Preparation', 'yes', 35000.00, 88000.00, '2023-02-15', 13),
		('Dynamic Cobweb', 'no', NULL, NULL, NULL, NULL),
		('Union of Passion', 'yes', 100000.00, 275000.00, '2023-03-15', 16),
		('Charity of Philosophy', 'no', NULL, NULL, NULL, NULL),
		('Tolerance of Curiosity', 'yes',65000.00, 90000.00, '2022-11-11', 10),
		('Support of Religion', 'yes', 25000.00, 180000.00, '2022-10-01', 18);
