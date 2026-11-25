-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local SduiApiStorePostConfig = require(SduiSharedUtilities.SduiApiStorePostConfig)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)
local SduiSurfaceToDisplayLocation = require(SduiSharedUtilities.SduiSurfaceToDisplayLocation)
local getSduiTemplateStore = require(SduiSharedUtilities.getSduiTemplateStore)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local ServiceContractsProto = require(SduiSharedUtilitiesParent.ServiceContractsProto)
local UrlBuilder = require(SduiSharedUtilitiesParent.UrlBuilder)

local SduiCapabilities = SduiCoreSystem.SduiCapabilities
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local DisplayLocation = ServiceContractsProto.apppageplatform.shared.display_location.DisplayLocation
local template_api_messages = ServiceContractsProto.apppageplatform.templates.template_api_messages

local FFlagSduiAdvertiseRuntimeSupportSets = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAdvertiseRuntimeSupportSets

local function getTemplatesUrl(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `{UrlBuilder.UrlBase.APIS}/landing-page-api/v1/templates`
end

local function resolveSurfaceKey(name: string, tbl1)
    local var1 = SduiSurfaceToDisplayLocation[name]
    if var1 == nil then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.CodeError,
            {
                name = name,
                message = `Unmapped SDUI surfaceKey {name}`
            },
            name
        )
        return
    end

    local success, result = pcall(DisplayLocation.toNumber, var1)
    if not success or type(result) ~= "number" then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.CodeError,
            {
                name = name,
                message = `Invalid DisplayLocation {var1} for surfaceKey {name}`
            },
            name
        )
        return
    end

    if not tbl1.uniqueDisplayLocationNumbers[result] then
        tbl1.uniqueDisplayLocationNumbers[result] = true
        table.insert(tbl1.displayLocationNumbers, result)
    end

    local tbl2 = tbl1.surfaceKeysByDisplayLocation[var1]
    if tbl2 == nil then
        tbl2 = {}
        tbl1.surfaceKeysByDisplayLocation[var1] = tbl2
    end
    if not table.find(tbl2, name) then
        table.insert(tbl2, name)
    end
end

local function resolveSurfaceKeys(surfaceKeys)
    local tbl1 = {
        displayLocationNumbers = {},
        uniqueDisplayLocationNumbers = {},
        surfaceKeysByDisplayLocation = {}
    }
    for _, surfaceKey in surfaceKeys do
        resolveSurfaceKey(surfaceKey, tbl1)
    end

    if #tbl1.displayLocationNumbers ~= 0 then
        table.sort(tbl1.displayLocationNumbers)
        return tbl1
    end

    if #surfaceKeys == 0 then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.CodeError,
            { name = "SduiTemplateApi", message = "At least one surfaceKey is required" },
            "Unknown"
        )
    end

    return nil
end

