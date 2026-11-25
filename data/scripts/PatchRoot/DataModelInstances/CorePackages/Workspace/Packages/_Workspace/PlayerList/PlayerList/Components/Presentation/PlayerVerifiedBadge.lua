-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)

local useVerifiedBadge = require(scriptParentParentParentParent.UserProfiles).Hooks.useVerifiedBadge

local VerifiedBadge = require(scriptParentParentParentParent.VerifiedBadges.VerifiedBadge)

local FFlagEnableVerifiedBadgeStore = require(scriptParentParentParentParent.SharedFlags).FFlagEnableVerifiedBadgeStore

return React.memo(function(tbl1) -- name: PlayerVerifiedBadge
    if not (if FFlagEnableVerifiedBadgeStore then useVerifiedBadge(tbl1.player) else tbl1.player.HasVerifiedBadge) then
        return nil
    end

    return React.createElement(VerifiedBadge, { LayoutOrder = tbl1.layoutOrder })
end)
