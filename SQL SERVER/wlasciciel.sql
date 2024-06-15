USE [RBDHOTEL]
GO
-------------- ------------------ -------------- 
-------------- -- DODAJ ZNIZKE -- -------------- 
-------------- ------------------ -------------- 
CREATE PROCEDURE WLASCICIEL.DODAJ_ZNIZKE
    @ZNIZKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- Przygotowanie zapytania do wykonania na serwerze Oracle
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_ZNIZKE(' + CAST(@ZNIZKA AS NVARCHAR) + '); END;';

    -- Wykonanie zapytania na zdalnym serwerze Oracle przez Linked Server
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- DODAJ HOTEL -- -------------- 
-------------- ----------------- -------------- 
CREATE PROCEDURE WLASCICIEL.DODAJ_HOTEL
    @NAZWA NVARCHAR(200),
    @ULICA NVARCHAR(200),
    @NR_DOMU INT,
    @NR_MIESZKANIA INT,
    @MIEJSCOWOSC NVARCHAR(100),
    @KOD_POCZTOWY NVARCHAR(20),
    @KRAJ NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_HOTEL(''' 
               + @NAZWA + ''', ''' 
               + @ULICA + ''', ' 
               + CAST(@NR_DOMU AS NVARCHAR) + ', ' 
               + CAST(@NR_MIESZKANIA AS NVARCHAR) + ', ''' 
               + @MIEJSCOWOSC + ''', ''' 
               + @KOD_POCZTOWY + ''', ''' 
               + @KRAJ + '''); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------------- -------------- 
-------------- -- DODAJ PRACOWNIKA -- -------------- 
-------------- ---------------------- -------------- 
CREATE PROCEDURE wlasciciel.DODAJ_PRACOWNIKA
    @IMIE NVARCHAR(100),
    @NAZWISKO NVARCHAR(100),
    @EMAIL NVARCHAR(100),
    @NR_TELEFONU NVARCHAR(50),
    @ULICA NVARCHAR(200),
    @NR_DOMU INT,
    @NR_MIESZKANIA INT,
    @MIEJSCOWOSC NVARCHAR(100),
    @KOD_POCZTOWY NVARCHAR(20),
    @KRAJ NVARCHAR(100),
    @ID_HOTELU INT,
    @PENSJA DECIMAL(18, 2),
    @STANOWISKO NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = N'BEGIN RBDHOTEL.DODAJ_PRACOWNIKA(''' 
               + @IMIE + ''', ''' 
               + @NAZWISKO + ''', ''' 
               + @EMAIL + ''', ''' 
               + @NR_TELEFONU + ''', ''' 
               + @ULICA + ''', ' 
               + CAST(@NR_DOMU AS NVARCHAR) + ', ' 
               + CAST(@NR_MIESZKANIA AS NVARCHAR) + ', ''' 
               + @MIEJSCOWOSC + ''', ''' 
               + @KOD_POCZTOWY + ''', ''' 
               + @KRAJ + ''', ' 
               + CAST(@ID_HOTELU AS NVARCHAR) + ', ' 
               + CAST(@PENSJA AS NVARCHAR) + ', ''' 
               + @STANOWISKO + '''); END;';

    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- DODAJ POKOJ -- -------------- 
-------------- ----------------- -------------- 
CREATE PROCEDURE wlasciciel.DODAJ_POKOJ
    @ID_HOTELU INT,
    @NR_POKOJU INT,
    @LICZBA_OSOB INT,
    @CENA DECIMAL(18, 2)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_POKOJ('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', ' 
               + CAST(@NR_POKOJU AS NVARCHAR) + ', ' 
               + CAST(@LICZBA_OSOB AS NVARCHAR) + ', ' 
               + CAST(@CENA AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------- -------------- 
-------------- -- DODAJ WYPOSAZENIE -- -------------- 
-------------- ----------------------- -------------- 
CREATE PROCEDURE wlasciciel.DODAJ_WYPOSAZENIE
    @ID_POKOJU INT,
    @NAZWA NVARCHAR(200),
    @ILOSC INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_WYPOSAZENIE('
               + CAST(@ID_POKOJU AS NVARCHAR) + ', ''' 
               + @NAZWA + ''', ' 
               + CAST(@ILOSC AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------ -------------- 
-------------- -- DODAJ USLUGE -- -------------- 
-------------- ------------------ -------------- 
CREATE PROCEDURE wlasciciel.DODAJ_USLUGE
    @ID_HOTELU INT,
    @NAZWA NVARCHAR(200),
    @CENA DECIMAL(18, 2)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_USLUGE('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', ''' 
               + @NAZWA + ''', ' 
               + CAST(@CENA AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------- -------------- 
-------------- -- EDYTUJ_ZNIZKE -- --------------
-------------- ------------------- -------------- 
CREATE PROCEDURE wlasciciel.EDYTUJ_ZNIZKE
    @ID_ZNIZKI INT,
    @PROCNET INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.EDYTUJ_ZNIZKE('
               + CAST(@ID_ZNIZKI AS NVARCHAR) + ', '
			   + CAST(@PROCNET AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------- -------------- 
-------------- -- USLUGA ZMIEN CENE -- -------------- 
-------------- ----------------------- -------------- 
CREATE PROCEDURE wlasciciel.USLUGA_ZMIEN_CENE
    @ID_USLUGI INT,
    @CENA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USLUGA_ZMIEN_CENE('
               + CAST(@ID_USLUGI AS NVARCHAR) + ', '
			   + CAST(@CENA AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- USLUGA ZMIEN NAZWE -- -------------- 
-------------- ------------------------ -------------- 
CREATE PROCEDURE wlasciciel.USLUGA_ZMIEN_NAZWE
    @ID_USLUGI INT,
    @NOWA_NAZWA NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USLUGA_ZMIEN_CENE('
               + CAST(@ID_USLUGI AS NVARCHAR) + ', '''
			   + @NOWA_NAZWA + '''); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------- -------------- 
-------------- -- USUN POKOJ -- -------------- 
-------------- ---------------- -------------- 
CREATE PROCEDURE wlasciciel.USUN_POKOJ
    @ID_POKOJU INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_POKOJ('
               + CAST(@ID_POKOJU AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- USUN USLUGE -- -------------- 
-------------- ----------------- -------------- 
CREATE PROCEDURE wlasciciel.USUN_USLUGE
    @ID_USLUGI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_USLUGE('
               + CAST(@ID_USLUGI AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------------- -------------- 
-------------- -- USUN WYPOSAZENIE -- -------------- 
-------------- ---------------------- -------------- 
CREATE PROCEDURE wlasciciel.USUN_WYPOSAZENIE
    @ID_POKOJU INT,
	@NAZWA NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_WYPOSAZENIE('
               + CAST(@ID_POKOJU AS NVARCHAR) + ', '''
			   + @NAZWA + ''') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- USUN ZNIZKE -- -------------- 
-------------- ----------------- -------------- 
CREATE PROCEDURE wlasciciel.USUN_ZNIZKE
    @ID_ZNIZKI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_ZNIZKE('
               + CAST(@ID_ZNIZKI AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------- -------------- 
-------------- -- ZMIEN CENE POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_CENE_POKOJU
    @ID_POKOJU INT,
	@CENA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_CENE_POKOJU('
				+ CAST(@ID_POKOJU AS NVARCHAR) + ', '
               + CAST(@CENA AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------------- -------------- 
-------------- -- ZMIEN ILOSC WYPOSAZENIA -- -------------- 
-------------- ----------------------------- -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_ILOSC_WYPOSAZENIA
    @ID_POKOJU INT,
	@NAZWA NVARCHAR,
	@ILOSC INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_ILOSC_WYPOSAZENIA('
				+ CAST(@ID_POKOJU AS NVARCHAR) + ', '''
				+ @NAZWA + ''', '
               + CAST(@ILOSC AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------------ -------------- 
-------------- -- ZMIEN LICZBE OSOB POKOJU -- -------------- 
-------------- ------------------------------ -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_LICZBE_OSOB_POKOJU
    @ID_POKOJU INT,
	@LICZBA_OSOB INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_LICZBE_OSOB_POKOJU('
				+ CAST(@ID_POKOJU AS NVARCHAR) + ', '
                + CAST(@LICZBA_OSOB AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- ZMIEN NAZWE HOTELU -- -------------- 
-------------- ------------------------ -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_NAZWE_HOTELU
    @ID_HOTELU INT,
	@NAZWA NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_NAZWE_HOTELU('
				+ CAST(@ID_HOTELU AS NVARCHAR) + ', '''
                + @NAZWA + ''') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------------- -------------- 
-------------- -- ZMIEN NAZWE WYPOSAZENIA -- -------------- 
-------------- ----------------------------- -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_NAZWE_WYPOSAZENIA
    @ID_HOTELU INT,
	@NAZWA NVARCHAR,
	@NOWA_NAZWA NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_NAZWE_WYPOSAZENIA('
				+ CAST(@ID_HOTELU AS NVARCHAR) + ', '''
                + @NAZWA + ''', '''
				+ @NOWA_NAZWA + ''') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- ZMIEN NUMER POKOJU -- -------------- 
-------------- ------------------------ -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_NUMER_POKOJU
    @ID_POKOJU INT,
	@NR_POKOJU INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_NUMER_POKOJU('
				+ CAST(@ID_POKOJU AS NVARCHAR) + ', '
                + CAST(@NR_POKOJU AS NVARCHAR) + ', END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------ -------------- 
-------------- -- ZMIEN PENSJE -- -------------- 
-------------- ------------------ -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_PENSJE
    @ID_PRACOWNIKA INT,
	@PENSJA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_PENSJE('
				+ CAST(@ID_PRACOWNIKA AS NVARCHAR) + ', '
                + CAST(@PENSJA AS NVARCHAR) + ', END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------------- -------------- 
-------------- -- ZMIEN STANOWISKO -- -------------- 
-------------- ---------------------- -------------- 
CREATE PROCEDURE wlasciciel.ZMIEN_STANOWISKO
    @ID_PRACOWNIKA INT,
	@STANOWIKSO NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZMIEN_STANOWISKO('
				+ CAST(@ID_PRACOWNIKA AS NVARCHAR) + ', '''
                + @STANOWIKSO + ''', END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- ZWOLNIJ PRACOWNIKA -- -------------- 
-------------- ------------------------ -------------- 
CREATE PROCEDURE wlasciciel.ZWOLNIJ_PRACOWNIKA
    @ID_PRACOWNIKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZWOLNIJ_PRACOWNIKA('
				+ CAST(@ID_PRACOWNIKA AS NVARCHAR) + 'END;';
    EXEC (@sql) AT HOTEL;
END;
GO