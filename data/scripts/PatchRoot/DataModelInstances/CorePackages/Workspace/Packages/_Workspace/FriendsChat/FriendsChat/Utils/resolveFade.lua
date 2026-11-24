-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local _React = require(FriendsChatParent.React)

local function resolveFade(num1: number, arg1)
    if type(arg1) == "number" then
        return num1 + arg1 * (1 - num1)
    elseif arg1 ~= nil then
        return arg1:map(function(num2: number): number
            return num1 + num2 * (1 - num1)
        end)
    end
    return num1
end

return resolveFade
