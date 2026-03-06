USE MonsterDB;
GO

-- ==========================================
-- 1. TEMÝZLÝK (Eski Tablolarý Siliyoruz)
-- ==========================================
-- Önce child (baðýmlý) tablolar silinmeli
IF OBJECT_ID('dbo.Monster_Habitat_Loot', 'U') IS NOT NULL DROP TABLE dbo.Monster_Habitat_Loot;
IF OBJECT_ID('dbo.Monster_Resistances', 'U') IS NOT NULL DROP TABLE dbo.Monster_Resistances;
IF OBJECT_ID('dbo.Monster_Weaknesses', 'U') IS NOT NULL DROP TABLE dbo.Monster_Weaknesses;
IF OBJECT_ID('dbo.Monster_Traits', 'U') IS NOT NULL DROP TABLE dbo.Monster_Traits;
IF OBJECT_ID('dbo.Monster_Abilities', 'U') IS NOT NULL DROP TABLE dbo.Monster_Abilities;
IF OBJECT_ID('dbo.Loot', 'U') IS NOT NULL DROP TABLE dbo.Loot;
IF OBJECT_ID('dbo.Habitat', 'U') IS NOT NULL DROP TABLE dbo.Habitat;
IF OBJECT_ID('dbo.Damage_Type', 'U') IS NOT NULL DROP TABLE dbo.Damage_Type;
IF OBJECT_ID('dbo.Trait', 'U') IS NOT NULL DROP TABLE dbo.Trait;
IF OBJECT_ID('dbo.Ability', 'U') IS NOT NULL DROP TABLE dbo.Ability;
IF OBJECT_ID('dbo.Monster', 'U') IS NOT NULL DROP TABLE dbo.Monster;
IF OBJECT_ID('dbo.Monster_Type', 'U') IS NOT NULL DROP TABLE dbo.Monster_Type;
GO

-- ==========================================
-- 2. TABLO OLUÞTURMA (IDENTITY Eklendi)
-- ==========================================

-- 1. Monster_Type
CREATE TABLE Monster_Type ( 
    ID INT PRIMARY KEY IDENTITY(1,1), -- Otomatik Artan ID
    Type_Name VARCHAR(50) UNIQUE NOT NULL
); 

-- 2. Monster
CREATE TABLE Monster ( 
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Name VARCHAR(50) NOT NULL, 
    Challenge_Rating DECIMAL(3,1) NOT NULL CHECK (Challenge_Rating >= 0), 
    Monster_Type_ID INT NOT NULL, 
    FOREIGN KEY (Monster_Type_ID) REFERENCES Monster_Type(ID)
); 

-- 3. Ability (Sorun yaþadýðýn tablo - DÜZELTÝLDÝ)
CREATE TABLE Ability ( 
    ID INT PRIMARY KEY IDENTITY(1,1), -- Artýk NULL hatasý vermez
    Name VARCHAR(50) NOT NULL, 
    Description VARCHAR(MAX) -- TEXT yerine güncel tip
); 

-- 4. Monster_Abilities (Ara Tablo)
CREATE TABLE Monster_Abilities (   
    ID INT PRIMARY KEY IDENTITY(1,1), -- EF için kendi ID'si var
    Monster_ID INT NOT NULL,  
    Ability_ID INT NOT NULL, 
    CONSTRAINT UQ_Monster_Ability UNIQUE (Monster_ID, Ability_ID), 
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Ability_ID) REFERENCES Ability(ID)
); 

-- 5. Trait
CREATE TABLE Trait ( 
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Trait_Name VARCHAR(50) UNIQUE NOT NULL 
); 

-- 6. Monster_Traits
CREATE TABLE Monster_Traits (   
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,  
    Trait_ID INT NOT NULL,  
    CONSTRAINT UQ_Monster_Trait UNIQUE (Monster_ID, Trait_ID),
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Trait_ID) REFERENCES Trait(ID)
); 

-- 7. Damage_Type
CREATE TABLE Damage_Type ( 
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Type_Name VARCHAR(30) UNIQUE NOT NULL
); 

