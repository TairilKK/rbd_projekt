USE [RBDHOTEL]
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
    SET @sql = N'BEGIN RBDHOTEL.RECEPCJA.DODAJ_REZERWACJA_USLUGA('
               + CAST(@ID_HOTELU AS NVARCHAR) + ', '
               + CAST(@ID_USLUGI AS NVARCHAR) + ', '
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
	PRINT @sql;
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
    SET @sql = N'BEGIN RBDHOTEL.RECEPCJA.OPLATA_ZNISZCZENIE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@OPLATA_ZNISCZENIE AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- -------------------------- -------------- 
-------------- -- POTWIERDZ REZERWACJE -- -------------- 
-------------- -------------------------- --------------
CREATE or alter PROCEDURE recepcja.POTWIERDZ_REZERWACJE
    @ID_REZERWACJI INT,
    @ID_PRACOWNIKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.RECEPCJA.POTWIERDZ_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ------------------------ -------------- 
-------------- -- ZAKONCZ REZERWACJE -- -------------- 
-------------- ------------------------ -------------- 
CREATE OR ALTER PROCEDURE recepcja.ZAKONCZ_REZERWACJE
    @ID_REZERWACJI INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.RECEPCJA.ZAKONCZ_REZERWACJE('
               + CAST(@ID_REZERWACJI AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO