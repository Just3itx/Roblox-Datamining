-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:50:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Array = require(scriptParentParent.Array)
local Boolean = require(scriptParentParent.Boolean)
local Object = require(scriptParentParent.Object)
local String = require(scriptParentParent.String)
local Error = require(scriptParentParent.Error)
local instanceof = require(scriptParentParent.instanceof)
local inspect = require(scriptParentParent.util.inspect)
local _types = require(scriptParentParent.types)

local tbl1 = {
    stderr = {
        isTTY = false,
        columns = 0,
        hasColors = function(...): boolean
            return true
        end
    }
}

function ErrorCaptureStackTrace(...) end

local function removeColors<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local str1 = ""
local str2 = ""
local str3 = ""
local str4 = ""
local tbl2 = {
    deepStrictEqual = "Expected values to be strictly deep-equal:",
    strictEqual = "Expected values to be strictly equal:",
    strictEqualObject = "Expected \"actual\" to be reference-equal to \"expected\":",
    deepEqual = "Expected values to be loosely deep-equal:",
    notDeepStrictEqual = "Expected \"actual\" not to be strictly deep-equal to:",
    notStrictEqual = "Expected \"actual\" to be strictly unequal to:",
    notStrictEqualObject = "Expected \"actual\" not to be reference-equal to \"expected\":",
    notDeepEqual = "Expected \"actual\" not to be loosely deep-equal to:",
    notIdentical = "Values have same structure but are not reference-equal:",
    notDeepEqualUnequal = "Expected values not to be loosely deep-equal:"
}

