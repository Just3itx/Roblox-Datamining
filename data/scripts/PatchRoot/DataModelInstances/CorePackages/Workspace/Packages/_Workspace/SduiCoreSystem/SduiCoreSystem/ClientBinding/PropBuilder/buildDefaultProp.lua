-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory
local SduiPropUtils = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiPropUtils)

local function buildDefaultProp(str1: string, arg1, arg2, arg3, arg4, arg5, func1: ((...any) -> (...any))?, arg6)
    if str1 == "literal" then
        return SduiPropUtils.generateStaticPropValue(arg1, func1), PropResultCategory.Literal
    elseif str1 == "token" then
        return SduiPropUtils.generateTokenBindingPropValue(arg1, arg4, func1), PropResultCategory.PropSignal
    elseif str1 == "binding_path" then
        return SduiPropUtils.generateDynamicBindingPropValue(arg1, arg2, arg4, arg3, func1), PropResultCategory.PropSignal
    elseif str1 == "conditional" then
        return SduiPropUtils.generateConditionalPropValue(arg1, arg2, arg4, arg5, arg3, arg6 or buildDefaultProp, func1), PropResultCategory.PropSignal
    end
    return nil, PropResultCategory.Failed
end

return buildDefaultProp
