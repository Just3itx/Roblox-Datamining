-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local findOr = require(script.Parent.findOr)
local slice = require(script.Parent.slice)

local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

local MAX_SAFE_INTEGER = require(scriptParentParent.Number).MAX_SAFE_INTEGER

local function split(str1: string, arg1, num1: number?)
    if arg1 == nil then
        return { str1 }
    end
    if num1 == 0 then
        return {}
    end
    if num1 == nil or num1 < 0 then
        num1 = MAX_SAFE_INTEGER
    end

    if typeof(arg1) == "string" then
        if arg1 == "" then
            local result = {}
            for value in str1:gmatch(".") do
                table.insert(result, value)
            end
            return result
        end

        arg1 = { arg1 }
    end

    local var1, var2 = utf8.len(str1)
    local str2 = tostring(var2)
    assert(var1 ~= nil, ("string `%s` has an invalid byte at position %s"):format(str1, str2))
    local num2 = 1
    local result = {}
    local var3 = nil

    repeat
        local var4 = findOr(str1, arg1, num2)
        if var4 ~= nil then
            table.insert(result, slice(str1, num2, var4.index))
            local var5 = utf8.len(var4.match)

            num2 = var4.index + var5
        else
            table.insert(result, slice(str1, num2, nil))
        end

        if var4 ~= nil then
            var3 = var4
        end
    until var4 == nil or var1 < num2 or num1 <= #result

    if var3 ~= nil then
        local var4, var5 = utf8.len(var3.match)

        local match = var3.match
        local str3 = tostring(var5)
        assert(var4 ~= nil, ("string `%s` has an invalid byte at position %s"):format(match, str3))

        if var3.index + var4 == var1 + 1 then
            table.insert(result, "")
        end
    end
    return result
end

return split
