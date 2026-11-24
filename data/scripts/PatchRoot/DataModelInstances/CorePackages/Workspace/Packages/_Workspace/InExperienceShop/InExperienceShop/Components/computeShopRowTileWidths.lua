-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    SHOP_ITEM_MEDIA_HEIGHT_SCALE = 0.85,
    MEDIA_HEIGHT_SCALE_FALLBACK = 0.425,
    computeShopRowTileWidths = function(num1: number, num2: number, num3: number, bool1: boolean)
        if num1 <= 0 or num3 <= 0 then
            return {
                shopWidth = 0,
                featuredRobuxWidth = if bool1 then 0 else nil
            }
        end

        local shopWidth = (num1 - (num3 - 1) * num2) / num3

        return {
            shopWidth = shopWidth,
            featuredRobuxWidth = if bool1 then shopWidth * 2 + num2 else nil
        }
    end,
    computeRobuxPackageMediaHeightScale = function(num1: number, num2: number): number
        if num1 <= 0 then
            return 0.425
        end

        local num3 = num1 * 2 + num2
        return if num3 <= 0 then 0.425 else num1 * 0.85 / num3
    end
}
