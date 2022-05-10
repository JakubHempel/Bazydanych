-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodając do niego kierunkowy dla Polski 
--    w nawiasie (+48)
UPDATE ksiegowosc.pracownicy
SET telefon = '(+48)'||telefon;

SELECT telefon FROM ksiegowosc.pracownicy;

-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony był myślnikami wg 
--    wzoru: ‘555-222-333’ 
UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon from 1 for 5) || ' ' || SUBSTRING(telefon from 6 for 3) || '-' || SUBSTRING(telefon from 9 for 3) || '-' || SUBSTRING(telefon from 11 for 3);

SELECT telefon FROM ksiegowosc.pracownicy;

-- c) Wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter
SELECT id_pracownika, UPPER(imie), UPPER(nazwisko), UPPER(adres), telefon 
FROM ksiegowosc.pracownicy
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko))
						 FROM ksiegowosc.pracownicy);
						 
-- d) Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
SELECT pr.id_pracownika, 
	   MD5(pr.imie) AS imie,
	   MD5(pr.nazwisko) AS nazwisko, 
	   MD5(pr.adres) AS adres, 
	   MD5(pr.telefon) AS telefon,  
	   MD5(pe.kwota::CHAR) AS pensja
FROM ksiegowosc.pracownicy AS pr
INNER JOIN ksiegowosc.wynagrodzenie AS w
USING(id_pracownika)
INNER JOIN ksiegowosc.pensja AS pe
USING(id_pensji);

-- f) Wyświetl pracowników, ich pensje oraz premie. Wykorzystaj złączenie lewostronne
SELECT pr.imie, pr.nazwisko, pr.adres, pr.telefon, pe.kwota AS pensja, pm.kwota AS premia
FROM ksiegowosc.pracownicy AS pr
LEFT JOIN ksiegowosc.wynagrodzenie AS w
ON pr.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja AS pe
ON w.id_pensji = pe.id_pensji
LEFT JOIN ksiegowosc.premia AS pm
ON w.id_premii = pm.id_premii;

-- g) Wygeneruj raport (zapytanie), które zwróci w wyniki treść wg poniższego szablonu:
--    Pracownik Jan Nowak, w dniu 7.08.2017 otrzymał pensję całkowitą na kwotę 7540 zł, gdzie 
--    wynagrodzenie zasadnicze wynosiło: 5000 zł, premia: 2000 zł, nadgodziny: 540 zł
ALTER TABLE ksiegowosc.godziny
ADD COLUMN liczba_nadgodzin SMALLINT;

UPDATE ksiegowosc.godziny
SET liczba_nadgodzin = 
CASE 
	WHEN liczba_godzin > 160 THEN (liczba_godzin - 160)
	WHEN liczba_godzin <= 160 THEN 0 
END

SELECT 
	'Pracownik ' || pr.imie || ' ' || pr.nazwisko || ', w dniu ' || w.data || 
	' otrzymał pensję całkowitą na kwotę ' || (pe.kwota+pm.kwota+CAST((g.liczba_nadgodzin*20) AS MONEY)) || 
	', gdzie wynagrodzenie zasadnicze wynosiło: ' || pe.kwota || 
	', premia: ' || pm.kwota || ', nadgodziny: ' || (g.liczba_nadgodzin*20) || ' zł' AS raport
FROM ksiegowosc.pracownicy AS pr
INNER JOIN ksiegowosc.wynagrodzenie AS w
ON pr.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS pe
ON w.id_pensji = pe.id_pensji
INNER JOIN ksiegowosc.premia AS pm
ON w.id_premii = pm.id_premii
INNER JOIN ksiegowosc.godziny AS g
ON w.id_godziny = g.id_godziny;

