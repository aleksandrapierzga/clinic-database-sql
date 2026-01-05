-- =========================================================
-- 01_schema.sql
-- Database schema for clinic management system
-- =========================================================

-- Drop tables if they already exist (to allow re-running the script)
DROP TABLE IF EXISTS PRACOWNIK;
DROP TABLE IF EXISTS ODDZIALY;
DROP TABLE IF EXISTS LEKARZ;
DROP TABLE IF EXISTS PACJENT;
DROP TABLE IF EXISTS LOZKO;
DROP TABLE IF EXISTS PRZEDMIOTY;
DROP TABLE IF EXISTS TEST;
DROP TABLE IF EXISTS ZATRUDNIA;
DROP TABLE IF EXISTS WYKONUJE_ZABIEG;
DROP TABLE IF EXISTS ZUZYWA;
DROP TABLE IF EXISTS PODLEGA;
DROP TABLE IF EXISTS PRZYPISANY;

-- =========================================================
-- Employees table
-- =========================================================
CREATE TABLE PRACOWNIK (
    NUMER INTEGER PRIMARY KEY,
    IMIE TEXT NOT NULL,
    NAZWISKO TEXT NOT NULL,
    ADRES TEXT,
    PENSJA REAL,
    TYP TEXT           -- employment type (e.g. full-time, hourly)
);

-- =========================================================
-- Hospital wards
-- =========================================================
CREATE TABLE ODDZIALY (
    NUMER INTEGER PRIMARY KEY,
    NAZWA TEXT NOT NULL
);

-- =========================================================
-- Doctors table (self-referencing for head doctor / supervisor)
-- =========================================================
CREATE TABLE LEKARZ (
    ID INTEGER PRIMARY KEY,
    IMIE TEXT NOT NULL,
    NAZWISKO TEXT NOT NULL,
    SPECJALNOSC TEXT,
    NR_TELEFONU TEXT CHECK (LENGTH(NR_TELEFONU) = 9),
    ORDYNATOR INTEGER,
    FOREIGN KEY (ORDYNATOR) REFERENCES LEKARZ(ID)
);

-- =========================================================
-- Patients table
-- =========================================================
CREATE TABLE PACJENT (
    NUMER INTEGER PRIMARY KEY,
    NAZWISKO TEXT NOT NULL,
    ADRES TEXT,
    KREWNY TEXT,              -- next of kin
    ID_LEKARZA INTEGER,
    DATA_URODZENIA TEXT,
    CHOROBA TEXT,
    FOREIGN KEY (ID_LEKARZA) REFERENCES LEKARZ(ID)
);

-- =========================================================
-- Beds table
-- =========================================================
CREATE TABLE LOZKO (
    NUMER INTEGER PRIMARY KEY,
    NUMER_POKOJU INTEGER,
    NUMER_ODDZIALU INTEGER,
    FOREIGN KEY (NUMER_ODDZIALU) REFERENCES ODDZIALY(NUMER)
);

-- =========================================================
-- Medical equipment / items
-- =========================================================
CREATE TABLE PRZEDMIOTY (
    NUMER INTEGER PRIMARY KEY,
    NAZWA TEXT
);

-- =========================================================
-- Tests performed on patients
-- =========================================================
CREATE TABLE TEST (
    NUMER INTEGER PRIMARY KEY,
    NAZWISKO TEXT,
    ID_PACJENTA INTEGER,
    FOREIGN KEY (ID_PACJENTA) REFERENCES PACJENT(NUMER)
);

-- =========================================================
-- Employment relationship between employees and wards
-- =========================================================
CREATE TABLE ZATRUDNIA (
    NUMER_PRACOWNIKA INTEGER,
    NUMER_ODDZIALU INTEGER,
    LICZBA_GODZIN INTEGER,
    PRIMARY KEY (NUMER_PRACOWNIKA, NUMER_ODDZIALU),
    FOREIGN KEY (NUMER_PRACOWNIKA) REFERENCES PRACOWNIK(NUMER),
    FOREIGN KEY (NUMER_ODDZIALU) REFERENCES ODDZIALY(NUMER)
);

-- =========================================================
-- Medical procedures performed by doctors on patients
-- =========================================================
CREATE TABLE WYKONUJE_ZABIEG (
    ID_LEKARZA INTEGER,
    NUMER_PACJENTA INTEGER,
    DATA TEXT,
    CZAS TEXT,
    WYNIK TEXT,
    PRIMARY KEY (ID_LEKARZA, NUMER_PACJENTA, DATA),
    FOREIGN KEY (ID_LEKARZA) REFERENCES LEKARZ(ID),
    FOREIGN KEY (NUMER_PACJENTA) REFERENCES PACJENT(NUMER)
);

-- =========================================================
-- Equipment usage by patients
-- =========================================================
CREATE TABLE ZUZYWA (
    NUMER_PACJENTA INTEGER,
    NUMER_PRZEDMIOTU INTEGER,
    DATA TEXT,
    GODZINA TEXT,
    ILOSC INTEGER,
    KOSZT REAL,
    PRIMARY KEY (NUMER_PACJENTA, NUMER_PRZEDMIOTU, DATA),
    FOREIGN KEY (NUMER_PACJENTA) REFERENCES PACJENT(NUMER),
    FOREIGN KEY (NUMER_PRZEDMIOTU) REFERENCES PRZEDMIOTY(NUMER)
);

-- =========================================================
-- Employee hierarchy (supervisor-subordinate)
-- =========================================================
CREATE TABLE PODLEGA (
    PODWLADNY INTEGER PRIMARY KEY,
    SZEF INTEGER,
    FOREIGN KEY (PODWLADNY) REFERENCES PRACOWNIK(NUMER),
    FOREIGN KEY (SZEF) REFERENCES PRACOWNIK(NUMER)
);

-- =========================================================
-- Patient-bed assignment
-- =========================================================
CREATE TABLE PRZYPISANY (
    ID_PACJENTA INTEGER PRIMARY KEY,
    ID_LOZKA INTEGER,
    FOREIGN KEY (ID_PACJENTA) REFERENCES PACJENT(NUMER),
    FOREIGN KEY (ID_LOZKA) REFERENCES LOZKO(NUMER)
);
