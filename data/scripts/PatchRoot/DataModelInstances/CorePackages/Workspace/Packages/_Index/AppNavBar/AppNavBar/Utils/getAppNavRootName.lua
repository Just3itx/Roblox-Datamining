-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local _Navigation = require(scriptParentParentParent.Navigation)

local getPageNameFromRoute = require(scriptParent.getPageNameFromRoute)

return function(arg1)
    if not (arg1 and arg1.routes and arg1.routes[1]) then
        return nil
    end

    return getPageNameFromRoute(arg1.routes[1])
end
