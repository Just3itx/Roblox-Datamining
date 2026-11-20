-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local invariant = require(scriptParentParent.utils.invariant)
local isValidScreenComponent = require(scriptParentParent.utils.isValidScreenComponent)

local function getScreenComponent(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        if type(arg1) == "table" and arg1.screen then
            return arg1.screen
        end

        return arg1
    end

    return nil
end

return function<T>(arg1: T): T
    invariant(next(arg1) ~= nil, "Please specify at least one route when configuring a navigator.")

    for value, value2 in arg1 do
        local screenComponent = getScreenComponent(value2)
        local bool1 = type(value2) == "table"
        local var1 = invariant
        local bool2 = isValidScreenComponent(screenComponent)

        if not bool2 then
            if bool1 then
                bool2 = type(value2.getScreen) == "function"
            else
                bool2 = bool1
            end
        end

        var1(
            bool2,
            "The component for route '%s' must be a Roact component or table with 'getScreen'. For example:\n\nlocal MyScreen = require(script.Parent.MyScreen)\n...\n%s = MyScreen,\n}\n\nYou can also use a navigator:\n\nlocal MyNavigator = require(script.Parent.MyNavigator)\n...\n%s = MyNavigator,\n}",
            value,
            value,
            value
        )

        if bool1 then
            invariant(
                value2.screen == nil or value2.getScreen == nil,
                "Route '%s' should declare a screen or a getScreen, not both.",
                value
            )
        end
    end

    return arg1
end
