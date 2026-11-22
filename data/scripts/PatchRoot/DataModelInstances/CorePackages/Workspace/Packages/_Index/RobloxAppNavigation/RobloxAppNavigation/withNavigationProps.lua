-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local React = require(RobloxAppNavigationParent.React)
local Cryo = require(RobloxAppNavigationParent.Cryo)

local useNavigationProps = require(script.Parent.useNavigationProps)
local _types = require(script.Parent.types)

local function withNavigationProps(arg1)
    return function(arg2)
        return function(arg3)
            return React.createElement(arg2, Cryo.Dictionary.join(arg3, useNavigationProps(arg1)))
        end
    end
end

return withNavigationProps
