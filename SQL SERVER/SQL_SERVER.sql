--EXEC sp_addlinkedserver
--	'HOTEL', '', 'OraOLEDB.Oracle', 'pd19';

--EXEC sp_addlinkedsrvlogin
--	'HOTEL', 'FALSE', 'sa', 'rbdhotel', '12345';

--CREATE DATABASE RBDHOTEL
--GO

--USE RBDHOTEL
--GO

-------------- --------------------- -------------- 
-------------- -- PERSONEL HOTELU -- -------------- 
-------------- --------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_PERSONEL_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW PERSONEL_HOTELU AS
            SELECT * FROM HOTEL..RBDHOTEL.PERSONEL
            WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


--EXEC UTWORZ_WIDOK_PERSONEL_HOTELU @ID_HOTELU = 1;
--GO

--select * from PERSONEL_HOTELU;
--GO

-------------- ------------------- -------------- 
-------------- -- POKOJE HOTELU -- -------------- 
-------------- ------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_POKOJE_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW POKOJE_HOTELU AS
            SELECT * FROM HOTEL..RBDHOTEL.POKOJE
            WHERE ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


--EXEC UTWORZ_WIDOK_POKOJE_HOTELU @ID_HOTELU = 1;
--GO

--select * from POKOJE_HOTELU;
--GO

-------------- ------------------------- -------------- 
-------------- -- WYPOSAZENIE POKOJOW -- -------------- 
-------------- ------------------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW WYPOSAZENIE_POKOJOW_HOTELU AS
            SELECT p.NR_POKOJU, w.NAZWA, w.ILOSC FROM HOTEL..RBDHOTEL.WYPOSAZENIE w JOIN 
            HOTEL..RBDHOTEL.POKOJE p on w.ID_POKOJU = p.ID_POKOJU
            WHERE p.ID_HOTELU = ' + CAST(@ID_HOTELU AS NVARCHAR(10)) + ';
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


--EXEC UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU @ID_HOTELU = 1;
--GO

--select * from WYPOSAZENIE_POKOJOW_HOTELU;
--GO


