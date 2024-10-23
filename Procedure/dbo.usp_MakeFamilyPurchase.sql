-- 5.1 Создание хранимой процедуры для обновления бюджета семьи
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255) -- Входной параметр — фамилия семьи
AS
BEGIN
    -- Проверка, существует ли такая семья
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        -- Ошибка, если семьи с такой фамилией нет
        RAISERROR('Семья с фамилией %s не найдена', 16, 1, @FamilySurName);
        RETURN;
    END

    -- Обновление поля BudgetValue для указанной семьи
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (
        SELECT SUM(Value) FROM dbo.Basket
        WHERE ID_Family = (SELECT ID FROM dbo.Family WHERE SurName = @FamilySurName)
    )
    WHERE SurName = @FamilySurName;
END;