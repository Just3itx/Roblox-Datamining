-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParentParent = script:FindFirstAncestor("Components").Parent.Parent
local React = require(ComponentsParentParent.React)

local function func1()
    warn("Wrap the component using HoverContext with a HoverContext.Provider element")
end

local context = React.createContext({ registerOnHoverCallback = func1, onHover = func1 })

function useHoverContext(arg1)
    local var1 = React.useContext(context)
    local var2, var3 = React.useState(false)

    React.useEffect(function()
        var1.registerOnHoverCallback(arg1, var3)
    end, {})

    return var2, (React.useCallback(function(bool1: boolean)
        var1.onHover(arg1, bool1)
    end, { arg1 }))
end

function Provider(tbl1)
    local var1 = React.useRef({})
    local onHover = React.useCallback(function(arg1, arg2)
        if not var1.current[arg1] then
            return
        end
        for _, value in var1.current[arg1] do
            value(arg2)
        end
    end, {})

    local registerOnHoverCallback = React.useCallback(function(arg1, arg2)
        local var3 = var1.current[arg1]
        if var3 then
            table.insert(var3, arg2)
            return
        end
        var1.current[arg1] = { arg2 }
    end, {})

    return React.createElement(
        context.Provider,
        {
            value = { onHover = onHover, registerOnHoverCallback = registerOnHoverCallback }
        },
        tbl1.children
    )
end

return {
    useHoverContext = useHoverContext,
    Provider = Provider
}
