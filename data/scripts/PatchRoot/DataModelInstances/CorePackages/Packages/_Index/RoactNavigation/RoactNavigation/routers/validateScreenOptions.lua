-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.Parent.utils.invariant)

return function(arg1, arg2)
    invariant(
        type(arg1.title) ~= "function",
        "title cannot be defined as a function in navigation options for screen '%s'",
        arg2.routeName
    )
end
