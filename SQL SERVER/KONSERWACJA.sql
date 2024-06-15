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
    @ID_POKOJU INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.POKOJ_NAPRAWIONY('
			   + CAST(@ID_POKOJU AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
GO