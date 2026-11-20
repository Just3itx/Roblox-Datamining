-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local String = LuauPolyfill.String
local Number = LuauPolyfill.Number
local RegExp = require(scriptParentParentParent.RegExp)

local function TypeError<T>(str1: T): T -- Luacid: Inlined by compiler; 2 call sites recovered
    return str1
end

local function encodeURIComponent(input: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return HttpService:UrlEncode(input)
end

local function strictUriEncode(str1: string)
    return encodeURIComponent(str1):gsub("[!'%(%)%*]", function(arg1): string
        return ("%%%x"):format(arg1:byte()):upper()
    end)
end

local decodeURIComponent = require(scriptParent.decodeURIComponent)
local splitOnFirst = require(scriptParent.splitOnFirst)

local encode = nil
local decode = nil

local module = {}

local function newNumber(arg1): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return tonumber(arg1) or (0 / 0)
end

local function encoderForArrayFormat(arg1)
    local arrayFormat = arg1.arrayFormat

    if arrayFormat == "index" then
        return function(arg2)
            return function(arg3, arg4)
                local num1 = #arg3
                if arg1.skipNull and arg4 == nil then
                    return arg3
                elseif arg4 == nil then
                    return Array.concat(arg3, { table.concat({ encode(arg2, arg1), "[", num1, "]" }, "") })
                end

                return Array.concat(arg3, { table.concat({ encode(arg2, arg1), "[", encode(num1, arg1), "]=", encode(arg4, arg1) }, "") })
            end
        end
    elseif arrayFormat == "bracket" then
        return function(arg2)
            return function(arg3, arg4)
                if arg1.skipNull and arg4 == nil then
                    return arg3
                elseif arg4 == nil then
                    return Array.concat(arg3, { table.concat({ encode(arg2, arg1), "[]" }, "") })
                end

                return Array.concat(arg3, { table.concat({ encode(arg2, arg1), "[]=", encode(arg4, arg1) }, "") })
            end
        end
    end

    if arrayFormat == "comma" or arrayFormat == "separator" then
        return function(arg2)
            return function(arg3, arg4)
                if arg4 == nil or #arg4 == 0 then
                    return arg3
                end

                if #arg3 == 0 then
                    return { table.concat({ encode(arg2, arg1), "=", encode(arg2, arg1) }, "") }
                end

                return { table.concat({ arg3, encode(arg2, arg1) }, arg1.arrayFormatSeparator) }
            end
        end
    end

    return function(arg2)
        return function(arg3, arg4)
            if arg1.skipNull and arg4 == nil then
                return arg3
            elseif arg4 == nil then
                return Array.concat(arg3, { encode(arg2, arg1) })
            end

            return Array.concat(arg3, { table.concat({ encode(arg2, arg1), "=", encode(arg4, arg1) }, "") })
        end
    end
end

local function parserForArrayFormat(arg1)
    local var1 = nil
    local arrayFormat = arg1.arrayFormat

    if arrayFormat == "index" then
        return function(arg2, arg3, arg4)
            var1 = RegExp("\\[(\\d*)\\]$"):exec(arg2)

            arg2 = arg2:gsub("%[%d*%]$", "")

            if not var1 then
                arg4[arg2] = arg3
                return
            end

            if arg4[arg2] == nil then
                arg4[arg2] = {}
            end

            arg4[arg2][var1[2]] = arg3
        end
    elseif arrayFormat == "bracket" then
        return function(arg2, arg3, arg4)
            var1 = RegExp("(\\[\\])$"):exec(arg2)
            arg2 = arg2:gsub("%[%]$", "")

            if not var1 then
                arg4[arg2] = arg3
                return
            end

            if arg4[arg2] == nil then
                arg4[arg2] = { arg3 }
            else
                arg4[arg2] = Array.concat({}, arg4[arg2], arg3)
            end
        end
    end

    if arrayFormat ~= "comma" and arrayFormat ~= "separator" then
        return function(arg2, arg3, arg4)
            if arg4[arg2] == nil then
                arg4[arg2] = arg3
                return
            end

            arg4[arg2] = Array.concat({}, arg4[arg2], arg3)
        end
    end

    return function(arg2, arg3, arg4)
        local bool1 = type(arg3) == "string" and string.find(arg3, arg1.arrayFormatSeparator, 1, true) ~= nil
        local var2 = nil
        if bool1 then
            var2 = Array.map(arg3:split(arg1.arrayFormatSeparator), function(arg5)
                return decode(arg5, arg1)
            end)
        elseif arg3 ~= nil then
            var2 = decode(arg3, arg1)
        end

        arg4[arg2] = var2
    end
end

local function validateArrayFormatSeparator(arrayFormatSeparator) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(arrayFormatSeparator) ~= "string" or #arrayFormatSeparator ~= 1 then
        local str1 = TypeError("arrayFormatSeparator must be single character string")
        error(str1)
    end
end

encode = function(arg1, arg2)
    if arg2.encode then
        if arg2.strict then
            return strictUriEncode(arg1)
        end

        return encodeURIComponent(arg1)
    end

    return arg1
end

decode = function(arg1, arg2)
    if arg2.decode then
        return decodeURIComponent(arg1)
    end

    return arg1
end

local function keysSorter(arg1)
    if Array.isArray(arg1) then
        return Array.sort(arg1)
    elseif type(arg1) == "table" then
        return Array.map(Array.sort(keysSorter(Object.keys(arg1)), function(arg2, arg3): number
            return newNumber(arg2) - newNumber(arg3)
        end), function(arg2)
            return arg1[arg2]
        end)
    end

    return arg1
end

local function removeHash(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = arg1:find("#")
    if var1 ~= nil then
        arg1 = arg1:sub(1, var1 - 1)
    end

    return arg1
end

local function getHash(url) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = url:find("#")
    return if var1 == nil then "" else url:sub(var1)
end

local function extract(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1 = removeHash(arg1)
    local var1 = arg1:find("?", 1, true)
    if var1 == nil then
        return ""
    end

    return arg1:sub(var1 + 1)
end

local function parseValue(arg1, arg2)
    if arg2.parseNumbers and not Number.isNaN((newNumber(arg1))) and type(arg1) == "string" and String.trim(arg1) ~= "" then
        return (newNumber(arg1))
    end

    if arg2.parseBooleans and arg1 ~= nil and (string.lower(arg1) == "true" or string.lower(arg1) == "false") then
        arg1 = string.lower(arg1) == "true"
    end

    return arg1
end

local function parse(arg1, arg2)
    arg2 = Object.assign({
        decode = true,
        sort = true,
        arrayFormat = "none",
        arrayFormatSeparator = ",",
        parseNumbers = false,
        parseBooleans = false
    }, arg2)
    validateArrayFormatSeparator(arg2.arrayFormatSeparator)
    local func1 = parserForArrayFormat(arg2)

    local tbl1 = ({})

    if type(arg1) ~= "string" then
        return tbl1
    end

    arg1 = string.gsub(String.trim(arg1), "^[%?#&]", "")

    if arg1 == "" then
        return tbl1
    end

    for _, value in arg1:split("&") do
        local var1 = splitOnFirst

        if arg2.decode then
            value = string.gsub(value, "%+", " ")
        end

        local var2 = var1(value, "=")
        local var3 = var2[1]
        local var4 = var2[2]

        if var4 ~= nil and arg2.arrayFormat ~= "comma" then
            var4 = decode(var4, arg2)
        end

        func1(decode(var3, arg2), var4, tbl1)
    end

    for value in tbl1 do
        local var1 = tbl1[value]
        if type(var1) == "table" then
            for value2 in var1 do
                var1[value2] = parseValue(var1[value2], arg2)
            end
        else
            tbl1[value] = parseValue(var1, arg2)
        end
    end

    if arg2.sort == false then
        return tbl1
    end

    local var1 = if arg2.sort == true then Array.sort(Object.keys(tbl1)) else Array.sort(Object.keys(tbl1), arg2.sort)

    return Array.reduce(var1, function(arg3, arg4)
        local var2 = tbl1[arg4]

        if Boolean.toJSBoolean(var2) and type(var2) == "table" and not Array.isArray(var2) then
            arg3[arg4] = keysSorter(var2)
        else
            arg3[arg4] = var2
        end

        return arg3
    end, {})
end

module.extract = extract
module.parse = parse

function module.stringify(arg1, arg2): string
    if not arg1 then
        return ""
    end

    local var1 = Object.assign({ encode = true, strict = true, arrayFormat = "none", arrayFormatSeparator = "," }, arg2)

    validateArrayFormatSeparator(var1.arrayFormatSeparator)

    local func1 = encoderForArrayFormat(var1)
    local var2 = table.clone(arg1)

    local var3 = Object.keys(var2)

    if var1.sort ~= false then
        Array.sort(var3, var1.sort)
    end

    return table.concat(Array.filter(Array.map(var3, function(arg3)
        local var4 = arg1[arg3]

        if var4 == nil then
            return encode(arg3, var1)
        elseif Array.isArray(var4) then
            return table.concat(Array.reduce(var4, func1(arg3), {}), "&")
        end

        return encode(arg3, var1) + "=" + encode(var4, var1)
    end), function(arg3): boolean
        return arg3.length > 0
    end), "&")
end

function module.parseUrl(arg1, arg2)
    return {
        url = removeHash(arg1):split("?")[1] or "",
        query = parse(extract(arg1), arg2)
    }
end

function module.stringifyUrl(arg1, arg2): string
    local var1 = removeHash(arg1.url):split("?")[1] or ""
    local var2 = module.extract(arg1.url)
    local var3 = module.parse(var2)
    local hash = getHash(arg1.url)
    local var4 = Object.assign(var3, arg1.query)
    local var5 = module.stringify(var4, arg2)
    return ("%s%s%s"):format(var1, var5 and ("?%s"):format(var5), hash)
end

return module
