-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigationParent = script:FindFirstAncestor("AvatarExperienceNavigation").Parent

local var1 = require(AvatarExperienceNavigationParent.AppDebug).LogTree.logger("ax.rn.overlay")

return function(arg1, bool1: boolean?)
    var1:info("onOverlayClosed {}, captureFocus: {}", arg1, bool1)
end
