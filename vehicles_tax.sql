# Creaza baza de date "vehicle_tax"
CREATE DATABASE vehicle_tax;
USE vehicle_tax;

# Creaza tabela "owners"
CREATE table owners (
ownerId INT NOT NULL, 
firstName VARCHAR(20) NOT NULL,
lastName VARCHAR(30) NOT NULL,
dateOfBirth date NOT NULL,
age INT NOT NULL
); 

# Definește coloana “onwerId” drept cheie primară a tabelei “owners”
ALTER TABLE owners
ADD PRIMARY KEY(ownerId);
DESC owners;
ALTER TABLE owners
MODIFY ownerId INT NOT NULL AUTO_INCREMENT;

# Modifică tabela “owners” prin inserarea coloanei “gender”
ALTER TABLE owners
ADD column gender VARCHAR(10) NOT NULL;
DESC owners;

# Populează tabela “owners” cu zece înregistrari aferente coloanelor existente
INSERT INTO owners
(firstName, lastName, dateOfBirth, age, gender)
VALUES
('Maria', 'Andone', '1988-08-12', 35, 'female'),
('Ion', 'Pantelimon', '1975-04-21', 48, 'male'),
('Antocomputerstoren', 'Andriesei', '1964-10-24', 59, 'male'),
('Mihai', 'Georgescu', '2003-12-05', 20, 'male'),
('Violeta', 'Nicoara', '1995-09-27', 28, 'female'),
('Andreea', 'Popa', '2000-05-18', 23, 'female'),
('Geta', 'Mandru', '1971-07-13', 52, 'female'),
('Doru', 'Stamate', '1982-02-09', 41, 'male'),
('Luminita', 'Rotaru', '1986-06-02', 37, 'female'),
('Catalin', 'Vasiliu', '1960-11-30', 37, 'male');

desc owners;
SELECT * FROM owners;

# Creaza tabela "vehicles"
CREATE TABLE vehicles (
vehicleId INT NOT NULL AUTO_INCREMENT,
vehicleType VARCHAR(25) NOT NULL,
vehicleModel VARCHAR(50) NOT NULL,
ownerId INT NOT NULL,
PRIMARY KEY (vehicleId),
foreign key (ownerId) references owners (ownerId)
); 

# Populează tabela “vehicles” cu înregistrari aferente coloanelor existente
INSERT INTO vehicles
(vehicleType, vehicleModel, ownerId)
VALUES
('car', 'VW Polo', 1),
('car', 'Dacia Duster', 2),
('motorcycle', 'Harley Davidson Freewheeler', 3),
('scooter', 'RDB Sulina', 4),
('car', 'Toyota Yaris', 5),
('scooter', 'Bili Bike Cobra', 6),
('car', 'Dacia Logan', 7),
('motorcycle', 'Honda Naked', 8),
('car', 'VW Taigo', 9),
('car', 'Nissan Qashqai', 10),
('car', 'Nissan Qashqai', 8),
('car', 'Dacia Spring', 6);

SELECT * FROM vehicles;
desc vehicles;


# Creaza tabela "tax"
CREATE TABLE tax (
taxId INT NOT NULL AUTO_INCREMENT,
taxValueOfCurrentYear INT NOT NULL,
dayOfPayment DATE,
ownerId INT NOT NULL,
vehicleId INT NOT NULL,
PRIMARY KEY (taxId),
foreign key (ownerId) references owners (ownerId),
foreign key (vehicleId) references vehicles (vehicleId)
);

# Populează tabela “tax” cu înregistrari aferente coloanelor existente
INSERT INTO tax
(taxValueOfCurrentYear, dayOfPayment, ownerId, vehicleId)
VALUES
(110, '2023-05-26', 1, 1),
(100, '2023-10-22', 2, 2),
(16, '2023-02-15', 4, 4),
(105, '2023-01-20', 5, 5),
(16, '2023-07-30', 6, 6),
(55, '2023-07-02', 7, 7),
(32, '2023-09-17', 8, 8),
(180, '2023-09-17', 10, 10),
(180, '2023-08-21', 8, 11);

# Actualizeaza informatiile din tabela "tax" cu date aferente coloanelor existente, 
# mai putin coloana "dayOfPayment" 
INSERT INTO tax
(taxValueOfCurrentYear, ownerId, vehicleId)
VALUES
(81, 3, 3),
(130, 9, 9),
(45, 6, 12);

SELECT * FROM tax;

# Afișează  cheile secundare ale tabelei “tax”. 
desc tax;

# Afișează proprietarii de gen feminin născuți înainte de anul 2000
SELECT firstName, lastName FROM owners
WHERE gender = 'female' AND dateOfBirth LIKE '19%'; 

# Numară vehiculele de tip “car”.
SELECT COUNT(*) FROM vehicles WHERE vehicleType = 'car';

# Afișează vehiculele aflate în proprietatea lui Doru Stamate
SELECT owners.firstName, owners.lastName, vehicles.vehicleType FROM owners
INNER JOIN vehicles ON owners.ownerId = vehicles.ownerId
WHERE lastName = 'Stamate';

# Afișează toți proprietarii de gen feminin care dețin un scooter
SELECT owners.firstName, owners.lastName, owners.gender, vehicles.vehicleType FROM owners
INNER JOIN vehicles ON owners.ownerId = vehicles.ownerId 
WHERE gender = 'female' AND vehicleType = 'scooter';

# Afișează suma încasată din taxele achitate pentru anul curent
SELECT SUM(taxValueOfCurrentYear) FROM tax WHERE dayOfPayment IS NOT NULL;

# Afișează primii doi proprietari care și-au achitat cel mai devreme impozitele
SELECT owners.firstName, owners.lastName, tax.dayOfPayment FROM owners
INNER JOIN tax ON owners.ownerId = tax.ownerId
WHERE dayOfPayment ORDER BY dayOfPayment ASC LIMIT 2; 

# Afiseaza toti proprietarii de motociclete
SELECT owners.firstName, owners.lastName, vehicles.vehicleType FROM owners 
INNER JOIN vehicles ON owners.ownerId = vehicles.ownerId WHERE vehicleType = 'motorcycle';

# Afiseaza proprietarii care nu si-au platit taxele pentru anul curent
SELECT owners.firstName, owners.lastName, tax.dayOfPayment FROM owners
INNER JOIN tax ON owners.ownerId = tax.ownerId
WHERE dayOfPayment IS NULL;

# Afiseaza persoanele intre 30-60 de ani care si-au achitat impozitul pentru anul curent
SELECT owners.firstName, owners.lastName, owners.age, tax.dayOfPayment FROM owners
INNER JOIN tax ON owners.ownerId = tax.ownerId
WHERE age BETWEEN 30 AND 60 AND dayOfPayment IS NOT NULL;

# Afiseaza lista persoanelor nascute dupa anul 2000 care detin in proprietate o motocicleta.
SELECT owners.firstName, owners.lastName, owners.dateOfBirth, vehicles.vehicleType FROM owners
INNER JOIN vehicles ON owners.ownerId = vehicles.ownerId
WHERE dateOfBirth LIKE '20%' AND vehicleType = 'motorcycle';


DROP table owners;
DROP table vehicles;
DROP table tax;






