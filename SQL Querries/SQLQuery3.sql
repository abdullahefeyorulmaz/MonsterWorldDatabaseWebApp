USE MonsterDB;
GO

-- ==========================================
-- 1. Monster_Weaknesses Tablosunu Düzeltiyoruz
-- ==========================================

-- Önce eskisini siliyoruz
DROP TABLE Monster_Weaknesses;
GO

-- Yeni ID'li halini oluþturuyoruz
CREATE TABLE Monster_Weaknesses (   
    ID INT PRIMARY KEY IDENTITY(1,1), -- Kurtarýcý ID Sütunu
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    
    -- Ayný canavara ayný zayýflýðý 2 kere eklemeyi engellemek için:
    CONSTRAINT UQ_Monster_Weaknesses UNIQUE (Monster_ID, DamageType_ID),

    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 
GO

-- ==========================================
-- 2. Monster_Resistances Tablosunu Düzeltiyoruz
-- ==========================================

-- Önce eskisini siliyoruz
DROP TABLE Monster_Resistances;
GO

-- Yeni ID'li halini oluþturuyoruz
CREATE TABLE Monster_Resistances (   
    ID INT PRIMARY KEY IDENTITY(1,1), -- Kurtarýcý ID Sütunu
    Monster_ID INT NOT NULL,  
    DamageType_ID INT NOT NULL,  
    
    -- Ayný canavara ayný direnci 2 kere eklemeyi engellemek için:
    CONSTRAINT UQ_Monster_Resistances UNIQUE (Monster_ID, DamageType_ID),

    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID),
    FOREIGN KEY (DamageType_ID) REFERENCES Damage_Type(ID)
); 
GO