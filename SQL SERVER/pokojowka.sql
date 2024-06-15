USE [RBDHOTEL]
GO
-------------- ---------------------------- -------------- 
-------------- -- DO POSPRZATANIA POKOJU -- -------------- 
-------------- ---------------------------- -------------- 
CREATE OR ALTER FUNCTION pokojowka.DO_POSPRZATANIA()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM POKOJE_HOTELU
    WHERE POSPRZATANY <> 'TAK'
);
GO
-------------- ----------------------- -------------- 
-------------- -- POKOJ_POSPRZATANY -- --------------
-------------- ----------------------- -------------- 
CREATE OR ALTER PROCEDURE pokojowka.POKOJ_POSPRZATANY
    @ID_POKOJU INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.POKOJ_POSPRZATANY('
			   + CAST(@ID_POKOJU AS NVARCHAR) + '); END;';
    EXEC (@sql) AT HOTEL;
END;
