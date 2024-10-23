-- 3. Создание функции для расчета стоимости SKU
CREATE FUNCTION dbo.udf_GetSKUPrice(@ID_SKU INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(18,2), @TotalQuantity INT;
    
    -- 3.1.1 Подсчет суммы Value и Quantity для переданного SKU
    SELECT @TotalValue = SUM(Value), @TotalQuantity = SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    -- 3.3 Возвращение результата: цена за единицу товара
    RETURN CASE 
        WHEN @TotalQuantity = 0 THEN 0 
        ELSE @TotalValue / @TotalQuantity 
    END;
END;
