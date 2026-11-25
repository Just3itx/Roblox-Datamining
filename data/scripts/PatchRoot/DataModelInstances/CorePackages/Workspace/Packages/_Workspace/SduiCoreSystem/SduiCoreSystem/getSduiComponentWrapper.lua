-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local _React = require(SduiCoreSystemParent.React)

local SduiComponent = require(SduiCoreSystem.SduiComponent)
local SduiFastPathComponent = require(SduiCoreSystem.SduiFastPathComponent)
local createSduiClientBindingWrappers = require(SduiCoreSystem.ClientBinding.createSduiClientBindingWrappers)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)

local var1 = nil

local function func1(arg1)
    if arg1 and arg1.__isClientBinding then
        if arg1.propSignals or arg1.isComponentFilteredSignal ~= nil or arg1._requiresDataBinding == true then
            return var1.SduiDataBindingWrapper
        end

        return var1.SduiClientBindingThinWrapper
    end

    if arg1
        and arg1.__processed
        and arg1.conditionalProps == nil
        and arg1.children == nil
        and (arg1.templateKey == nil or arg1.templateKey == "NONE")
    then
        return SduiFastPathComponent
    end

    return SduiComponent
end

var1 = createSduiClientBindingWrappers(func1)

return func1
