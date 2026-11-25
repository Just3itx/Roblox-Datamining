-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local buildRepeatedProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildRepeatedProp)
local buildTableProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildTableProp)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory

local function isArrayLike(array): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local arrayLen = #array
    return arrayLen > 0 and next(array, arrayLen) == nil
end

local function buildContainerProp(_, array, arg1, arg2, arg3, arg4)
    if next(array) == nil then
        return array, PropResultCategory.Literal
    end

    if isArrayLike(array) then
        return buildRepeatedProp("literal", { array = array }, arg1, arg2, arg3, arg4)
    end

    return buildTableProp("literal", array, arg1, arg2, arg3, arg4)
end

return buildContainerProp
