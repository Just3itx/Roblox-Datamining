-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local Cryo = require(RobloxAppNavigationParent.Cryo)
local React = require(RobloxAppNavigationParent.React)
local RoactNavigation = require(RobloxAppNavigationParent.RoactNavigation)
local tutils = require(RobloxAppNavigationParent.tutils)

local tbl1 = { navigation = true }

local function arePropsEqualIgnoringNavigation(arg1, arg2)
    return tutils.shallowEqual(arg1, arg2, tbl1)
end

local function withNavigationFocusIgnoringNavigation(arg1)
    return React.memo(RoactNavigation.withNavigationFocus(React.memo(function(arg2)
        return React.createElement(arg1, Cryo.Dictionary.join(arg2, { navigation = Cryo.None }))
    end, arePropsEqualIgnoringNavigation)))
end

return withNavigationFocusIgnoringNavigation
