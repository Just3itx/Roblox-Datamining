-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)

local function buildTableProp(str1: string, arg1, arg2, arg3, arg4, arg5, func1: ((...any) -> (...any))?)
    if str1 == "literal" then
        return SduiPropUtils.generateTablePropSignalValue(arg1, arg2, arg4, arg5, arg3, SduiClientBindingBuilder.buildPropTable, func1), PropResultCategory.PropSignal
    elseif str1 == "binding_path" then
        return SduiPropUtils.generateDynamicBindingPropValue(arg1, arg2, arg4, arg3, function(tbl1, arg6) -- name: evaluatePropTable
            local var1, var2, var3 = SduiClientBindingBuilder.buildPropTable(tbl1, arg2, arg3, arg4, arg5)

            return SduiPropUtils.resolveTablePropValue(
                arg6,
                var1,
                var2,
                var3,
                arg2,
                arg4,
                arg5,
                arg3,
                SduiClientBindingBuilder.buildPropTable
            )
        end), PropResultCategory.PropSignal
    elseif str1 == "conditional" then
        return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, buildTableProp, func1), PropResultCategory.PropSignal
    end
    return nil, PropResultCategory.Failed
end

return buildTableProp
