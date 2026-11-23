-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function AvatarPolicies(arg1)
    return {
        getAvatarHeaderIcon = function()
            return arg1.AvatarHeaderIcon or "LuaApp/icons/ic-back"
        end,
        getAvatarEditorShowBuyRobuxOnTopBar = function()
            return arg1.AvatarEditorShowBuyRobuxOnTopBar or false
        end,
        getCustomOutfitNames = function()
            return arg1.CustomCostumeNames == nil or arg1.CustomCostumeNames
        end
    }
end

return AvatarPolicies
