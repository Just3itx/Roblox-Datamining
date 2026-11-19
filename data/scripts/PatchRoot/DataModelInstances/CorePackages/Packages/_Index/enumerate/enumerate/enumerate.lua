-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function strict(tbl1, str1: string?)
    local str2 = str1 or tostring(tbl1)

    return (setmetatable(tbl1, {
        __index = function(_, arg1)
            local str3 = ("%q (%s) is not a valid member of %s"):format(tostring(arg1), typeof(arg1), str2)

            error(str3, 2)
        end,
        __newindex = function(_, arg1, _)
            local str3 = ("%q (%s) is not a valid member of %s"):format(tostring(arg1), typeof(arg1), str2)

            error(str3, 2)
        end
    }))
end

local function addEnumValue(tbl1, tbl2, str1: string, arg1, rawValue)
    local bool1 = typeof(arg1) == "string"
    assert(bool1, "Only string names are supported for enums!")
    if bool1 then
        assert(arg1 ~= "fromRawValue", "fromRawValue is reserved")
        assert(arg1 ~= "isEnumValue", "isEnumValue is reserved")
        assert(arg1 ~= "allValues", "allValues is reserved")
    end
    assert(tbl1[arg1] == nil, "Enum value names can only be used once!")
    assert(tbl2[arg1] == nil, "Enum values can only be used once!")

    local var1 = newproxy(true)
    local var2 = getmetatable(var1)

    function var2.__tostring(): string
        return ("%s.%s"):format(str1, arg1)
    end

    var2.__index = strict({
        rawValue = function()
            return rawValue
        end
    })

    tbl1[arg1] = var1
    tbl2[rawValue] = var1
end

local function enumerate(str1: string, tbl1)
    assert(typeof(str1) == "string", "Bad argument #1 - enums must be created using a string name!")
    assert(typeof(tbl1) == "table", "Bad argument #2 - enums must be created using a table!")

    local tbl2 = {}
    local tbl3 = {}

    if tbl1[1] ~= nil then
        for _, value in ipairs(tbl1) do
            addEnumValue(tbl2, tbl3, str1, value, value)
        end
    else
        for k, value in pairs(tbl1) do
            addEnumValue(tbl2, tbl3, str1, k, value)
        end
    end

    function tbl2.fromRawValue(arg1)
        return tbl3[arg1]
    end

    function tbl2.isEnumValue(arg1)
        if typeof(arg1) ~= "userdata" then
            return false
        end

        for _, value in pairs(tbl2) do
            if value == arg1 then
                return true
            end
        end

        return false
    end

    function tbl2.allValues()
        local result = {}

        for _, value in pairs(tbl3) do
            table.insert(result, value)
        end

        return result
    end

    local var1 = newproxy(true)
    local var2 = getmetatable(var1)
    var2.__index = strict(tbl2, str1)
    function var2.__tostring()
        return str1
    end

    return var1
end

return enumerate
