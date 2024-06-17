USE [RBDHOTEL]
GO
-------------- ----------------------- -------------- 
-------------- -- DO NAPRAWY POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR ALTER FUNCTION konserwacja.DO_NAPRAWY()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE WYMAGA_NAPRAWY <> 'NIE'
);
GO
-------------- ---------------------- -------------- 
-------------- -- POKOJ_NAPRAWIONY -- --------------
-------------- ---------------------- -------------- 
CREATE OR ALTER PROCEDURE konserwacja.POKOJ_NAPRAWIONY
	@ID_HOTELU INT
	@ID_REZERWACJI INT,
    @NR_POKOJU INT,			
	@ID_PRACOWNIKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.KONSERWATOR.POKOJ_NAPRAWIONY('
			   + CAST(@ID_HOTELU AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@NR_POKOJU AS NVARCHAR) + ', '
			   + CAST(@ID_PRACOWNIKA AS NVARCHAR) + ', sysdate); END;';
    EXEC (@sql) AT HOTEL;
END;
GO