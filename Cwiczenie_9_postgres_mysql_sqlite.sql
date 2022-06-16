CREATE DATABASE Geologia;

CREATE TABLE GeoEon(
	id_eon INT PRIMARY KEY,
	nazwa_eon VARCHAR(80)
);

CREATE TABLE GeoEra(
	id_era INT PRIMARY KEY,
	id_eon INT NOT NULL,
	nazwa_era VARCHAR(80)
);

ALTER TABLE GeoEra
ADD FOREIGN KEY (id_eon)
REFERENCES GeoEon(id_eon);

CREATE TABLE GeoOkres(
	id_okres INT PRIMARY KEY,
	id_era INT NOT NULL,
	nazwa_okres VARCHAR(80)
);

ALTER TABLE GeoOkres
ADD FOREIGN KEY (id_era)
REFERENCES GeoEra(id_era);

CREATE TABLE GeoEpoka
(
	id_epoka INT PRIMARY KEY,
	id_okres INT NOT NULL,
	nazwa_epoka VARCHAR(80)
);

ALTER TABLE GeoEpoka
ADD FOREIGN KEY (id_okres)
REFERENCES GeoOkres(id_okres);

CREATE TABLE GeoPietro
(
	id_pietro INT PRIMARY KEY,
	id_epoka INT NOT NULL,
	nazwa_pietro VARCHAR(80)
);

ALTER TABLE GeoPietro
ADD FOREIGN KEY (id_epoka)
REFERENCES GeoEpoka(id_epoka);

-- dodanie rekordow do tabeli GeoEon
INSERT INTO GeoEon VALUES (1, 'Fanerozoik');

-- dodanie rekordow do tabeli GeoEra
INSERT INTO GeoEra VALUES
(1, 1, 'Kenozoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Paleozoik');

-- dodanie rekordow do tabeli GeoOkres
INSERT INTO GeoOkres VALUES
(1, 1, 'Czwartorzęd'), (2, 1, 'Neogen'), (3, 1, 'Paleogen'),
(4, 2, 'Kreda'), (5, 2, 'Jura'), (6, 2, 'Trias'),
(7, 3, 'Perm'), (8, 3, 'Karbon'), (9, 3, 'Dewon'), (10, 3, 'Sylur'), (11, 3, 'Ordowik'), (12, 3, 'Kambr');

-- dodawanie rekordow do tabeli GeoEpoka
INSERT INTO GeoEpoka VALUES
(1, 1, 'Holocen'), (2, 1, 'Plejstocen'),
(3, 2, 'Pliocen'), (4, 2, 'Miocen'),
(5, 3, 'Oligocen'), (6, 3, 'Eocen'), (7, 3, 'Paleocen'),
(8, 4, 'Kreda Górna'), (9, 4, 'Kreda Dolna'),
(10, 5, 'Jura Górna'), (11, 5, 'Jura Środkowa'), (12, 5, 'Jura Dolna'),
(13, 6, 'Trias Górny'), (14, 6, 'Trias Środkowy'), (15, 6, 'Trias Dolny'),
(16, 7, 'Loping'), (17, 7, 'Gwadelup'), (18, 7, 'Cisural'),
(19, 8, 'Pensylwan'), (20, 8, 'Missisip'),
(21, 9, 'Dewon Górny'), (22, 9, 'Dewon Środkowy'), (23, 9, 'Dewon Dolny'),
(24, 10, 'Przydol'), (25, 10, 'Ludlow'), (26, 10, 'Wenlok'), (27, 10, 'Landower'),
(28, 11, 'Ordowik Górny'), (29, 11, 'Ordowik Środkowy'), (30, 11, 'Ordowik Dolny'),
(31, 12, 'Furong'), (32, 12, 'Miaoling'), (33, 12, 'Oddział 2'), (34, 12, 'Terenew');

