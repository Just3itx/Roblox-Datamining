-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Cryo = require(SduiCoreSystemParent.Cryo)
local _Signals = require(SduiCoreSystemParent.Signals)
local _UnifiedLogging = require(SduiCoreSystemParent.UnifiedLogging)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local SduiLogger = require(SduiCoreSystem.SduiLogger)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)

local tbl1 = {}

local tbl2 = {
    __index = function(arg1, arg2)
        if arg2 == "analyticsData" then
            return arg1.getAnalyticsDataSnapshot()
        elseif arg2 == "ancestorAnalyticsData" then
            return arg1.getAncestorAnalyticsDataSnapshot()
        end
        return nil
    end
}

local function buildAnalyticsContextForClientBinding(arg1, tbl3, arg2, arg3)
    local currentComponentType = arg3.currentComponentType
    local currentParserName = arg3.currentParserName

    local var1 = nil

    local tbl4 = {
        getAnalyticsDataSnapshot = function()
            local var2 = table.clone(arg1 or tbl1)
            if tbl3 then
                xpcall(function()
                    for value, value2 in tbl3 do
                        var2[value] = value2(false).data
                    end
                end, function(message)
                    local tbl4 = {
                        message = message,
                        name = arg3.debugName,
                        componentType = currentComponentType,
                        parserName = currentParserName
                    }
                    if FFlagSduiErrorPaths then
                        addSduiErrorContextFields(tbl4, arg3.errorContext)
                    end
                    SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToComputeAnalyticsData, tbl4, arg3.appPage)
                end)
            end

            if var1 then
                return (Cryo.Dictionary.join(var2, var1))
            end

            return var2
        end,
        getAncestorAnalyticsDataSnapshot = function()
            if not arg2 then
                return tbl1
            end

            local var2 = arg2.ancestorAnalyticsData or tbl1
            local var3 = arg2.analyticsData or tbl1
            return Cryo.Dictionary.join(var2, var3)
        end,
        setLocalAnalyticsData = function(arg4)
            var1 = arg4
        end,
        getCollectionData = function()
            if arg2 and arg2.getCollectionData then
                return arg2.getCollectionData()
            end
            return nil
        end
    }
    setmetatable(tbl4, tbl2)
    return tbl4
end

return buildAnalyticsContextForClientBinding
