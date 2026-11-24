-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local function getShopViewportBounds(vector2: Vector2)
    local topbarInset = GuiService.TopbarInset
    local _vector2, vector2_2 = GuiService:GetGuiInset()

    return {
        min = Vector2.new(0, topbarInset.Max.Y),
        max = Vector2.new(vector2.X, vector2.Y - vector2_2.Y)
    }
end

local function intersectViewPortBounds(tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        min = tbl1.min:Max(tbl2.min),
        max = tbl1.max:Min(tbl2.max)
    }
end

local function getScrollClipBounds(arg1)
    while arg1 do
        if arg1:IsA("ScrollingFrame") then
            local absolutePosition = arg1.AbsolutePosition
            return {
                min = absolutePosition,
                max = absolutePosition + arg1.AbsoluteSize
            }
        end
        arg1 = arg1.Parent
    end

    return nil
end

return {
    getShopViewportBounds = getShopViewportBounds,
    getShopImpressionsViewportBounds = function(vector2: Vector2, arg1)
        local shopViewportBounds = getShopViewportBounds(vector2)
        if arg1 == nil then
            return shopViewportBounds
        end

        local scrollClipBounds = getScrollClipBounds(arg1)
        if scrollClipBounds == nil then
            return shopViewportBounds
        end

        return intersectViewPortBounds(shopViewportBounds, scrollClipBounds)
    end,
    intersectViewPortBounds = intersectViewPortBounds,
    getScrollClipBounds = getScrollClipBounds
}
