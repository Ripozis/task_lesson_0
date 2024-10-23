-- 2.1 Создание таблицы dbo.SKU
CREATE TABLE dbo.SKU (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Code AS ('s' + CAST(ID AS VARCHAR(10))) PERSISTED,
    Name NVARCHAR(255) NOT NULL,
    CONSTRAINT UQ_SKU_Code UNIQUE (Code)
);

-- 2.2 Создание таблицы dbo.Family
CREATE TABLE dbo.Family (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SurName NVARCHAR(255) NOT NULL,
    BudgetValue DECIMAL(18,2) NOT NULL
);

-- 2.3 Создание таблицы dbo.Basket
CREATE TABLE dbo.Basket (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ID_SKU INT NOT NULL,
    ID_Family INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Value DECIMAL(18,2) NOT NULL CHECK (Value >= 0),
    PurchaseDate DATETIME DEFAULT GETDATE(),
    DiscountValue DECIMAL(18,2) NULL,
    CONSTRAINT FK_Basket_SKU FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU(ID),
    CONSTRAINT FK_Basket_Family FOREIGN KEY (ID_Family) REFERENCES dbo.Family(ID)
);