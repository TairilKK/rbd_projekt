-- Dodanie przykładowych danych osobowych
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_OSOBY, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU FROM DANE_PERSONALNE'')
    VALUES (1, ''Jan'', ''Kowalski'', ''jan.kowalski@example.com'', ''123456789'', 1);
';

-- Dodanie przykładowego adresu
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_ADRESU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ FROM ADRESY'')
    VALUES (1, ''Polna'', 10, NULL, ''Warszawa'', ''00-001'', ''Polska'');
';

-- Dodanie przykładowego pracownika
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_PRACOWNIKA, ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, DATA_ZWOLNIENIA, PENSJA, STANOWISKO FROM PERSONEL'')
    VALUES (1, 1, 1, ''2023-01-01'', NULL, 3000, ''Recepcjonista'');
';

-- Dodanie przykładowego pokoju
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_POKOJU, ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY FROM POKOJE'')
    VALUES (1, 1, 101, 2, 200, ''TAK'', ''NIE'');
';

-- Dodanie przykładowego wyposażenia pokoju
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_POKOJU, NAZWA, ILOSC FROM WYPOSAZENIE'')
    VALUES (1, ''Łóżko'', 2);
';

-- Dodanie przykładowej rezerwacji
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC FROM REZERWACJE'')
    VALUES (1, 1, 1, 1, 1, ''2023-01-10'', ''2023-01-20'', NULL, NULL, 100, 2000, 500, 2500);
';

-- Dodanie przykładowej usługi
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_USLUGI, ID_HOTELU, NAZWA, CENA FROM USLUGI'')
    VALUES (1, 1, ''Room Service'', 100);
';

-- Dodanie przykładowej rezerwacji usługi
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_REZ_USLUGI, ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB FROM REZERWACJE_USLUGI'')
    VALUES (1, 1, 1, 1, 2);
';

-- Dodanie przykładowego gościa
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_REZERWACJI, IMIE, NAZWISKO FROM GOSCIE'')
    VALUES (1, ''Anna'', ''Nowak'');
';

-- Dodanie przykładowego klienta
EXEC sp_executesql N'
    INSERT INTO OPENQUERY(HOTEL, ''SELECT ID_KLIENTA, ID_OSOBY, ID_ZNIZKI, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ, PROCENT FROM KLIENCI'')
    VALUES (1, 1, 1, ''Jan'', ''Kowalski'', ''jan.kowalski@example.com'', ''123456789'', ''Polna'', 10, NULL, ''Warszawa'', ''00-001'', ''Polska'', 10);
';
