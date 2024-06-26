-------------- -------------------------------- -------------- 
-------------- -- SPRAWDZENIE PROCEDUR SZEFA -- -------------- 
-------------- -------------------------------- -------------- 

EXEC SZEF.DODAJ_HOTEL('HOTEL_WARSZAWA', 'Gda�ska', 10, NULL, 'Warszawa', '00-001', 'Polska');

EXEC SZEF.ZMIEN_NAZWE_HOTELU(1, 'HOTEL_WAWA');
    
BEGIN
  SZEF.DODAJ_PRACOWNIKA(
    'Jan', 
    'Kowalski', 
    'jan.kowalski@example.com', 
    '123456789', 
    'Mickiewicza', 
    15, 
    3, 
    'Warszawa', 
    '00-001', 
    'Polska', 
    1, 
    3000, 
    'SZEF'
  );
END;

EXEC SZEF.ZMIEN_PENSJE(1, 3500);
EXEC SZEF.ZMIEN_STANOWISKO(1, 'KONSERWATOR');
EXEC SZEF.ZWOLNIJ_PRACOWNIKA(1);

EXEC SZEF.DODAJ_POKOJ(1, 101, 2, 150);
EXEC SZEF.ZMIEN_LICZBE_OSOB_POKOJU(1, 4);
EXEC SZEF.ZMIEN_NUMER_POKOJU(1, 102);
EXEC SZEF.ZMIEN_CENE_POKOJU(1, 200);

EXEC SZEF.DODAJ_WYPOSAZENIE(1, '��ko', 2);
EXEC SZEF.ZMIEN_ILOSC_WYPOSAZENIA(1, '��ko', 4);
EXEC SZEF.ZMIEN_NAZWE_WYPOSAZENIA(1, '��ko', 'Krzes�o');

EXEC SZEF.DODAJ_USLUGE(1, 'SPA', 100);
EXEC SZEF.USLUGA_ZMIEN_CENE(1, 150);
EXEC SZEF.USLUGA_ZMIEN_NAZWE(1, 'MASAZ');

EXEC SZEF.DODAJ_ZNIZKE(0);
EXEC SZEF.EDYTUJ_ZNIZKE(1, 5);
EXEC SZEF.OBNIZ_ZNIZKI();

select * from hotele;
select * from adresy;
select * from personel;
select * from pokoje;
select * from wyposazenie;
select * from uslugi;
select * from znizki;
SELECT * FROM DANE_PERSONALNE;

-------------- ---------------------------------- -------------- 
-------------- -- SPRAWDZENIE PROCEDUR KLIENTA -- -------------- 
-------------- ---------------------------------- -------------- 

BEGIN
  KLIENT.DODAJ_KLIENTA(
    'Anna', 
    'Nowak', 
    'anna.nowak@example.com', 
    '987654321', 
    'Kwiatowa', 
    20, 
    1, 
    'Krak�w', 
    '30-001', 
    'Polska'
  );
END;

