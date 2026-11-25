-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local FormFactor = require(SocialCommonParent.FormFactor)
local useSelector = require(SocialCommonParent.RoactUtils).Hooks.RoactRodux.useSelector

return function()
    return useSelector(function(arg1): boolean
        return arg1.FormFactor == FormFactor.Enums.FormFactor.WIDE
    end)
end
