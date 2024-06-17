--TEST PROCEDUR

-- DBO
DECLARE
	@ID_HOTELU INT = 1
BEGIN
	PRINT('DBO');
	EXEC UTWORZ_WIDOK_PERSONEL_HOTELU @ID_HOTELU;
	EXEC UTWORZ_WIDOK_POKOJE_HOTELU @ID_HOTELU;
	EXEC UTWORZ_WIDOK_WYPOSAZENIE_POKOJOW_HOTELU @ID_HOTELU;
END;

BEGIN
	PRINT('WLASCICIEL');
	-- Dodanie hotelu w £odzi
	EXEC WLASCICIEL.DODAJ_HOTEL
		@NAZWA = N'Hotel £ódŸ',
		@ULICA = N'Piotrkowska',
		@NR_DOMU = 123,
		@NR_MIESZKANIA = 1,
		@MIEJSCOWOSC = N'£ódŸ',
		@KOD_POCZTOWY = N'90-001',
		@KRAJ = N'Polska';

	-- Dodanie drugiego hotelu
	EXEC WLASCICIEL.DODAJ_HOTEL
		@NAZWA = N'Hotel Kraków',
		@ULICA = N'Floriañska',
		@NR_DOMU = 45,
		@NR_MIESZKANIA = 1,
		@MIEJSCOWOSC = N'Kraków',
		@KOD_POCZTOWY = N'31-019',
		@KRAJ = N'Polska';

	-- Dodanie trzeciego hotelu
	EXEC WLASCICIEL.DODAJ_HOTEL
		@NAZWA = N'Hotel Gdañsk',
		@ULICA = N'D³uga',
		@NR_DOMU = 12,
		@NR_MIESZKANIA = 1,
		@MIEJSCOWOSC = N'Gdañsk',
		@KOD_POCZTOWY = N'80-827',
		@KRAJ = N'Polska';


	EXEC WLASCICIEL.DODAJ_ZNIZKE 5;
	EXEC WLASCICIEL.DODAJ_ZNIZKE 10;
	EXEC WLASCICIEL.DODAJ_ZNIZKE 20;
END;

-- RECEPCJA
BEGIN
	PRINT('RECEPCJA');
END;

SELECT * FROM HOTEL..RBDHOTEL.HOTELE

