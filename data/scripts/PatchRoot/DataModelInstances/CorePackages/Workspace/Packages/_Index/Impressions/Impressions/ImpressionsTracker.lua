-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent
local Cryo = require(ImpressionsParent.Cryo)
local React = require(ImpressionsParent.React)
local useRouteName = require(ImpressionsParent.Navigation).useRouteName
local _ImpressionsVisualizer = require(script.Parent.ImpressionsVisualizer)

local ImpressionsTrackerWithoutNavigation = require(script.Parent.ImpressionsTrackerWithoutNavigation)

return function(tbl1)
    local routeName = useRouteName()
    local var2 = Cryo.Dictionary.join(tbl1, { routeName = routeName })
    return React.createElement(ImpressionsTrackerWithoutNavigation, var2)
end