-- dodanie rekordow do tabeli GeoPietro
INSERT INTO GeoPietro VALUES
(1, 1, 'Megalaj'), (2, 1, 'Northgrip'), (3, 1, 'Grenland'),
(4, 2, 'Plejstocen górny'), (5, 2, 'Jon'), (6, 2, 'Chiban'), (7, 2, 'Kalabr'), (8, 2, 'Gelas'),
(9, 3, 'Piacent'), (10, 3, 'Zankl'),
(11, 4, 'Messyn'), (12, 4, 'Torton'), (13, 4, 'Serrawal'), (14, 4, 'Lang'), (15, 4, 'Burdygał'), (16, 4, 'Akwitan'),
(17, 5, 'Szat'), (18, 5, 'Rupel'),
(19, 6, 'Priabon'), (20, 6, 'Barton'), (21, 6, 'Lutet'), (22, 6, 'Iprez'),
(23, 7, 'Tanet'), (24, 7, 'Zeland'), (25, 7, 'Dan'),
(26, 8, 'Mastrycht'), (27, 8, 'Kampan'), (28, 8, 'Santon'), (29, 8, 'Koniak'), (30, 8, 'Turon'), (31, 8, 'Cenoman'),
(32, 9, 'Alb'), (33, 9, 'Apt'), (34, 9, 'Barrem'), (35, 9, 'Hoteryw'), (36, 9, 'Walanżyn'), (37, 9, 'Berias'),
(38, 10, 'Tyton'), (39, 10, 'Kimeryd'), (40, 10, 'Oksford'),
(41, 11, 'Kelowej'), (42, 11, 'Baton'), (43, 11, 'Bajos'), (44, 11, 'Aalen'),
(45, 12, 'Toark'), (46, 12, 'Pliensbach'), (47, 12, 'Synemur'), (48, 12, 'Hetang'),
(49, 13, 'Retyk'), (50, 13, 'Noryk'), (51, 13, 'Karnik'),
(52, 14, 'Ladyn'), (53, 14, 'Anizyk'),
(54, 15, 'Olenek'), (55, 15, 'Ind'),
(56, 16, 'Czangszing'), (57, 16, 'Wucziaping'),
(58, 17, 'Kapitan'), (59, 17, 'Word'), (60, 17, 'Road'),
(61, 18, 'Kungur'), (62, 18, 'Artyńsk'), (63, 18, 'Sakmar'), (64, 18, 'Aselsk'),
(65, 19, 'Gżel'), (66, 19, 'Kasimow'), (67, 19, 'Moskow'), (68, 19, 'Baszkir'),
(69, 20, 'Serpuchow'), (70, 20, 'Wizen'), (71, 20, 'Turnej'),
(72, 21, 'Famen'), (73, 21, 'Fran'),
(74, 22, 'Żywet'), (75, 22, 'Eifel'),
(76, 23, 'Ems'), (77, 23, 'Prag'), (78, 23, 'Lochkow'),
(79, 24, NULL),
(80, 25, 'Ludford'), (81, 25, 'Gorst'),
(82, 26, 'Homer'), (83, 26, 'Szejnwud'),
(84, 27, 'Telicz'), (85, 27, 'Aeron'), (86, 27, 'Ruddan'),
(87, 28, 'Hirnant'), (88, 28, 'Kat'), (89, 28, 'Sandb'),
(90, 29, 'Darriwil'), (91, 29, 'Daping'),
(92, 30, 'Flo'), (93, 30, 'Tremadok'),
(94, 31, 'Piętro 10'), (95, 31, 'Diangszan'), (96, 31, 'Paib'),
(97, 32, 'Gużang'), (98, 32, 'Drum'), (99, 32, 'Wuliuan'),
(100, 33, 'Piętro 4'), (101, 33, 'Piętro 3'), (102, 34, 'Piętro 2'), (103, 34, 'Fortun');	
	
	
-- 1. Tabela Zdenormalizowana GeoTabela

CREATE TABLE GeoTabela AS
(SELECT * FROM GeoPietro 
 NATURAL JOIN GeoEpoka 
 NATURAL JOIN GeoOkres 
 NATURAL JOIN GeoEra 
 NATURAL JOIN GeoEon);
 
ALTER TABLE GeoTabela
ADD PRIMARY KEY (id_pietro);

SELECT *
FROM GeoTabela

-- III. Tabele Obliczeniowe

CREATE TABLE Dziesiec(cyfra int, bit int);

INSERT INTO Dziesiec VALUES
	(0, 0000000),
	(1, 0000001),
	(2, 0000010),
	(3, 0000011),
	(4, 0000100),
	(5, 0000101),
	(6, 0000110),
	(7, 0000111),
	(8, 0001000),
	(9, 0001001)
	

CREATE TABLE Milion(liczba int,cyfra int, bit int);

INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a6.cyfra AS cyfra, a6.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec
a6;

SELECT * FROM Milion ORDER BY liczba;

-- XX. Indeksowanie, testy wydajności

-- 1. Zapytanie pierwsze (1 ZL)
EXPLAIN (FORMAT JSON)
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON
(mod(Milion.liczba,68)=(GeoTabela.id_pietro));

-- 2. Zapytanie drugie (2 ZL)
EXPLAIN (FORMAT JSON)
SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON
(mod(Milion.liczba,68)=GeoPietro.id_pietro) NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon;

-- Zapytanie trzecie (3 ZG)
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68)=
(SELECT id_pietro FROM GeoTabela WHERE mod(Milion.liczba,68)=(id_pietro));

-- Zapytanie czwarte (4 ZG)
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba, 68) IN
(SELECT GeoPietro.id_pietro FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon);

CREATE INDEX idx_geoera ON GeoEra (id_eon);
CREATE INDEX idx_geookres ON GeoOkres (id_era);
CREATE INDEX idx_geoepoka ON GeoEpoka (id_okres);
CREATE INDEX idx_geopietro ON GeoPietro (id_epoka);

CREATE INDEX idx_milion ON Milion (liczba);

CREATE INDEX idx_geotabela ON GeoTabela (id_eon, id_era, id_okres, id_epoka);