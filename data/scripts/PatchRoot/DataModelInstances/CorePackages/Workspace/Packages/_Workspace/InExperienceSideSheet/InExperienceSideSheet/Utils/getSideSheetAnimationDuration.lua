-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local Constants = require(InExperienceSideSheet.Parent.Drawer).Constants

return function()
    return Constants.DRAWER_ANIM_SETTINGS.duration
end
