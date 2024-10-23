-- 6.1 Создание триггера для таблицы dbo.Basket, который проверяет количество добавленных записей с одним и тем же ID_SKU
CREATE TRIGGER TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT
AS
BEGIN
    -- Объявление переменных
    DECLARE @ID_SKU INT;
    DECLARE @Quantity INT;

    -- Цикл по всем добавленным записям
    DECLARE cur CURSOR FOR 
    SELECT ID_SKU, Quantity FROM inserted;

    OPEN cur;
    FETCH NEXT FROM cur INTO @ID_SKU, @Quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Проверяем количество записей с тем же ID_SKU
        IF (SELECT COUNT(*) FROM inserted WHERE ID_SKU = @ID_SKU) >= 2
        BEGIN
            -- Если 2 и более записей, рассчитываем DiscountValue
            UPDATE dbo.Basket
            SET DiscountValue = Value * 0.05
            WHERE ID_SKU = @ID_SKU AND ID_Family IN (SELECT ID_Family FROM inserted WHERE ID_SKU = @ID_SKU);
        END
        ELSE
        BEGIN
            -- Иначе устанавливаем DiscountValue в 0
            UPDATE dbo.Basket
            SET DiscountValue = 0
            WHERE ID_SKU = @ID_SKU AND ID_Family IN (SELECT ID_Family FROM inserted WHERE ID_SKU = @ID_SKU);
        END

        FETCH NEXT FROM cur INTO @ID_SKU, @Quantity;
    END

    CLOSE cur;
    DEALLOCATE cur;
END;