-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local React = require(ultimateList.Parent.React)

local function joinAndMapBindings<T>(func1: (...any) -> (...any), arg1: T, arg2: T, arg3: T)
    return React.joinBindings({ arg1, arg2, arg3 }):map(function(tbl1: {any})
        return func1(unpack(tbl1))
    end)
end

return joinAndMapBindings
