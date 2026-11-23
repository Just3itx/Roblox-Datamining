-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local RoundedVariant = require(AppChat.Enums.RoundedVariant)
local getCornerRadii = require(script.Parent.Parent.getCornerRadii)

local tbl1 = {
    [RoundedVariant.Top] = { topLeft = true, topRight = true },
    [RoundedVariant.TopLeft] = { topLeft = true },
    [RoundedVariant.TopRight] = { topRight = true }
}

local function getGameCardThumbnailCornerRadii(arg1, num1: number)
    local var1 = tbl1[arg1 or RoundedVariant.Top] or tbl1[RoundedVariant.Top]
    return getCornerRadii(var1, num1)
end

return getGameCardThumbnailCornerRadii
