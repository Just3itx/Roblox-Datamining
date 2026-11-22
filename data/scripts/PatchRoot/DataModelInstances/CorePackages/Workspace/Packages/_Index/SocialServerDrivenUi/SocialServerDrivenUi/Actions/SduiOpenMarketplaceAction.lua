-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local _SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local AvatarScreen = require(SocialServerDrivenUiParent.AvatarExperienceNavigation).Enums.AvatarScreen

return function(_, _, arg1, _)
    arg1.dependencies.getNavigation().navigate(AvatarScreen.Catalog)
end
