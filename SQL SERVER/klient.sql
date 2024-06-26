USE [RBDHOTEL]
GO
-------------- ------------------ -------------- 
-------------- -- DODAJ GOSCIA -- -------------- 
-------------- ------------------ -------------- 
CREATE PROCEDURE klient.DODAJ_GOSCIA
    @ID_REZERWACJI INT,
    @IMIE NVARCHAR(100),
    @NAZWISKO NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KLIENT.DODAJ_GOSCIA('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', ''' 
               + @IMIE + ''', ''' 
               + @NAZWISKO + '''); END;';

    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------- -------------- 
-------------- -- DODAJ KLIENTA -- -------------- 
-------------- ------------------- -------------- 
CREATE OR ALTER PROCEDURE KLIENT.DODAJ_KLIENTA
    @IMIE NVARCHAR(100),
    @NAZWISKO NVARCHAR(100),
    @EMAIL NVARCHAR(100),
    @NR_TELEFONU NVARCHAR(50),
    @ULICA NVARCHAR(200),
    @NR_DOMU INT,
    @NR_MIESZKANIA INT,
    @MIEJSCOWOSC NVARCHAR(100),
    @KOD_POCZTOWY NVARCHAR(20),
    @KRAJ NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KLIENT.DODAJ_KLIENTA(''' 
               + @IMIE + ''', ''' 
               + @NAZWISKO + ''', ''' 
               + @EMAIL + ''', ''' 
               + @NR_TELEFONU + ''', ''' 
               + @ULICA + ''', ' 
               + CAST(@NR_DOMU AS NVARCHAR) + ', ' 
               + CAST(@NR_MIESZKANIA AS NVARCHAR) + ', ''' 
               + @MIEJSCOWOSC + ''', ''' 
               + @KOD_POCZTOWY + ''', ''' 
               + @KRAJ + '''); END;'
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------------- -------------- 
-------------- -- DODAJ REZERWACJE -- -------------- 
-------------- ---------------------- -------------- 
-- PROCEDURE DODAJ_REZERWACJE(
--  P_ID_HOTELU IN NUMBER,
--  P_ID_KLIENTA IN NUMBER,
--  P_LICZBA_OSOB IN NUMBER,
--  P_PRZYJAZD IN DATE,
--  P_ODJAZD IN DATE
--);
CREATE OR ALTER PROCEDURE KLIENT.DODAJ_REZERWACJE
    @ID_HOTELU INT,
    @ID_KLIENTA INT,
    @LICZBA_OSOB INT,
    @PRZYJAZD DATE,
    @ODJAZD DATE
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KLIENT.DODAJ_REZERWACJE('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', '
               + CAST(@ID_KLIENTA AS NVARCHAR) + ', '
               + CAST(@LICZBA_OSOB AS NVARCHAR) + ', '
               + 'TO_DATE(''' + CONVERT(NVARCHAR, @PRZYJAZD, 23) + ''', ''YYYY-MM-DD''), '
               + 'TO_DATE(''' + CONVERT(NVARCHAR, @ODJAZD, 23) + ''', ''YYYY-MM-DD'')); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- -------------------- -------------- 
-------------- -- OPLAC_ZALICZKE -- --------------
-------------- -------------------- -------------- 
CREATE OR ALTER PROCEDURE klient.OPLAC_ZALICZKE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.OPLAC_ZALICZKE('
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- USUN GOSCIA -- -------------- 
-------------- ----------------- -------------- 
CREATE OR ALTER PROCEDURE klient.USUN_GOSCIA
    @ID_REZERWACJI INT,
    @IMIE NVARCHAR(50),
	@NAZWISKO NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KLIENT.USUN_GOSCIA('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '''
			   + @IMIE + ''', '''
			   + @NAZWISKO + '''); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- --------------------- -------------- 
-------------- -- USUN REZERWACJE -- -------------- 
-------------- --------------------- -------------- 
CREATE or alter PROCEDURE klient.USUN_REZERWACJE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KLIENT.USUN_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO