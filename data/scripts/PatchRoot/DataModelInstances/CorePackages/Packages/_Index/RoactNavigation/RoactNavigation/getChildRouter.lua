-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.utils.invariant)

return function(arg1, arg2)
    if arg1.childRouters and arg1.childRouters[arg2] then
        return arg1.childRouters[arg2]
    end

    invariant(
        type(arg1.getComponentForRouteName) == "function",
        "router.getComponentForRouteName must be a function if no child routers are specified"
    )
    local componentForRouteName = arg1.getComponentForRouteName(arg2)

    return if type(componentForRouteName) == "table" then componentForRouteName.router else nil
end
