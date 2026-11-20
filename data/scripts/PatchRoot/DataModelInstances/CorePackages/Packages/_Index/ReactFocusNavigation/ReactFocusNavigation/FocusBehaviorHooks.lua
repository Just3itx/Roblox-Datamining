-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _FocusNavigation = require(scriptParentParent.FocusNavigation)
local FocusBehaviors = require(scriptParentParent.FocusBehaviors)
local React = require(scriptParentParent.React)

local default = FocusBehaviors.default
local mostRecent = FocusBehaviors.mostRecent
local mostRecentOrDefault = FocusBehaviors.mostRecentOrDefault

local useContainerFocusBehavior = require(script.Parent.useContainerFocusBehavior)

return {
    useDefaultFocusBehavior = function(arg1)
        local var1, var2 = React.useState(nil)

        local var3 = React.useMemo(function()
            return default(var1)
        end, { var1 })

        return var2, (useContainerFocusBehavior(var3, arg1))
    end,
    useMostRecentFocusBehavior = function(arg1)
        local var1 = React.useMemo(mostRecent, {})

        return useContainerFocusBehavior(var1, arg1)
    end,
    useMostRecentOrDefaultFocusBehavior = function(arg1)
        local var1, var2 = React.useState(nil)

        local var3 = React.useMemo(function()
            return mostRecentOrDefault(var1)
        end, { var1 })

        return var2, (useContainerFocusBehavior(var3, arg1))
    end
}
