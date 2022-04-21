CREATE DATABASE firma;

CREATE SCHEMA ksiegowosc;

COMMENT ON DATABASE firma IS 'Baza danych firma przechowująca informacje na temat pracowników oraz ich szczegółowych wynagrodzeń';
COMMENT ON SCHEMA ksiegowosc IS 'Schemat ksiegowość w bazie danych firma';

-- Tworzenie tabeli w schemacie ksiegowość wraz z komentarzami do każdej tabeli i kolumny
CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika SMALLINT PRIMARY KEY NOT NULL,
	imie VARCHAR(40) NOT NULL,
	nazwisko VARCHAR(40) NOT NULL,
	adres VARCHAR(50) NOT NULL,
	telefon CHAR(12)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela pracownicy w schemacie ksiegowość przedstawia osoby zatrudnione w firmie.';
COMMENT ON COLUMN ksiegowosc.pracownicy.id_pracownika IS 'Kolumna przedstawiająca unikatowy numer przypisany każdemu pracownikowi (klucz główny tabeli).';
COMMENT ON COLUMN ksiegowosc.pracownicy.imie IS 'Kolumna przeznaczona na przechowywanie imion pracowników; typu varchar dla oszczędności pamięci.';
COMMENT ON COLUMN ksiegowosc.pracownicy.imie IS 'Kolumna przeznaczona na przechowywanie nazwisk pracowników; typu varchar dla oszczędności pamięci.';
COMMENT ON COLUMN ksiegowosc.pracownicy.adres IS 'Kolumna przechowująca adres pracownika; typ varchar.';
COMMENT ON COLUMN ksiegowosc.pracownicy.telefon IS 'Kolumna przechowująca numery telefonów do pracowników; stały rozmiar typu char, kolumna może przyjmować wartość NULL w poszczególnym rekordzie.';

CREATE TABLE ksiegowosc.godziny(
	id_godziny SMALLINT PRIMARY KEY NOT NULL,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika SMALLINT NOT NULL REFERENCES ksiegowosc.pracownicy (id_pracownika)
);

-- dodanie klucza obcego przez polecenie ALTER TABLE
/* ALTER TABLE ksiegowosc.godziny(
	ADD CONSTRAINT FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy (id_pracownika)
	);
*/

COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela godziny w schemacie ksiegowość przedstawia liczbę godzin przepracowanych przez danych pracowników w miesiącu, datę wpisu. Tabela jest połączona z tabelą ksiegowosc.pracownicy kluczem obcym id_pracownika (w celu jednoznaczej identyfikacji pracowników); jest to związek N:1 obowiązkowy po obu stronach.';
COMMENT ON COLUMN ksiegowosc.godziny.id_godziny IS 'Klucz główny tabeli.';
COMMENT ON COLUMN ksiegowosc.godziny.data IS 'Kolumna przechowująca datę w formacie YYYY-MM-DD.';
COMMENT ON COLUMN ksiegowosc.godziny.liczba_godzin IS 'Kolumna przechowująca liczbę godzin przepracowaną przez danego pracownika w miesiącu.';
COMMENT ON COLUMN ksiegowosc.godziny.id_pracownika IS 'Klucz obcy tabeli ksiegowosc.godziny przedstawiający unikalny numer pracownika.';

CREATE TABLE ksiegowosc.pensja(
	id_pensji SMALLINT PRIMARY KEY NOT NULL,
	stanowisko VARCHAR(60) NOT NULL,
	kwota MONEY NOT NULL
);

COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela pensja w schemacie ksiegowość przedstawia kwotę wynagrodzenia jaka jest przypisana do odpowiedniego stanowiska.';
COMMENT ON COLUMN ksiegowosc.pensja.id_pensji IS 'Klucz główny tabeli.';
COMMENT ON COLUMN ksiegowosc.pensja.stanowisko IS 'Kolumna przechowująca dane dotyczące stanowisk w firmie; typ varchar dla oszczędności pamięci.';
COMMENT ON COLUMN ksiegowosc.pensja.kwota IS 'Kolumna przedstawiająca miesięczną kwotę wynagrodzenia dla danego stanowiska w firmie.';

CREATE TABLE ksiegowosc.premia(
	id_premii SMALLINT PRIMARY KEY NOT NULL,
	rodzaj VARCHAR(40),
	kwota MONEY
);

