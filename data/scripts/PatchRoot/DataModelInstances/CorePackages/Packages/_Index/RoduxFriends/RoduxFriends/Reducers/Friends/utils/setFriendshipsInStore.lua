-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local llama = require(RoduxFriendsParent.llama)
local addUser = require(script.Parent.addUser)
local removeUser = require(script.Parent.removeUser)

function difference(arg1, arg2)
    local tbl1 = ({})
    for _, value in pairs(arg1) do
        tbl1[value] = true
    end

    for _, value in pairs(arg2) do
        tbl1[value] = nil
    end

    local result = ({})
    local num1 = 0
    for _, value in pairs(arg1) do
        if tbl1[value] then
            num1 += 1
            result[num1] = value
        end
    end

    return result
end

return function(arg1, arg2)
    local str1 = tostring(arg2.namedIds.users)
    local var1 = arg1[str1] or {}

    local var2 = llama.List.map(llama.Dictionary.values(arg2.responseBody.data), function(arg3): string
        return tostring(arg3.id)
    end)

    local var3 = difference(var2, var1)
    local var4 = difference(var1, var2)

    for _, value in pairs(var3) do
        arg1 = llama.Dictionary.join(arg1, { [str1] = addUser(arg1[str1], value), [value] = addUser(arg1[value], str1) })
    end

    for _, value in pairs(var4) do
        arg1 = llama.Dictionary.join(arg1, { [str1] = removeUser(arg1[str1], value), [value] = removeUser(arg1[value], str1) })
    end

    for k, value in pairs(arg1) do
        if llama.isEmpty(value) then
            arg1[k] = nil
        end
    end

    return arg1
end
