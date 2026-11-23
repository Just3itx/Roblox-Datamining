-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

return require(AvatarWorkshopParent.React).createContext({
    verticalLayout = false,
    onClose = function() end
})
