-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.Parent.utils.invariant)
local isValidScreenComponent = require(script.Parent.Parent.utils.isValidScreenComponent)

return function(arg1)
    invariant(type(arg1) == "table", "routeConfigs must be an array table")

    for value, value2 in arg1 do
        invariant(
            type(value) == "number",
            ("routeConfigs must be an array table (found non-number key %q of type %q)"):format(value, type(value))
        )
        local var1, var2 = next(value2)
        invariant(
            next(value2, var1) == nil,
            ("only one route must be defined in each entry (found multiple at index %d)"):format(value)
        )
        local bool1 = type(var2) == "table"
        local var3 = not bool1 and {} or var2
        if bool1 then
            var2 = var2.screen or var2
        end

        local var4 = invariant
        local var5 = isValidScreenComponent(var2)

        if not var5 then
            if type(var3.getScreen) == "function" then
                var5 = isValidScreenComponent(var3.getScreen())
            else
                var5 = false
            end
        end

        var4(
            var5,
            "The component for route '%s' must be a Roact Function/Stateful component or table with 'getScreen'.getScreen function must return Roact Function/Stateful component.",
            var1
        )

        invariant(
            var3.screen == nil or var3.getScreen == nil,
            "Route '%s' should provide 'screen' or 'getScreen', but not both.",
            var1
        )
    end

    invariant(#arg1 > 0, "Please specify at least one route when configuring a navigator.")

    return arg1
end
