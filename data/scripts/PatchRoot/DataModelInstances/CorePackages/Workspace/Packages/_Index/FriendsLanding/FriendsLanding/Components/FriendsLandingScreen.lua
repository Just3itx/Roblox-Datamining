-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local Roact = require(FriendsLanding.dependencies).Roact
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local FriendsLandingContainer = require(FriendsLanding.Components.FriendsLandingContainer)

local var1 = Roact.PureComponent:extend("FriendsLandingScreen")

var1.defaultProps = {
    friends = {}
}

function var1.render(_)
    return FriendsLandingContext.with(function(_)
        return Roact.createElement(FriendsLandingContainer, {})
    end)
end

return var1