-------------- ---------------- -------------- 
-------------- -- REZERWACJE -- -------------- 
-------------- ---------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_REZERWACJE
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW REZERWACJE_HOTELU AS
            SELECT * FROM OPENQUERY(HOTEL, ''''
                SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC
                FROM REZERWACJE
                WHERE ID_HOTELU = ''''''' + CAST(@ID_HOTELU AS NVARCHAR(10)) + '''''''
            '');
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------- ---------------- -------------- 
-------------- -- USŁUGI -- -------------- 
-------------- ---------------- -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_USLUGI
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW USLUGI_HOTELU AS
            SELECT * FROM OPENQUERY(HOTEL, ''''
                SELECT ID_USLUGI, ID_HOTELU, NAZWA, CENA
                FROM USLUGI
                WHERE ID_HOTELU = ''''''' + CAST(@ID_HOTELU AS NVARCHAR(10)) + '''''''
            '');
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------- ----------------------- -------------- 
-------------- -- REZERWACJE USŁUGI -- -------------- 
-------------- ----------------------- --------------
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_REZERWACJE_USLUGI
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW REZERWACJE_USLUGI_HOTELU AS
            SELECT * FROM OPENQUERY(HOTEL, ''''
                SELECT ID_REZ_USLUGI, ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB
                FROM REZERWACJE_USLUGI
                WHERE ID_HOTELU = ''''''' + CAST(@ID_HOTELU AS NVARCHAR(10)) + '''''''
            '');
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------- ------------ -------------- 
-------------- -- GOŚCIE -- -------------- 
-------------- ------------ --------------
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_GOSCIE
    @ID_HOTELU INT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW GOSCIE_HOTELU AS
            SELECT g.ID_REZERWACJI, g.IMIE, g.NAZWISKO
            FROM OPENQUERY(HOTEL, ''''
                SELECT g.ID_REZERWACJI, g.IMIE, g.NAZWISKO, r.ID_HOTELU
                FROM GOSCIE g JOIN REZERWACJE r ON g.ID_REZERWACJI = r.ID_REZERWACJI
                WHERE r.ID_HOTELU = ''''''' + CAST(@ID_HOTELU AS NVARCHAR(10)) + '''''''
            '') g;
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------- ------------ -------------- 
-------------- -- KLIENT -- -------------- 
-------------- ------------ -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_KLIENT
AS
BEGIN
    BEGIN TRY
        DECLARE @SQL NVARCHAR(MAX);
        SET @SQL = '
            CREATE OR ALTER VIEW KLIENT_VIEW AS
            SELECT k.ID_KLIENTA, k.ID_OSOBY, k.ID_ZNIZKI, d.IMIE, d.NAZWISKO, d.EMAIL, d.NR_TELEFONU, a.ULICA, a.NR_DOMU, a.NR_MIESZKANIA, a.MIEJSCOWOSC, a.KOD_POCZTOWY, a.KRAJ, z.PROCENT
            FROM OPENQUERY(HOTEL, ''''
                SELECT k.ID_KLIENTA, k.ID_OSOBY, k.ID_ZNIZKI, d.IMIE, d.NAZWISKO, d.EMAIL, d.NR_TELEFONU, a.ULICA, a.NR_DOMU, a.NR_MIESZKANIA, a.MIEJSCOWOSC, a.KOD_POCZTOWY, a.KRAJ, z.PROCENT
                FROM KLIENCI k
                JOIN DANE_PERSONALNE d ON k.ID_OSOBY = d.ID_OSOBY
                JOIN ADRESY a ON d.ID_ADRESU = a.ID_ADRESU
                JOIN ZNIZKI z ON k.ID_ZNIZKI = z.ID_ZNIZKI
            '') k;
        ';
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-------------- ------------------------ -------------- 
-------------- -- REZERWACJE KLIENTA -- -------------- 
-------------- ------------------------ -------------- 
CREATE OR ALTER PROCEDURE UTWORZ_WIDOK_REZERWACJE_KLIENTA
    @ID_KLIENTA INT
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = '
        CREATE OR ALTER VIEW REZERWACJE_KLIENTA AS
        SELECT r.ID_REZERWACJI, r.ID_HOTELU, r.ID_KLIENTA, r.ID_PRACOWNIKA, r.ID_POKOJU, r.PRZYJAZD, r.ODJAZD, r.ZAMELDOWANIE, r.ODMELDOWANIE, r.OPLATA_ZNISCZENIE, r.CENA_POBYTU, r.OPLATA_ZALICZKA, r.OPLATA_CALOSC
        FROM OPENQUERY(HOTEL, ''
            SELECT r.ID_REZERWACJI, r.ID_HOTELU, r.ID_KLIENTA, r.ID_PRACOWNIKA, r.ID_POKOJU, r.PRZYJAZD, r.ODJAZD, r.ZAMELDOWANIE, r.ODMELDOWANIE, r.OPLATA_ZNISCZENIE, r.CENA_POBYTU, r.OPLATA_ZALICZKA, r.OPLATA_CALOSC
            FROM REZERWACJE r
            WHERE r.ID_KLIENTA = ''''' + CAST(@ID_KLIENTA AS NVARCHAR(10)) + '''''
        '');
    ';

    EXEC sp_executesql @SQL;
END;
GO


-------------- -- TRIGGERY -- --------------
-------------- -------------- --------------
-------------- ---------------------- --------------
-------------- -- DODAJ PRACOWNIKA -- --------------
-------------- ---------------------- --------------
CREATE TRIGGER TRIGGER_DODAJ_PRACOWNIKA
ON PERSONEL_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_PRACOWNIKA, ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, DATA_ZWOLNIENIA, PENSJA, STANOWISKO FROM PERSONEL')
    SELECT ID_PRACOWNIKA, ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, DATA_ZWOLNIENIA, PENSJA, STANOWISKO
    FROM INSERTED;
END;
GO

-------------- ---------------------- --------------
-------------- -- AKTUALIZUJ PRACOWNIKA -- --------------
-------------- ---------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_PRACOWNIKA
ON PERSONEL_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_PRACOWNIKA, ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, DATA_ZWOLNIENIA, PENSJA, STANOWISKO FROM PERSONEL')
    SET 
        ID_OSOBY = i.ID_OSOBY,
        ID_HOTELU = i.ID_HOTELU,
        DATA_ZATRUDNIENIA = i.DATA_ZATRUDNIENIA,
        DATA_ZWOLNIENIA = i.DATA_ZWOLNIENIA,
        PENSJA = i.PENSJA,
        STANOWISKO = i.STANOWISKO
    FROM INSERTED i
    WHERE PERSONEL.ID_PRACOWNIKA = i.ID_PRACOWNIKA;
END;
GO

-------------- ----------------- --------------
-------------- -- DODAJ POKÓJ -- --------------
-------------- ----------------- --------------
CREATE TRIGGER TRIGGER_DODAJ_POKOJ
ON POKOJE_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_POKOJU, ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY FROM POKOJE')
    SELECT ID_POKOJU, ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY
    FROM INSERTED;
END;
GO

-------------- ---------------------- --------------
-------------- -- AKTUALIZUJ POKÓJ -- --------------
-------------- ---------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_POKOJ
ON POKOJE_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_POKOJU, ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY FROM POKOJE')
    SET 
        ID_HOTELU = i.ID_HOTELU,
        NR_POKOJU = i.NR_POKOJU,
        LICZBA_OSOB = i.LICZBA_OSOB,
        CENA = i.CENA,
        POSPRZATANY = i.POSPRZATANY,
        WYMAGA_NAPRAWY = i.WYMAGA_NAPRAWY
    FROM INSERTED i
    WHERE POKOJE.ID_POKOJU = i.ID_POKOJU;
END;
GO

-------------- ------------------------------ --------------
-------------- -- DODAJ WYPOSAZENIE POKOJU -- --------------
-------------- ------------------------------ --------------
CREATE TRIGGER TRIGGER_DODAJ_WYPOSAZENIE_POKOJU
ON WYPOSAZENIE_POKOJOW_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_POKOJU, NAZWA, ILOSC FROM WYPOSAZENIE')
    SELECT ID_POKOJU, NAZWA, ILOSC
    FROM INSERTED;
END;
GO

-------------- ----------------------------------- --------------
-------------- -- AKTUALIZUJ WYPOSAZENIE POKOJU -- --------------
-------------- ----------------------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_WYPOSAZENIE_POKOJU
ON WYPOSAZENIE_POKOJOW_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_POKOJU, NAZWA, ILOSC FROM WYPOSAZENIE')
    SET 
        NAZWA = i.NAZWA,
        ILOSC = i.ILOSC
    FROM INSERTED i
    WHERE WYPOSAZENIE.ID_POKOJU = i.ID_POKOJU;
END;
GO

-------------- ------------------------------- --------------
-------------- -- DODAJ REZERWACJE -- --------------
-------------- ------------------------------- --------------
CREATE TRIGGER TRIGGER_DODAJ_REZERWACJE
ON REZERWACJE_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC FROM REZERWACJE')
    SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC
    FROM INSERTED;
END;
GO

-------------- --------------------------- --------------
-------------- -- AKTUALIZUJ REZERWACJE -- --------------
-------------- --------------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_REZERWACJE
ON REZERWACJE_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC FROM REZERWACJE')
    SET 
        ID_HOTELU = i.ID_HOTELU,
        ID_KLIENTA = i.ID_KLIENTA,
        ID_PRACOWNIKA = i.ID_PRACOWNIKA,
        ID_POKOJU = i.ID_POKOJU,
        PRZYJAZD = i.PRZYJAZD,
        ODJAZD = i.ODJAZD,
        ZAMELDOWANIE = i.ZAMELDOWANIE,
        ODMELDOWANIE = i.ODMELDOWANIE,
        OPLATA_ZNISCZENIE = i.OPLATA_ZNISCZENIE,
        CENA_POBYTU = i.CENA_POBYTU,
        OPLATA_ZALICZKA = i.OPLATA_ZALICZKA,
        OPLATA_CALOSC = i.OPLATA_CALOSC
    FROM INSERTED i
    WHERE REZERWACJE.ID_REZERWACJI = i.ID_REZERWACJI;
END;
GO

-------------- ------------------ --------------
-------------- -- DODAJ USLUGI -- --------------
-------------- ------------------ --------------
CREATE TRIGGER TRIGGER_DODAJ_USLUGI
ON USLUGI_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_USLUGI, ID_HOTELU, NAZWA, CENA FROM USLUGI')
    SELECT ID_USLUGI, ID_HOTELU, NAZWA, CENA
    FROM INSERTED;
END;
GO

-------------- ----------------------- --------------
-------------- -- AKTUALIZUJ USLUGI -- --------------
-------------- ----------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_USLUGI
ON USLUGI_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_USLUGI, ID_HOTELU, NAZWA, CENA FROM USLUGI')
    SET 
        ID_HOTELU = i.ID_HOTELU,
        NAZWA = i.NAZWA,
        CENA = i.CENA
    FROM INSERTED i
    WHERE USLUGI.ID_USLUGI = i.ID_USLUGI;
END;
GO

-------------- ----------------------------- --------------
-------------- -- DODAJ REZERWACJE USLUGI -- --------------
-------------- ----------------------------- --------------
CREATE TRIGGER TRIGGER_DODAJ_REZERWACJE_USLUGI
ON REZERWACJE_USLUGI_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_REZ_USLUGI, ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB FROM REZERWACJE_USLUGI')
    SELECT ID_REZ_USLUGI, ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB
    FROM INSERTED;
END;
GO

-------------- ---------------------------------- --------------
-------------- -- AKTUALIZUJ REZERWACJE USLUGI -- --------------
-------------- ---------------------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_REZERWACJE_USLUGI
ON REZERWACJE_USLUGI_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_REZ_USLUGI, ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB FROM REZERWACJE_USLUGI')
    SET 
        ID_HOTELU = i.ID_HOTELU,
        ID_USLUGI = i.ID_USLUGI,
        ID_REZERWACJI = i.ID_REZERWACJI,
        LICZBA_OSOB = i.LICZBA_OSOB
    FROM INSERTED i
    WHERE REZERWACJE_USLUGI.ID_REZ_USLUGI = i.ID_REZ_USLUGI;
END;
GO

-------------- ------------------ --------------
-------------- -- DODAJ GOSCIE -- --------------
-------------- ------------------ --------------
CREATE TRIGGER TRIGGER_DODAJ_GOSCIE
ON GOSCIE_HOTELU
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_REZERWACJI, IMIE, NAZWISKO FROM GOSCIE')
    SELECT ID_REZERWACJI, IMIE, NAZWISKO
    FROM INSERTED;
END;
GO

-------------- ----------------------- --------------
-------------- -- AKTUALIZUJ GOSCIE -- --------------
-------------- ----------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_GOSCIE
ON GOSCIE_HOTELU
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_REZERWACJI, IMIE, NAZWISKO FROM GOSCIE')
    SET 
        IMIE = i.IMIE,
        NAZWISKO = i.NAZWISKO
    FROM INSERTED i
    WHERE GOSCIE.ID_REZERWACJI = i.ID_REZERWACJI;
END;
GO

-------------- ------------------- --------------
-------------- -- DODAJ KLIENTA -- --------------
-------------- ------------------- --------------
CREATE TRIGGER TRIGGER_DODAJ_KLIENT
ON KLIENT_VIEW
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO OPENQUERY(HOTEL, 'SELECT ID_KLIENTA, ID_OSOBY, ID_ZNIZKI, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ, PROCENT FROM KLIENCI')
    SELECT ID_KLIENTA, ID_OSOBY, ID_ZNIZKI, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ, PROCENT
    FROM INSERTED;
END;
GO

-------------- ----------------------- --------------
-------------- -- AKTUALIZUJ KLIENT -- --------------
-------------- ----------------------- --------------
CREATE TRIGGER TRIGGER_AKTUALIZUJ_KLIENT
ON KLIENT_VIEW
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE OPENQUERY(HOTEL, 'SELECT ID_KLIENTA, ID_OSOBY, ID_ZNIZKI, IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ, PROCENT FROM KLIENCI')
    SET 
        ID_OSOBY = i.ID_OSOBY,
        ID_ZNIZKI = i.ID_ZNIZKI,
        IMIE = i.IMIE,
        NAZWISKO = i.NAZWISKO,
        EMAIL = i.EMAIL,
        NR_TELEFONU = i.NR_TELEFONU,
        ULICA = i.ULICA,
        NR_DOMU = i.NR_DOMU,
        NR_MIESZKANIA = i.NR_MIESZKANIA,
        MIEJSCOWOSC = i.MIEJSCOWOSC,
        KOD_POCZTOWY = i.KOD_POCZTOWY,
        KRAJ = i.KRAJ,
        PROCENT = i.PROCENT
    FROM INSERTED i
    WHERE KLIENCI.ID_KLIENTA = i.ID_KLIENTA;
END;
GO




-------------- ------------------------ -------------- 
-------------- -- WYPOSAZENIE POKOJU -- -------------- 
-------------- ------------------------ -------------- 
CREATE FUNCTION WYPOSAZENIE_POKOJU(
@NR_POKOJU INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM WYPOSAZENIE_POKOJOW_HOTELU
    WHERE NR_POKOJU = @NR_POKOJU
);
GO

--SELECT * FROM WYPOSAZENIE_POKOJU(201);
--GO

-------------- ---------------------------- -------------- 
-------------- -- DO POSPRZATANIA POKOJU -- -------------- 
-------------- ---------------------------- -------------- 
CREATE OR ALTER FUNCTION DO_POSPRZATANIA()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE POSPRZATANY <> 'TAK'
);
GO
--SELECT * FROM DO_POSPRZATANIA();
--GO

-------------- ----------------------- -------------- 
-------------- -- DO NAPRAWY POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR ALTER FUNCTION DO_NAPRAWY()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE WYMAGA_NAPRAWY <> 'NIE'
);
GO
--SELECT * FROM DO_NAPRAWY();
--GO

-------------- --------------------- --------------
-------------- -- DOSTĘPNE POKOJE -- --------------
-------------- --------------------- --------------
CREATE OR ALTER FUNCTION DOSTEPNE_POKOJE(
    @DATA_PRZYJAZDU DATE,
    @DATA_ODJAZDU DATE,
    @LICZBA_OSOB INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT p.ID_POKOJU, p.NR_POKOJU, p.LICZBA_OSOB, p.CENA
    FROM POKOJE_HOTELU p
    LEFT JOIN REZERWACJE_HOTELU r ON p.ID_POKOJU = r.ID_POKOJU
        AND (
            (@DATA_PRZYJAZDU BETWEEN r.PRZYJAZD AND r.ODJAZD) OR
            (@DATA_ODJAZDU BETWEEN r.PRZYJAZD AND r.ODJAZD) OR
            (r.PRZYJAZD BETWEEN @DATA_PRZYJAZDU AND @DATA_ODJAZDU) OR
            (r.ODJAZD BETWEEN @DATA_PRZYJAZDU AND @DATA_ODJAZDU)
        )
    WHERE r.ID_POKOJU IS NULL
    AND p.LICZBA_OSOB >= @LICZBA_OSOB
);
GO

--SELECT * FROM DOSTEPNE_POKOJE('2024-06-01', '2024-06-10', 2);
--GO

-------------- ---------------------------- --------------
-------------- -- REZERWACJE DLA KLIENTA -- --------------
-------------- ---------------------------- --------------
CREATE OR ALTER FUNCTION REZERWACJE_DLA_KLIENTA(
    @ID_KLIENTA INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT r.ID_REZERWACJI, r.ID_HOTELU, r.ID_PRACOWNIKA, r.ID_POKOJU, r.PRZYJAZD, r.ODJAZD, r.ZAMELDOWANIE, r.ODMELDOWANIE, r.OPLATA_ZNISCZENIE, r.CENA_POBYTU, r.OPLATA_ZALICZKA, r.OPLATA_CALOSC
    FROM REZERWACJE_KLIENTA r
    WHERE r.ID_KLIENTA = @ID_KLIENTA
);
GO
--SELECT * FROM REZERWACJE_DLA_KLIENTA(1);
--GO

-------------- -------------------------- --------------
-------------- -- GOŚCIE DO REZERWACJI -- --------------
-------------- -------------------------- --------------
CREATE OR ALTER FUNCTION GOSCIE_DO_REZERWACJI(
    @ID_REZERWACJI INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT g.IMIE, g.NAZWISKO
    FROM GOSCIE_HOTELU g
    WHERE g.ID_REZERWACJI = @ID_REZERWACJI
);
GO

--SELECT * FROM GOSCIE_DO_REZERWACJI(1);
--GO

-------------- ------------------------------------- --------------
-------------- -- PRZENOSZENIE STARYCH REZERWACJI -- --------------
-------------- ------------------------------------- --------------
CREATE OR ALTER PROCEDURE PRZENIES_STARE_REZERWACJE
AS
BEGIN
    BEGIN TRY
        DECLARE @DATA_GRANICZNA DATE = DATEADD(YEAR, -1, GETDATE());

        -- Przenoszenie danych do tabeli archiwum
        INSERT INTO ARCHIWUM_REZERWACJI (ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC)
        SELECT ID_REZERWACJI, ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD, ZAMELDOWANIE, ODMELDOWANIE, OPLATA_ZNISCZENIE, CENA_POBYTU, OPLATA_ZALICZKA, OPLATA_CALOSC
        FROM REZERWACJE_HOTELU
        WHERE ODJAZD < @DATA_GRANICZNA;

        -- Usuwanie danych z oryginalnej tabeli
        DELETE FROM REZERWACJE_HOTELU
        WHERE ODJAZD < @DATA_GRANICZNA;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- EXEC PRZENIES_STARE_REZERWACJE;
-- GO