COMMENT ON TABLE ksiegowosc.premia IS 'Tabela premia w schemacie ksiegowość przedstawia rodzaj oraz kwotę premii przyznawanych w firmie.';
COMMENT ON COLUMN ksiegowosc.premia.id_premii IS 'Klucz główny tabeli.';
COMMENT ON COLUMN ksiegowosc.premia.rodzaj IS 'Kolumna służąca do przechowywania danych dotyczących rodzaju premii, np. Uznaniowa, Motywacyjna itd. Kolumna może przyjmować wartości NULL.';
COMMENT ON COLUMN ksiegowosc.premia.kwota IS 'Kolumna przechowujacą informacje na temat wysokości danej premii.';

CREATE TABLE ksiegowosc.wynagrodzenie(
	id_wynagrodzenia SMALLINT PRIMARY KEY NOT NULL,
	data DATE NOT NULL,
	id_pracownika SMALLINT NOT NULL REFERENCES ksiegowosc.pracownicy (id_pracownika),
	id_godziny SMALLINT NOT NULL REFERENCES ksiegowosc.godziny (id_godziny),
	id_pensji SMALLINT NOT NULL REFERENCES ksiegowosc.pensja (id_pensji),
	id_premii SMALLINT REFERENCES ksiegowosc.premia (id_premii)
);

COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela wynagrodzenie w schemacie ksiegowość jest tabelą łącznikową (encją słabą zależną od innych encji), która zawiera informacje na temat wynagrodzenia danego pracownika. Informuje o dacie wydania wynagrodzenia oraz za pomocą kluczy obcy o liczbie przepracowanych godzin w miesiącu, wysokości pensji oraz potencjalnej premii.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.id_wynagrodzenia IS 'Klucz główny tabeli.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.data IS 'Kolumna przechowująca informacje o dacie, w której zostało wydane wynagrodzenie pracownikowi.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.id_pracownika IS 'Klucz obcy z tabeli pracownicy informujący o pracowniku, który ma dostać wynagrodzenie.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.id_godziny IS 'Klucz obcy z tabeli godziny informujący o liczbie godzin przepracowanych przez pracownika w miesiącu.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.id_pensji IS 'Klucz obcy z tabeli pensja informujący o kwocie wynagrodzenie na danym stanowisku w firmie.';
COMMENT ON COLUMN ksiegowosc.wynagrodzenie.id_premii IS 'Klucz obcy z tabeli premia informujący o wysokości oraz rodzaju przyznanej premii pracownikowi.';

-- Wypełnianie tabeli rekordami

INSERT INTO ksiegowosc.pracownicy VALUES
(1, 'Jan', 'Kowalski', 'ul. Jagodowa 30/10, Kraków', '790511775'),
(2, 'Stefan', 'Nowak', 'ul. Sezamkowa 100, Kraków', NULL),
(3, 'Natalia', 'Mazurek', 'ul. Akacjowa 10/3, Warszawa', '124744200'),
(4, 'Konrad', 'Bednarczyk', 'ul. Słowiańska 1/44, Lublin', '665122711'),
(5, 'Jarosław', 'Kowalczyk', 'ul. Jutrzenki 100/53, Wrocław', NULL),
(6, 'Sabina', 'Woźniak', 'ul. Kasztanowa 1, Kraków', '857001995'),
(7, 'Beata', 'Grabowska', 'ul. Leśna 4, Olkusz', '451051966'),
(8, 'Arkadiusz', 'Romanowski', 'al. Adama Mickiewicza 19/12, Wieliczka', NULL),
(9, 'Aleksandra', 'Kosińska', 'ul. Orzeszkowej 1/11, Kraków', '664391033'),
(10, 'Igor', 'Kalinowski', 'ul. Makowa 12, Kraków', '517590117');

SELECT * FROM ksiegowosc.pracownicy;

INSERT INTO ksiegowosc.godziny VALUES
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

SELECT * FROM ksiegowosc.godziny;

INSERT INTO ksiegowosc.pensja VALUES
(1, 'Księgowy', 5500),
(2, 'Analityk Finansowy', 9800),
(3, 'Programista', 12000),
(4, 'Stażysta',  2900),
(5, 'Dyrektor ds. Informatyki', 15000),
(6, 'Programista', 10500),
(7, 'Administrator', 10000),
(8, 'Księgowy', 6000),
(9, 'Programista', 13200),
(10, 'Kierownik ds. Promocji', 8400);

SELECT * FROM ksiegowosc.pensja;

INSERT INTO ksiegowosc.premia VALUES
(1, 'Regulaminowa', 300),
(2, 'Uznaniowa', 500),
(3, 'Motywacyjna', 500),
(4, 'Motywacyjna', 200),
(5, 'Świąteczna', 300),
(6, 'Regulaminowa', 100),
(7, 'Wynikowa', 1000),
(8, 'Wynikowa', 800),
(9, 'Uznaniowa', 450),
(10, 'Motywacyjna', 300);

