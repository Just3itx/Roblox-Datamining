-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array
local RegExp = require(scriptParentParentParent.RegExp)

local function TypeError<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local module = {}

local escapeString = nil
local flags = nil

local function lexer(str1: string)
    local tbl1 = {}
    local num1 = 1

    local function preIncrement_i<T>(arg1: T): T -- Luacid: unused: defined but never referenced
        num1 += 1
        return arg1
    end

    local function getChar(arg1): string -- Luacid: Inlined by compiler; 14 call sites recovered
        return string.sub(str1, arg1, arg1)
    end

    local num2 = string.len(str1)

    while true do
        while true do
            if not (num1 <= num2) then
                table.insert(tbl1, { type = "END", index = num1, value = "" })

                return tbl1
            end

            local str2 = string.sub(str1, num1, num1)

            if str2 == "*" or str2 == "+" or str2 == "?" then
                break
            end

            if str2 == "\\" then
                local tbl2 = { type = "ESCAPED_CHAR", index = 0, value = 0 }

                local index = num1
                num1 += 1

                tbl2.index = index
                local num4 = num1
                num1 += 1

                tbl2.value = getChar(num4)
                table.insert(tbl1, tbl2)
            elseif str2 == "{" then
                local tbl2 = { type = "OPEN", index = num1, value = 0 }
                local num3 = num1
                num1 += 1

                tbl2.value = getChar(num3)
                table.insert(tbl1, tbl2)
            elseif str2 == "}" then
                local tbl2 = { type = "CLOSE", index = num1, value = 0 }
                local num3 = num1
                num1 += 1

                tbl2.value = getChar(num3)
                table.insert(tbl1, tbl2)
            elseif str2 == ":" then
                local str3 = ""
                local num3 = num1 + 1

                local function preIncrement_j<T>(arg1: T): T -- Luacid: unused: defined but never referenced
                    num3 += 1
                    return arg1
                end

                while num3 <= num2 do
                    local var1 = string.byte(str1, num3)

                    if not (var1 >= 48 and var1 <= 57) and not (var1 >= 65 and var1 <= 90) and not (var1 >= 97 and var1 <= 122) and var1 ~= 95 then
                        break
                    end

                    local num4 = num3
                    num3 += 1
                    str3 ..= getChar(num4)
                end

                if str3 == "" then
                    error((("Missing parameter name at %d"):format(num1)))
                end

                table.insert(tbl1, { type = "NAME", index = num1, value = str3 })

                num1 = num3
            elseif str2 == "(" then
                local num3 = 1
                local str3 = ""
                local num4 = num1 + 1

                if getChar(num4) == "?" then
                    error((("Pattern cannot start with \"?\" at %d"):format(num4)))
                end

                local function preIncrement_j<T>(arg1: T): T -- Luacid: unused: defined but never referenced
                    num4 += 1
                    return arg1
                end

                while num4 <= num2 do
                    if getChar(num4) == "\\" then
                        local num5 = num4
                        num4 += 1
                        local char = getChar(num5)

                        local num6 = num4
                        num4 += 1
                        str3 ..= char .. getChar(num6)
                    end

                    if getChar(num4) == ")" then
                        num3 -= 1
                        if num3 == 0 then
                            num4 += 1
                            break
                        end
                    elseif getChar(num4) == "(" then
                        num3 += 1

                        if getChar(num4 + 1) ~= "?" then
                            error((("Capturing groups are not allowed at %d"):format(num4)))
                        end
                    end

                    local num5 = num4
                    num4 += 1
                    str3 ..= getChar(num5)
                end

                if num3 ~= 0 then
                    error((("Unbalanced pattern at %d"):format(num1)))
                end
                if str3 == "" then
                    error((("Missing pattern at %d"):format(num1)))
                end

                table.insert(tbl1, { type = "PATTERN", index = num1, value = str3 })

                num1 = num4
            else
                local tbl2 = { type = "CHAR", index = num1, value = 0 }
                local num3 = num1
                num1 += 1

                tbl2.value = getChar(num3)
                table.insert(tbl1, tbl2)
            end
        end

        local tbl2 = { type = "MODIFIER", index = num1, value = 0 }
        local num3 = num1
        num1 += 1

        tbl2.value = getChar(num3)
        table.insert(tbl1, tbl2)
    end
