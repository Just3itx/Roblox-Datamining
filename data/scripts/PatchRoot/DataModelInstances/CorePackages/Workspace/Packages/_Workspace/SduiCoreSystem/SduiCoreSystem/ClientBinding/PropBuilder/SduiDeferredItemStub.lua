-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local _Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiParseHelpers = require(SduiCoreSystem.SduiParseHelpers)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local buildConfigForComponent = SduiClientBindingBuilder.buildConfigForComponent

return {
    makeStub = function(arg1, arg2, arg3, arg4, arg5, tbl1, str1: string?, str2: string?)
        return (setmetatable({ isBlank = false }, {
            __index = function(arg6, str3: string)
                setmetatable(arg6, nil)

                local success, result = pcall(
                    buildConfigForComponent,
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    nil,
                    arg5,
                    arg6,
                    if FFlagSduiErrorPaths then str1 else nil,
                    if FFlagSduiErrorPaths then str2 else nil
                )

                if success then
                    return arg6[str3]
                end

                local tbl2 = {
                    message = `Failed to materialize deferred list item: {SduiParseHelpers.stringifyValue(result)}`,
                    name = tbl1.name,
                    componentType = tbl1.componentType,
                    parserName = tbl1.parserName
                }
                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl2, arg6.errorContext or tbl1.nodeContext)
                end
                SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToParseProp, tbl2, tbl1.appPage)

                return nil
            end
        }))
    end
}
