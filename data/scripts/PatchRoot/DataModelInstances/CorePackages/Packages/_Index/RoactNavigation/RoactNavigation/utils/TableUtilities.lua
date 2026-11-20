-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local tbl1 = {}

local function makeKeyString(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    if type(arg1) == "string" then
        return string.format("%s", arg1)
    end
    return string.format("[%s]", tostring(arg1))
end

local function makeValueString(arg1): string
    local str1 = type(arg1)
    if str1 == "string" then
        return string.format("%q", arg1)
    elseif str1 == "function" or str1 == "table" then
        return string.format("<%s>", tostring(arg1))
    end
    return string.format("%s", tostring(arg1))
end

local function printKeypair(arg1, arg2, str1: string, str2: string)
    local keyString = makeKeyString(arg1)
    local valueString = makeValueString(arg2)

    local str3 = if str2 then string.format(" -- %s", str2) else ""
    print(string.format("%s%s = %s,%s", str1, keyString, valueString, str3))
end

function module.ShallowEqual(arg1, arg2, arg3)
    if not (arg1 and arg2) then
        return false
    end

    if arg1 == arg2 then
        return true
    end

    arg3 = arg3 or tbl1

    for value, value2 in arg1 do
        if arg2[value] ~= value2 and not arg3[value] then
            return false
        end
    end
    for value, value2 in arg2 do
        if arg1[value] ~= value2 and not arg3[value] then
            return false
        end
    end

    return true
end

local function formatDeepEqualMessage(arg1, arg2)
    if arg2 ~= 0 then
        return arg1
    end

    return arg1:gsub("{1}", "first"):gsub("{2}", "second")
end

function module.DeepEqual(arg1, arg2, arg3)
    arg3 = arg3 or 0
    if arg1 == arg2 then
        return true
    end

    if typeof(arg1) ~= typeof(arg2) then
        local str1 = ("{1} is of type %s, but {2} is of type %s"):format(typeof(arg1), typeof(arg2))

        return false, formatDeepEqualMessage(str1, arg3)
    end

    if typeof(arg1) ~= "table" then
        return false, formatDeepEqualMessage("{1} ~= {2}", arg3)
    end

    local tbl2 = ({})

    for value, value2 in arg1 do
        tbl2[value] = true

        local var1, var2 = module.DeepEqual(value2, arg2[value], arg3 + 1)
        if not var1 then
            local var3 = var2:gsub("{1}", ("{1}[%s]"):format(tostring(value))):gsub("{2}", ("{2}[%s]"):format(tostring(value)))

            return false, formatDeepEqualMessage(var3, arg3)
        end
    end

    for value, value2 in arg2 do
        if tbl2[value] then
            continue
        end

        local var1, var2 = module.DeepEqual(arg1[value], value2, arg3 + 1)

        if not var1 then
            local var3 = var2:gsub("{1}", ("{1}[%s]"):format(tostring(value))):gsub("{2}", ("{2}[%s]"):format(tostring(value)))

            return false, formatDeepEqualMessage(var3, arg3)
        end
    end

    return true
end

function module.EqualKey(arg1, arg2, arg3): boolean
    return not not (arg1 and arg2 and arg3 and arg3 ~= "" and arg1[arg3] and arg2[arg3] and arg1[arg3] == arg2[arg3])
end

function module.TableDifference(arg1, arg2)
    local result = ({})

    for value, value2 in arg1 do
        if arg2[value] ~= arg1[value] then
            result[value] = value2
        end
    end

    return result
end

local function membershipTable(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}
    for i = 1, #arg1 do
        result[arg1[i]] = true
    end
    return result
end

local function listOfKeys(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    for value, _ in arg1 do
        table.insert(result, value)
    end
    return result
end

function module.ListDifference(arg1, arg2)
    return listOfKeys((module.TableDifference(membershipTable(arg1), (membershipTable(arg2)))))
end

function module.CheckListConsistency(arg1)
    local bool1 = false
    local bool2 = false
    local bool3 = true

    local num1 = 1
    for value, _ in arg1 do
        if type(value) == "string" then
            bool2 = true
        else
            if type(value) ~= "number" then
                return false
            end

            if num1 ~= value then
                bool3 = false
            end

            bool1 = true
        end

        if bool2 and bool1 then
            return false
        end

        num1 += 1
    end

    return not bool1 or bool3
end

function module.RecursiveToString(arg1, arg2)
    arg2 = arg2 or ""

    if type(arg1) ~= "table" then
        return tostring(arg1)
    end

    local str1 = ""
    if not module.CheckListConsistency(arg1) then
        str1 ..= "-- WARNING: this table fails the list consistency test\n"
    end
    local str2 = str1 .. "{\n"
    for value, value2 in arg1 do
        if type(value) == "string" then
            str2 ..= "  " .. arg2 .. tostring(value) .. " = " .. module.RecursiveToString(value2, "  " .. arg2) .. ";\n"
        end
        if type(value) == "number" then
            str2 ..= "  " .. arg2 .. module.RecursiveToString(value2, "  " .. arg2) .. ",\n"
        end
    end
    return str2 .. arg2 .. "}"
end

function module.Print(arg1, arg2)
    local var1 = arg2 or "  "

    if type(arg1) ~= "table" then
        error("TableUtilities.Print must be passed a table", 2)
    end

    local tbl2 = ({})

    local function recurse(arg3, arg4, arg5)
        tbl2[arg3] = true

        local str1 = string.rep(var1, arg5)
        local str2 = string.rep(var1, arg5 + 1)

        if arg4 then
            local print = print
            local format = string.format
            local keyString = makeKeyString(arg4)
            print(format("%s%s = %s {", str1, keyString, makeValueString(arg3)))
        else
            print(string.format("%s%s {", str1, makeValueString(arg3)))
        end

        for value, value2 in arg3 do
            if type(value2) ~= "table" then
                local keyString = makeKeyString(value)
                local valueString = makeValueString(value2)

                print(string.format("%s%s = %s,%s", str2, keyString, valueString, ""))
            elseif tbl2[value2] then
                printKeypair(value, value2, str2, "Possible cycle")
            else
                recurse(value2, value, arg5 + 1)
            end
        end

        print(string.format("%s}%s", str1, if arg5 > 0 then "," else ""))
    end

    recurse(arg1, nil, 0)
end

function module.FieldCount(arg1): number
    local num1 = 0
    for _ in arg1 do
        num1 += 1
    end
    return num1
end

return module