end

function module.parse(str1: string, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = lexer(str1)

    local var2 = if tbl2.prefixes == nil or tbl2.prefixes == "" then "./" else tbl2.prefixes

    local str2 = string.format("[^%s]+?", escapeString(tbl2.delimiter or "/#?"))
    local result = {}
    local num1 = 0
    local num2 = 1

    local function preIncrement_i<T>(arg1: T): T -- Luacid: unused: defined but never referenced
        num2 += 1
        return arg1
    end

    local function preIncrement_key(num3: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
        num1 += 1
        return num3
    end

    local function tryConsume(type: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        if not (num2 <= #var1) or var1[num2].type ~= type then
            return nil
        end

        local var3 = var1
        local num3 = num2
        num2 += 1
        return var3[num3].value
    end

    local function mustConsume(type: string)
        local var3 = tryConsume(type)

        if var3 ~= nil then
            return var3
        end
        local var4 = var1[num2]
        if var4 == nil then
            error((("Expected token %s, got nil"):format(type)))
        end
        local type2 = var4.type
        local index = var4.index
        error((("Unexpected %s at %d, expected %s"):format(type2, index, type)))
    end

    local function consumeText()
        local str3 = ""
        local var3 = tryConsume("CHAR") or tryConsume("ESCAPED_CHAR")

        while var3 and var3 ~= "" do
            str3 ..= var3
            var3 = tryConsume("CHAR")

            if var3 then
                continue
            end

            if num2 <= #var1 and var1[num2].type == "ESCAPED_CHAR" then
                local var4 = var1
                local num3 = num2
                num2 += 1
                var3 = var4[num3].value
            else
                var3 = nil
            end
        end
        return str3
    end

    local str3 = ""

    while #var1 >= num2 do
        local num3 = #var1
        local value

        if num2 <= num3 and var1[num2].type == "CHAR" then
            local num4 = num2
            num2 += 1
            value = var1[num4].value
        else
            value = nil
        end

        local num4 = #var1
        local value2

        if num2 <= num4 and var1[num2].type == "NAME" then
            local num5 = num2
            num2 += 1
            value2 = var1[num5].value
        else
            value2 = nil
        end

        local num5 = #var1
        local value3

        if num2 <= num5 and var1[num2].type == "PATTERN" then
            local num6 = num2
            num2 += 1
            value3 = var1[num6].value
        else
            value3 = nil
        end

        if value2 and value2 ~= "" or value3 and value3 ~= "" then
            local var3 = value or ""

            if string.find(var2, var3) == nil then
                str3 ..= var3
                var3 = ""
            end

            if str3 ~= nil and str3 ~= "" then
                table.insert(result, str3)
                str3 = ""
            end

            if value2 == nil or value2 == "" then
                value2 = preIncrement_key(num1)
            end

            if value3 == nil or value3 == "" then
                value3 = str2
            end

            local tbl3 = {
                name = value2,
                prefix = var3,
                suffix = "",
                pattern = value3,
                modifier = 0
            }
            local num6 = #var1
            local value4

            if num2 <= num6 and var1[num2].type == "MODIFIER" then
                local num7 = num2
                num2 += 1
                value4 = var1[num7].value
            else
                value4 = nil
            end

            tbl3.modifier = value4 or ""
            table.insert(result, tbl3)
        else
            if not value then
                local num6 = #var1

                if num2 <= num6 and var1[num2].type == "ESCAPED_CHAR" then
                    local num7 = num2
                    num2 += 1
                    value = var1[num7].value
                else
                    value = nil
                end
            end

            if value and value ~= "" then
                str3 ..= value
            else
                if str3 and str3 ~= "" then
                    table.insert(result, str3)
                    str3 = ""
                end

                local num6 = #var1
                local value4

                if num2 <= num6 and var1[num2].type == "OPEN" then
                    local num7 = num2
                    num2 += 1
                    value4 = var1[num7].value
                else
                    value4 = nil
                end

                if value4 and value4 ~= "" then
                    local prefix = consumeText()
                    local num7 = #var1
                    local value5

                    if num2 <= num7 and var1[num2].type == "NAME" then
                        local num8 = num2
                        num2 += 1
                        value5 = var1[num8].value
                    else
                        value5 = nil
                    end

                    local var4 = value5 or ""
                    local num8 = #var1
                    local value6

                    if num2 <= num8 and var1[num2].type == "PATTERN" then
                        local num9 = num2
                        num2 += 1
                        value6 = var1[num9].value
                    else
                        value6 = nil
                    end

                    local var5 = value6 or ""

                    local suffix = consumeText()

                    mustConsume("CLOSE")

                    if var4 == "" and var5 ~= "" then
                        var4 = preIncrement_key(num1)
                    end

                    if var4 ~= "" and var4 ~= 0 and (var5 == nil or var5 == "") then
                        var5 = str2
                    end

                    local tbl3 = {
                        name = var4,
                        pattern = var5,
                        prefix = prefix,
                        suffix = suffix,
                        modifier = 0
                    }
                    local num9 = #var1
                    local value7

                    if num2 <= num9 and var1[num2].type == "MODIFIER" then
                        local num10 = num2
                        num2 += 1
                        value7 = var1[num10].value
                    else
                        value7 = nil
                    end

                    tbl3.modifier = value7 or ""
                    table.insert(result, tbl3)
                else
                    mustConsume("END")
                end
            end
        end
    end

    return result
end

function module.compile(str1: string, arg1)
    return module.tokensToFunction(module.parse(str1, arg1), arg1)
end

function module.tokensToFunction(tbl1, tbl2)
    tbl2 = tbl2 == nil and {} or tbl2

    local var1 = flags(tbl2)
    local var2 = tbl2.encode or function(str1: string): string
        return str1
    end
    local validate = tbl2.validate
    if validate == nil then
        validate = true
    end

    local var3 = Array.map(tbl1, function(arg1)
        if type(arg1) == "table" then
            return RegExp(("^(?:%s)$"):format(arg1.pattern), var1)
        end
        return nil
    end)

    return function(tbl3): string
        local str1 = ""

        for value, value2 in tbl1 do
            if type(value2) == "string" then
                str1 ..= value2
            else
                local var4 = if tbl3 then tbl3[tostring(value2.name)] else nil
                local bool1 = value2.modifier == "?" or value2.modifier == "*"
                local bool2 = value2.modifier == "*" or value2.modifier == "+"

                if Array.isArray(var4) then
                    if not bool2 then
                        error((("Expected \"%s\" to not repeat, but got an array"):format(value2.name)))
                    end

                    if #var4 == 0 then
                        if bool1 then
                            continue
                        end

                        error((("Expected \"%s\" to not be empty"):format(value2.name)))
                    end

                    for _, value3 in var4 do
                        local var5 = var2(value3, value2)

                        if validate and not var3[value]:test(var5) then
                            error((("Expected all \"%s\" to match \"%s\", but got \"%s\""):format(value2.name, value2.pattern, var5)))
                        end

                        str1 ..= value2.prefix .. var5 .. value2.suffix
                    end
                else
                    local str2 = type(var4)
                    if str2 == "string" or str2 == "number" then
                        local var5 = var2(tostring(var4), value2)

                        if validate and not var3[value]:test(var5) then
                            error((("Expected \"%s\" to match \"%s\", but got \"%s\""):format(value2.name, value2.pattern, var5)))
                        end

                        str1 ..= value2.prefix .. var5 .. value2.suffix
                    else
                        if bool1 then
                            continue
                        end

                        local error = error
                        local name = value2.name
                        error((("Expected \"%s\" to be %s"):format(tostring(name), if bool2 then "an array" else "a string")))
                    end
                end
            end
        end

        return str1
    end
end

function module.match(arg1, arg2)
    local tbl1 = {}
    local var1 = module.pathToRegexp(arg1, tbl1, arg2)
    return module.regexpToFunction(var1, tbl1, arg2)
end

function module.regexpToFunction(arg1, tbl1, tbl2): (string) -> (boolean | {index: any, params: {[any]: any}, path: any})
    local var1 = (tbl2 == nil and {} or tbl2).decode or function(str1: string): string
        return str1
    end

    return function(str1: string)
        local var2 = arg1:exec(str1)
        if not var2 then
            return false
        end

        local path = var2[1]
        local index = var2.index or 0
        local params = {}

        for i = 2, var2.n do
            if var2[i] == nil then
                continue
            end

            local var4 = tbl1[i - 1]
            if var4.modifier == "*" or var4.modifier == "+" then
                params[var4.name] = Array.map(string.split(var2[i], var4.prefix .. var4.suffix), function(arg2)
                    return var1(arg2, var4)
                end)
            else
                params[var4.name] = var1(var2[i], var4)
            end
        end

        return { path = path, index = index, params = params }
    end
end

escapeString = function(str1: string)
    return string.gsub(str1, "[%.%+%*%?=%^!:${}%(%)%[%]|/\\]", function(arg1)
        return "\\" .. arg1
    end)
end

flags = function(tbl1): string
    return if tbl1 and tbl1.sensitive then "" else "i"
end

local function arrayToRegexp(tbl1, tbl2, arg1)
    local var1 = Array.map(tbl1, function(arg2)
        return module.pathToRegexp(arg2, tbl2, arg1).source
    end)

    return RegExp(("(?:%s)"):format(table.concat(var1, "|")), flags(arg1))
end

local function stringToRegexp(arg1, tbl1, arg2)
    return module.tokensToRegexp(module.parse(arg1, arg2), tbl1, arg2)
end

function module.tokensToRegexp(tbl1, tbl2, tbl3)
    local var1 = tbl3 == nil and {} or tbl3

    local strict = var1.strict
    if strict == nil then
        strict = false
    end

    local start = var1.start
    if start == nil then
        start = true
    end

    local _end = var1.end_
    if _end == nil then
        _end = true
    end

    local var2 = var1.encode or function(str1: string): string
        return str1
    end

    local str1 = if var1.endsWith then ("[%s]|$"):format(escapeString(var1.endsWith or "")) else "$"
    local str2 = ("[%s]"):format(escapeString(var1.delimiter or "/#?"))
    local str3 = if start then "^" else ""

    for _, value in tbl1 do
        if type(value) == "string" then
            str3 ..= escapeString(var2(value))
        else
            local var3 = escapeString(var2(value.prefix))
            local var4 = escapeString(var2(value.suffix))

            if value.pattern and value.pattern ~= "" then
                if tbl2 then
                    table.insert(tbl2, value)
                end

                if var3 and var3 ~= "" or var4 and var4 ~= "" then
                    if value.modifier == "+" or value.modifier == "*" then
                        local str4 = if value.modifier == "*" then "?" else ""
                        str3 ..= ("(?:%s((?:%s)(?:%s%s(?:%s))*)%s)%s"):format(var3, value.pattern, var4, var3, value.pattern, var4, str4)
                    else
                        str3 ..= ("(?:%s(%s)%s)%s"):format(var3, value.pattern, var4, value.modifier)
                    end
                else
                    str3 ..= ("(%s)%s"):format(value.pattern, value.modifier)
                end
            else
                str3 ..= ("(?:%s%s)%s"):format(var3, var4, value.modifier)
            end
        end
    end

    if _end then
        if not strict then
            str3 ..= ("%s?"):format(str2)
        end

        if var1.endsWith and var1.endsWith ~= "" then
            str3 ..= ("(?=%s)"):format(str1)
        else
            str3 ..= "$"
        end
    else
        local var3 = tbl1[#tbl1]
        local bool1 = if type(var3) == "string" then string.find(str2, var3:sub(-1)) ~= nil else var3 == nil

        if not strict then
            str3 ..= string.format("(?:%s(?=%s))?", str2, str1)
        end
        if not bool1 then
            str3 ..= string.format("(?=%s|%s)", str2, str1)
        end
    end

    return RegExp(str3, flags(var1))
end

function module.pathToRegexp(arg1, tbl1, arg2)
    if Array.isArray(arg1) then
        return arrayToRegexp(arg1, tbl1, arg2)
    end
    return stringToRegexp(arg1, tbl1, arg2)
end

return module
