-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent
local React = require(UserListParent.React)
local useTokens = require(UserListParent.Foundation).Hooks.useTokens

local function useCompactTileHeight()
    local var1 = useTokens()

    return (React.useMemo(function()
        local size1400 = var1.Size.Size_1400
        local medium = var1.Padding.Medium
        local small = var1.Gap.Small

        local fontSize = var1.Typography.TitleSmall.FontSize
        local fontSize2 = var1.Typography.LabelSmall.FontSize
        local fontSize3 = var1.Typography.BodySmall.FontSize

        local size800 = var1.Size.Size_800

        local var2 = fontSize + fontSize2 + fontSize3

        return medium + size1400 + small + var2 + small + size800 + medium
    end, { var1 }))
end

return useCompactTileHeight
