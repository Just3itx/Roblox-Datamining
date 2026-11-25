-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

return function(arg1, arg2)
    local state = arg1.state
    local router = arg1.router
    local getChildNavigation = arg1.getChildNavigation

    local routes = state.routes
    local screenOptions = nil

    while routes do
        local childNavigation = getChildNavigation(routes[state.index].key)
        screenOptions = router.getScreenOptions(childNavigation, arg2)

        if not childNavigation then
            break
        end

        getChildNavigation = childNavigation.getChildNavigation
        state = childNavigation.state
        routes = state.routes
        router = childNavigation.router
    end

    return screenOptions
end
