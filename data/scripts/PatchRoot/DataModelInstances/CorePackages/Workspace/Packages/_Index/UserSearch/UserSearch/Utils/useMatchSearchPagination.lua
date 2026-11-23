-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local React = require(UserSearchParent.React)
local Dash = require(UserSearchParent.Dash)

local function func1(tbl1, num1: number)
    local num2 = num1 + 1
    return Dash.slice(tbl1, num2)
end

return function(tbl1)
    local var1 = tbl1.users or {}
    local var2, var3 = React.useState(0)
    local var4, var5 = React.useState(var1)

    React.useEffect(function()
        var5(func1(var1, var2))
        var3(#var1)
    end, { #var1 })

    return var4
end
