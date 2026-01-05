-- =========================================================
-- 02_seed.sql
-- Sample data for clinic database
-- =========================================================

-- =========================================================
-- Employees
-- =========================================================
INSERT INTO PRACOWNIK VALUES (1, 'Maria', 'Kowalska', 'ul. Lipowa 1', 5500.00, 'Nurse');
INSERT INTO PRACOWNIK VALUES (2, 'Mariola', 'Kornelowicz', 'ul. Nasturcjowa', 0.00, 'Technician');
INSERT INTO PRACOWNIK VALUES (3, 'Michał', 'Kasperowicz', NULL, 8000.00, 'Doctor');
INSERT INTO PRACOWNIK VALUES (4, 'Agnieszka', 'Nowicka', 'ul. Brzozowa 5', 1200.00, 'Full-time');

-- =========================================================
-- Hospital wards
-- =========================================================
INSERT INTO ODDZIALY VALUES (150, 'Gynecology');
INSERT INTO ODDZIALY VALUES (205, 'Surgery');
INSERT INTO ODDZIALY VALUES (101, 'Pediatrics');

-- =========================================================
-- Employment relationships
-- =========================================================
INSERT INTO ZATRUDNIA VALUES (1, 101, 40);
INSERT INTO ZATRUDNIA VALUES (2, 102, 0);
INSERT INTO ZATRUDNIA VALUES (12, 101, 30);

-- =========================================================
-- Doctors
-- =========================================================
INSERT INTO LEKARZ VALUES (10, 'Mariusz', 'Lis', 'Gynecologist', '111222333', NULL);
INSERT INTO LEKARZ VALUES (11, 'Patrycja', 'Brzoska', 'Surgeon', '222333444', 10);
INSERT INTO LEKARZ VALUES (12, 'Joanna', 'Pająk', 'General', '123456789', NULL);
INSERT INTO LEKARZ VALUES (13, 'Grzegorz', 'Samuel', 'General', '233939331', NULL);
INSERT INTO LEKARZ VALUES (14, 'Marta', 'Wieża', 'Gynecologist', '991372409', NULL);

-- =========================================================
-- Patients
-- =========================================================
INSERT INTO PACJENT VALUES (1001, 'Markowska', 'ul. Świdnicka 4', 'Mariusz Adamski', 10, NULL, NULL);
INSERT INTO PACJENT VALUES (1002, 'Poznański', 'ul. Szmaragdowa 64', NULL, NULL, NULL, NULL);

-- Update patient details
UPDATE PACJENT
SET DATA_URODZENIA = '1998-08-01', CHOROBA = 'Diabetes'
WHERE NUMER = 1001;

UPDATE PACJENT
SET DATA_URODZENIA = '1988-08-11', CHOROBA = NULL
WHERE NUMER = 1002;

-- =========================================================
-- Beds
-- =========================================================
INSERT INTO LOZKO VALUES (201, 12, 101);
INSERT INTO LOZKO VALUES (202, 15, 102);

-- =========================================================
-- Medical items / equipment
-- =========================================================
INSERT INTO PRZEDMIOTY VALUES (301, NULL);
INSERT INTO PRZEDMIOTY VALUES (305, NULL);
INSERT INTO PRZEDMIOTY VALUES (400, 'Cetol-2');

-- =========================================================
-- Tests
-- =========================================================
INSERT INTO TEST VALUES (1, 'Marian Kwiatkowski', 1001);
INSERT INTO TEST VALUES (2, 'Anastazja Mark', 1002);

-- =========================================================
-- Medical procedures
-- =========================================================
INSERT INTO WYKONUJE_ZABIEG VALUES (10, 1001, '2025-03-01', '17:00', 'Positive');
INSERT INTO WYKONUJE_ZABIEG VALUES (11, 1002, '2025-01-01', '19:00', 'Negative');
INSERT INTO WYKONUJE_ZABIEG VALUES (12, 1001, '2025-04-07', '10:00', 'Positive');
INSERT INTO WYKONUJE_ZABIEG VALUES (13, 1001, '2025-02-09', '10:00', 'Positive');
INSERT INTO WYKONUJE_ZABIEG VALUES (14, 1001, '2025-06-22', '11:30', 'Positive');

-- =========================================================
-- Equipment usage
-- =========================================================
INSERT INTO ZUZYWA VALUES (1001, 301, '2025-04-21', '08:00', 2, 155.00);
INSERT INTO ZUZYWA VALUES (1001, 305, '2025-11-11', '15:00', 0, 0.00);
INSERT INTO ZUZYWA VALUES (1001, 400, '2025-06-10', '12:00', 1, 100.00);

-- =========================================================
-- Employee hierarchy
-- =========================================================
INSERT INTO PODLEGA VALUES (2, 1);

-- =========================================================
-- Patient-bed assignment
-- =========================================================
INSERT INTO PRZYPISANY VALUES (1001, 201);
