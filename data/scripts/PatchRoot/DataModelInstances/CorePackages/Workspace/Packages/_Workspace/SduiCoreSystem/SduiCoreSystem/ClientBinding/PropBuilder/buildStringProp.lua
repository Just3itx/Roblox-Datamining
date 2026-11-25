-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local _Signals = require(SduiCoreSystemParent.Signals)

local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local buildDefaultProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildDefaultProp)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)
local SduiClientBindingParsers = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiClientBindingParsers)

local function buildStringProp(str1: string, arg1, arg2, arg3, arg4, arg5, func1: ((...any) -> (...any))?)
    local var1 = func1 or SduiClientBindingParsers.parseToString
    if str1 ~= "translation" then
        if str1 == "format" then
            return SduiPropUtils.generateFormatStringPropValue(arg1, arg2, arg4, arg3, var1), PropResultCategory.PropSignal
        end
        local var2, var3 = buildDefaultProp(str1, arg1, arg2, arg3, arg4, arg5, var1, buildStringProp)

        return var2, var3
    end

    local var2 = arg4.resolveLocalizedLiteral(arg1, if FFlagSduiErrorPaths then arg4.errorContext else nil)

    if not var2 then
        return nil, PropResultCategory.Failed
    end

    if var1 then
        var2 = var1(var2)
    end

    return var2, PropResultCategory.Literal
end

return buildStringProp
