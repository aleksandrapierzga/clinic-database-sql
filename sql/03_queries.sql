-- =========================================================
-- 03_queries.sql
-- Example queries for clinic database
-- =========================================================

-- 1) Patients (surname, birth date) who:
-- - used item 'Cetol-2'
-- - have disease 'Diabetes'
-- - are associated with ward 'Pediatrics'
SELECT p.NAZWISKO, p.DATA_URODZENIA
FROM PACJENT p
JOIN ZUZYWA z ON p.NUMER = z.NUMER_PACJENTA
JOIN PRZEDMIOTY pr ON z.NUMER_PRZEDMIOTU = pr.NUMER
JOIN WYKONUJE_ZABIEG w ON p.NUMER = w.NUMER_PACJENTA
JOIN ZATRUDNIA za ON w.ID_LEKARZA = za.NUMER_PRACOWNIKA
JOIN ODDZIALY o ON za.NUMER_ODDZIALU = o.NUMER
WHERE pr.NAZWA = 'Cetol-2'
  AND p.CHOROBA = 'Diabetes'
  AND o.NAZWA = 'Pediatrics';

-- 2) Distinct patient surnames for patients treated by doctors with given surnames
SELECT DISTINCT p.NAZWISKO
FROM PACJENT p
JOIN WYKONUJE_ZABIEG w ON p.NUMER = w.NUMER_PACJENTA
JOIN LEKARZ l ON w.ID_LEKARZA = l.ID
WHERE l.NAZWISKO IN ('Pająk', 'Samuel', 'Gąska')
ORDER BY p.NAZWISKO;

-- 3) Count patients with surname starting with 'S' who had > 2 procedures
-- performed by doctors with specialization = 'General'
SELECT COUNT(*)
FROM (
  SELECT p.NUMER
  FROM PACJENT p
  JOIN WYKONUJE_ZABIEG w ON p.NUMER = w.NUMER_PACJENTA
  JOIN LEKARZ l ON w.ID_LEKARZA = l.ID
  WHERE p.NAZWISKO LIKE 'S%'
    AND l.SPECJALNOSC = 'Ogólny'
  GROUP BY p.NUMER
  HAVING COUNT(*) > 2
) AS t;

-- 4) Doctor with the smallest number of procedures in year 2015
SELECT l.NAZWISKO, l.IMIE
FROM LEKARZ l
LEFT JOIN WYKONUJE_ZABIEG w
  ON l.ID = w.ID_LEKARZA AND w.DATA LIKE '2015%'
GROUP BY l.ID
ORDER BY COUNT(w.NUMER_PACJENTA)
LIMIT 1;

-- 5) Increase salary by 15% for hourly employees (rounded)
SELECT NAZWISKO, ROUND(PENSJA * 1.15)
FROM PRACOWNIK
WHERE TYP = 'Godzinowy';

-- 6) Salary for full-time employees, but NULL for those who are head doctors (ORDYNATOR)
SELECT p.NAZWISKO,
       CASE
         WHEN p.NUMER IN (SELECT ORDYNATOR FROM LEKARZ WHERE ORDYNATOR IS NOT NULL)
         THEN NULL
         ELSE p.PENSJA
       END AS PLACA
FROM PRACOWNIK p
WHERE p.TYP = 'Etatowy';

-- 7) Number of employees per ward
SELECT o.NAZWA, COUNT(z.NUMER_PRACOWNIKA) AS LICZBA_PRACOWNIKOW
FROM ODDZIALY o
LEFT JOIN ZATRUDNIA z ON o.NUMER = z.NUMER_ODDZIALU
GROUP BY o.NAZWA;

-- 8) Employees whose salary is <= 50% of their supervisor's salary
SELECT p.NAZWISKO, p.TYP
FROM PRACOWNIK p
JOIN PODLEGA pd ON p.NUMER = pd.PODWŁADNY
JOIN PRACOWNIK sz ON pd.SZEF = sz.NUMER
WHERE p.PENSJA <= sz.PENSJA * 0.5;

-- 9) Wards with number of assigned patients greater than the average
SELECT o.NAZWA, COUNT(*) AS LICZBA_PACJENTOW
FROM ODDZIALY o
JOIN LOZKO l ON o.NUMER = l.NUMER_ODDZIALU
JOIN PRZYPISANY pr ON l.NUMER = pr.ID_LOZKA
GROUP BY o.NAZWA
HAVING COUNT(*) > (
  SELECT AVG(liczba)
  FROM (
    SELECT COUNT(*) AS liczba
    FROM LOZKO l2
    JOIN PRZYPISANY pr2 ON l2.NUMER = pr2.ID_LOZKA
    GROUP BY l2.NUMER_ODDZIALU
  )
);

-- 10) Ward with the highest total salary cost for full-time employees
SELECT o.NAZWA
FROM ODDZIALY o
JOIN ZATRUDNIA z ON o.NUMER = z.NUMER_ODDZIALU
JOIN PRACOWNIK p ON z.NUMER_PRACOWNIKA = p.NUMER
WHERE p.TYP = 'Etatowy'
GROUP BY o.NAZWA
ORDER BY SUM(p.PENSJA) DESC
LIMIT 1;
