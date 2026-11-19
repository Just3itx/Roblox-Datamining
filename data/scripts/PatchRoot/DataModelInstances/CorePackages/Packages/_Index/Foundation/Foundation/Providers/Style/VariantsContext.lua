-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

function getOrSet(current, arg1, func1: (...any) -> (...any), ...)
    local var1 = current[arg1]
    if not var1 then
        var1 = func1(...)
        current[arg1] = var1
    end
    return var1
end

function useVariantsState()
    local var1 = React.useRef({})
    local var2 = React.useRef(nil)
    return React.useCallback(function(str1: string, func1: (...any) -> (...any), current)
        if var2.current ~= current then
            table.clear(var1.current)
            var2.current = current
        end
        return getOrSet(var1.current, str1, func1, current)
    end, {})
end

local context = React.createContext(nil)

function useVariants(str1: string, func1: (...any) -> (...any), arg1)
    local var1 = React.useContext(context)
    if var1 == nil then
        error("VariantsContext hasn't been instantiated")
    end
    return var1(str1, func1, arg1)
end

return {
    useVariants = useVariants,
    useVariantsState = useVariantsState,
    Provider = context.Provider
}