local function copyError(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local result = {}

    for _, value in (Object.keys(tbl3)) do
        result[value] = tbl3[value]
    end
    result.message = tbl3.message
    return result
end

local function inspectValue(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    return inspect(arg1, {
        compact = false,
        customInspect = false,
        depth = 1000,
        maxArrayLength = math.huge,
        showHidden = false,
        showProxy = false,
        sorted = true,
        getters = true
    })
end

local function createErrDiff(arg1, arg2, arg3)
    local str5 = ""
    local str6 = ""
    local str7 = ""
    local bool1 = false
    local var1 = inspectValue(arg1)

    local var2 = String.split(var1, "\n")
    local var3 = String.split(inspectValue(arg2), "\n")

    local num1 = 0
    local str8 = ""

    if arg3 == "strictEqual" then
        if typeof(arg1) == "table" and arg1 ~= nil and typeof(arg2) == "table" and arg2 ~= nil then
            arg3 = "strictEqualObject"
        elseif typeof(arg1) == "function" then
            arg3 = if typeof(arg2) == "function" then "strictEqualObject" else arg3
        end
    end

    if #var2 == 1 and #var3 == 1 and var2[1] ~= var3[1] then
        local var4 = var2[1]
        local var5 = if Boolean.toJSBoolean(false) then var3[1] else var3[1]
        local num2 = string.len(var4) + string.len(var5)

        if num2 <= 12 then
            if (typeof(arg1) ~= "table" or arg1 == nil) and (typeof(arg2) ~= "table" or arg2 == nil) and (arg1 ~= 0 or arg2 ~= 0) then
                return ("%s\n\n"):format(tbl2[arg3]) .. ("%s !== %s\n"):format(var2[1], var3[1])
            end
        elseif arg3 ~= "strictEqualObject" and num2 < (if tbl1.stderr.isTTY then tbl1.stderr.columns else 80) then
            while string.sub(var4, num1 + 1, num1 + 1) == string.sub(var5, num1 + 1, num1 + 1) do
                num1 += 1
            end

            if num1 > 2 then
                str8 = ("\n  %s^"):format(string.rep(" ", num1))
                num1 = 0
            end
        end
    end

    local var4 = var2[#var2]
    local var5 = var3[#var3]
    local var6

    while true do
        if var4 ~= var5 then
            var6 = num1
            break
        end
        var6 = num1 + 1
        if num1 < 3 then
            str7 = ("\n  %s%s"):format(var4, str7)
        else
            str5 = var4
        end

        table.remove(var2)
        table.remove(var3)
        if #var2 == 0 or #var3 == 0 then
            break
        end

        var4 = var2[#var2]
        var5 = var3[#var3]
        num1 = var6
    end

    local num2 = math.max(#var2, #var3)

    if num2 == 0 then
        local var7 = String.split(var1, "\n")

        if #var7 > 50 then
            var7[47] = ("%s...%s"):format(str1, str4)
            while #var7 > 47 do
                table.remove(var7)
            end
        end

        return ("%s\n\n"):format("Values have same structure but are not reference-equal:") .. ("%s\n"):format(Array.join(var7, "\n"))
    end

    if var6 >= 5 then
        str7 = ("\n%s...%s%s"):format(str1, str4, str7)
        bool1 = true
    end

    if str5 ~= "" then
        str7 = ("\n  %s%s"):format(str5, str7)
        str5 = ""
    end

    local num3 = 0
    local num4 = 0
    local var7 = tbl2[arg3] .. ("\n%s+ actual%s %s- expected%s"):format(str2, str4, str3, str4)
    local str9 = (" %s...%s Lines skipped"):format(str1, str4)

    local str10 = ("%s+%s"):format(str2, str4)
    local num5 = #var3
    local var8

    if #var2 < num2 then
        str10 = ("%s-%s"):format(str3, str4)
        num5 = #var2
        var8 = var3
    else
        var8 = var2
    end

    for i = 1, num2 do
        if num5 < i then
            if num4 > 2 then
                if num4 > 3 then
                    if num4 > 4 then
                        if num4 == 5 then
                            str6 ..= ("\n  %s"):format(var8[i - 3])
                            num3 += 1
                        else
                            str6 ..= ("\n%s...%s"):format(str1, str4)
                            bool1 = true
                        end
                    end

                    str6 ..= ("\n  %s"):format(var8[i - 2])
                    num3 += 1
                end
                str6 ..= ("\n  %s"):format(var8[i - 1])
                num3 += 1
            end

            num4 = 0

            if var8 == var2 then
                str6 ..= ("\n%s %s"):format(str10, var8[i])
            else
                str5 ..= ("\n%s %s"):format(str10, var8[i])
            end
            num3 += 1
        else
            local var9 = var3[i]
            local var10 = var2[i]
            local bool2 = not (var10 == var9) and (not Boolean.toJSBoolean(String.endsWith(var10, ",")) or String.slice(var10, 0, -1) ~= var9)

            if bool2 and String.endsWith(var9, ",") and String.slice(var9, 0, -1) == var10 then
                var10 ..= ","
                bool2 = false
            end
            if bool2 then
                if num4 > 2 then
                    if num4 > 3 then
                        if num4 > 4 then
                            if num4 == 5 then
                                str6 ..= ("\n  %s"):format(var2[i - 3])
                                num3 += 1
                            else
                                str6 ..= ("\n%s...%s"):format(str1, str4)
                                bool1 = true
                            end
                        end

                        str6 ..= ("\n  %s"):format(var2[i - 2])
                        num3 += 1
                    end
                    str6 ..= ("\n  %s"):format(var2[i - 1])
                    num3 += 1
                end

                str6 ..= ("\n%s+%s %s"):format(str2, str4, var10)
                str5 ..= ("\n%s-%s %s"):format(str3, str4, var9)
                num3 += 2
                num4 = 0
            else
                str6 ..= str5
                str5 = ""
                num4 += 1

                if num4 <= 2 then
                    str6 ..= ("\n  %s"):format(var10)
                    num3 += 1
                end
            end
        end

        if num3 > 50 and i < num2 - 2 then
            return ("%s%s\n%s\n%s...%s%s\n"):format(var7, str9, str6, str1, str4, str5) .. ("%s...%s"):format(str1, str4)
        end
    end

    return ("%s%s\n%s%s%s%s"):format(var7, if bool1 then str9 else "", str6, str5, str7, str8)
end

local AssertionError = (setmetatable({}, { __index = Error }))

AssertionError.__index = AssertionError
function AssertionError.__tostring(arg1)
    return arg1:toString()
end

function AssertionError.new(tbl3)
    local message = tbl3.message
    local operator = tbl3.operator
    local stackStartFn = tbl3.stackStartFn
    local actual = tbl3.actual
    local expected = tbl3.expected
    local var2

    if message ~= nil then
        var2 = setmetatable(Error.new(tostring(message)), AssertionError)
    else
        if tbl1.stderr.isTTY then
            if tbl1.stderr:hasColors() then
                str1 = "\27[34m"
                str2 = "\27[32m"
                str4 = "\27[39m"
                str3 = "\27[31m"
            else
                str1 = ""
                str2 = ""
                str4 = ""
                str3 = ""
            end
        end

        if typeof(actual) == "table"
            and actual ~= nil
            and typeof(expected) == "table"
            and expected ~= nil
            and Array.indexOf(Object.keys(actual), "stack") ~= -1
            and instanceof(actual, Error)
            and Array.indexOf(Object.keys(expected), "stack") ~= -1
            and instanceof(expected, Error)
        then
            actual = copyError(actual)
            expected = copyError(expected)
        end

        if operator == "deepStrictEqual" or operator == "strictEqual" then
            var2 = setmetatable(Error.new(createErrDiff(actual, expected, operator)), AssertionError)
        elseif operator == "notDeepStrictEqual" or operator == "notStrictEqual" then
            local var3 = tbl2[operator]
            local var4 = String.split(inspectValue(actual), "\n")

            if operator == "notStrictEqual" then
                var3 = if typeof(actual) == "table" and actual ~= nil then "Expected \"actual\" not to be reference-equal to \"expected\":" elseif typeof(actual) == "function" then "Expected \"actual\" not to be reference-equal to \"expected\":" else var3
            end

            if #var4 > 50 then
                var4[47] = ("%s...%s"):format(str1, str4)
                while #var4 > 47 do
                    table.remove(var4)
                end
            end

            if #var4 == 1 then
                local new2 = Error.new
                local var5 = var4[1]
                var2 = setmetatable(new2(("%s%s%s"):format(var3, if string.len(var5) > 5 then "\n\n" else " ", var4[1])), AssertionError)
            else
                var2 = setmetatable(Error.new(("%s\n\n%s\n"):format(var3, Array.join(var4, "\n"))), AssertionError)
            end
        else
            local var3 = inspectValue(actual)
            local var4 = inspectValue(expected)

            local var5 = tbl2[tostring(operator)]
            if operator == "notDeepEqual" and var3 == var4 then
                local str5 = ("%s\n\n%s"):format(var5, var3)
                if string.len(str5) > 1024 then
                    str5 = ("%s..."):format(String.slice(str5, 0, 1021))
                end
                var2 = setmetatable(Error.new(str5), AssertionError)
            else
                if string.len(var3) > 512 then
                    var3 = ("%s..."):format(String.slice(var3, 0, 509))
                end
                if string.len(var4) > 512 then
                    var4 = ("%s..."):format(String.slice(var4, 0, 509))
                end
                if operator == "deepEqual" then
                    var3 = ("%s\n\n%s\n\nshould loosely deep-equal\n\n"):format(var5, var3)
                else
                    local var6 = tbl2[("%sUnequal"):format(tostring(operator))]
                    if Boolean.toJSBoolean(var6) then
                        var3 = ("%s\n\n%s\n\nshould not loosely deep-equal\n\n"):format(var6, var3)
                    else
                        var4 = (" %s %s"):format(tostring(operator), var4)
                    end
                end
                var2 = setmetatable(Error.new(("%s%s"):format(var3, var4)), AssertionError)
            end
        end
    end

    var2.generatedMessage = not Boolean.toJSBoolean(message)

    var2.name = "AssertionError [ERR_ASSERTION]"
    var2.code = "ERR_ASSERTION"

    var2.actual = actual
    var2.expected = expected
    var2.operator = operator

    ErrorCaptureStackTrace(var2, stackStartFn)

    var2.name = "AssertionError"
    return var2
end

function AssertionError:toString(): string
    return ("%s [%s]: %s"):format(self.name, self.code, self.message)
end

AssertionError.name = "AssertionError"

return { AssertionError = AssertionError }
