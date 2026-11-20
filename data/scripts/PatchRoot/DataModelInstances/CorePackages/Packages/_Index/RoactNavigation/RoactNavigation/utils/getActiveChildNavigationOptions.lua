-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local state = arg1.state
    local router = arg1.router
    local childNavigation = arg1.getChildNavigation(state.routes[state.index].key)

    return router.getScreenOptions(childNavigation, arg2)
end
