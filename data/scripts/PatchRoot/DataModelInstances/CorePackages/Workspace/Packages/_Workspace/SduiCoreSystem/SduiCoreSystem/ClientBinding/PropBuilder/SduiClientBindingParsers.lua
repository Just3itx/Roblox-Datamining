-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)
local _Foundation = require(SduiCoreSystemParent.Foundation)
local _ReactFocusNavigation = require(SduiCoreSystemParent.ReactFocusNavigation)
local InputHandlers = require(SduiCoreSystemParent.InputHandlers)

local getSduiTokensStore = require(SduiCoreSystem.ClientBinding.getSduiTokensStore)
local ProtoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)
local splitDottedPath = require(SduiCoreSystem.ClientBinding.splitDottedPath)
local parsePymkItems = require(SduiCoreSystem.ClientBinding.PropBuilder.parsePymkItems)
local FFlagSduiPropParsersShouldHandleTokens = require(SduiCoreSystemParent.SharedFlags).FFlagSduiPropParsersShouldHandleTokens
local FFlagSduiUnwrapStructPropEnvelope = require(SduiCoreSystemParent.SharedFlags).FFlagSduiUnwrapStructPropEnvelope

local function applyTokenScaling(num1: number, arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    return num1 * (arg1 and arg1.Config.UI.Scale or 1)
end

local function resolveTokenValueToNumber(arg1, str1: string)
    local bool1 = string.sub(str1, 1, 1) == "-"
    local str2 = if bool1 then string.sub(str1, 2) else str1
    local var1 = splitDottedPath(str2)
    local num1 = #var1
    for value, value2 in var1 do
        local var2 = arg1[value2]
        if value ~= num1 and typeof(var2) ~= "table" then
            error(`Token path {str2} invalid`)
        end
        arg1 = arg1[value2]
    end

    if typeof(arg1) ~= "number" then
        error(`Token path {str2} did not resolve to a number: {str1}`)
    end

    return if bool1 then arg1 * -1 else arg1
end

local function getTokenOrNumber(str1: string, arg1, bool1: boolean, str2: string)
    local var1 = tonumber(str1)
    if var1 then
        if bool1 then
            return applyTokenScaling(var1, (getSduiTokensStore().getTokens(arg1, str2)))
        end

        return var1
    elseif typeof(str1) == "string" then
        local success, result = pcall(function()
            return (resolveTokenValueToNumber(getSduiTokensStore().getTokens(arg1, str2), str1))
        end)
        if success and result then
            return result
        end
        local error = error

        if typeof(result) ~= "string" then
            result = nil
        end

        error(result)
    else
        error("Expected number or token string, got " .. typeof(str1))
    end
end

local parseUDim2 = FFlagSduiPropParsersShouldHandleTokens and function(str1: string, arg1, bool1: boolean)
    local success, result = pcall(function()
        local tbl1 = string.split(str1, ",")
        if #tbl1 == 4 then
            local tokenOrNumber = getTokenOrNumber(tbl1[2], arg1, bool1, "parseUDim2")
            local tokenOrNumber2 = getTokenOrNumber(tbl1[4], arg1, bool1, "parseUDim2")
            return UDim2.new(tonumber(tbl1[1]) or 0, tokenOrNumber, tonumber(tbl1[3]) or 0, tokenOrNumber2)
        end
        error("Not enough components in string to parse UDim2")
    end)

    if success and result then
        return result
    end
    local error = error

    if typeof(result) ~= "string" then
        result = nil
    end

    error(result)
end or function(str1: string, arg1, bool1: boolean)
    local success, result = pcall(function()
        local tbl1 = string.split(str1, ",")
        if #tbl1 ~= 4 then
            error("Not enough components in string to parse UDim2")
            return
        end

        local num1 = tonumber(tbl1[2]) or 0
        local num2 = tonumber(tbl1[4]) or 0
        if bool1 then
            local var1 = getSduiTokensStore().getTokens(arg1, "parseUDim2")
            num1 = applyTokenScaling(num1, var1)
            num2 = applyTokenScaling(num2, var1)
        end

        return UDim2.new(tonumber(tbl1[1]) or 0, num1, tonumber(tbl1[3]) or 0, num2)
    end)

    if success and result then
        return result
    end
    local error = error

    if typeof(result) ~= "string" then
        result = nil
    end

    error(result)
end

local parseUDim = FFlagSduiPropParsersShouldHandleTokens and function(str1: string, arg1, bool1: boolean)
    local success, result = pcall(function()
        local tbl1 = string.split(str1, ",")
        if #tbl1 == 2 then
            local tokenOrNumber = getTokenOrNumber(tbl1[2], arg1, bool1, "parseUDim")
            return UDim.new(tonumber(tbl1[1]) or 0, tokenOrNumber)
        end
        error("Not enough components in string to parse UDim")
    end)

    if success and result then
        return result
    end
    local error = error

    if typeof(result) ~= "string" then
        result = nil
    end

    error(result)
end or function(str1: string, arg1, bool1: boolean)
    local success, result = pcall(function()
        local tbl1 = string.split(str1, ",")
        if #tbl1 ~= 2 then
            error("Not enough components in string to parse UDim")
            return
        end

        local num1 = tonumber(tbl1[2]) or 0

        if bool1 then
            num1 = applyTokenScaling(num1, (getSduiTokensStore().getTokens(arg1, "parseUDim2")))
        end

        return UDim.new(tonumber(tbl1[1]) or 0, num1)
    end)

    if success and result then
        return result
    end
    local error = error

    if typeof(result) ~= "string" then
        result = nil
    end

    error(result)
end

local function parseNumber(arg1, arg2, bool1: boolean)
    local success, result = pcall(function(): number?
        return tonumber(arg1)
    end)
    if success and result then
        if bool1 then
            return applyTokenScaling(result, (getSduiTokensStore().getTokens(arg2, "parseUDim2")))
        end

        return result
    end
    local error = error

    if typeof(result) ~= "string" then
        result = nil
    end

    error(result)
end

local unwrapStruct = nil

local function isStructEnvelope(arg1)
    local fields = arg1.fields
    if typeof(fields) ~= "table" then
        return false
    end
    for value in arg1 do
        if value ~= "fields" then
            return false
        end
    end
    local bool1 = false
    for _, field in fields do
        if typeof(field) ~= "table" then
            return false
        end
        if typeof(field.kind) == "table" and typeof(field.kind.type) == "string" then
            bool1 = true
        end
    end

    return bool1 or next(fields) == nil
end

local function parseStruct(arg1)
    if typeof(arg1) ~= "table" then
        return arg1
    end
    if FFlagSduiUnwrapStructPropEnvelope and isStructEnvelope(arg1) then
        return unwrapStruct(arg1)
    end
    local mapPropName = ProtoVariableMapper.mapPropName
    local result = ({})
    for value, value2 in arg1 do
        if typeof(value) == "string" then
            value = mapPropName(value)
        end

        if typeof(value2) == "table" then
            value2 = parseStruct(value2)
        end

        result[value] = value2
    end
    return result
end

local unwrapStructValue = nil

local function unwrapStructList(arg1)
    local result = ({})
    local values = if typeof(arg1) == "table" then arg1.values else nil

    if typeof(values) ~= "table" then
        return result
    end
    for value, value2 in values do
        result[value] = unwrapStructValue(value2)
    end
    return result
end

unwrapStructValue = function(arg1)
    if typeof(arg1) ~= "table" then
        return arg1
    end

    local kind = arg1.kind
    if typeof(kind) ~= "table" or typeof(kind.type) ~= "string" then
        return parseStruct(arg1)
    elseif kind.type == "null_value" then
        return nil
    elseif kind.type == "struct_value" then
        return parseStruct(kind.value)
    elseif kind.type == "list_value" then
        return (unwrapStructList(kind.value))
    end

    return kind.value
end

unwrapStruct = function(arg1)
    local mapPropName = ProtoVariableMapper.mapPropName
    local result = ({})
    for k, field in arg1.fields do
        if typeof(k) == "string" then
            k = mapPropName(k)
        end

        result[k] = unwrapStructValue(field)
    end
    return result
end

local function parseColor3(arg1)
    if typeof(arg1) == "Color3" then
        return arg1
    end
    if typeof(arg1) == "string" then
        local success, result = pcall(function(): Color3
            return Color3.fromHex(arg1)
        end)
        return if success then result else nil
    end
    if typeof(arg1) == "table" and typeof(arg1.Color3) == "Color3" then
        return arg1.Color3
    end
    error(`Could not resolve Color3 from input: {arg1}`)
end

local tbl1 = {
    startColor = Color3.new(0, 0, 0),
    endColor = Color3.new(0, 0, 0),
    startOpacity = 0,
    endOpacity = 1,
    degree = 270
}

return {
    parseUDim = parseUDim,
    parseUDim2 = parseUDim2,
    parseNumber = parseNumber,
    applyTokenScaling = applyTokenScaling,
    parseUiScaledNumber = function(arg1, arg2)
        return parseNumber(arg1, arg2, true)
    end,
    parseUiScaledUDim = function(str1: string, arg1)
        return parseUDim(str1, arg1, true)
    end,
    parseUiScaledUDim2 = function(str1: string, arg1)
        return parseUDim2(str1, arg1, true)
    end,
    parseStruct = parseStruct,
    parseArrayOfStruct = function(arg1)
        if typeof(arg1) ~= "table" then
            return arg1
        end
        local result = ({})
        for value, value2 in arg1 do
            result[value] = parseStruct(value2)
        end
        return result
    end,
    parsePymkItems = parsePymkItems,
    parseStringArray = function(arg1)
        return if typeof(arg1) == "table" then arg1.items or arg1 else nil
    end,
    parseToString = function(arg1)
        if arg1 == nil then
            return nil
        end
        return tostring(arg1)
    end,
    parseColor3 = parseColor3,
    parseGradient = function(arg1)
        local var1 = parseStruct(arg1)
        if typeof(var1) ~= "table" then
            error(`Could not resolve gradient from input: {arg1}`)
        end

        local startColor = if var1.startColor == nil then tbl1.startColor else parseColor3(var1.startColor)
        local endColor = if var1.endColor == nil then tbl1.endColor else parseColor3(var1.endColor)

        if startColor == nil or endColor == nil then
            error(`Could not resolve gradient colors from input: {arg1}`)
        end
        if var1.startOpacity ~= nil and typeof(var1.startOpacity) ~= "number" then
            error(`Could not resolve gradient startOpacity from input: {arg1}`)
        end
        if var1.endOpacity ~= nil and typeof(var1.endOpacity) ~= "number" then
            error(`Could not resolve gradient endOpacity from input: {arg1}`)
        end
        if var1.degree ~= nil and typeof(var1.degree) ~= "number" then
            error(`Could not resolve gradient degree from input: {arg1}`)
        end

        return {
            startColor = startColor,
            endColor = endColor,
            startOpacity = if var1.startOpacity == nil then tbl1.startOpacity else var1.startOpacity,
            endOpacity = if var1.endOpacity == nil then tbl1.endOpacity else var1.endOpacity,
            degree = if var1.degree == nil then tbl1.degree else var1.degree
        }
    end,
    parseColorPropLegacy = function(arg1)
        if typeof(arg1) == "string" then
            return Color3.fromHex(arg1)
        end

        return arg1
    end,
    parseFocusNavActions = function(arg1)
        if typeof(arg1) ~= "table" then
            return nil
        end

        local keys = ({})
        if typeof(arg1.keys) == "table" then
            for k, key in arg1.keys do
                if typeof(key) == "EnumItem" and typeof(k) == "string" then
                    keys[key] = k
                end
            end
        end

        local events = ({})
        if typeof(arg1.events) == "table" then
            for k, event in arg1.events do
                if typeof(k) == "string" and typeof(event) == "function" then
                    local tbl4 = {
                        handler = InputHandlers.onRelease(event)
                    }
                    events[k] = tbl4
                end
            end
        end

        return { keys = keys, events = events }
    end
}
