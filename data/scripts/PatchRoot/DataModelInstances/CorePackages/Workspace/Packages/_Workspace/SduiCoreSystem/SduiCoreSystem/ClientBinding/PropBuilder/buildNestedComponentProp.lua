-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
local Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local buildConfigForComponent = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder).buildConfigForComponent
local buildInputsForNestedComponent = require(SduiCoreSystem.ClientBinding.PropBuilder.buildInputsForNestedComponent)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local function buildNestedComponentProp(str1: string, arg1, arg2, arg3, arg4, arg5, bool1: boolean?)
    local currentComponentType = arg4.currentComponentType
    local currentParserName = arg4.currentParserName

    if str1 ~= "literal" then
        if str1 == "conditional" then
            return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, buildNestedComponentProp, nil, not bool1), PropResultCategory.PropSignal
        end
        error(`Could not build prop. Unknown propDefinitionType: {str1}`)

        return
    end

    local var1 = SduiPropUtils.resolveTemplateFromData(arg1, arg4)
    local configForComponent

    if arg1.inline_component ~= nil then
        configForComponent = buildConfigForComponent(var1, arg3, arg4, arg5, nil, arg2)
    else
        local computed = Signals.createComputed(function(arg6)
            local result = {}
            local success, result2 = pcall(function()
                buildInputsForNestedComponent(arg3, arg1.inputs, arg2, arg6, result, arg4)
            end)

            if not success then
                local tbl1 = {
                    message = `Failed to build inputs for nested component: {SduiParseHelpers.stringifyValue(result2)}`,
                    name = arg4.debugName,
                    componentType = currentComponentType,
                    parserName = currentParserName
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl1, arg4.errorContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl1, arg4.appPage)
            end

            return result
        end)
        local var2 = buildConfigForComponent

        local var3 = nil
        local var4 = nil
        local var5 = nil
        local robloxComponent = if FFlagSduiErrorPaths then arg1.roblox_component else nil
        configForComponent = var2(var1, computed, arg4, arg5, var3, var4, var5, robloxComponent)
    end

    if bool1 then
        return configForComponent, PropResultCategory.Literal
    end

    return configForComponent, PropResultCategory.NestedComponentConfig
end
return buildNestedComponentProp
