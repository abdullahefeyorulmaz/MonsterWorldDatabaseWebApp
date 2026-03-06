Monster Database WebApp
This is a "Dive Into the World of Monsters" Web project based on Blazor Web App, MSSQL Database, and Entity Framework 6. The purpose of this project is to provide a comprehensive database for an RPG (Role-Playing Game) universe. In this website, you can view, edit, and manage various monster species.

In the detailed view, you can see a monster's type, challenge rating, natural habitats, potential loot drops, specific abilities, and inherent traits. You can analyze their combat properties by viewing their resistances and weaknesses against different damage types.

In the Admin interface, you can create, read, update, and delete (CRUD) all elements including Monsters, Abilities, Traits, Loot, and Habitats. You can also manage complex relationships, such as assigning specific drop rates for items in certain habitats or defining which damage types a monster is weak against.

Implementation Steps
1. Database Creation
Create a database in MSSQL Server Management Studio with the query given below.



CREATE DATABASE MonsterDB;
GO
USE MonsterDB;
GO

-- 1. Independent Tables
CREATE TABLE Monster_Type (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Type_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Damage_Type (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Type_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Habitat (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Habitat_Name VARCHAR(50) NOT NULL,
    Region VARCHAR(50)
);

CREATE TABLE Loot (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Loot_Name VARCHAR(50) NOT NULL,
    Rarity VARCHAR(20)
);

CREATE TABLE Trait (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Trait_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Ability (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(MAX)
);

-- 2. Main Entity Table
CREATE TABLE Monster (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Challenge_Rating DECIMAL(3,1) NOT NULL,
    Monster_Type_ID INT NOT NULL,
    FOREIGN KEY (Monster_Type_ID) REFERENCES Monster_Type(ID)
);

-- 3. Relationship Tables (Many-to-Many)

CREATE TABLE Monster_Abilities (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    Ability_ID INT NOT NULL,
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Ability_ID) REFERENCES Ability(ID)
);

CREATE TABLE Monster_Traits (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    Trait_ID INT NOT NULL,
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Trait_ID) REFERENCES Trait(ID)
);

CREATE TABLE Monster_Resistances (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    DamageType_ID INT NOT NULL,
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
);

CREATE TABLE Monster_Weaknesses (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    DamageType_ID INT NOT NULL,
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
);

CREATE TABLE Monster_Habitat_Loot (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    Habitat_ID INT NOT NULL,
    Loot_ID INT NOT NULL,
    Drop_Rate DECIMAL(4,2), -- e.g., 0.50 for 50%
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Habitat_ID) REFERENCES Habitat(ID),
    FOREIGN KEY (Loot_ID) REFERENCES Loot(ID)
);
2. Data Population
Open a new query in your MSSQL Server Management Studio and insert the sample data given below to populate the dropdowns and lists.

SQL

-- Insert Types
INSERT INTO Monster_Type (Type_Name) VALUES ('Dragon'), ('Undead'), ('Beast'), ('Humanoid'), ('Elemental');
INSERT INTO Damage_Type (Type_Name) VALUES ('Fire'), ('Cold'), ('Poison'), ('Physical'), ('Lightning');

-- Insert Traits & Abilities
INSERT INTO Trait (Trait_Name) VALUES ('Aggressive'), ('Flying'), ('Stealthy'), ('Regenerating');
INSERT INTO Ability (Name, Description) VALUES ('Fire Breath', 'Exhales fire in a 15ft cone'), ('Howl', 'Calls allies for help'), ('Slash', 'Basic physical attack');

-- Insert Environment
INSERT INTO Habitat (Habitat_Name, Region) VALUES ('Volcanic Cave', 'North Mountains'), ('Dark Forest', 'Western Woods'), ('Ancient Graveyard', 'East Valley');
INSERT INTO Loot (Loot_Name, Rarity) VALUES ('Dragon Scale', 'Legendary'), ('Rusty Sword', 'Common'), ('Wolf Pelt', 'Uncommon'), ('Gold Coin', 'Rare');

-- Insert Monsters
INSERT INTO Monster (Name, Challenge_Rating, Monster_Type_ID) VALUES 
('Fire Drake', 5.0, 1),        -- Dragon
('Skeleton Warrior', 2.0, 2),  -- Undead
('Forest Wolf', 1.5, 3);       -- Beast

-- Insert Relations (Examples)
-- Fire Drake is resistant to Fire but weak to Cold
INSERT INTO Monster_Resistances (Monster_ID, DamageType_ID) VALUES (1, 1);
INSERT INTO Monster_Weaknesses (Monster_ID, DamageType_ID) VALUES (1, 2);

-- Fire Drake lives in Volcanic Cave and drops Dragon Scale with 0.10 rate
INSERT INTO Monster_Habitat_Loot (Monster_ID, Habitat_ID, Loot_ID, Drop_Rate) VALUES (1, 1, 1, 0.10);

-- Assign Abilities
INSERT INTO Monster_Abilities (Monster_ID, Ability_ID) VALUES (1, 1); -- Fire Drake has Fire Breath
INSERT INTO Monster_Abilities (Monster_ID, Ability_ID) VALUES (3, 2); -- Wolf has Howl
3. Setup & Usage
Open the CMPE232.sln file with Visual Studio using the "Open a project or solution" option.

Change your connection string in the appsettings.json file to match your local database instance. You can find your connection string by:

Clicking View > Server Explorer.

Right-clicking Data Connections > Add Connection and selecting the MonsterDB database.

Checking the Properties window for the Connection String.

After completing these steps, click the https (Run) button in Visual Studio.

Use the side navigation menu to access different entities. The "Relations" section allows you to manage Drop Rates, Resistances, Weaknesses, Abilities, and Traits using ID-based or Dropdown-based selection forms.

4. Important Notes
NuGet Packages: Make sure you have all necessary NuGet packages restored.

Do Not Update Model: Do not update the model from the database (.edmx). We have applied specific modifications to the .cs files (such as adding [ForeignKey] attributes and fixing relationship definitions) to handle Entity Framework 6 mapping correctly. Updating the model from the database will overwrite these manual fixes and break the application.

Disclaimer
This project is created solely for educational purposes. We aim to provide a solid foundation for database management in a web environment. No real monsters were harmed during the coding of this project.