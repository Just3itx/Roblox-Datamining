-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Cryo = require(SduiCoreSystemParent.Cryo)
local React = require(SduiCoreSystemParent.React)
local Images = require(SduiCoreSystemParent.FoundationImages).Images
local GetImageData = require(SduiCoreSystemParent.RobloxAppAssets).GetImageData
local FocusNavigationEventNameEnum = require(SduiCoreSystemParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local InputHandlers = require(SduiCoreSystemParent.InputHandlers)

local executeAction = require(SduiCoreSystem.executeAction)
local _SduiActionType = require(SduiCoreSystem.SduiActionType)
local SduiBuilder = require(SduiCoreSystem.SduiBuilder)
local SduiBuilderProcessingPhase = require(SduiCoreSystem.SduiBuilderTypes).SduiBuilderProcessingPhase
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiResponsiveHelpers = require(SduiCoreSystem.SduiResponsiveHelpers)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiErrorType = SduiErrors.SduiErrorType
local getSduiComponentWrapper = require(SduiCoreSystem.getSduiComponentWrapper)
local getSduiActionHandlerRegistry = require(SduiCoreSystem.getSduiActionHandlerRegistry)
local getSduiTokensStore = require(SduiCoreSystem.ClientBinding.getSduiTokensStore)

local _SduiContentTypes = require(SduiCoreSystem.SduiContentTypes)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiFocusNavigationTypes = require(SduiCoreSystem.SduiFocusNavigationTypes)

local function withErrorHandling(arg1) -- Luacid: Inlined by compiler; 19 call sites recovered
    return function(arg2, arg3, arg4, arg5)
        local success, result = pcall(function()
            return arg1(arg2, arg3, arg4, arg5)
        end)

        if success then
            return result
        end
        local var1 = Cryo.Dictionary.join(
            if typeof(result) == "table" then result else typeof(result) == "string" and {
                message = result
            } or {},
            {
                value = SduiParseHelpers.stringifyValue(arg2)
            }
        )
        arg3.dependencies.logger.reportError(SduiErrorType.FailedToParse, var1, arg3.appPage)

        return if typeof(result) == "table" then result.overrideValue else nil
    end
end

local function parseFoundationTokenHelper(arg1, str1: string, parserName: string, arg2)
    local str2 = typeof(arg1)
    if str2 == str1 then
        return arg1
    end

    if str2 ~= "string" then
        error({ parserName = parserName, message = `Invalid inputType. Expect string. {str2}` })
    end

    local var1 = getSduiTokensStore().getTokens(false, arg2.appPage)

    for _, value in (arg1:split(".")) do
        if typeof(var1) == "table" then
            var1 = var1[value]
        else
            error({ parserName = parserName, message = `Invalid path for token for input {arg1}` })
        end

        if var1 == nil then
            error({ parserName = parserName, message = `Nil tokens for input {arg1}` })
        end
    end

    if typeof(var1) ~= str1 then
        error(
            {
                parserName = parserName,
                message = `Unexpected token type for {arg1}. {typeof(var1)} ~= {str1}`
            }
        )
    end
    return var1
end

local function parseNumberToken(arg1, arg2, _, _) -- Luacid: Inlined by compiler; 1 call site recovered
    return (parseFoundationTokenHelper(arg1, "number", "parseNumberToken", arg2))
end

local function parseTypographyToken(arg1, arg2, _, _)
    return (parseFoundationTokenHelper(arg1, "table", "parseTypographyToken", arg2))
end

local function parseFontFromTypographyToken(arg1, arg2, _, _)
    return (parseFoundationTokenHelper(arg1, "EnumItem", "parseFontFromTypographyToken", arg2))
end

local function parseColorToken(arg1, arg2, _, _) -- Luacid: Inlined by compiler; 1 call site recovered
    return (parseFoundationTokenHelper(arg1, "table", "parseColorToken", arg2))
end

local function parseLuaTableEnumHelper(arg1, str1: string, tbl1, tbl2)
    local str2 = typeof(arg1)

    if str2 == str1 and tbl2[arg1] then
        return arg1
    end

    if str2 ~= "string" then
        error({
            parserName = "parseLuaTableEnumHelper",
            message = `Invalid input type to parser: {str2}. Expected string.`
        })
    end

    local var1 = tbl1[arg1]
    if var1 ~= nil then
        return var1
    end

    local str3 = ""
    for value in tbl2 do
        str3 ..= value .. ", "
    end
    error({
        parserName = "parseLuaTableEnumHelper",
        message = `Failed to parse lua table enum. input: {arg1} validValues: {str3}`
    })
end

local tbl1 = ({})

local function makeLuaTableEnumParser(tbl2, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = ({})
    for _, value in tbl2 do
        tbl3[value] = true
    end
    return function(arg1, _, _, _)
        return parseLuaTableEnumHelper(arg1, str1, tbl2, tbl3)
    end
end

local function parseEngineEnumHelper(arg1, arg2)
    if typeof(arg1) == "EnumItem" then
        return arg1
    end

    if typeof(arg1) ~= "string" then
        error({
            parserName = "parseEngineEnumHelper",
            message = `Invalid input type Engine Enum value. Expect string. received {arg1}`
        })
    end

    local success, result = pcall(function()
        return arg2[arg1]
    end)

    if success then
        return result
    end
    error({ parserName = "parseEngineEnumHelper", message = result })
end

local tbl2 = ({})

local function makeEngineEnumParser(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(arg2, _, _, _)
        return parseEngineEnumHelper(arg2, arg1)
    end
end

local function parseUDim2(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 == "UDim2" then
        return arg1
    end

    local success, result = pcall(function()
        if str1 == "string" then
            local tbl3 = string.split(arg1, ",")
            if #tbl3 == 4 then
                return UDim2.new(tonumber(tbl3[1]) or 0, tonumber(tbl3[2]) or 0, tonumber(tbl3[3]) or 0, tonumber(tbl3[4]) or 0)
            end

            error("Not enough components in string to parse UDim2")
            return
        end
        if str1 == "table" then
            if #arg1 == 4 then
                return UDim2.new(tonumber(arg1[1]) or 0, tonumber(arg1[2]) or 0, tonumber(arg1[3]) or 0, tonumber(arg1[4]) or 0)
            end

            error("Not enough components in table to parse UDim2")
        else
            error(`Invalid input type for parseUDim2: {str1}`)
        end
    end)

    if success and result then
        return result
    end
    local error = error
    local tbl3 = { parserName = "parseUDim2", message = 0 }

    if typeof(result) ~= "string" then
        result = nil
    end

    tbl3.message = result
    error(tbl3)
end

local function parseUDim(offset: number?, _, _, _)
    local str1 = typeof(offset)
    if str1 == "UDim" then
        return offset
    end

    local success, result = pcall(function()
        if str1 == "string" then
            local tbl3 = string.split(offset, ",")
            if #tbl3 == 2 then
                return UDim.new(tonumber(tbl3[1]) or 0, tonumber(tbl3[2]) or 0)
            end
            error("Not enough components in string to parse UDim")
            return
        end
        if str1 == "table" then
            if #offset == 2 then
                return UDim.new(tonumber(offset[1]) or 0, tonumber(offset[2]) or 0)
            end
            error("Not enough components in table to parse UDim")
        else
            if str1 == "number" then
                return UDim.new(0, offset)
            end
            error(`Invalid input type for parseUDim: {str1}`)
        end
    end)

    if success and result then
        return result
    end
    local error = error
    local tbl3 = { parserName = "parseUDim", message = 0 }

    if typeof(result) ~= "string" then
        result = nil
    end

    tbl3.message = result
    error(tbl3)
end

local function parseColor3(hex: string, arg1, arg2, arg3)
    local str1 = typeof(hex)
    if str1 == "Color3" then
        return hex
    end

    local success, message = pcall(function()
        if str1 ~= "string" then
            if str1 == "table" then
                return Color3.fromRGB(hex.r, hex.g, hex.b)
            end
            error(`Invalid input type for parseColor3: {str1}`)

            return
        end

        local success, result = pcall(function(): Color3
            return Color3.fromHex(hex)
        end)

        if success and result then
            return result
        end

        local success2, result2 = pcall(function()
            return (parseColorToken(hex, arg1, nil, nil))
        end)

        if success2 and typeof(result2) == "table" and result2.Color3 ~= nil then
            return result2.Color3
        end

        error(`Invalid input for Color3: {hex}`)
    end)
    if success and message then
        return message
    end
    local error = error
    local tbl3 = { parserName = "parseColor3", message = 0 }

    if typeof(message) ~= "string" then
        if typeof(message) == "table" then
            message = message.message
        else
            message = nil
        end
    end

    tbl3.message = message
    error(tbl3)
end

local black = Color3.new(0, 0, 0)
local tbl3 = {
    startColor = black,
    endColor = black,
    startOpacity = 0,
    endOpacity = 1,
    degree = 270
}

local function isValidGradient(arg1): boolean
    if typeof(arg1) ~= "table" then
        return false
    end
    if typeof(arg1.startColor) ~= "Color3" then
        return false
    end
    if typeof(arg1.endColor) ~= "Color3" then
        return false
    end
    if typeof(arg1.startOpacity) ~= "number" then
        return false
    end
    if typeof(arg1.endOpacity) ~= "number" then
        return false
    end
    return typeof(arg1.degree) == "number"
end

local function parseGradient(arg1, arg2, arg3, arg4)
    local str1 = typeof(arg1)
    if str1 == "table" then
        if isValidGradient(arg1) then
            return arg1
        end
    else
        error({ parserName = "parseGradient", message = `invalid input type for parseGradient: {str1}` })
    end

    local startColor

    if arg1.startColor then
        local success

        success, startColor = pcall(function()
            return parseColor3(arg1.startColor, arg2, arg3, arg4)
        end)
        if not success then
            error({
                parserName = "parseGradient",
                message = if typeof(startColor) ~= "string" then "failed to parse startColor field" else startColor
            })
        end
    else
        startColor = tbl3.startColor
    end

    local endColor

    if arg1.endColor then
        local success

        success, endColor = pcall(function()
            return parseColor3(arg1.endColor, arg2, arg3, arg4)
        end)
        if not success then
            error({
                parserName = "parseGradient",
                message = if typeof(endColor) ~= "string" then "failed to parse endColor field" else endColor
            })
        end
    else
        endColor = tbl3.endColor
    end

    local startOpacity = nil
    if typeof(arg1.startOpacity) == "number" then
        startOpacity = arg1.startOpacity
    elseif arg1.startOpacity ~= nil then
        local error = error
        local tbl4 = { parserName = "parseGradient", message = 0 }

        local startOpacity2 = arg1.startOpacity
        tbl4.message = `invalid input type for startOpacity: {typeof(startOpacity2)}`
        error(tbl4)
    end

    local endOpacity = nil
    if typeof(arg1.endOpacity) == "number" then
        endOpacity = arg1.endOpacity
    elseif arg1.endOpacity ~= nil then
        local error = error
        local tbl4 = { parserName = "parseGradient", message = 0 }

        local endOpacity2 = arg1.endOpacity
        tbl4.message = `invalid input type for endOpacity: {typeof(endOpacity2)}`
        error(tbl4)
    end

    local degree = nil
    if typeof(arg1.degree) == "number" then
        degree = arg1.degree
    elseif arg1.degree ~= nil then
        local error = error
        local tbl4 = { parserName = "parseGradient", message = 0 }

        local degree2 = arg1.degree
        tbl4.message = `invalid input type for degree: {typeof(degree2)}`
        error(tbl4)
    end

    return {
        startColor = startColor,
        endColor = endColor,
        startOpacity = startOpacity or tbl3.startOpacity,
        endOpacity = endOpacity or tbl3.endOpacity,
        degree = degree or tbl3.degree
    }
end

local function isValidImageSet(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return typeof(arg1) == "table"
        and typeof(arg1.ImageRectOffset) == "Vector2"
        and typeof(arg1.Image) == "string"
        and typeof(arg1.ImageRectSize) == "Vector2"
end

local tbl4 = {
    truncate_arrows = true,
    squircles = true,
    gradient = true,
    component_assets = true,
    chat_bubble = true,
    icons = true
}

local function isValidIconString(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl5 = str1:split("/")
    return not not (tbl5 and #tbl5 > 1 and tbl4[tbl5[1]])
end

local function parseIcon(arg1, _, _, _)
    local bool1 = isValidImageSet(arg1)
    local result = nil

    if bool1 then
        return arg1
    end

    if typeof(arg1) == "string" then
        local success

        success, result = pcall(function()
            return GetImageData(arg1) or Images[arg1]
        end)
        if not (success and result) then
            error({ parserName = "parseIcon", message = `No icon found for {arg1}` })
        end
    end

    if not result then
        error({ parserName = "parseIcon", message = `Bad input for icon: {arg1}` })
    end

    return result
end

local function isValidActionConfig(arg1, _): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "table" or typeof(arg1.actionType) ~= "string" then
        return false
    end

    local var1 = getSduiActionHandlerRegistry().getActionHandlerConfig(arg1.actionType)

    return not (var1 == nil) and (var1.handler ~= nil or var1.telemetryHandler ~= nil)
end

local function isCallableTable(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "table" then
        local var1 = getmetatable(arg1)
        if var1 and type(var1.__call) == "function" then
            return true
        end
    end
    return false
end

local function parseCallback(arg1, sduiContext, analyticsContext, _)
    local str1 = typeof(arg1)
    local var1 = nil
    if str1 == "function" then
        return arg1
    end

    if isCallableTable(arg1) then
        arg1.analyticsContext = analyticsContext
        arg1.sduiContext = sduiContext
        return arg1
    end

    if isValidActionConfig(arg1, nil) then
        var1 = arg1
    end

    if var1 then
        local tbl5 = { analyticsContext = analyticsContext, sduiContext = sduiContext }

        setmetatable(tbl5, {
            __call = function(arg2, arg3)
                return executeAction(var1, arg2.analyticsContext, arg2.sduiContext, arg3)
            end
        })
        return tbl5
    end

    local name = if typeof(arg1) ~= "table" then "unknown" else arg1.actionType or "unknown"

    error({
        parserName = "parseCallback",
        message = `Could not find action for: {arg1} actionType: {name}`,
        overrideValue = function()
            sduiContext.dependencies.logger.reportCounter(SduiErrors.SduiCounterName.ExecutedInvalidAction, { name = name })
        end
    })
end

local function parseUiComponent(componentConfig, sduiContext, parentAnalyticsContext, eager)
    local success, result

    if eager == SduiBuilderProcessingPhase.Eager then
        success, result = pcall(function()
            if typeof(componentConfig) ~= "table" then
                error(`Invalid input type {typeof(componentConfig)}`)
            end
            local var1, var2 = SduiBuilder.tryCreateEagerProcessedComponentConfig(
                componentConfig,
                sduiContext,
                "parseUiComponent",
                parentAnalyticsContext
            )
            if var1 then
                return var2
            end
            error("Unable to parse componentConfig during Eager phase")
        end)
    else
        success, result = pcall(function()
            if typeof(componentConfig) ~= "table" then
                error(`Invalid input type {typeof(componentConfig)}`)
                return
            end

            local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)
            return React.createElement(sduiComponentWrapper, {
                componentConfig = componentConfig,
                sduiContext = sduiContext,
                parentAnalyticsContext = parentAnalyticsContext,
                debugName = `parsedUiComponent-{componentConfig.componentType}`
            })
        end)
    end
    if success and result then
        return result
    end
    local error = error
    local tbl5 = { parserName = "parseUiComponent", message = 0 }

    if typeof(result) ~= "string" then
        result = nil
    end

    tbl5.message = result
    error(tbl5)
end

local function parseVector2(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 == "Vector2" then
        return arg1
    end

    local success, result = pcall(function()
        if str1 == "string" then
            local tbl5 = string.split(arg1, ",")
            if #tbl5 == 2 then
                return Vector2.new(tonumber(tbl5[1]) or 0, tonumber(tbl5[2]) or 0)
            end
            error("Not enough components in string to parse Vector2")
            return
        end
        if str1 == "table" then
            if #arg1 == 2 then
                return Vector2.new(tonumber(arg1[1]) or 0, tonumber(arg1[2]) or 0)
            end
            error("Not enough components in table to parse Vector2")
        else
            error(`Invalid input type for parseVector2: {str1}`)
        end
    end)

    if success and result then
        return result
    end
    local error = error
    local tbl5 = { parserName = "parseVector2", message = 0 }

    if typeof(result) ~= "string" then
        result = nil
    end

    tbl5.message = result
    error(tbl5)
end

local function parseNumber(arg1, arg2, arg3, arg4)
    local str1 = typeof(arg1)
    if str1 == "number" then
        return arg1
    elseif str1 == "string" then
        local success, result = pcall(function(): number?
            return tonumber(arg1)
        end)

        if not success or result == nil then
            success, result = pcall(function()
                return (parseNumberToken(arg1, arg2, nil, nil))
            end)
        end

        if success and result then
            return result
        end
        local error = error
        local tbl5 = { parserName = "parseNumber", message = 0 }

        if typeof(result) ~= "string" then
            result = `Failed to parse string {arg1} to number`
        end

        tbl5.message = result
        error(tbl5)
    else
        error({ parserName = "parseNumber", message = `Invalid input type for parseNumber: {str1}` })
    end
end

local function parseInteger(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 == "number" then
        return arg1
    elseif str1 == "string" then
        local success, result = pcall(function(): number?
            return tonumber(arg1)
        end)

        if success and result then
            local num1 = math.round(result)

            if arg1 ~= tostring(num1) then
                error({
                    parserName = "parseInteger",
                    message = if typeof(result) == "string" then result else `Unexpected output {result} does not match input {arg1}.`
                })
            end

            return result
        end
        local error = error
        local tbl5 = { parserName = "parseInteger", message = 0 }

        if typeof(result) ~= "string" then
            result = `Failed to parse string {arg1} to number`
        end

        tbl5.message = result
        error(tbl5)
    else
        error({ parserName = "parseInteger", message = `Invalid input type for parseInteger: {str1}` })
    end
end

local function parseBoolean(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 == "boolean" then
        return arg1
    elseif str1 == "number" then
        if arg1 == 1 then
            return true
        elseif arg1 == 0 then
            return false
        end
        error({ parserName = "parseBoolean", message = `Failed to parse number {arg1} to boolean` })
    elseif str1 == "string" then
        local str2 = string.lower(arg1)
        if str2 == "t" or str2 == "true" then
            return true
        end

        if str2 == "f" or str2 == "false" then
            return false
        end
        error({ parserName = "parseBoolean", message = `Failed to parse string {arg1} to boolean` })
    else
        error({ parserName = "parseBoolean", message = `Invalid input type for parseBoolean: {str1}` })
    end
end

local function parseString(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 == "string" then
        return arg1
    end

    if str1 == "number" or str1 == "boolean" then
        return tostring(arg1)
    end
    error({ parserName = "parseString", message = `Invalid input type for parseString: {str1}` })
end

local function parseImageString(arg1, _, _, _)
    local str1 = typeof(arg1)
    if str1 ~= "string" then
        error({ parserName = "parseImageString", message = `Invalid input type for parseImageString: {str1}` })
    end

    local var1 = arg1:split("://")

    if not (#var1 > 1) or var1[1] ~= "rbxthumb" then
        return arg1
    end

    local tbl5 = ({})
    for _, value in (var1[2]:split("&")) do
        local var2 = value:split("=")
        if #var2 == 2 then
            tbl5[var2[1]] = var2[2]
        end
    end

    if tbl5.mw == nil or tbl5.mh == nil then
        return arg1
    end

    local var2 = tonumber(tbl5.w)
    local var3 = tonumber(tbl5.h)
    local var4 = tonumber(tbl5.mw)
    local var5 = tonumber(tbl5.mh)
    if var2 == nil or var3 == nil or var4 == nil or var5 == nil or tbl5.type == nil or tbl5.id == nil then
        error(
            {
                parserName = "parseImageString",
                message = `Invalid params for rbxthumb in parseImageString: {arg1}`
            }
        )
    end

    assert(var2, "inputWidth must exist")
    assert(var3, "inputHeight must exist")
    assert(var4, "inputWidth must exist")
    assert(var5, "inputHeight must exist")

    local var6, var7 = SduiResponsiveHelpers.adaptThumbnailDimensions(var2, var3, var4, var5, tbl5.type)

    local str2 = `rbxthumb://type={tbl5.type}&id={tbl5.id}&w={var6}&h={var7}`

    tbl5.w = nil
    tbl5.h = nil
    tbl5.mw = nil
    tbl5.mh = nil
    tbl5.id = nil
    tbl5.type = nil
    for value, value2 in tbl5 do
        str2 ..= string.format("&%s=%s", value, value2)
    end
    return str2
end

local function parseImageSetOrImage(arg1, arg2, arg3, arg4)
    local str1 = typeof(arg1)
    if str1 == "table" then
        return arg1
    end
    if str1 ~= "string" then
        error(
            {
                parserName = "parseImageSetOrImage",
                message = `Invalid input type for parseImageSetOrImage: {str1}`
            }
        )
    end

    if isValidIconString(arg1) then
        return (parseIcon(arg1, arg2, arg3, arg4))
    end
    return (parseImageString(arg1, arg2, arg3, arg4))
end

local function isValidFocusNavActions(arg1)
    if typeof(arg1) ~= "table" then
        return false
    end
    local var1 = nil
    local var2 = nil
    local keys = arg1.keys
    if keys then
        if typeof(keys) ~= "table" then
            return false
        end
        for k, key in keys do
            if typeof(k) ~= "EnumItem" then
                return false
            end
            if FocusNavigationEventNameEnum[key] == nil then
                return false
            end

            var1 = true
        end
    end

    local events = arg1.events
    if events then
        if typeof(events) ~= "table" then
            return false
        end
        for k, event in events do
            if FocusNavigationEventNameEnum[k] == nil then
                return false
            end

            if typeof(event) ~= "table" then
                return false
            end
            if typeof(event.handler) ~= "function" then
                return false
            end

            var2 = true
        end
    end

    return var1 or var2 or false
end

local function parseFocusNavActions(arg1, sduiContext, analyticsContext, arg2)
    if isValidFocusNavActions(arg1) then
        return arg1
    end

    local str1 = typeof(arg1)
    if str1 ~= "table" then
        error(
            {
                parserName = "parseFocusNavActions",
                message = `Invalid input type for parseFocusNavActions: {str1}`
            }
        )
    end

    assert(typeof(arg1) == "table", "input must be table")

    local success, result = pcall(function()
        local var1 = FocusNavigationEventNameEnum

        if tbl1[var1] == nil then
            tbl1[var1] = makeLuaTableEnumParser(var1, "string")
        end
        local var2 = tbl1[var1]

        local var3 = nil
        local var4 = nil
        local keys = arg1.keys
        if keys then
            if typeof(keys) ~= "table" then
                error({ parserName = "parseFocusNavActions", message = `Invalid input type for keys: {str1}` })
            end

            assert(typeof(keys) == "table", "keys must be table")

            local keyCode = Enum.KeyCode

            if tbl2[keyCode] == nil then
                tbl2[keyCode] = makeEngineEnumParser(keyCode)
            end
            local var5 = tbl2[keyCode]

            for k, key in keys do
                local var6

                if typeof(k) == "string" then
                    keys[k] = nil
                    var6 = var5(k, sduiContext, analyticsContext, arg2)
                else
                    var6 = nil
                end
                keys[var6] = var2(key, sduiContext, analyticsContext, arg2)
                var3 = true
            end
        end

        local events = arg1.events
        if events then
            if typeof(events) ~= "table" then
                error({ parserName = "parseFocusNavActions", message = `Invalid input type for events: {str1}` })
            end

            assert(typeof(events) == "table", "events must be table")

            for k, event in events do
                if typeof(event) ~= "table" or typeof(event.handler) == "function" then
                    continue
                end

                events[k] = nil
                local var5 = var2(k, sduiContext, analyticsContext, arg2)

                events[var5] = {
                    handler = InputHandlers.onRelease(parseCallback(event, sduiContext, analyticsContext, arg2))
                }
                var4 = true
            end
        end

        if not (var3 or var4) then
            error("Invalid format. keys or events required")
        end

        return { keys = keys, events = events }
    end)

    if success and result then
        return result
    elseif typeof(result) == "table" then
        result.parserName = "parseFocusNavActions"
        result.overrideValue = nil
        error(result)
    else
        error({
            parserName = "parseFocusNavActions",
            message = if typeof(result) ~= "string" then "Failed to parse focus nav event" else result
        })
    end
end

local tbl5 = ({})

return {
    parseBooleanProp_ = parseBoolean,
    parseCallbackProp_ = parseCallback,
    parseColor3Prop_ = parseColor3,
    parseGradientProp_ = parseGradient,
    parseIconProp_ = parseIcon,
    parseImageStringProp_ = parseImageString,
    parseIntegerProp_ = parseInteger,
    parseLazyCallbackProp_ = function<T>(arg1: T, _, _, _): T -- name: parseLazyCallback
        return arg1
    end,
    parseLazyUiComponentProp_ = function(arg1, arg2, arg3, eager) -- name: parseLazyUiComponent
        if eager ~= SduiBuilderProcessingPhase.Eager then
            return arg1
        end

        local success, result = pcall(function()
            if typeof(arg1) ~= "table" then
                error(`Invalid input type {typeof(arg1)}`)
            end
            local var1, var2 = SduiBuilder.tryCreateEagerProcessedComponentConfig(arg1, arg2, "parseUiComponent", arg3)

            if var1 then
                return var2
            end
            error("Unable to parse componentConfig during Eager phase")
        end)

        if success and result then
            return result
        end
        local error = error
        local tbl6 = { parserName = "parseLazyUiComponent", message = 0 }

        if typeof(result) ~= "string" then
            result = nil
        end

        tbl6.message = result
        error(tbl6)
    end,
    parseNumberProp_ = parseNumber,
    parseStringProp_ = parseString,
    parseUDimProp_ = parseUDim,
    parseUDim2Prop_ = parseUDim2,
    parseUiComponentProp_ = parseUiComponent,
    parseVector2Prop_ = parseVector2,
    parseNumberTokenProp_ = parseNumberToken,
    parseTypographyTokenProp_ = parseTypographyToken,
    parseColorTokenProp_ = parseColorToken,
    parseFontFromTypographyTokenProp_ = parseFontFromTypographyToken,
    parseFocusNavActionsProp_ = parseFocusNavActions,
    parseImageSetOrImageProp_ = parseImageSetOrImage,
    getArrayMetatableParser = function(arg1)
        if tbl5[arg1] == nil then
            tbl5[arg1] = setmetatable({}, {
                __index = function(_, arg2)
                    return if type(arg2) == "number" then arg1 else nil
                end
            })
        end
        return tbl5[arg1]
    end,
    getEngineEnumParser = function(arg1)
        if tbl2[arg1] == nil then
            tbl2[arg1] = makeEngineEnumParser(arg1)
        end
        return tbl2[arg1]
    end,
    getLuaTableEnumParser = function(tbl6, str1: string)
        if tbl1[tbl6] == nil then
            tbl1[tbl6] = makeLuaTableEnumParser(tbl6, str1)
        end
        return tbl1[tbl6]
    end,
    isValidActionConfig = isValidActionConfig,
    isValidImageSet = isValidImageSet,
    isValidGradient = isValidGradient,
    isValidFocusNavActions = isValidFocusNavActions,
    safeParseBoolean = withErrorHandling(parseBoolean),
    safeParseCallback = withErrorHandling(parseCallback),
    safeParseColor3 = withErrorHandling(parseColor3),
    safeParseGradient = withErrorHandling(parseGradient),
    safeParseIcon = withErrorHandling(parseIcon),
    safeParseImageString = withErrorHandling(parseImageString),
    safeParseInteger = withErrorHandling(parseInteger),
    safeParseNumber = withErrorHandling(parseNumber),
    safeParseString = withErrorHandling(parseString),
    safeParseUDim = withErrorHandling(parseUDim),
    safeParseUDim2 = withErrorHandling(parseUDim2),
    safeParseUiComponent = withErrorHandling(parseUiComponent),
    safeParseVector2 = withErrorHandling(parseVector2),
    safeParseNumberToken = withErrorHandling(parseNumberToken),
    safeParseTypographyToken = withErrorHandling(parseTypographyToken),
    safeParseFontFromTypographyToken = withErrorHandling(parseFontFromTypographyToken),
    safeParseColorToken = withErrorHandling(parseColorToken),
    safeParseFocusNavActions = withErrorHandling(parseFocusNavActions),
    safeParseImageSetOrImageProp_ = withErrorHandling(parseImageSetOrImage)
}
