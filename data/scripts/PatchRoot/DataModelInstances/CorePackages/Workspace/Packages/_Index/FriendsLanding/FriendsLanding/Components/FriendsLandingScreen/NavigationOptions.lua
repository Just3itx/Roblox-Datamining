-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local Roact = require(FriendsLanding.dependencies).Roact
local LocalizedKeys = require(FriendsLanding.Enums.LocalizedKeys)

local HeaderBarRightView = require(FriendsLanding.Components.HeaderBarRightView)

return function(arg1)
    return {
        headerText = {
            raw = LocalizedKeys.FriendsHeader.rawValue(),
            shouldLocalize = true
        },
        useSecondaryHeader = true,
        shouldExitNavigation = false,
        tabBarVisible = false,
        renderRight = function()
            return Roact.createElement(HeaderBarRightView, arg1)
        end,
        transparent = true,
        absorbInputSelectable = false
    }
end
