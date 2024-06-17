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
    @ID_HOTELU INT
	@ID_REZERWACJI INT,
    @NR_POKOJU INT,
	@ID_PRACOWNIKA INT
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.POKOJOWKA.POKOJ_POSPRZATANY('
			   + CAST(@ID_HOTELU AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@NR_POKOJU AS NVARCHAR) + ', '
			   + CAST(@ID_PRACOWNIKA AS NVARCHAR) + ', sysdate); END;';
    EXEC (@sql) AT HOTEL;
END;