-- 8. Monster_Weaknesses
CREATE TABLE Monster_Weaknesses (   
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    CONSTRAINT UQ_Monster_Weakness UNIQUE (Monster_ID, DamageType_ID),
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 

-- 9. Monster_Resistances
CREATE TABLE Monster_Resistances (   
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    CONSTRAINT UQ_Monster_Resistance UNIQUE (Monster_ID, DamageType_ID),
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 

-- 10. Habitat
CREATE TABLE Habitat ( 
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Habitat_Name VARCHAR(50) UNIQUE NOT NULL, 
    Region VARCHAR(50)
); 

-- 11. Loot
CREATE TABLE Loot ( 
    ID INT PRIMARY KEY IDENTITY(1,1), 
    Loot_Name VARCHAR(50) NOT NULL, 
    Rarity VARCHAR(20) CHECK (Rarity IN ('Common','Rare','Epic','Legendary'))
); 

-- 12. Monster_Habitat_Loot
CREATE TABLE Monster_Habitat_Loot (   
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,  
    Habitat_ID INT NOT NULL,  
    Loot_ID INT NOT NULL, 
    Drop_Rate DECIMAL(4,2) CHECK (Drop_Rate BETWEEN 0 AND 1),  
    CONSTRAINT UQ_Monster_Habitat_Loot UNIQUE (Monster_ID, Habitat_ID, Loot_ID),
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Habitat_ID) REFERENCES Habitat(ID),
    FOREIGN KEY (Loot_ID) REFERENCES Loot(ID)
); 


-- ==========================================
-- 3. ÖRNEK VERÝ GÝRÝÞÝ (ID'siz - Otomatik)
-- ==========================================

INSERT INTO Monster_Type (Type_Name) VALUES
    ('Dragon'),
    ('Undead'),
    ('Beast');

INSERT INTO Monster (Name, Challenge_Rating, Monster_Type_ID) VALUES
    ('Fire Drake', 5.0, 1),      
    ('Skeleton Warrior', 2.0, 2), 
    ('Forest Wolf', 1.5, 3);      

INSERT INTO Ability (Name, Description) VALUES
    ('Fire Breath', 'Deals heavy fire damage in a cone area.'),
    ('Bone Shield', 'Creates a defensive barrier made of bones.'),
    ('Howl', 'Boosts nearby allies attack power.');

INSERT INTO Monster_Abilities (Monster_ID, Ability_ID) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (1, 3),
    (2, 3);

INSERT INTO Trait (Trait_Name) VALUES
    ('Flying'),
    ('Regenerating'),
    ('Aggressive');

INSERT INTO Monster_Traits (Monster_ID, Trait_ID) VALUES
    (1, 1), (1, 3), (2, 2), (3, 3), (3, 2);

INSERT INTO Damage_Type (Type_Name) VALUES
    ('Fire'), ('Cold'), ('Poison');

INSERT INTO Monster_Weaknesses (Monster_ID, DamageType_ID) VALUES
    (1, 2), (2, 3), (3, 1);

INSERT INTO Monster_Resistances (Monster_ID, DamageType_ID) VALUES
    (1, 1), (2, 2), (3, 3);

INSERT INTO Habitat (Habitat_Name, Region) VALUES
    ('Volcanic Cave', 'Southern Mountains'),
    ('Ancient Graveyard', 'Eastern Valley'),
    ('Dark Forest', 'Northern Woods');

INSERT INTO Loot (Loot_Name, Rarity) VALUES
    ('Dragon Scale', 'Rare'),
    ('Rusty Sword', 'Common'),
    ('Wolf Pelt', 'Common');

INSERT INTO Monster_Habitat_Loot (Monster_ID, Habitat_ID, Loot_ID, Drop_Rate) VALUES
    (1, 1, 1, 0.25),
    (2, 2, 2, 0.50),
    (3, 3, 3, 0.60),
    (1, 3, 3, 0.10),
    (2, 1, 2, 0.30);