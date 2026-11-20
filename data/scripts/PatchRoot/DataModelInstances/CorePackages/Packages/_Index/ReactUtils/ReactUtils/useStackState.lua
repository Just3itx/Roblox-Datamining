-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtils = script:FindFirstAncestor("ReactUtils")

local ReactUtilsParent = ReactUtils.Parent
local React = require(ReactUtilsParent.React)

local LUAU_ANALYZE_ERROR = require(ReactUtils.LUAU_ANALYZE_ERROR)

local function useStackState(tbl1)
    local var1 = React.useRef(tbl1 or {})
    assert(var1.current ~= nil, LUAU_ANALYZE_ERROR)

    local size, var3 = React.useState(#var1.current)

    return {
        push = React.useCallback(function(arg1)
            table.insert(var1.current, arg1)
            var3(#var1.current)
        end, {}),
        pop = React.useCallback(function()
            local var4 = table.remove(var1.current)
            var3(#var1.current)
            return var4
        end, {}),
        getTop = React.useCallback(function()
            return var1.current[#var1.current]
        end, {}),
        clear = React.useCallback(function()
            table.clear(var1.current)
            var3(0)
        end, {}),
        size = size
    }
end

return useStackState
