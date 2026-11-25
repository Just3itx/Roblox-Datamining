-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationParent = script:FindFirstAncestor("Navigation").Parent
local Actions = require(NavigationParent.RoactNavigation).Actions
local _types = require(script.Parent.types)
local getRootNavigation = require(script.Parent.getRootNavigation)

local function canGoBack(arg1): boolean
    local rootNavigation = getRootNavigation(arg1)
    local state = rootNavigation.state

    return state ~= rootNavigation.router.getStateForAction(Actions.back({ key = false }), state)
end

return canGoBack
