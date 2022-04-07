-- tworzenie bazy danych
CREATE DATABASE firma;

USE firma;

-- tworzenie schematu 
CREATE SCHEMA rozliczenia;

-- tworzenie tabeli w schemacie
CREATE TABLE rozliczenia.pracownicy(
	id_pracownika CHAR(6) PRIMARY KEY NOT NULL,
	imie NVARCHAR(40) NOT NULL,
	nazwisko NVARCHAR(40) NOT NULL,
	adres NVARCHAR(50) NOT NULL,
	telefon CHAR(12)
);

CREATE TABLE rozliczenia.godziny(
	id_godziny CHAR(6) PRIMARY KEY NOT NULL,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika CHAR(6) NOT NULL
);

CREATE TABLE rozliczenia.pensje(
	id_pensji CHAR(6) PRIMARY KEY NOT NULL,
	stanowisko NVARCHAR(60) NOT NULL,
	kwota SMALLMONEY NOT NULL,
	id_premii CHAR(6)
);

CREATE TABLE rozliczenia.premie(
	id_premii CHAR(6) PRIMARY KEY NOT NULL,
	rodzaj VARCHAR(40),
	kwota SMALLMONEY
);

-- dodawanie kluczy obcych do tabel
--- w CREATE TABLE mozna dac CONSTRAINT FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy (id_pracownika);

-- CONSTRAINT FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii)
ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie (id_premii);

-- wypelnianie tabeli rekordami
-- rozliczenia.pracownicy

INSERT INTO rozliczenia.pracownicy VALUES
(1, 'Jan', 'Kowalski', 'ul. Jagodowa 30/10, Kraków', '790511775'),
(2, 'Stefan', 'Nowak', 'ul. Sezamkowa 100, Kraków', NULL),
(3, 'Natalia', 'Mazurek', 'ul. Akacjowa 10/3, Warszawa', '124744200'),
(4, 'Konrad', 'Bednarczyk', 'ul. S³owiañska 1/44, Lublin', '665122711'),
(5, 'Jaros³aw', 'Kowalczyk', 'ul. Jutrzenki 100/53, Wroc³aw', NULL),
(6, 'Sabina', 'WoŸniak', 'ul. Kasztanowa 1, Kraków', '857001995'),
(7, 'Beata', 'Grabowska', 'ul. Leœna 4, Olkusz', '451051966'),
(8, 'Arkadiusz', 'Romanowski', 'al. Adama Mickiewicza 19/12, Wieliczka', NULL),
(9, 'Aleksandra', 'Kosiñska', 'ul. Orzeszkowej 1/11, Kraków', '664391033'),
(10, 'Igor', 'Kalinowski', 'ul. Makowa 12, Kraków', '517590117');

SELECT * FROM rozliczenia.pracownicy ORDER BY imie, nazwisko;

-- DELETE FROM rozliczenia.pracownicy;

-- rozliczenia.godziny

INSERT INTO rozliczenia.godziny VALUES
(1, '2022-01-11', 152, 1),
(2, '2022-01-28', 160, 2),
(3, '2022-02-02', 190, 3),
(4, '2022-02-10', 100, 4),
(5, '2022-03-20', 174, 5),
(6, '2022-03-17', 90, 6),
(7, '2022-03-26', 202, 7),
(8, '2022-04-08', 155, 8),
(9, '2022-04-08', 160, 9),
(10, '2022-04-10', 188, 10);

SELECT * FROM rozliczenia.godziny;

-- rozliczenia.premie

INSERT INTO rozliczenia.premie VALUES
(1, 'Regulaminowa', 300),
(2, 'Uznaniowa', 500),
(3, NULL, NULL),
(4, 'Motywacyjna', 200),
(5, NULL, NULL),
(6, 'Regulaminowa', 100),
(7, 'Wynikowa', 1000),
(8, NULL, NULL),
(9, 'Uznaniowa', 450),
(10, 'Motywacyjna', 300);

SELECT * FROM rozliczenia.premie;

--rozliczenia.pensje

INSERT INTO rozliczenia.pensje VALUES
(1, 'Ksiêgowy', 5500, 1),
(2, 'Analityk Finansowy', 9800, 2),
(3, 'Programista', 12000, NULL),
(4, 'Sta¿ysta',  3400, 4),
(5, 'Dyrektor ds. Informatyki', 15000, NULL),
(6, 'Programista', 10500, 6),
(7, 'Administrator', 10000, 7),
(8, 'Ksiêgowy', 6000, NULL),
(9, 'Programista', 13200, 9),
(10, 'Kierownik ds. Promocji', 8400, 10);

SELECT * FROM rozliczenia.pensje;

-- zapytania SELECT
SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

-- zapytanie konwertujace date na dzien tygodnia i miesiac
SELECT data, DATEPART(dw, data) AS dzien_tygodnia, DATEPART(month, data) AS miesiac
FROM rozliczenia.godziny;

-- zmiana nazwy kolumny
EXEC sp_rename'rozliczenia.pensje.kwota', 'kwota_brutto';

-- dodanie kolumny kwota_netto 
ALTER TABLE rozliczenia.pensje
ADD kwota_netto AS (kwota_brutto*0.81);

SELECT * FROM rozliczenia.pensje;

-- ALTER TABLE rozliczenia.pensje
-- DROP COLUMN kwota_netto;

-- ALTER TABLE rozliczenia.pensje ALTER COLUMN kwota_netto SMALLMONEY;
