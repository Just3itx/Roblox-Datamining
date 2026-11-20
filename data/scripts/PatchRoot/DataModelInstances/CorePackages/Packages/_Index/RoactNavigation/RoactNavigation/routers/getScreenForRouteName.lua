-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local invariant = require(scriptParentParent.utils.invariant)
local isValidScreenComponent = require(scriptParentParent.utils.isValidScreenComponent)

return function(arg1, arg2)
    local var1 = arg1[arg2]

    if var1 == nil then
        local var2 = Array.map(Object.keys(arg1), function(arg3): string
            return ("'%s'"):format(arg3)
        end)

        local str1 = ("There is no route defined for key %s.\nMust be one of: %s"):format(arg2, table.concat(var2, ","))

        error(str1, 2)
    end

    if type(var1) == "table" then
        if var1.screen ~= nil then
            invariant(isValidScreenComponent(var1.screen), "screen for key '%s' must be a valid Roact component.", arg2)

            return var1.screen
        end

        if type(var1.getScreen) == "function" then
            local screen = var1.getScreen()
            invariant(
                isValidScreenComponent(screen),
                "The getScreen defined for route '%s' didn't return a valid screen or navigator.\n\nPlease pass it like this:\n%s = {\n    getScreen: function() return MyScreen end\n}",
                arg2,
                arg2
            )

            return screen
        end
    end

    invariant(
        isValidScreenComponent(var1),
        "Value for key '%s' must be a route config table or a valid Roact component.",
        arg2
    )

    return var1
end
