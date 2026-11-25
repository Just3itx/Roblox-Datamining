-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)

local getPropBuilder = require(SduiCoreSystem.ClientBinding.PropBuilder.getPropBuilder)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local FFlagSduiSharedLocalizedLiterals = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSharedLocalizedLiterals
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths

local function getLocalizedLiteralResolver(localizedLiterals, appPage: string, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl1, arg1)
        if typeof(tbl1) ~= "table" or not tbl1.map_key then
            local tbl2 = {
                message = `Invalid translationRef: expected table with map_key, got {typeof(tbl1)}`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg1)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToResolveLocalizedLiteral, tbl2, appPage)
            return nil
        end
        local mapKey = tbl1.map_key
        local var1 = if FFlagSduiSharedLocalizedLiterals then func1(mapKey) else localizedLiterals and localizedLiterals[mapKey]

        if var1 == nil then
            local tbl2 = {
                message = `Could not find localized literal for mapKey: {tostring(mapKey)}, namespace: {tbl1.namespace}, key: {tbl1.key}`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl2, arg1)
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToResolveLocalizedLiteral, tbl2, appPage)
        end
        return var1
    end
end

local function createBuilderConfig(tbl1)
    local tbl2 = {
        appPage = tbl1.appPage,
        debugName = tbl1.debugName,
        getTemplateForRobloxComponent = tbl1.getTemplateForRobloxComponent,
        getTemplateIdForRCT = if FFlagSduiErrorPaths then tbl1.getTemplateIdForRCT else nil,
        getPropBuilder = getPropBuilder,
        resolveLocalizedLiteral = 0,
        configKey = 0
    }
    local localizedLiterals = tbl1.localizedLiterals
    local appPage = tbl1.appPage
    local getLocalizedLiteral = if FFlagSduiSharedLocalizedLiterals then tbl1.getLocalizedLiteral else nil
    tbl2.resolveLocalizedLiteral = getLocalizedLiteralResolver(localizedLiterals, appPage, getLocalizedLiteral)

    tbl2.configKey = tbl1.configKey
    return tbl2
end

return createBuilderConfig
