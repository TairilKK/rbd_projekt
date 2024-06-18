USE [RBDHOTEL]
GO
-------------- ---------------------- -------------- 
-------------- -- DO POSPRZATANIA  -- -------------- 
-------------- ---------------------- -------------- 
CREATE OR ALTER PROCEDURE klient.DO_NAPRAWY
    @ID_HOTELU INT,
	@ID_REZERWACJI INT,
    @NR_POKOJU INT,
	@OPIS NVARCHAR(255),
	@GODZINA_POCZATEK TIME,
	@GODZINA_KONIEC TIME
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BEGIN RBDHOTEL.POKOJ_DO_NAPRAWY('
			   + CAST(@ID_HOTELU AS NVARCHAR) + ', '
			   + CAST(@ID_REZERWACJI AS NVARCHAR) + ', '
			   + CAST(@NR_POKOJU AS NVARCHAR) + ', '''
			   + @OPIS + ''', TO_TIMESTAMP('''
			   + CAST(@GODZINA_POCZATEK AS NVARCHAR) + ''',''HH24:Mi:SS.FF7''), TO_TIMESTAMP('''
			   + CAST(@GODZINA_KONIEC AS NVARCHAR) + ''',''HH24:Mi:SS.FF7'')); END;';
    EXEC (@sql) AT HOTEL;
END;
GO
-------------- ----------------------- -------------- 
-------------- -- POKOJ_POSPRZATANY -- --------------
-------------- ----------------------- -------------- 
CREATE OR ALTER PROCEDURE konserwacja.POKOJ_NAPRAWIONY
    @ID_HOTELU INT,
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
