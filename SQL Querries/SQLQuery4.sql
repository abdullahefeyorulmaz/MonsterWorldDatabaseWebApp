USE MonsterDB;
GO

-- 1. Önce Ability tablosuna baðlý olan ara tabloyu siliyoruz (Foreign Key hatasý almamak için)
IF OBJECT_ID('dbo.Monster_Abilities', 'U') IS NOT NULL
    DROP TABLE dbo.Monster_Abilities;
GO

-- 2. Sorunlu olan Ability tablosunu siliyoruz
IF OBJECT_ID('dbo.Ability', 'U') IS NOT NULL
    DROP TABLE dbo.Ability;
GO

-- 3. Ability Tablosunu 'IDENTITY(1,1)' (Otomatik Artan) ile YENÝDEN oluþturuyoruz
CREATE TABLE Ability ( 
    ID INT PRIMARY KEY IDENTITY(1,1), -- <-- ÝÞTE ÇÖZÜM BU SATIRDA!
    Name VARCHAR(50) NOT NULL, 
    Description VARCHAR(MAX) 
); 
GO

-- 4. Ara tabloyu (Monster_Abilities) tekrar oluþturuyoruz
CREATE TABLE Monster_Abilities (   
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Monster_ID INT NOT NULL,  
    Ability_ID INT NOT NULL, 
    CONSTRAINT UQ_Monster_Ability UNIQUE (Monster_ID, Ability_ID), 
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Ability_ID) REFERENCES Ability(ID)
); 
GO