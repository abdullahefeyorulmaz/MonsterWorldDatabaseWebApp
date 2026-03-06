USE MonsterDB;
GO

-- Önce eski tabloyu siliyoruz
DROP TABLE Monster_Habitat_Loot;
GO

-- Þimdi ID sütunu olan (Primary Key) yeni halini oluþturuyoruz
CREATE TABLE Monster_Habitat_Loot (   
    ID INT PRIMARY KEY IDENTITY(1,1), -- ÝÞTE KURTARICI SÜTUNUMUZ BU!
    Monster_ID INT NOT NULL,  
    Habitat_ID INT NOT NULL,  
    Loot_ID INT NOT NULL, 
    Drop_Rate DECIMAL(4,2) CHECK (Drop_Rate BETWEEN 0 AND 1),  
    
    -- Eski anahtar yapýsýný "UNIQUE" yaparak koruyoruz (Ayný kayýt 2 kere girilmesin)
    CONSTRAINT UQ_Monster_Habitat_Loot UNIQUE (Monster_ID, Habitat_ID, Loot_ID),

    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (Habitat_ID) REFERENCES Habitat(ID),
    FOREIGN KEY (Loot_ID) REFERENCES Loot(ID)
); 
GO