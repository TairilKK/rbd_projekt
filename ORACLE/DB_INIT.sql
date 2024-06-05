-------------- BLOK CZYSZCZACY
-----------------------------------
BEGIN
  FOR cur_rec IN (SELECT object_name, object_type 
                  FROM   user_objects
                  WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE', 'TRIGGER', 'TYPE')) LOOP
    BEGIN
      IF cur_rec.object_type = 'TABLE' THEN
        IF instr(cur_rec.object_name, 'STORE') = 0 then
          EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
        END IF;
      ELSIF cur_rec.object_type = 'TYPE' THEN
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" FORCE';
      ELSE
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
    END;
  END LOOP;
END;
/

-------------- TABELE + SEKWENCJE + TRIGGERY
--------------------------------------------------------

-------------- ------------ -------------- 
-------------- -- ADRESY -- -------------- 
-------------- ------------ -------------- 
CREATE TABLE ADRESY 
(
  ID_ADRESU NUMBER NOT NULL 
, ULICA VARCHAR2(30) NOT NULL 
, NR_DOMU NUMBER NOT NULL 
, NR_MIESZKANIA NUMBER 
, MIEJSCOWOSC VARCHAR2(30) NOT NULL 
, KOD_POCZTOWY VARCHAR2(7) NOT NULL 
, KRAJ VARCHAR2(30) NOT NULL 
, CONSTRAINT ADRESY_PK PRIMARY KEY 
  (
    ID_ADRESU 
  )
  ENABLE 
);
/
CREATE SEQUENCE ADRES_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER ADRESY_TRG 
BEFORE INSERT ON ADRESY 
FOR EACH ROW
BEGIN
  :NEW.ID_ADRESU := ADRES_SEQ.NEXTVAL;
END;
/
-------------- --------------------- -------------- 
-------------- -- DANE PERSONALNE -- -------------- 
-------------- --------------------- -------------- 
CREATE TABLE DANE_PERSONALNE 
(
  ID_OSOBY NUMBER NOT NULL 
, IMIE VARCHAR2(30) NOT NULL 
, NAZWISKO VARCHAR2(30) NOT NULL 
, EMAIL VARCHAR2(50) 
, NR_TELEFONU VARCHAR2(14) NOT NULL 
, ID_ADRESU NUMBER NOT NULL 
, CONSTRAINT DANE_PERSONALNE_PK PRIMARY KEY 
  (
    ID_OSOBY 
  )
  ENABLE 
, CONSTRAINT FK_DANE_PERSONALNE_ID_ADRESU FOREIGN KEY (ID_ADRESU)
    REFERENCES ADRESY (ID_ADRESU)
);
/
CREATE SEQUENCE DANE_PERSONALNE_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER DANE_PERSONALNE_TRG 
BEFORE INSERT ON DANE_PERSONALNE 
FOR EACH ROW
BEGIN
  :NEW.ID_OSOBY := DANE_PERSONALNE_SEQ.NEXTVAL;
END;
/
-------------- ------------ -------------- 
-------------- -- HOTELE -- -------------- 
-------------- ------------ -------------- 
CREATE TABLE HOTELE 
(
  ID_HOTELU NUMBER NOT NULL 
, ID_ADRESU NUMBER NOT NULL 
, NAZWA VARCHAR2(20) NOT NULL 
, CONSTRAINT HOTELE_PK PRIMARY KEY 
  (
    ID_HOTELU 
  )
  ENABLE 
, CONSTRAINT FK_HOTELE_ID_ADRESU FOREIGN KEY (ID_ADRESU)
    REFERENCES ADRESY (ID_ADRESU)
);
/
CREATE SEQUENCE HOTELE_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER HOTELE_TRG 
BEFORE INSERT ON HOTELE 
FOR EACH ROW
BEGIN
  :NEW.ID_HOTELU := HOTELE_SEQ.NEXTVAL;
END;
/
-------------- -------------- -------------- 
-------------- -- PERSONEL -- -------------- 
-------------- -------------- -------------- 
CREATE TABLE PERSONEL 
(
  ID_PRACOWNIKA NUMBER NOT NULL 
, ID_OSOBY NUMBER NOT NULL
, ID_HOTELU NUMBER NOT NULL
, DATA_ZATRUDNIENIA DATE NOT NULL 
, DATA_ZWOLNIENIA DATE 
, PENSJA NUMBER NOT NULL 
, STANOWISKO VARCHAR2(20) NOT NULL 
, CONSTRAINT PERSONEL_PK PRIMARY KEY 
  (
    ID_PRACOWNIKA 
  )
  ENABLE 
, CONSTRAINT FK_PERSONEL_ID_DANE_PERSONALNE FOREIGN KEY (ID_OSOBY)
    REFERENCES DANE_PERSONALNE (ID_OSOBY)
, CONSTRAINT FK_PERSONEL_ID_HOTELU FOREIGN KEY (ID_HOTELU)
    REFERENCES HOTELE (ID_HOTELU)
);
/
CREATE SEQUENCE PERSONEL_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER PERSONEL_TRG 
BEFORE INSERT ON PERSONEL 
FOR EACH ROW
BEGIN
  :NEW.ID_PRACOWNIKA := PERSONEL_SEQ.NEXTVAL;
END;
/
-------------- ------------ -------------- 
-------------- -- ZNIZKI -- -------------- 
-------------- ------------ -------------- 
CREATE TABLE ZNIZKI 
(
  ID_ZNIZKI NUMBER NOT NULL 
, PROCENT NUMBER NOT NULL
, CONSTRAINT ZNIZKI_PK PRIMARY KEY 
  (
    ID_ZNIZKI 
  )
  ENABLE 
);
/
CREATE SEQUENCE ZNIZKI_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER ZNIZKI_TRG 
BEFORE INSERT ON ZNIZKI 
FOR EACH ROW
BEGIN
  IF :NEW.PROCENT < 0 AND :NEW.PROCENT > 100 THEN
    RAISE_APPLICATION_ERROR(-20001, 'PROCENT PWOINIEN BY� W ZAKRESIE [0, 100]');
  END IF;
  :NEW.ID_ZNIZKI := ZNIZKI_SEQ.NEXTVAL;
END;
/
-------------- ------------- -------------- 
-------------- -- KLIENCI -- -------------- 
-------------- ------------- -------------- 
CREATE TABLE KLIENCI 
(
  ID_KLIENTA NUMBER NOT NULL 
, ID_OSOBY NUMBER NOT NULL
, ID_ZNIZKI NUMBER DEFAULT 0 NOT NULL 
, CONSTRAINT KLIENCI_PK PRIMARY KEY 
  (
    ID_KLIENTA 
  )
  ENABLE 
, CONSTRAINT FK_KLIENCI_ID_DANE_PERSONALNE FOREIGN KEY (ID_OSOBY)
    REFERENCES DANE_PERSONALNE (ID_OSOBY)
, CONSTRAINT FK_KLIENCI_ID_ZNIZKI FOREIGN KEY (ID_ZNIZKI)
    REFERENCES ZNIZKI (ID_ZNIZKI)
);
/
CREATE SEQUENCE KLIENCI_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER KLIENCI_TRG 
BEFORE INSERT ON KLIENCI 
FOR EACH ROW
BEGIN
  :NEW.ID_KLIENTA := KLIENCI_SEQ.NEXTVAL;
END;
/
-------------- ------------ -------------- 
-------------- -- POKOJE -- -------------- 
-------------- ------------ -------------- 
CREATE TABLE POKOJE 
(
  ID_POKOJU NUMBER NOT NULL 
, ID_HOTELU NUMBER NOT NULL 
, NR_POKOJU NUMBER NOT NULL
, LICZBA_OSOB NUMBER NOT NULL
, CENA NUMBER NOT NULL
, POSPRZATANY VARCHAR2(255) 
, WYMAGA_NAPRAWY VARCHAR2(255) 
, CONSTRAINT POKOJE_PK PRIMARY KEY 
  (
    ID_POKOJU 
  )
  ENABLE 
, CONSTRAINT FK_POKOJE_ID_HOTELU FOREIGN KEY (ID_HOTELU)
    REFERENCES HOTELE (ID_HOTELU)
);
/
CREATE SEQUENCE POKOJE_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER POKOJE_TRG 
BEFORE INSERT ON POKOJE 
FOR EACH ROW
BEGIN
  :NEW.ID_POKOJU := POKOJE_SEQ.NEXTVAL;
END;
/
-------------- ---------------- -------------- 
-------------- -- REZERWACJE -- -------------- 
-------------- ---------------- -------------- 
CREATE TABLE REZERWACJE 
(
  ID_REZERWACJI NUMBER NOT NULL 
, ID_HOTELU NUMBER NOT NULL
, ID_KLIENTA NUMBER NOT NULL 
, ID_PRACOWNIKA NUMBER NOT NULL 
, ID_POKOJU NUMBER NOT NULL 
, PRZYJAZD DATE NOT NULL 
, ODJAZD DATE NOT NULL 
, ZAMELDOWANIE DATE 
, ODMELDOWANIE DATE 
, OPLATA_ZNISCZENIE NUMBER 
, CENA_POBYTU NUMBER 
, OPLATA_ZALICZKA NUMBER 
, OPLATA_CALOSC NUMBER 
, CONSTRAINT REZERWACJE_PK PRIMARY KEY 
  (
    ID_REZERWACJI 
  )
  ENABLE 
, CONSTRAINT FK_REZERWACJE_ID_KLIENTA FOREIGN KEY (ID_KLIENTA)
    REFERENCES KLIENCI (ID_KLIENTA)
, CONSTRAINT FK_REZERWACJE_ID_PRACOWNIKA FOREIGN KEY (ID_PRACOWNIKA)
    REFERENCES PERSONEL (ID_PRACOWNIKA)
, CONSTRAINT FK_REZERWACJE_ID_POKOJU FOREIGN KEY (ID_POKOJU)
    REFERENCES POKOJE (ID_POKOJU)
, CONSTRAINT FK_REZERWACJE_ID_HOTELU FOREIGN KEY (ID_HOTELU)
    REFERENCES HOTELE (ID_HOTELU)
);
COMMENT ON COLUMN REZERWACJE.PRZYJAZD IS 'Data poczatku rezerwacji.';
COMMENT ON COLUMN REZERWACJE.ODJAZD IS 'Data konca rezerwacji.';
COMMENT ON COLUMN REZERWACJE.ZAMELDOWANIE IS 'Data zameldowania klienta w hotelu.';
COMMENT ON COLUMN REZERWACJE.ODMELDOWANIE IS 'Data odmeldowania klienta z hotelu.';

CREATE SEQUENCE REZERWACJE_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER REZERWACJE_TRG 
BEFORE INSERT ON REZERWACJE 
FOR EACH ROW
BEGIN
  :NEW.ID_REZERWACJI := REZERWACJE_SEQ.NEXTVAL;
END;
/
-------------- ------------ -------------- 
-------------- -- GOSCIE -- -------------- 
-------------- ------------ -------------- 
CREATE TABLE GOSCIE 
(
  ID_REZERWACJI NUMBER NOT NULL 
, IMIE VARCHAR2(30) NOT NULL 
, NAZWISKO VARCHAR2(30) NOT NULL 
, CONSTRAINT FK_GOSCIE_ID_REZERWACJI FOREIGN KEY (ID_REZERWACJI)
    REFERENCES REZERWACJE (ID_REZERWACJI)
);
/
-------------- ----------------- --------------
-------------- -- WYPOSAZENIE -- --------------
-------------- ----------------- --------------
CREATE TABLE WYPOSAZENIE 
(
  ID_POKOJU NUMBER NOT NULL 
, NAZWA VARCHAR2(30) NOT NULL 
, ILOSC NUMBER NOT NULL 
, CONSTRAINT FK_WYPOSAZENIE_ID_POKOJU FOREIGN KEY (ID_POKOJU)
    REFERENCES POKOJE (ID_POKOJU)
);
/
-------------- ------------ --------------
-------------- -- USLUGI -- --------------
-------------- ------------ --------------
CREATE TABLE USLUGI 
(	
  ID_USLUGI NUMBER NOT NULL ENABLE
, ID_HOTELU NUMBER NOT NULL ENABLE
, NAZWA VARCHAR2(50 BYTE) NOT NULL ENABLE
, CENA NUMBER NOT NULL ENABLE
, CONSTRAINT USLUGI_PK PRIMARY KEY (ID_USLUGI)
, CONSTRAINT FK_USLUGI_ID_HOTELU FOREIGN KEY (ID_HOTELU)
    REFERENCES HOTELE (ID_HOTELU)
);
/
CREATE SEQUENCE USLUGI_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER USLUGI_TRG 
BEFORE INSERT ON USLUGI 
FOR EACH ROW
BEGIN
  :NEW.ID_USLUGI := USLUGI_SEQ.NEXTVAL;
END;
/
-------------- ----------------------- --------------
-------------- -- REZERWACJE US�UGI -- --------------
-------------- ----------------------- --------------
CREATE TABLE REZERWACJE_USLUGI 
(
  ID_REZ_USLUGI NUMBER NOT NULL 
, ID_HOTELU NUMBER NOT NULL 
, ID_USLUGI NUMBER NOT NULL 
, ID_REZERWACJI NUMBER 
, LICZBA_OSOB NUMBER NOT NULL 
, CONSTRAINT REZERWACJE_USLUGI_PK PRIMARY KEY 
  (ID_REZ_USLUGI)
, CONSTRAINT FK_REZERWACJE_USLUGI_ID_HOTELU FOREIGN KEY (ID_HOTELU)
    REFERENCES HOTELE (ID_HOTELU)
, CONSTRAINT FK_REZERWACJE_USLUGI_ID_USLUGI FOREIGN KEY (ID_USLUGI)
    REFERENCES USLUGI (ID_USLUGI)
, CONSTRAINT FK_REZERWACJE_USLUGI_ID_REZERWACJI FOREIGN KEY (ID_REZERWACJI)
    REFERENCES REZERWACJE (ID_REZERWACJI)
  ENABLE 
);
/
CREATE SEQUENCE REZ_USLUGI_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999999999999999 MINVALUE 1 NOCACHE ORDER;
/
CREATE OR REPLACE TRIGGER REZERWACJE_USLUGI_TRG 
BEFORE INSERT ON REZERWACJE_USLUGI 
FOR EACH ROW
BEGIN
  :NEW.ID_REZ_USLUGI := REZ_USLUGI_SEQ.NEXTVAL;
END;
/

-------------- WIDOKI
----------------------------  

-------------- --------------------- -------------- 
-------------- -- DANE PERSONALNE -- -------------- 
-------------- --------------------- --------------
CREATE VIEW DANE_PERSONALNE_VIEW
AS SELECT 
    Nazwisko, 
    Imie, 
    Email, 
    NR_telefonu, 
    ulica, 
    Nr_Domu, 
    Nr_mieszkania, 
    Miejscowosc, 
    Kod_pocztowy, 
    Kraj 
FROM 
    DANE_PERSONALNE 
JOIN 
    adresy USING(ID_ADRESU);
/   
-------------- ------------ -------------- 
-------------- -- HOTELE -- -------------- 
-------------- ------------ --------------   
CREATE VIEW HOTELE_VIEW
AS SELECT 
    NAZWA,
    ULICA,
    NR_DOMU,
    MIEJSCOWOSC,
    KOD_POCZTOWY,
    KRAJ
FROM 
    HOTELE 
JOIN ADRESY USING(ID_ADRESU);
/

-------------- FUNKCJE
----------------------------

-------------- ------------------------ -------------- 
-------------- -- OBLICZ CENE POBYTU -- -------------- 
-------------- ------------------------ --------------
CREATE OR REPLACE FUNCTION OBLICZ_CENE_POBYTU 
(
  ID_REZERWACJI IN NUMBER  
) RETURN NUMBER AS 
LICZBA_DNI NUMBER;
OPLATA_ZNISZCZENIE NUMBER;
ID_POKOJU NUMBER;
CENA_POKOJU NUMBER;
ID_KLIENTA NUMBER;
ID_ZNIZKI NUMBER;
PROCENT_ZNIZKI NUMBER;
BEGIN
  SELECT TRUNC(ODMELDOWANIE - ZAMELDOWANIE) INTO LICZBA_DNI FROM REZERWACJE WHERE ID_REZERWACJI = ID_REZERWACJI;
  SELECT OPLATA_ZNISZCZENIE INTO OPLATA_ZNISZCZENIE FROM REZERWACJE WHERE ID_REZERWACJI = ID_REZERWACJI;
  SELECT ID_POKOJU INTO ID_POKOJU FROM REZERWACJE WHERE ID_REZERWACJI = ID_REZERWACJI;
  SELECT CENA INTO CENA_POKOJU FROM POKOJE WHERE ID_POKOJU = ID_POKOJU;
  SELECT ID_KLIENTA INTO ID_KLIENTA FROM REZERWACJE WHERE ID_REZERWACJI = ID_REZERWACJI;
  SELECT ID_ZNIZKI INTO ID_ZNIZKI FROM KLIENCI WHERE ID_KLIENTA = ID_KLIENTA;
  SELECT PROCENT INTO PROCENT_ZNIZKI FROM ZNIZKI WHERE ID_ZNIZKI = ID_ZNIZKI;

  RETURN ((LICZBA_DNI * CENA_POKOJU) + OPLATA_ZNISZCZENIE) * (1 - PROCENT_ZNIZKI / 100);
END OBLICZ_CENE_POBYTU;
/
-------------- ------------------------------------------ -------------- 
-------------- -- ROCZNA LICZBA REZERWACJI DLA KLIENTA -- -------------- 
-------------- ------------------------------------------ --------------
CREATE OR REPLACE FUNCTION ROCZNA_LICZBA_REZERWACJI_KLIENT 
(
  ID_KLIENTA IN NUMBER 
) RETURN NUMBER AS 
LICZBA_REZERWACJI NUMBER;
BEGIN
  SELECT COUNT(ID_REZERWACJI) INTO LICZBA_REZERWACJI FROM REZERWACJE 
  WHERE ID_KLIENTA = ID_KLIENTA
  AND EXTRACT(YEAR FROM PRZYJAZD) = EXTRACT(YEAR FROM SYSDATE); 
  RETURN LICZBA_REZERWACJI;
END ROCZNA_LICZBA_REZERWACJI_KLIENT;
/

-------------- PROCEDURY
----------------------------  

-------------- ----------------- -------------- 
-------------- -- DODAJ ADRES -- -------------- 
-------------- ----------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_ADRES 
(
  ULICA IN VARCHAR2 
, NR_DOMU IN NUMBER 
, NR_MIESZKANIA IN NUMBER 
, MIEJSCOWOSC IN VARCHAR2 
, KOD_POCZTOWY IN VARCHAR2 
, KRAJ IN VARCHAR2 
) AS 
BEGIN
  INSERT INTO ADRESY(ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ)
  VALUES(ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ);
END DODAJ_ADRES;
/
-------------- --------------------------- -------------- 
-------------- -- DODAJ DANE PERSONALNE -- -------------- 
-------------- --------------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_DANE_PERSONALNE
( 
  IMIE IN VARCHAR2
, NAZWISKO IN VARCHAR2
, EMAIL IN VARCHAR2
, NR_TELEFONU IN VARCHAR2
, ULICA IN VARCHAR2 
, NR_DOMU IN NUMBER 
, NR_MIESZKANIA IN NUMBER 
, MIEJSCOWOSC IN VARCHAR2 
, KOD_POCZTOWY IN VARCHAR2 
, KRAJ IN VARCHAR2 
) AS 
BEGIN
  DODAJ_ADRES(ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ);
  INSERT INTO DANE_PERSONALNE(IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ID_ADRESU)
  VALUES(IMIE, NAZWISKO, EMAIL, NR_TELEFONU, (SELECT ID_ADRESU FROM ADRESY 
  WHERE ULICA=ULICA AND NR_DOMU=NR_DOMU AND NR_MIESZKANIA=NR_MIESZKANIA AND MIEJSCOWOSC=MIEJSCOWOSC AND KOD_POCZTOWY=KOD_POCZTOWY AND KRAJ=KRAJ));
END DODAJ_DANE_PERSONALNE;
/
-------------- ------------------- -------------- 
-------------- -- DODAJ KLIENTA -- -------------- 
-------------- ------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_KLIENTA
( 
  IMIE IN VARCHAR2
, NAZWISKO IN VARCHAR2
, EMAIL IN VARCHAR2
, NR_TELEFONU IN VARCHAR2
, ULICA IN VARCHAR2 
, NR_DOMU IN NUMBER 
, NR_MIESZKANIA IN NUMBER 
, MIEJSCOWOSC IN VARCHAR2 
, KOD_POCZTOWY IN VARCHAR2 
, KRAJ IN VARCHAR2 
) AS 
BEGIN
  DODAJ_DANE_PERSONALNE(IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ);
  INSERT INTO KLIENCI (ID_OSOBY)
  VALUES((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE IMIE=IMIE AND NAZWISKO=NAZWISKO AND EMAIL=EMAIL AND NR_TELEFONU=NR_TELEFONU));
END DODAJ_KLIENTA;
/
-------------- ---------------------- -------------- 
-------------- -- DODAJ PRACOWNIKA -- -------------- 
-------------- ---------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_PRACOWNIKA
( 
  IMIE IN VARCHAR2
, NAZWISKO IN VARCHAR2
, EMAIL IN VARCHAR2
, NR_TELEFONU IN VARCHAR2
, ULICA IN VARCHAR2 
, NR_DOMU IN NUMBER 
, NR_MIESZKANIA IN NUMBER 
, MIEJSCOWOSC IN VARCHAR2 
, KOD_POCZTOWY IN VARCHAR2 
, KRAJ IN VARCHAR2 
, ID_HOTELU IN NUMBER
, PENSJA IN NUMBER
, STANOWISKO IN VARCHAR2
) AS 
BEGIN
  DODAJ_DANE_PERSONALNE(IMIE, NAZWISKO, EMAIL, NR_TELEFONU, ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ);
  INSERT INTO PERSONEL (ID_OSOBY, ID_HOTELU, DATA_ZATRUDNIENIA, PENSJA, STANOWISKO)
  VALUES((SELECT ID_OSOBY FROM DANE_PERSONALNE WHERE IMIE=IMIE AND NAZWISKO=NAZWISKO AND EMAIL=EMAIL AND NR_TELEFONU=NR_TELEFONU), ID_HOTELU, SYSDATE, PENSJA, STANOWISKO);
END DODAJ_PRACOWNIKA;
/
-------------- ------------------ -------------- 
-------------- -- ZMIEN PENSJE -- -------------- 
-------------- ------------------ -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_PENSJE
(
  ID_PARACOWNKIA IN NUMBER
, PENSJA IN NUMBER
) AS 
BEGIN
  UPDATE PERSONEL SET PENSJA=PENSJA WHERE ID_PRACOWNIKA=ID_PRACOWNIKA;
END ZMIEN_PENSJE;
/
-------------- ------------------------ -------------- 
-------------- -- ZWOLNIJ PRACOWNIKA -- -------------- 
-------------- ------------------------ -------------- 
CREATE OR REPLACE PROCEDURE ZWOLNIJ_PRACOWNIKA
(
  ID_PARACOWNKIA IN NUMBER
) AS 
BEGIN
  UPDATE PERSONEL SET DATA_ZWOLNIENIA=SYSDATE WHERE ID_PRACOWNIKA=ID_PRACOWNIKA;
END ZWOLNIJ_PRACOWNIKA;
/
-------------- ---------------------- -------------- 
-------------- -- ZMIEN STANOWISKO -- -------------- 
-------------- ---------------------- -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_STANOWISKO
(
  ID_PARACOWNKIA IN NUMBER
, STANOWISKO IN VARCHAR2
) AS 
BEGIN
  UPDATE PERSONEL SET STANOWISKO=STANOWISKO WHERE ID_PRACOWNIKA=ID_PRACOWNIKA;
END ZMIEN_STANOWISKO;
/
-------------- ----------------- -------------- 
-------------- -- DODAJ HOTEL -- -------------- 
-------------- ----------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_HOTEL 
(
  NAZWA IN VARCHAR2
, ULICA IN VARCHAR2 
, NR_DOMU IN NUMBER 
, NR_MIESZKANIA IN NUMBER 
, MIEJSCOWOSC IN VARCHAR2 
, KOD_POCZTOWY IN VARCHAR2 
, KRAJ IN VARCHAR2 
) AS 
BEGIN
  DODAJ_ADRES(ULICA, NR_DOMU, NR_MIESZKANIA, MIEJSCOWOSC, KOD_POCZTOWY, KRAJ);
  INSERT INTO HOTELE(ID_ADRESU, NAZWA)
  VALUES((SELECT ID_ADRESU FROM ADRESY 
  WHERE ULICA=ULICA AND NR_DOMU=NR_DOMU AND NR_MIESZKANIA=NR_MIESZKANIA AND MIEJSCOWOSC=MIEJSCOWOSC AND KOD_POCZTOWY=KOD_POCZTOWY AND KRAJ=KRAJ), 
  NAZWA);
END DODAJ_HOTEL;
/
-------------- ---------------- -------------- 
-------------- -- USUN HOTEL -- -------------- 
-------------- ---------------- -------------- 
CREATE OR REPLACE PROCEDURE USUN_HOTEL
(
  ID_HOTELU IN NUMBER
) AS 
BEGIN
  DELETE ADRESY WHERE ID_ADRESU=(SELECT ID_ADRESU FROM HOTELE WHERE ID_HOTELU=ID_HOTELU);
  DELETE HOTELE WHERE ID_HOTELU=ID_HOTELU;
END USUN_HOTEL;
/
-------------- ------------------------ -------------- 
-------------- -- ZMIEN NAZWE HOTELU -- -------------- 
-------------- ------------------------ -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_NAZWE_HOTELU
(
  ID_HOTELU IN NUMBER
, NAZWA IN VARCHAR2
) AS 
BEGIN
  UPDATE HOTELE SET NAZWA=NAZWA WHERE ID_HOTELU=ID_HOTELU;
END ZMIEN_NAZWE_HOTELU;
/
-------------- ------------------ -------------- 
-------------- -- DODAJ GOSCIA -- -------------- 
-------------- ------------------ -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_GOSCIA 
(
  ID_REZERWACJI IN NUMBER
, IMIE IN VARCHAR2
, NAZWISKO IN VARCHAR2
) AS 
BEGIN
  INSERT INTO GOSCIE
  VALUES(ID_REZERWACJI, IMIE, NAZWISKO); 
END DODAJ_GOSCIA;
/
-------------- ----------------- -------------- 
-------------- -- USUN GOSCIA -- -------------- 
-------------- ----------------- -------------- 
CREATE OR REPLACE PROCEDURE USUN_GOSCIA 
(
  ID_REZERWACJI IN NUMBER
, IMIE IN VARCHAR2
, NAZWISKO IN VARCHAR2
) AS 
BEGIN
  DELETE GOSCIE
  WHERE ID_REZERWACJI=ID_REZERWACJI AND IMIE=IMIE AND NAZWISKO=NAZWISKO; 
END USUN_GOSCIA;
/
-------------- ----------------- -------------- 
-------------- -- DODAJ POKOJ -- -------------- 
-------------- ----------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_POKOJ
(
  ID_HOTELU IN NUMBER
, NR_POKOJU IN NUMBER
, LICZBA_OSOB IN NUMBER
, CENA IN NUMBER
) AS 
BEGIN
  INSERT INTO POKOJE(ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, POSPRZATANY, WYMAGA_NAPRAWY)
  VALUES(ID_HOTELU, NR_POKOJU, LICZBA_OSOB, CENA, 'TAK', 'NIE'); 
END DODAJ_POKOJ;
/
-------------- ---------------- -------------- 
-------------- -- USUN POKOJ -- -------------- 
-------------- ---------------- -------------- 
CREATE OR REPLACE PROCEDURE USUN_POKOJ
(
  ID_POKOJU IN NUMBER
) AS 
BEGIN
  DELETE POKOJE WHERE ID_POKOJU=ID_POKOJU;
END USUN_POKOJ;
/
-------------- ----------------------- -------------- 
-------------- -- ZMIEN CENE POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_CENE_POKOJU
(
  ID_POKOJU IN NUMBER
, CENA IN NUMBER
) AS 
BEGIN
  UPDATE POKOJE SET CENA=CENA WHERE ID_POKOJU=ID_POKOJU;
END ZMIEN_CENE_POKOJU;
/
-------------- ----------------------- -------------- 
-------------- -- ZMIEN NUMER POKOJU -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_NUMER_POKOJU
(
  ID_POKOJU IN NUMBER
, NR_POKOJU IN NUMBER
) AS 
BEGIN
  UPDATE POKOJE SET NR_POKOJU=NR_POKOJU WHERE ID_POKOJU=ID_POKOJU;
END ZMIEN_NUMER_POKOJU;
/
-------------- ------------------------------ -------------- 
-------------- -- ZMIEN LICZBE OSOB POKOJU -- -------------- 
-------------- ------------------------------ -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_LICZBE_OSOB_POKOJU
(
  ID_POKOJU IN NUMBER
, LICZBA_OSOB IN NUMBER
) AS 
BEGIN
  UPDATE POKOJE SET LICZBA_OSOB=LICZBA_OSOB WHERE ID_POKOJU=ID_POKOJU;
END ZMIEN_LICZBE_OSOB_POKOJU;
/
-------------- ----------------------- -------------- 
-------------- -- POKOJ POSPRZATANY -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE POKOJ_POSPRZATANY
(
  ID_POKOJU IN NUMBER
) AS 
BEGIN
  UPDATE POKOJE SET POSPRZATANY='TAK' WHERE ID_POKOJU=ID_POKOJU;
END POKOJ_POSPRZATANY;
/
-------------- ------------------------- -------------- 
-------------- -- POKOJ DO SPRZATANIA -- -------------- 
-------------- ------------------------- -------------- 
CREATE OR REPLACE PROCEDURE POKOJ_DO_SPRZATANIA
(
  ID_POKOJU IN NUMBER
, OPIS IN VARCHAR2
) AS 
BEGIN
  UPDATE POKOJE SET POSPRZATANY=OPIS WHERE ID_POKOJU=ID_POKOJU;
END POKOJ_DO_SPRZATANIA;
/
-------------- ----------------------- -------------- 
-------------- -- POKOJ NAPRAWIONY -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE POKOJ_NAPRAWIONY
(
  ID_POKOJU IN NUMBER
) AS 
BEGIN
  UPDATE POKOJE SET POSPRZATANY='NIE' WHERE ID_POKOJU=ID_POKOJU;
END POKOJ_NAPRAWIONY;
/
-------------- ----------------------- -------------- 
-------------- -- POKOJ NAPRAWIONY -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE POKOJ_DO_NAPRAWY
(
  ID_POKOJU IN NUMBER
, OPIS IN VARCHAR2
) AS 
BEGIN
  UPDATE POKOJE SET POSPRZATANY=OPIS WHERE ID_POKOJU=ID_POKOJU;
END POKOJ_DO_NAPRAWY;
/
-------------- ----------------------- -------------- 
-------------- -- DODAJ WYPOSAZENIE -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_WYPOSAZENIE
(
  ID_POKOJU IN NUMBER
, NAZWA IN VARCHAR2
, ILOSC IN NUMBER
) AS 
BEGIN
  INSERT INTO WYPOSAZENIE
  VALUES(ID_POKOJU, NAZWA, ILOSC); 
END DODAJ_WYPOSAZENIE;
/
-------------- ----------------------- -------------- 
-------------- -- USUN WYPOSAZENIE -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE USUN_WYPOSAZENIE
(
  ID_POKOJU IN NUMBER
, NAZWA IN VARCHAR2
) AS 
BEGIN
  DELETE WYPOSAZENIE WHERE ID_POKOJU=ID_POKOJU AND NAZWA=NAZWA;
END USUN_WYPOSAZENIE;
/
-------------- ----------------------------- -------------- 
-------------- -- ZMIEN NAZWE WYPOSAZENIA -- -------------- 
-------------- ----------------------------- -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_NAZWE_WYPOSAZENIA
(
  ID_POKOJU IN NUMBER
, NAZWA IN VARCHAR2
, NOWA_NAZWA IN VARCHAR2
) AS 
BEGIN
  UPDATE WYPOSAZENIE SET NAZWA=NOWA_NAZWA WHERE ID_POKOJU=ID_POKOJU AND NAZWA=NAZWA;
END ZMIEN_NAZWE_WYPOSAZENIA;
/
-------------- ----------------------- -------------- 
-------------- -- ZMIEN ILOSC WYPOSAZENIA -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE ZMIEN_ILOSC_WYPOSAZENIA
(
  ID_POKOJU IN NUMBER
, NAZWA IN VARCHAR2
, ILOSC IN NUMBER
) AS 
BEGIN
    UPDATE WYPOSAZENIE SET ILOSC=ILOSC WHERE ID_POKOJU=ID_POKOJU AND NAZWA=NAZWA; 
END ZMIEN_ILOSC_WYPOSAZENIA;
/
-------------- ------------------ -------------- 
-------------- -- DODAJ USLUGE -- -------------- 
-------------- ------------------ -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_USLUGE
(
  ID_HOTELU IN NUMBER
, NAZWA IN VARCHAR2
, CENA IN NUMBER
) AS 
BEGIN
  INSERT INTO USLUGI(ID_HOTELU, NAZWA, CENA)
  VALUES(ID_HOTELU, NAZWA, CENA); 
END DODAJ_USLUGE;
/
-------------- ----------------- -------------- 
-------------- -- USUN USLUGE -- -------------- 
-------------- ----------------- -------------- 
CREATE OR REPLACE PROCEDURE USUN_USLUGE
(
  ID_USLUGI IN NUMBER
) AS 
BEGIN
  DELETE USLUGI WHERE ID_USLUGI=ID_USLUGI;
END USUN_USLUGE;
/
-------------- ----------------------- -------------- 
-------------- -- USLUGA ZMIEN CENE -- -------------- 
-------------- ----------------------- -------------- 
CREATE OR REPLACE PROCEDURE USLUGA_ZMIEN_CENE
(
  ID_USLUGI IN NUMBER
, CENA IN NUMBER
) AS 
BEGIN
  UPDATE USLUGI SET CENA=CENA WHERE ID_USLUGI=ID_USLUGI;
END USLUGA_ZMIEN_CENE;
/
-------------- ------------------------ -------------- 
-------------- -- USLUGA ZMIEN NAZWE -- -------------- 
-------------- ------------------------ -------------- 
CREATE OR REPLACE PROCEDURE USLUGA_ZMIEN_NAZWE
(
  ID_USLUGI IN NUMBER
, NAZWA IN NUMBER
) AS 
BEGIN
  UPDATE USLUGI SET NAZWA=NAZWA WHERE ID_USLUGI=ID_USLUGI;
END USLUGA_ZMIEN_NAZWE;
/
-------------- ---------------------- -------------- 
-------------- -- DODAJ REZERWACJE -- -------------- 
-------------- ---------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE
(
  ID_HOTELU IN NUMBER
, ID_KLIENTA IN NUMBER
, ID_PRACOWNIKA IN NUMBER
, ID_POKOJU IN NUMBER
, PRZYJAZD IN DATE
, ODJAZD IN DATE
) AS 
BEGIN
  INSERT INTO REZERWACJE(ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD)
  VALUES(ID_HOTELU, ID_KLIENTA, ID_PRACOWNIKA, ID_POKOJU, PRZYJAZD, ODJAZD); 
END DODAJ_REZERWACJE;
/
-------------- ----------------------------- -------------- 
-------------- -- DODAJ REZERWACJE USLUGA -- -------------- 
-------------- ----------------------------- -------------- 
CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJA_USULGA
(
  ID_HOTELU IN NUMBER
, ID_USLUGI IN NUMBER
, ID_REZERWACJI IN NUMBER
, LICZBA_OSOB IN NUMBER
) AS 
BEGIN
  INSERT INTO REZERWACJE_USLUGI(ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB)
  VALUES(ID_HOTELU, ID_USLUGI, ID_REZERWACJI, LICZBA_OSOB); 
END DODAJ_REZERWACJA_USULGA;
/
-------------- ----------------------- -------------- 
-------------- -- ZAKO�CZ REZERWACJE -- -------------- 
-------------- ----------------------- --------------
CREATE OR REPLACE PROCEDURE ZAKONCZ_REZERWACJE 
(
  ID_REZERWACJI IN NUMBER 
) AS 
BEGIN
  UPDATE REZERWACJE SET ODMELDOWANIE = SYSDATE, OPLATA_CALOSC = 1 WHERE ID_REZERWACJI = ID_REZERWACJI;
END ZAKONCZ_REZERWACJE;
/
-------------- -------------------------- -------------- 
-------------- -- POTWIERD� REZERWACJE -- -------------- 
-------------- -------------------------- --------------
CREATE OR REPLACE PROCEDURE POTWIERDZ_REZERWACJE 
(
  ID_REZERWACJI IN NUMBER 
, ID_PRACOWNIKA IN NUMBER 
) AS 
BEGIN
  UPDATE REZERWACJE SET ZAMELDOWANIE = SYSDATE, ID_PRACOWNIKA = ID_PRACOWNIKA WHERE ID_REZERWACJI = ID_REZERWACJI;
END POTWIERDZ_REZERWACJE;
/
-------------- -------------------- -------------- 
-------------- -- OPLAC ZALICZKE -- -------------- 
-------------- -------------------- --------------
CREATE OR REPLACE PROCEDURE OPLAC_ZALICZKE 
(
  ID_REZERWACJI IN NUMBER 
) AS 
BEGIN
  UPDATE REZERWACJE SET OPLATA_ZALICZKA = 1 WHERE ID_REZERWACJI = ID_REZERWACJI;
END OPLAC_ZALICZKE;
/
-------------- --------------------------------- -------------- 
-------------- -- DODAJ OPLATE ZA ZNISZCZENIE -- -------------- 
-------------- --------------------------------- --------------
CREATE OR REPLACE PROCEDURE OPLATA_ZNISZCZENIE 
(
  ID_REZERWACJI IN NUMBER
, OPLATA_ZNISCZENIE IN NUMBER
) AS 
BEGIN
  UPDATE REZERWACJE SET OPLATA_ZNISCZENIE = OPLATA_ZNISCZENIE WHERE ID_REZERWACJI = ID_REZERWACJI;
END OPLATA_ZNISZCZENIE;
/
-------------- --------------------- -------------- 
-------------- -- USU� REZERWACJE -- -------------- 
-------------- --------------------- --------------
CREATE OR REPLACE PROCEDURE USUN_REZERWACJE 
(
  ID_REZERWACJI IN NUMBER
) AS 
BEGIN
  DELETE FROM REZERWACJE WHERE ID_REZERWACJI = ID_REZERWACJI;
END USUN_REZERWACJE;
/
-------------- ---------------------------- -------------- 
-------------- -- AKTUALIZUJ CEN� POBYTU -- -------------- 
-------------- ---------------------------- --------------
CREATE OR REPLACE PROCEDURE AKTUALIZUJ_CENE_POBYTU 
(
  ID_REZERWACJI IN NUMBER
) AS 
NOWA_CENA_POBYTU NUMBER;
BEGIN
  NOWA_CENA_POBYTU := OBLICZ_CENE_POBYTU(ID_REZERWACJI);
  UPDATE REZERWACJE SET CENA_POBYTU = NOWA_CENA_POBYTU WHERE ID_REZERWACJI = ID_REZERWACJI;
END AKTUALIZUJ_CENE_POBYTU;
/
-------------- ------------------ -------------- 
-------------- -- DODAJ ZNI�KE -- -------------- 
-------------- ------------------ --------------
CREATE OR REPLACE PROCEDURE DODAJ_ZNIZKE 
(
  PROCENT IN NUMBER
) AS 
BEGIN
  INSERT INTO ZNIZKI(PROCENT) VALUES(PROCENT); 
END DODAJ_ZNIZKE;
/
-------------- ------------------- -------------- 
-------------- -- EDYTUJ ZNI�KE -- -------------- 
-------------- ------------------- --------------
CREATE OR REPLACE PROCEDURE EDYTUJ_ZNIZKE 
(
  ID_ZNIZKI IN NUMBER
, NOWY_PROCENT IN NUMBER
) AS 
BEGIN
  UPDATE ZNIZKI SET PROCENT = NOWY_PROCENT WHERE ID_ZNIZKI = ID_ZNIZKI;
END EDYTUJ_ZNIZKE;
/
-------------- ----------------- -------------- 
-------------- -- USU� ZNI�KE -- -------------- 
-------------- ----------------- --------------
CREATE OR REPLACE PROCEDURE USUN_ZNIZKE 
(
  ID_ZNIZKI IN NUMBER
) AS 
BEGIN
  DELETE FROM ZNIZKI WHERE ID_ZNIZKI = ID_ZNIZKI;
END USUN_ZNIZKE;
/
-------------- ------------------ -------------- 
-------------- -- OBNI� ZNI�KI -- -------------- 
-------------- ------------------ --------------
CREATE OR REPLACE PROCEDURE OBNIZ_ZNIZKI AS 
BEGIN  
  IF TO_CHAR(SYSDATE, 'MMDD') = '0101' THEN
    UPDATE KLIENCI SET ID_ZNIZKI = 
        CASE 
            WHEN ID_ZNIZKI = 1 THEN 1
            ELSE ID_ZNIZKI - 1
        END;
  END IF;    
END OBNIZ_ZNIZKI;
/

-------------- TRIGGERY
------------------------------

-------------- ----------------------- -------------- 
-------------- -- AKTUALIZUJ ZNI�KE -- -------------- 
-------------- ----------------------- --------------
CREATE OR REPLACE TRIGGER AKTUALIZUJ_ZNIZKE 
BEFORE INSERT ON REZERWACJE 
FOR EACH ROW
DECLARE
  ID_KLIENTA NUMBER;
  ROCZNA_LICZBA_REZERWACJI NUMBER;
  ID_ZNIZKI NUMBER;
BEGIN
    SELECT :NEW.ID_KLIENTA INTO ID_KLIENTA FROM REZERWACJE WHERE ID_REZERWACJI = :NEW.ID_REZERWACJI;
    ROCZNA_LICZBA_REZERWACJI := ROCZNA_LICZBA_REZERWACJI_KLIENT(ID_KLIENTA);
    
    IF ROCZNA_LICZBA_REZERWACJI < 2 THEN
        SELECT ID_ZNIZKI INTO ID_ZNIZKI FROM ZNIZKI WHERE PROCENT = 0;
    ELSIF ROCZNA_LICZBA_REZERWACJI >= 2 AND ROCZNA_LICZBA_REZERWACJI <= 4 THEN
        SELECT ID_ZNIZKI INTO ID_ZNIZKI FROM ZNIZKI WHERE PROCENT = 5;
    ELSIF ROCZNA_LICZBA_REZERWACJI >= 5 AND ROCZNA_LICZBA_REZERWACJI <= 10 THEN
        SELECT ID_ZNIZKI INTO ID_ZNIZKI FROM ZNIZKI WHERE PROCENT = 10;
    ELSIF ROCZNA_LICZBA_REZERWACJI >= 10 THEN
        SELECT ID_ZNIZKI INTO ID_ZNIZKI FROM ZNIZKI WHERE PROCENT = 20;    
    END IF;
    
    UPDATE KLIENCI SET ID_ZNIZKI = ID_ZNIZKI WHERE ID_KLIENTA = ID_KLIENTA;
END;
/