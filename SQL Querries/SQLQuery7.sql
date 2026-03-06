USE MonsterDB;
GO

-- 1. ADIM: Eðer tablo zaten varsa, önce onu bir güzel temizle (Sil)
IF OBJECT_ID('dbo.Monster_Abilities', 'U') IS NOT NULL
    DROP TABLE dbo.Monster_Abilities;
GO

-- 2. ADIM: Þimdi tertemiz, iliþkileri kurulmuþ halini yarat
CREATE TABLE Monster_Abilities (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Monster_ID INT NOT NULL,
    Ability_ID INT NOT NULL,
    
    -- "ON DELETE CASCADE" sayesinde Canavar silinirse yetenek baðý da otomatik silinir
    FOREIGN KEY (Monster_ID) REFERENCES Monster(ID) ON DELETE CASCADE,
    FOREIGN KEY (Ability_ID) REFERENCES Ability(ID) ON DELETE CASCADE
);
GO