EXEC KLIENT.DODAJ_REZERWACJE(1, 1, 2, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-10', 'YYYY-MM-DD'));
EXEC KLIENT.DODAJ_GOSCIA(1, 'MARIA', 'POLAK');
EXEC KLIENT.USUN_GOSCIA(1, 'MARIA', 'POLAK');
EXEC KLIENT.OPLAC_ZALICZKE(1);
EXEC KLIENT.USUN_REZERWACJE(1);

select * from hotele;
select * from adresy;
select * from personel;
select * from pokoje;
select * from wyposazenie;
select * from uslugi;
select * from znizki;
SELECT * FROM DANE_PERSONALNE;
SELECT * FROM KLIENCI;
SELECT * FROM REZERWACJE;
SELECT * FROM GOSCIE;

-------------- ---------------------------------- -------------- 
-------------- -- SPRAWDZENIE PROCEDUR KLIENTA -- -------------- 
-------------- ---------------------------------- --------------

--EXEC RECEPCJA.AKTUALIZUJ_CENE_POBYTU(1);
EXEC RECEPCJA.DODAJ_REZERWACJA_USLUGA(1, 1, 1, 2);
EXEC RECEPCJA.OPLATA_ZNISZCZENIE(1, 200);
EXEC RECEPCJA.POTWIERDZ_REZERWACJE(1, 1);
EXEC RECEPCJA.ZAKONCZ_REZERWACJE(1);

select * from hotele;
select * from adresy;
select * from personel;
select * from pokoje;
select * from wyposazenie;
select * from uslugi;
select * from znizki;
SELECT * FROM DANE_PERSONALNE;
SELECT * FROM KLIENCI;
SELECT * FROM REZERWACJE;
SELECT * FROM GOSCIE;
SELECT * FROM REZERWACJE_USLUGI;

-------------- -------------------------------------------------- -------------- 
-------------- -- SPRAWDZENIE PROCEDUR POKOJOWKA I KONSERWATOR -- -------------- 
-------------- -------------------------------------------------- --------------

BEGIN
  POKOJ_DO_SPRZATANIA(
    1, 
    1,
    101,  
    'Generalne sprz�tanie po d�ugim pobycie go�cia', 
    TIMESTAMP '2024-06-20 09:00:00', 
    TIMESTAMP '2024-06-20 12:00:00'
  );
END;

SELECT * FROM SPRZATANIE;

BEGIN
  POKOJ_DO_NAPRAWY(
    1, 
    1,
    101,  
    'USZKODZONY KARNISZ', 
    TIMESTAMP '2024-06-20 09:00:00', 
    TIMESTAMP '2024-06-20 12:00:00'
  );
END;

SELECT * FROM NAPRAWY;

EXEC KONSERWATOR.POKOJ_NAPRAWIONY(1, 1, 101, 1, TIMESTAMP '2024-06-20 10:00:00');
EXEC POKOJOWKA.POKOJ_POSPRZATANY(1, 1, 101, 1, TIMESTAMP '2024-06-20 10:00:00');

----STARE-----

-------------- ------------ -------------- 
-------------- -- POKOJE -- -------------- 
-------------- ------------ --------------

------- HOTEL WARSZAWA
----------------------
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 101, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 102, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 103, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 104, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 105, 4, 600, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 201, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 202, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 203, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 204, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 205, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 206, 3, 450, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 301, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 302, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 303, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 304, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 305, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 306, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 307, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Warszawa'), 308, 2, 300, 'TAK', 'NIE');

--------- HOTEL KRAK�W
----------------------
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 101, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 102, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 103, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 104, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 105, 4, 600, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 201, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 202, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 203, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 204, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 205, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 206, 3, 450, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 301, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 302, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 303, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 304, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 305, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 306, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 307, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel Krak�w'), 308, 2, 300, 'TAK', 'NIE');

----------- HOTEL ��D�
----------------------
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 101, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 102, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 103, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 104, 4, 600, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 105, 4, 600, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 201, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 202, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 203, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 204, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 205, 3, 450, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 206, 3, 450, 'TAK', 'NIE');

INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 301, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 302, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 303, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 304, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 305, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 306, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 307, 2, 300, 'TAK', 'NIE');
INSERT INTO POKOJE (ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
VALUES ((SELECT ID_HOTELU FROM HOTELE WHERE NAZWA = 'Hotel ��d�'), 308, 2, 300, 'TAK', 'NIE');

--select * from pokoje;

-------------- ----------------- --------------
-------------- -- WYPOSAZENIE -- --------------
-------------- ----------------- --------------

-------------- -------------- -------------- 
-------------- -- PERSONEL -- -------------- 
-------------- -------------- -------------- 

INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Nowowiejska', 1, NULL, 'Warszawa', '00-002', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Marsza�kowska', 5, NULL, 'Warszawa', '00-003', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Krucza', 7, NULL, 'Warszawa', '00-004', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Aleje Jerozolimskie', 12, NULL, 'Warszawa', '00-005', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Plac Zbawiciela', 3, NULL, 'Warszawa', '00-006', 'Polska');

INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Floria�ska', 8, NULL, 'Krak�w', '31-001', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Grodzka', 10, NULL, 'Krak�w', '31-002', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Szewska', 12, NULL, 'Krak�w', '31-003', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('�wi�tej Anny', 14, NULL, 'Krak�w', '31-004', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Kanonicza', 16, NULL, 'Krak�w', '31-005', 'Polska');

INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('D�uga', 18, NULL, '��d�', '80-001', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Mariacka', 20, NULL, '��d�', '80-002', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('�w. Ducha', 22, NULL, '��d�', '80-003', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Piwna', 24, NULL, '��d�', '80-004', 'Polska');
INSERT INTO ADRESY (ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
VALUES ('Chlebnicka', 26, NULL, '��d�', '80-005', 'Polska');

----------------------------------------------------------------------------------------------

INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Jan', 'Kowalski', 'jan.kowalski@rbd.com', '123456789', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Nowowiejska' AND NR_DOMU = 1));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Anna', 'Nowak', 'anna.nowak@rbd.com', '234567890', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Marsza�kowska' AND NR_DOMU = 5));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Piotr', 'Zieli�ski', 'piotr.zielinski@rbd.com', '345678901', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Krucza' AND NR_DOMU = 7));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Katarzyna', 'Wi�niewska', 'katarzyna.wisniewska@rbd.com', '456789012', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Aleje Jerozolimskie' AND NR_DOMU = 12));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Micha�', 'W�jcik', 'michal.wojcik@rbd.com', '567890123', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Plac Zbawiciela' AND NR_DOMU = 3));

INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Agnieszka', 'Lewandowska', 'agnieszka.lewandowska@rbd.com', '678901234', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Floria�ska' AND NR_DOMU = 8));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Tomasz', 'D�browski', 'tomasz.dabrowski@rbd.com', '789012345', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Grodzka' AND NR_DOMU = 10));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Monika', 'Kr�l', 'monika.krol@rbd.com', '890123456', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Szewska' AND NR_DOMU = 12));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Krzysztof', 'Majewski', 'krzysztof.majewski@rbd.com', '901234567', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = '�wi�tej Anny' AND NR_DOMU = 14));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Joanna', 'Kami�ska', 'joanna.kaminska@rbd.com', '012345678', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Kanonicza' AND NR_DOMU = 16));

INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Pawe�', 'Sikorski', 'pawel.sikorski@rbd.com', '123456780', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'D�uga' AND NR_DOMU = 18));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Magdalena', 'Zawadzka', 'magdalena.zawadzka@rbd.com', '234567890', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Mariacka' AND NR_DOMU = 20));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Adam', 'Piotrowski', 'adam.piotrowski@rbd.com', '345678901', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = '�w. Ducha' AND NR_DOMU = 22));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Ewa', 'Kowalczyk', 'ewa.kowalczyk@rbd.com', '456789012', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Piwna' AND NR_DOMU = 24));
INSERT INTO DANE_PERSONALNE (IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
VALUES ('Grzegorz', 'Witkowski', 'grzegorz.witkowski@rbd.com', '567890123', (SELECT ID_ADRESU FROM ADRESY WHERE ULICA = 'Chlebnicka' AND NR_DOMU = 26));

----------------------------------------------------------------------------------------------

INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'jan.kowalski@rbd.com'), 1, SYSDATE, 4000, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'anna.nowak@rbd.com'), 1, SYSDATE, 4500, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'piotr.zielinski@rbd.com'), 1, SYSDATE, 4200, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'katarzyna.wisniewska@rbd.com'), 1, SYSDATE, 4100, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'michal.wojcik@rbd.com'), 1, SYSDATE, 4300, 'Szef');

INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'agnieszka.lewandowska@rbd.com'), 2, SYSDATE, 4000, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'tomasz.dabrowski@rbd.com'), 2, SYSDATE, 4500, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'monika.krol@rbd.com'), 2, SYSDATE, 4200, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'krzysztof.majewski@rbd.com'), 2, SYSDATE, 4100, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'joanna.kaminska@rbd.com'), 2, SYSDATE, 4300, 'Szef');

INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'pawel.sikorski@rbd.com'), 3, SYSDATE, 4000, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'magdalena.zawadzka@rbd.com'), 3, SYSDATE, 4500, 'Recepcja');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'adam.piotrowski@rbd.com'), 3, SYSDATE, 4200, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'ewa.kowalczyk@rbd.com'), 3, SYSDATE, 4100, 'Pokoj�wka');
INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
VALUES ((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE EMAIL = 'grzegorz.witkowski@rbd.com'), 3, SYSDATE, 4300, 'Szef');

----------------------------------------------------------------------------------------------


