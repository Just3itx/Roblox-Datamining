-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local getDeepValue = require(scriptParent.getDeepValue)
local EnumNetworkStatus = require(scriptParent.EnumNetworkStatus)

return function(arg1)
    local keyPath = arg1.keyPath

    return function(arg2, arg3)
        assert(typeof(arg2) == "table")
        assert(typeof(arg3) == "string")
        assert(#arg3 > 0)
        local deepValue = getDeepValue(arg2, keyPath)
        assert(deepValue, string.format("Reducer not found for keyPath: %s. Did you forget to call `installReducer`?", keyPath))

        return deepValue[arg3] or EnumNetworkStatus.NotStarted
    end
end
