CREATE DATABASE pracownicy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_polish_ci;
USE pracownicy;

-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.

CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    imie VARCHAR(30) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    wyplata DECIMAL(7.2) NOT NULL,
    data_urodzenia DATE NOT NULL,
    stanowisko VARCHAR(45)
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników

INSERT INTO pracownik (imie, nazwisko, wyplata, data_urodzenia, stanowisko)
	VALUES
    ('Kasia', 'Fasola', 25000, '1980-02-02', 'kierownik projektów IT'),
    ('Robert', 'Leszcz', 25000, '1980-02-02', 'kierownik projektów IT'),
    ('Stefan', 'Hill', 9000, '1988-12-15', 'analityk danych'),
    ('Max', 'Podkowa', 19000, '1995-07-24', 'front end developer'),
    ('Jan', 'Karczewski', 15000, '2000-01-04', 'back end developer'),
    ('Zosia', 'Zembata', 8000, '2003-09-02', 'tester oprogramowania'),
    ('Mariusz', 'Kapuściński', 10000, '1970-11-18', 'analityk ds. bezpieczeństwa');
    
-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku

SELECT * FROM pracownik ORDER BY nazwisko ASC;

-- 4. Pobiera pracowników na wybranym stanowisku

SELECT * FROM pracownik WHERE stanowisko = 'kierownik projektów IT';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat

SELECT * FROM pracownik WHERE TIMESTAMPDIFF(YEAR, data_urodzenia, CURDATE()) >= 30;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

UPDATE pracownik SET wyplata = wyplata * 1.1 WHERE (stanowisko = 'kierownik projektów IT' AND id <> 0);  

-- 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)

SELECT imie, nazwisko, data_urodzenia  FROM pracownik WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik);

-- 8. Usuwa tabelę pracownik

DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)

CREATE TABLE stanowisko (
	stanowisko_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nazwa_stanowiska VARCHAR(50) NOT NULL,
    opis VARCHAR(200),
    wypata DECIMAL(7,2) NOT NULL
);

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)

CREATE TABLE adres (
	adres_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ulica VARCHAR(50) NOT NULL,
    numer_domu VARCHAR(10) NOT NULL,
    numer_mieszkania VARCHAR(10),
    kod_pocztowy VARCHAR(6) NOT NULL,
    miesjcowosc VARCHAR(30) NOT NULL
);

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres

CREATE TABLE pracownik (
	id INT AUTO_INCREMENT NOT NULL,
    stanowisko_id VARCHAR(4) NOT NULL,
    adres_id VARCHAR(4) NOT NULL,
    imie VARCHAR(30) NOT NULL,
    nazwisko VARCHAR(30) NOT NULL,
    PRIMARY KEY (id, stanowisko_id, adres_id)
);

-- 12.Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

INSERT INTO adres (ulica, numer_domu, numer_mieszkania, kod_pocztowy, miesjcowosc)
	VALUES
    ('Chabrów', 10, 11, '55-555', 'Opole'),
    ('1go. Maja', 18, NULL, '65-888', 'Kraków'),
    ('Poznańska', 12, NULL, '33-787', 'Wrocław'),
    ('Malwowa', 55, 23, '15-222', 'Lublin'),
    ('Ozimska', 33, 2, '22-222', 'Warszawa'),
    ('Wrocławska', '188b', 15, '66-952', 'Ozimek'),
    ('Ozimska', 202, NULL, '35-645', 'Jelenia Góra');
    
INSERT INTO stanowisko (nazwa_stanowiska, opis, wypata)
	VALUES
    ('kierownik projektów IT', NULL, 25000),
    ('analityk danych', NULL, 9000),
    ('front end developer', NULL, 19000),
    ('back end developer', NULL, 15000),
    ('tester oprogramowania', NULL, 8000),
    ('analityk ds. bezpieczeństwa', NULL, 10000);
    
INSERT INTO pracownik (imie, nazwisko, adres_id, stanowisko_id)
	VALUES 
    ('Kasia', 'Fasol', 1, 1),
    ('Robert', 'Leszcz', 2, 2),
    ('Stefan', 'Hill', 3, 3),
    ('Max', 'Podkowa', 4, 4),
    ('Jan', 'Karczewski', 5, 5),
    ('Zosia', 'Zębata', 6, 6),
    ('Mariusz', 'Kapuściński', 7, 2);
    
-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)

SELECT p.imie, p.nazwisko,
		a.ulica, a.numer_domu, a.numer_mieszkania, a.miesjcowosc, a.kod_pocztowy, 
        s.nazwa_stanowiska, s.opis, s.wypata 
	FROM pracownik p 
    JOIN adres a 
		ON p.adres_id = a.adres_id
	JOIN stanowisko s
		ON p.stanowisko_id = s.stanowisko_id;
        
-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie

SELECT SUM(s.wypata) AS 'SUMA WYPŁAT' FROM pracownik p 
	JOIN stanowisko s
		ON p.stanowisko_id = s.stanowisko_id;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210 (albo innym, który będzie miał sens dla Twoich danych testowych)

SELECT * FROM pracownik p 
	JOIN adres a
		ON p.adres_id = a.adres_id
	WHERE a.kod_pocztowy = '35-645';


    
    