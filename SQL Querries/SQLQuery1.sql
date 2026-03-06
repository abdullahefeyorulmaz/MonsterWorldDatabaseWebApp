-- 1. Create the Database
CREATE DATABASE MonsterDB;
GO

-- 2. Select the Database to use
USE MonsterDB;
GO

-- ==========================================
-- CREATE TABLES
-- ==========================================

-- 3. Monster_Type Table
CREATE TABLE Monster_Type ( 
    ID INT PRIMARY KEY,
    Type_Name VARCHAR(50) UNIQUE NOT NULL
); 

-- 4. Monster Table
CREATE TABLE Monster ( 
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL, 
    Challenge_Rating DECIMAL(3,1) NOT NULL CHECK (Challenge_Rating >= 0), 
    Monster_Type_ID INT NOT NULL, 
    FOREIGN KEY (Monster_Type_ID) REFERENCES Monster_Type(ID)
); 

-- 5. Ability Table
CREATE TABLE Ability ( 
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL, 
    Description TEXT 
); 

-- 6. Monster_Abilities Table
CREATE TABLE Monster_Abilities (   
    Monster_ID INT NOT NULL,  
    Ability_ID INT NOT NULL, 
    PRIMARY KEY (Monster_ID, Ability_ID), 
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Ability_ID) REFERENCES Ability(ID)
); 

-- 7. Trait Table
CREATE TABLE Trait ( 
    ID INT PRIMARY KEY,
    Trait_Name VARCHAR(50) UNIQUE NOT NULL 
); 

-- 8. Monster_Traits Table
CREATE TABLE Monster_Traits (   
    Monster_ID INT NOT NULL,  
    Trait_ID INT NOT NULL,  
    PRIMARY KEY (Monster_ID, Trait_ID),  
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Trait_ID) REFERENCES Trait(ID)
); 

-- 9. Damage_Type Table
CREATE TABLE Damage_Type ( 
    ID INT PRIMARY KEY,
    Type_Name VARCHAR(30) UNIQUE NOT NULL
); 

-- 10. Monster_Weaknesses Table
CREATE TABLE Monster_Weaknesses (   
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    PRIMARY KEY (Monster_ID, DamageType_ID),  
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 

-- 11. Monster_Resistances Table
CREATE TABLE Monster_Resistances (   
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    PRIMARY KEY (Monster_ID, DamageType_ID), 
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 

-- 12. Habitat Table
CREATE TABLE Habitat ( 
    ID INT PRIMARY KEY,
    Habitat_Name VARCHAR(50) UNIQUE NOT NULL, 
    Region VARCHAR(50)
); 

-- 13. Loot Table
CREATE TABLE Loot ( 
    ID INT PRIMARY KEY,
    Loot_Name VARCHAR(50) NOT NULL, 
    Rarity VARCHAR(20) CHECK (Rarity IN ('Common','Rare','Epic','Legendary'))
); 

-- 14. Monster_Habitat_Loot Table
CREATE TABLE Monster_Habitat_Loot (   
    Monster_ID INT NOT NULL,  
    Habitat_ID INT NOT NULL,  
    Loot_ID INT NOT NULL, 
    Drop_Rate DECIMAL(4,2) CHECK (Drop_Rate BETWEEN 0 AND 1), 
    PRIMARY KEY (Monster_ID, Habitat_ID, Loot_ID),  
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Habitat_ID) REFERENCES Habitat(ID),
    FOREIGN KEY (Loot_ID) REFERENCES Loot(ID)
); 


-- ==========================================
-- INSERT DATA
-- ==========================================

INSERT INTO Monster_Type (ID, Type_Name) VALUES
    (1, 'Dragon'),
    (2, 'Undead'),
    (3, 'Beast');

INSERT INTO Monster (ID, Name, Challenge_Rating, Monster_Type_ID) VALUES
    (1, 'Fire Drake', 5.0, 1),
    (2, 'Skeleton Warrior', 2.0, 2),
    (3, 'Forest Wolf', 1.5, 3);

INSERT INTO Ability (ID, Name, Description) VALUES
    (1, 'Fire Breath', 'Deals heavy fire damage in a cone area.'),
    (2, 'Bone Shield', 'Creates a defensive barrier made of bones.'),
    (3, 'Howl', 'Boosts nearby allies attack power.');

INSERT INTO Monster_Abilities (Monster_ID, Ability_ID) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (1, 3),
    (2, 3);

INSERT INTO Trait (ID, Trait_Name) VALUES
    (1, 'Flying'),
    (2, 'Regenerating'),
    (3, 'Aggressive');

INSERT INTO Monster_Traits (Monster_ID, Trait_ID) VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (3, 3),
    (3, 2);

INSERT INTO Damage_Type (ID, Type_Name) VALUES
    (1, 'Fire'),
    (2, 'Cold'),
    (3, 'Poison');

INSERT INTO Monster_Weaknesses (Monster_ID, DamageType_ID) VALUES
    (1, 2),
    (2, 3),
    (3, 1);

INSERT INTO Monster_Resistances (Monster_ID, DamageType_ID) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO Habitat (ID, Habitat_Name, Region) VALUES
    (1, 'Volcanic Cave', 'Southern Mountains'),
    (2, 'Ancient Graveyard', 'Eastern Valley'),
    (3, 'Dark Forest', 'Northern Woods');

INSERT INTO Loot (ID, Loot_Name, Rarity) VALUES
    (1, 'Dragon Scale', 'Rare'),
    (2, 'Rusty Sword', 'Common'),
    (3, 'Wolf Pelt', 'Common');

INSERT INTO Monster_Habitat_Loot (Monster_ID, Habitat_ID, Loot_ID, Drop_Rate) VALUES
    (1, 1, 1, 0.25),
    (2, 2, 2, 0.50),
    (3, 3, 3, 0.60),
    (1, 3, 3, 0.10),
    (2, 1, 2, 0.30);