-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Symbol = require(scriptParentParent.Symbols.Symbol)
local strict = require(scriptParentParent.strict)

local function createEnum(str1: string, tbl1)
    assert(typeof(str1) == "string", "Bad argument #1, expected string")
    assert(typeof(tbl1) == "table", "Bad argument #2, expected list of values")

    local tbl2 = {}

    for _, value in ipairs(tbl1) do
        assert(value ~= "isMember", "Shadowing 'isMember' function is not allowed")
        assert(typeof(value) == "string", "Only string names are supported for enum types")

        local var1 = Symbol.named(value)
        local str2 = ("%s.%s"):format(str1, value)
        getmetatable(var1).__tostring = function()
            return str2
        end

        tbl2[value] = var1
    end

    function tbl2.isMember(arg1)
        if typeof(arg1) ~= "userdata" then
            return false
        end

        for _, value in pairs(tbl2) do
            if arg1 == value then
                return true
            end
        end

        return false
    end

    local var1 = newproxy(true)
    getmetatable(var1).__index = tbl2

    return strict(tbl2, str1)
end

return createEnum