-- Dodanie w³aœcicieli do hoteli
EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = N'Jan',
    @NAZWISKO = N'Kowalski',
    @EMAIL = N'jan.kowalski@hotel1.pl',
    @NR_TELEFONU = N'123456789',
    @ULICA = N'Piotrkowska',
    @NR_DOMU = 1,
    @NR_MIESZKANIA = 22,
    @MIEJSCOWOSC = N'£ódŸ',
    @KOD_POCZTOWY = N'90-001',
    @KRAJ = N'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 10000.00,
    @STANOWISKO = N'W£AŒCICIEL';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = N'Anna',
    @NAZWISKO = N'Nowak',
    @EMAIL = N'anna.nowak@hotel2.pl',
    @NR_TELEFONU = N'987654321',
    @ULICA = N'Floriañska',
    @NR_DOMU = 2,
    @NR_MIESZKANIA = 12,
    @MIEJSCOWOSC = N'Kraków',
    @KOD_POCZTOWY = N'31-019',
    @KRAJ = N'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 10000.00,
    @STANOWISKO = N'W£AŒCICIEL';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = N'Piotr',
    @NAZWISKO = N'Wiœniewski',
    @EMAIL = N'piotr.wisniewski@hotel3.pl',
    @NR_TELEFONU = N'112233445',
    @ULICA = N'D³uga',
    @NR_DOMU = 3,
    @NR_MIESZKANIA = 1,
    @MIEJSCOWOSC = N'Gdañsk',
    @KOD_POCZTOWY = N'80-827',
    @KRAJ = N'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 10000.00,
    @STANOWISKO = N'W£AŒCICIEL';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Anna',
    @NAZWISKO = 'Kowalska',
    @EMAIL = 'anna.kowalska@example.com',
    @NR_TELEFONU = '123456789',
    @ULICA = 'Dluga',
    @NR_DOMU = 1,
    @NR_MIESZKANIA = 1,
    @MIEJSCOWOSC = 'Warszawa',
    @KOD_POCZTOWY = '00-001',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3000.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Maria',
    @NAZWISKO = 'Nowak',
    @EMAIL = 'maria.nowak@example.com',
    @NR_TELEFONU = '987654321',
    @ULICA = 'Krotka',
    @NR_DOMU = 2,
    @NR_MIESZKANIA = 2,
    @MIEJSCOWOSC = 'Kraków',
    @KOD_POCZTOWY = '30-002',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3100.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Katarzyna',
    @NAZWISKO = 'Wiœniewska',
    @EMAIL = 'katarzyna.wisniewska@example.com',
    @NR_TELEFONU = '555666777',
    @ULICA = 'Szeroka',
    @NR_DOMU = 3,
    @NR_MIESZKANIA = 3,
    @MIEJSCOWOSC = 'Poznañ',
    @KOD_POCZTOWY = '61-003',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3200.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Ewa',
    @NAZWISKO = 'Kwiatkowska',
    @EMAIL = 'ewa.kwiatkowska@example.com',
    @NR_TELEFONU = '234567890',
    @ULICA = 'Polna',
    @NR_DOMU = 4,
    @NR_MIESZKANIA = 10,
    @MIEJSCOWOSC = 'Gdañsk',
    @KOD_POCZTOWY = '80-004',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3000.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Joanna',
    @NAZWISKO = 'Lewandowska',
    @EMAIL = 'joanna.lewandowska@example.com',
    @NR_TELEFONU = '876543210',
    @ULICA = 'S³oneczna',
    @NR_DOMU = 5,
    @NR_MIESZKANIA = 15,
    @MIEJSCOWOSC = 'Wroc³aw',
    @KOD_POCZTOWY = '50-005',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3100.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Magdalena',
    @NAZWISKO = 'Zieliñska',
    @EMAIL = 'magdalena.zielinska@example.com',
    @NR_TELEFONU = '444555666',
    @ULICA = 'Leœna',
    @NR_DOMU = 6,
    @NR_MIESZKANIA = 20,
    @MIEJSCOWOSC = '£ódŸ',
    @KOD_POCZTOWY = '90-006',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3200.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Zofia',
    @NAZWISKO = 'WoŸniak',
    @EMAIL = 'zofia.wozniak@example.com',
    @NR_TELEFONU = '345678901',
    @ULICA = 'Krótka',
    @NR_DOMU = 7,
    @NR_MIESZKANIA = 25,
    @MIEJSCOWOSC = 'Katowice',
    @KOD_POCZTOWY = '40-007',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3000.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Agnieszka',
    @NAZWISKO = 'Piotrowska',
    @EMAIL = 'agnieszka.piotrowska@example.com',
    @NR_TELEFONU = '765432109',
    @ULICA = 'D³uga',
    @NR_DOMU = 8,
    @NR_MIESZKANIA = 30,
    @MIEJSCOWOSC = 'Lublin',
    @KOD_POCZTOWY = '20-008',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3100.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Patrycja',
    @NAZWISKO = 'Szymañska',
    @EMAIL = 'patrycja.szymanska@example.com',
    @NR_TELEFONU = '333444555',
    @ULICA = 'Brzozowa',
    @NR_DOMU = 9,
    @NR_MIESZKANIA = 35,
    @MIEJSCOWOSC = 'Szczecin',
    @KOD_POCZTOWY = '70-009',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3200.00,
    @STANOWISKO = 'POKOJÓWKA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Jan',
    @NAZWISKO = 'Kowalski',
    @EMAIL = 'jan.kowalski@example.com',
    @NR_TELEFONU = '111222333',
    @ULICA = 'Dluga',
    @NR_DOMU = 10,
    @NR_MIESZKANIA = 1,
    @MIEJSCOWOSC = 'Warszawa',
    @KOD_POCZTOWY = '00-001',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3500.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Piotr',
    @NAZWISKO = 'Nowak',
    @EMAIL = 'piotr.nowak@example.com',
    @NR_TELEFONU = '222333444',
    @ULICA = 'Krotka',
    @NR_DOMU = 11,
    @NR_MIESZKANIA = 2,
    @MIEJSCOWOSC = 'Kraków',
    @KOD_POCZTOWY = '30-002',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3600.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Tomasz',
    @NAZWISKO = 'Wiœniewski',
    @EMAIL = 'tomasz.wisniewski@example.com',
    @NR_TELEFONU = '333444555',
    @ULICA = 'Szeroka',
    @NR_DOMU = 12,
    @NR_MIESZKANIA = 3,
    @MIEJSCOWOSC = 'Poznañ',
    @KOD_POCZTOWY = '61-003',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3700.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Micha³',
    @NAZWISKO = 'Lewandowski',
    @EMAIL = 'michal.lewandowski@example.com',
    @NR_TELEFONU = '444555666',
    @ULICA = 'Leœna',
    @NR_DOMU = 13,
    @NR_MIESZKANIA = 4,
    @MIEJSCOWOSC = '£ódŸ',
    @KOD_POCZTOWY = '90-004',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3800.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Adam',
    @NAZWISKO = 'Zieliñski',
    @EMAIL = 'adam.zielinski@example.com',
    @NR_TELEFONU = '555666777',
    @ULICA = 'Polna',
    @NR_DOMU = 14,
    @NR_MIESZKANIA = 5,
    @MIEJSCOWOSC = 'Gdañsk',
    @KOD_POCZTOWY = '80-005',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 3900.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Pawe³',
    @NAZWISKO = 'Wójcik',
    @EMAIL = 'pawel.wojcik@example.com',
    @NR_TELEFONU = '666777888',
    @ULICA = 'S³oneczna',
    @NR_DOMU = 15,
    @NR_MIESZKANIA = 6,
    @MIEJSCOWOSC = 'Wroc³aw',
    @KOD_POCZTOWY = '50-006',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3500.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Grzegorz',
    @NAZWISKO = 'Kaczmarek',
    @EMAIL = 'grzegorz.kaczmarek@example.com',
    @NR_TELEFONU = '777888999',
    @ULICA = 'Leœna',
    @NR_DOMU = 16,
    @NR_MIESZKANIA = 7,
    @MIEJSCOWOSC = '£ódŸ',
    @KOD_POCZTOWY = '90-007',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3600.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Mateusz',
    @NAZWISKO = 'Pawlak',
    @EMAIL = 'mateusz.pawlak@example.com',
    @NR_TELEFONU = '888999000',
    @ULICA = 'Polna',
    @NR_DOMU = 17,
    @NR_MIESZKANIA = 8,
    @MIEJSCOWOSC = 'Gdañsk',
    @KOD_POCZTOWY = '80-008',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3700.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Rafa³',
    @NAZWISKO = 'Michalski',
    @EMAIL = 'rafal.michalski@example.com',
    @NR_TELEFONU = '999000111',
    @ULICA = 'Krótka',
    @NR_DOMU = 18,
    @NR_MIESZKANIA = 9,
    @MIEJSCOWOSC = 'Katowice',
    @KOD_POCZTOWY = '40-009',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3800.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = '£ukasz',
    @NAZWISKO = 'Sikora',
    @EMAIL = 'lukasz.sikora@example.com',
    @NR_TELEFONU = '000111222',
    @ULICA = 'Szeroka',
    @NR_DOMU = 19,
    @NR_MIESZKANIA = 10,
    @MIEJSCOWOSC = 'Poznañ',
    @KOD_POCZTOWY = '61-010',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 3900.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Krzysztof',
    @NAZWISKO = 'Jankowski',
    @EMAIL = 'krzysztof.jankowski@example.com',
    @NR_TELEFONU = '111222333',
    @ULICA = 'D³uga',
    @NR_DOMU = 20,
    @NR_MIESZKANIA = 11,
    @MIEJSCOWOSC = 'Warszawa',
    @KOD_POCZTOWY = '00-011',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3500.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Jakub',
    @NAZWISKO = 'Mazur',
    @EMAIL = 'jakub.mazur@example.com',
    @NR_TELEFONU = '222333444',
    @ULICA = 'Krótka',
    @NR_DOMU = 21,
    @NR_MIESZKANIA = 12,
    @MIEJSCOWOSC = 'Kraków',
    @KOD_POCZTOWY = '30-012',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3600.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Sebastian',
    @NAZWISKO = 'Baran',
    @EMAIL = 'sebastian.baran@example.com',
    @NR_TELEFONU = '333444555',
    @ULICA = 'Szeroka',
    @NR_DOMU = 22,
    @NR_MIESZKANIA = 13,
    @MIEJSCOWOSC = 'Poznañ',
    @KOD_POCZTOWY = '61-013',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3700.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Marcin',
    @NAZWISKO = 'Wróbel',
    @EMAIL = 'marcin.wrobel@example.com',
    @NR_TELEFONU = '444555666',
    @ULICA = 'Leœna',
    @NR_DOMU = 23,
    @NR_MIESZKANIA = 14,
    @MIEJSCOWOSC = '£ódŸ',
    @KOD_POCZTOWY = '90-014',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3800.00,
    @STANOWISKO = 'RECEPCJA';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Dariusz',
    @NAZWISKO = 'Krawczyk',
    @EMAIL = 'dariusz.krawczyk@example.com',
    @NR_TELEFONU = '555666777',
    @ULICA = 'Polna',
    @NR_DOMU = 24,
    @NR_MIESZKANIA = 15,
    @MIEJSCOWOSC = 'Gdañsk',
    @KOD_POCZTOWY = '80-015',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 3900.00,
    @STANOWISKO = 'RECEPCJA';
 
EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Andrzej',
    @NAZWISKO = 'Krawczyk',
    @EMAIL = 'andrzej.krawczyk@example.com',
    @NR_TELEFONU = '123123123',
    @ULICA = 'Ogrodowa',
    @NR_DOMU = 25,
    @NR_MIESZKANIA = 1,
    @MIEJSCOWOSC = 'Warszawa',
    @KOD_POCZTOWY = '00-021',
    @KRAJ = 'Polska',
    @ID_HOTELU = 1,
    @PENSJA = 4000.00,
    @STANOWISKO = 'KONSERWATOR';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Robert',
    @NAZWISKO = 'Wysocki',
    @EMAIL = 'robert.wysocki@example.com',
    @NR_TELEFONU = '321321321',
    @ULICA = 'Parkowa',
    @NR_DOMU = 26,
    @NR_MIESZKANIA = 2,
    @MIEJSCOWOSC = 'Kraków',
    @KOD_POCZTOWY = '30-022',
    @KRAJ = 'Polska',
    @ID_HOTELU = 2,
    @PENSJA = 4100.00,
    @STANOWISKO = 'KONSERWATOR';

EXEC wlasciciel.DODAJ_PRACOWNIKA
    @IMIE = 'Marian',
    @NAZWISKO = 'D¹browski',
    @EMAIL = 'marian.dabrowski@example.com',
    @NR_TELEFONU = '456456456',
    @ULICA = 'Lipowa',
    @NR_DOMU = 27,
    @NR_MIESZKANIA = 3,
    @MIEJSCOWOSC = 'Poznañ',
    @KOD_POCZTOWY = '61-023',
    @KRAJ = 'Polska',
    @ID_HOTELU = 3,
    @PENSJA = 4200.00,
    @STANOWISKO = 'KONSERWATOR';

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 101,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 102,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 103,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 104,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 105,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 201,
    @LICZBA_OSOB = 3,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 202,
    @LICZBA_OSOB = 3,
    @CENA = 300.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 203,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 1,
    @NR_POKOJU = 204,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 101,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 102,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 103,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 104,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 105,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 201,
    @LICZBA_OSOB = 3,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 202,
    @LICZBA_OSOB = 3,
    @CENA = 300.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 203,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 2,
    @NR_POKOJU = 204,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 101,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 102,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 103,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 104,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 105,
    @LICZBA_OSOB = 2,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 201,
    @LICZBA_OSOB = 3,
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 202,
    @LICZBA_OSOB = 3,
    @CENA = 300.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 203,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_POKOJ
    @ID_HOTELU = 3,
    @NR_POKOJU = 204,
    @LICZBA_OSOB = 4,
    @CENA = 400.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 1,
    @NAZWA = 'Masa¿ relaksacyjny',
    @CENA = 150.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 1,
    @NAZWA = 'Sauna fiñska',
    @CENA = 100.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 1,
    @NAZWA = 'Basen kryty',
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 2,
    @NAZWA = 'Masa¿ relaksacyjny',
    @CENA = 150.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 2,
    @NAZWA = 'Sauna fiñska',
    @CENA = 100.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 2,
    @NAZWA = 'Basen kryty',
    @CENA = 200.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 3,
    @NAZWA = 'Masa¿ relaksacyjny',
    @CENA = 150.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 3,
    @NAZWA = 'Sauna fiñska',
    @CENA = 100.00;

EXEC wlasciciel.DODAJ_USLUGE
    @ID_HOTELU = 3,
    @NAZWA = 'Basen kryty',
    @CENA = 200.00;