SELECT * FROM ksiegowosc.premia;

INSERT INTO ksiegowosc.wynagrodzenie VALUES
(1, '2022-01-21', 1, 1, 1, 1),
(2, '2022-01-27', 2, 2, 2, NULL),
(3, '2022-02-03', 3, 3, 3, NULL),
(4, '2022-02-03', 4, 4, 4, 4),
(5, '2022-02-15', 5, 5, 5, 5),
(6, '2022-03-10', 6, 6, 6, NULL),
(7, '2022-03-11', 7, 7, 7, 7),
(8, '2022-03-21', 8, 8, 8, 8),
(9, '2022-04-04', 9, 9, 9, 9),
(10, '2022-04-09', 10, 10, 10, NULL);

SELECT * FROM ksiegowosc.wynagrodzenie;

-- Zapytania
-- a)  Wyświetl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

-- b) Wyświetl id pracowników, których płaca jest większa niż 1000.
SELECT p.id_pracownika
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING (id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING (id_pensji) -- albo w.id_pensji = p.id_pensji
WHERE pe.kwota > cast(10000 AS MONEY);

-- c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000. 
SELECT p.id_pracownika
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING (id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING(id_pensji)
WHERE w.id_premii IS NULL AND pe.kwota > '2000,00 zł';   -- cast(2000 AS MONEY)

-- d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’. 
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

-- e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas 
--    pracy to 160 h miesięcznie. 
SELECT p.imie, p.nazwisko, (g.liczba_godzin - 160) AS nadgodziny
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.godziny AS g
USING(id_pracownika)
WHERE g.liczba_godzin > 160

-- inny sposob
/*
SELECT p.imie, p.nazwisko, 
CASE 
	WHEN g.liczba_godzin > 160 THEN (g.liczba_godzin - 160)
	WHEN g.liczba_godzin <= 160 THEN 0 
END AS nadgodziny
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.godziny AS g
USING (id_pracownika);   -- albo ON p.id_pracownika = g.id_pracownika
*/

-- g)  Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN.
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING (id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING (id_pensji)
WHERE pe.kwota BETWEEN cast(1500 AS MONEY) AND cast(3000 AS MONEY);   -- '1500,00 zł AND '3000,00 zł'

-- h)  Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT p.imie, p.nazwisko 
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
ON p.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.godziny AS g
ON w.id_godziny = g.id_godziny
WHERE g.liczba_godzin > 160 AND w.id_premii IS NULL;

-- i) Uszereguj pracowników według pensji.
SELECT p.imie, p.nazwisko, pe.kwota AS pensja
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING (id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING (id_pensji)
ORDER BY pe.kwota;

-- j) Uszereguj pracowników według pensji i premii malejąco.
SELECT p.imie, p.nazwisko, pe.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy AS p
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING (id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING (id_pensji)
INNER JOIN ksiegowosc.premia AS pr
USING (id_premii)
ORDER BY pe.kwota, pr.kwota DESC;

-- k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.
SELECT stanowisko, COUNT(stanowisko) AS liczba_pracownikow
FROM ksiegowosc.pensja
GROUP BY stanowisko;

-- l)  Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to 
--     przyjmij dowolne inne).
SELECT stanowisko, AVG(cast(kwota AS NUMERIC)) AS srednia_pensja, MIN(kwota) AS min_pensja, MAX(kwota) AS max_pensja
FROM ksiegowosc.pensja
WHERE stanowisko = 'Programista'
GROUP BY stanowisko;

-- m)  Policz sumę wszystkich wynagrodzeń.
SELECT SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja;

-- n) Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT stanowisko, SUM(kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja
GROUP BY stanowisko;

-- o) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
SELECT pe.stanowisko, COUNT(pr.id_premii) AS liczba_premii
FROM ksiegowosc.wynagrodzenie AS w
INNER JOIN ksiegowosc.pensja AS pe
USING (id_pensji)
INNER JOIN ksiegowosc.premia AS pr
USING (id_premii)
GROUP BY pe.stanowisko;

-- p) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.
DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN 
(SELECT w.id_pracownika 
 FROM ksiegowosc.wynagrodzenie AS w
 INNER JOIN ksiegowosc.pensja AS pe
 ON w.id_pensji = pe.id_pensji
 WHERE pe.kwota < cast(1200 AS MONEY));

