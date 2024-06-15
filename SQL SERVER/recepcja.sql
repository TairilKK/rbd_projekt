USE [RBDHOTEL]
GO
-------------- ------------------- -------------- 
-------------- -- DODAJ KLIENTA -- -------------- 
-------------- ------------------- -------------- 
CREATE OR ALTER PROCEDURE RECEPCJA.DODAJ_KLIENTA
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
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_KLIENTA(''' 
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
-------------- ------------------ -------------- 
-------------- -- DODAJ GOSCIA -- -------------- 
-------------- ------------------ -------------- 
CREATE PROCEDURE recepcja.DODAJ_GOSCIA
    @ID_REZERWACJI INT,
    @IMIE NVARCHAR(100),
    @NAZWISKO NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_GOSCIA('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', ''' 
               + @IMIE + ''', ''' 
               + @NAZWISKO + '''); END;';

    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ---------------------- -------------- 
-------------- -- DODAJ REZERWACJE -- -------------- 
-------------- ---------------------- -------------- 
CREATE OR ALTER PROCEDURE recepcja.DODAJ_REZERWACJE
    @ID_HOTELU INT,
    @ID_KLIENTA INT,
    @ID_POKOJU INT,
    @PRZYJAZD DATETIME,
    @ODJAZD DATETIME
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_REZERWACJE('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', '
               + CAST(@ID_KLIENTA AS NVARCHAR) + ', '
               + CAST(@ID_POKOJU AS NVARCHAR) + ', '
               + '''' + CONVERT(NVARCHAR, @PRZYJAZD, 120) + ''', '
               + '''' + CONVERT(NVARCHAR, @ODJAZD, 120) + '''); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- WYPOSAZENIE POKOJU -- -------------- 
-------------- ------------------------ -------------- 
CREATE FUNCTION recepcja.WYPOSAZENIE_POKOJU(
@NR_POKOJU INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM wlasciciel.WYPOSAZENIE_POKOJOW_HOTELU
    WHERE NR_POKOJU = @NR_POKOJU
);
GO
-------------- ------------------------ -------------- 
-------------- DODAJ_REZERWACJA_USULGA --------------
-------------- ------------------------ -------------- 
CREATE OR ALTER PROCEDURE recepcja.DODAJ_REZERWACJA_USULGA
    @ID_HOTELU INT,
    @ID_USLUGI INT,
    @ID_REZERWACJI INT,
    @LICZBA_OSOB INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.DODAJ_REZERWACJA_USULGA('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', '
               + CAST(@ID_USLUGI AS NVARCHAR) + ', '
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- -------------------- -------------- 
-------------- -- OPLAC_ZALICZKE -- --------------
-------------- -------------------- -------------- 
CREATE OR ALTER PROCEDURE recepcja.OPLAC_ZALICZKE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.OPLAC_ZALICZKE('
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- OPLATA_ZNISZCZENIE -- --------------
-------------- ------------------------ -------------- 
CREATE OR ALTER PROCEDURE recepcja.OPLATA_ZNISZCZENIE
    @ID_REZERWACJI INT,
    @OPLATA_ZNISCZENIE INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.OPLATA_ZNISZCZENIE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@OPLATA_ZNISCZENIE AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- -------------------------- -------------- 
-------------- -- POTWIERDZ REZERWACJE -- -------------- 
-------------- -------------------------- --------------
CREATE PROCEDURE recepcja.POTWIERDZ_REZERWACJE
    @ID_REZERWACJI INT,
    @ID_PRACOWNIKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.POTWIERDZ_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------- -------------- 
-------------- -- USUN GOSCIA -- -------------- 
-------------- ----------------- -------------- 
CREATE PROCEDURE recepcja.USUN_GOSCIA
    @ID_REZERWACJI INT,
    @IMIE NVARCHAR,
	@NAZWISKO NVARCHAR
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_GOSCIA('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '''
			   + @IMIE + ', '''
			   + @NAZWISKO + '''); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- --------------------- -------------- 
-------------- -- USUN REZERWACJE -- -------------- 
-------------- --------------------- -------------- 
CREATE PROCEDURE recepcja.USUN_REZERWACJE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.USUN_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- ZAKONCZ REZERWACJE -- -------------- 
-------------- ------------------------ -------------- 
CREATE PROCEDURE recepcja.ZAKONCZ_REZERWACJE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.ZAKONCZ_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ') END;';
    EXEC (@sql) AT HOTEL;
END;
GO