local function getDisplayLocationValues(displayLocationNumbers): {string} -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = table.create(#displayLocationNumbers)
    for _, displayLocationNumber in displayLocationNumbers do
        table.insert(var1, tostring(displayLocationNumber))
    end
    return var1
end

local function buildCachedComponentMappings(displayLocationNumbers, surfaceKeysByDisplayLocation)
    local cachedComponentMappings = {}
    local sduiTemplateStore = getSduiTemplateStore()
    for _, displayLocation in displayLocationNumbers do
        local robloxComponentToTemplateId = ({})

        for _, value in surfaceKeysByDisplayLocation[DisplayLocation.fromNumber(displayLocation)] or {} do
            for value2, value3 in sduiTemplateStore.getCachedRobloxComponentToTemplateId(value) do
                robloxComponentToTemplateId[value2] = value3
            end
        end
        if next(robloxComponentToTemplateId) then
            table.insert(
                cachedComponentMappings,
                template_api_messages.DisplayLocationTemplateMapping.new(
                    {
                        display_location = displayLocation,
                        roblox_component_to_template_id = robloxComponentToTemplateId
                    }
                )
            )
        end
    end

    return cachedComponentMappings
end

local function buildPostConfig(tbl1, locale: string, tbl2)
    local clientCapabilities = ServiceContractsProto.apppageplatform.shared.client_capabilities.ClientCapabilities
    local platform = ServiceContractsProto.apppageplatform.shared.client_capabilities.Platform
    local getTemplatesRequest = template_api_messages.GetTemplatesRequest.new({
        display_locations = tbl1.displayLocationNumbers,
        client_capabilities = clientCapabilities.new({
            enabled_capabilities = SduiCapabilities.getEnabledCapabilityNumbers(tbl2),
            platform = platform.toNumber("PLATFORM_APP")
        }),
        cached_component_mappings = buildCachedComponentMappings(tbl1.displayLocationNumbers, tbl1.surfaceKeysByDisplayLocation),
        locale = locale
    })

    return {
        contentType = SduiApiStorePostConfig.SduiApiStorePostConfigContentType.Proto,
        protoMessage = template_api_messages.GetTemplatesRequest,
        body = getTemplatesRequest
    }
end

local function buildPostConfigWithRuntimeSupport(tbl1, locale: string, clientCapabilities)
    local getTemplatesRequest = template_api_messages.GetTemplatesRequest.new({
        display_locations = tbl1.displayLocationNumbers,
        client_capabilities = clientCapabilities,
        cached_component_mappings = buildCachedComponentMappings(tbl1.displayLocationNumbers, tbl1.surfaceKeysByDisplayLocation),
        locale = locale
    })

    return {
        contentType = SduiApiStorePostConfig.SduiApiStorePostConfigContentType.Proto,
        protoMessage = template_api_messages.GetTemplatesRequest,
        body = getTemplatesRequest
    }
end

local function getDisplayLocationName(displayLocation) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(displayLocation) ~= "number" then
        return displayLocation
    end

    local success, result = pcall(DisplayLocation.fromNumber, displayLocation)

    return if success then result else nil
end

local function extractTemplates(arg1)
    local result = ({})
    if arg1.templates then
        for value, value2 in arg1.templates do
            if value2.template then
                result[value] = value2.template
            end
        end
    end
    return result
end

return {
    createRequest = function(tbl1)
        local var1 = resolveSurfaceKeys(tbl1.surfaceKeys)
        if var1 == nil then
            return nil
        end
        local var2 = tbl1.locale or LocalizationService.RobloxLocaleId
        local var3 = tbl1.capabilities or SduiCapabilities.getEnabledCapabilities()
        if not FFlagSduiAdvertiseRuntimeSupportSets then
            local var4 = table.clone(var3)
            table.sort(var4)
            return {
                url = getTemplatesUrl(),
                cacheKey = `sdui-template-api:{table.concat(getDisplayLocationValues(var1.displayLocationNumbers), ",")}:{var2}:{table.concat(var4, ",")}`,
                postConfig = buildPostConfig(var1, var2, var3),
                responseProto = template_api_messages.GetTemplatesResponse,
                surfaceKeysByDisplayLocation = var1.surfaceKeysByDisplayLocation
            }
        end

        local var4 = table.clone(SduiCapabilities.getEnabledCapabilities())
        table.sort(var4)
        local clientCapabilities = SduiCapabilities.buildClientCapabilities()
        return {
            url = getTemplatesUrl(),
            cacheKey = `sdui-template-api:{table.concat(getDisplayLocationValues(var1.displayLocationNumbers), ",")}:{var2}:{table.concat(var4, ",")}`,
            postConfig = buildPostConfigWithRuntimeSupport(var1, var2, clientCapabilities),
            responseProto = template_api_messages.GetTemplatesResponse,
            surfaceKeysByDisplayLocation = var1.surfaceKeysByDisplayLocation
        }
    end,
    parseResponseForSurface = function(arg1, str1: string)
        local var1 = SduiSurfaceToDisplayLocation[str1]
        local tbl1 = extractTemplates(arg1)
        local tbl2 = {}
        if arg1.component_mappings then
            for _, componentMapping in arg1.component_mappings do
                if getDisplayLocationName(componentMapping.display_location) == var1 then
                    tbl2 = componentMapping.roblox_component_to_template_id
                    break
                end
            end
        end

        local tbl3 = ({})
        local sduiTemplateStore = getSduiTemplateStore()
        for value, value2 in tbl2 do
            local var2 = tbl1[value2] or sduiTemplateStore.getTemplate(value2)
            if var2 then
                tbl3[value] = var2
            end
        end
        return tbl1, tbl3, tbl2
    end,
    storeResponse = function(arg1, tbl1)
        local sduiTemplateStore = getSduiTemplateStore()
        sduiTemplateStore.addTemplates((extractTemplates(arg1)))
        if arg1.component_mappings then
            for _, componentMapping in arg1.component_mappings do
                local displayLocationName = getDisplayLocationName(componentMapping.display_location)
                if displayLocationName == nil then
                    local _, var1 = next(tbl1.surfaceKeysByDisplayLocation)
                    local var2 = if var1 then var1[1] else "Unknown"
                    SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToMapRobloxComponentToTemplate, {
                        name = tostring(componentMapping.display_location),
                        message = `Unknown DisplayLocation {componentMapping.display_location}`
                    }, var2)
                else
                    local var1 = tbl1.surfaceKeysByDisplayLocation[displayLocationName]
                    if var1 then
                        for _, value in var1 do
                            sduiTemplateStore.recordSurfaceTemplates(value, componentMapping.roblox_component_to_template_id)
                        end
                    end
                end
            end
        end

        sduiTemplateStore.addLocalizedLiterals(arg1.localized_literals or {})
        return arg1
    end
}
