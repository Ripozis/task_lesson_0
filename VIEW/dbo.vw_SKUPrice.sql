-- 4.1 Создание представления, которое возвращает все атрибуты из dbo.SKU и рассчитанную цену продукта
CREATE VIEW dbo.vw_SKUPrice
AS
SELECT 
    SKU.ID,
    SKU.Code,
    SKU.Name,
    dbo.udf_GetSKUPrice(SKU.ID) AS SKUPrice -- Использование функции для расчета стоимости продукта
FROM dbo.SKU AS SKU;