-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)

local buildDataBindingSourcesForTemplate = require(SduiCoreSystem.ClientBinding.buildDataBindingSourcesForTemplate)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local SduiClientBindingBuilder = require(SduiCoreSystem.ClientBinding.SduiClientBindingBuilder)
local _SduiListEntryNormalizer = require(SduiCoreSystem.ClientBinding.PropBuilder.SduiListEntryNormalizer)

local PropResultCategory = SduiClientBindingTypes.PropResultCategory

local tbl1 = {}

local function resolvePropToValue(arg1, arg2, arg3, arg4, arg5, arg6) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg1.kind == nil then
        return nil
    end
    local var1, var2 = SduiClientBindingBuilder.buildProp(arg1, arg2, arg3, arg4, arg5)

    if var2 ~= PropResultCategory.PropSignal or var1 == nil then
        return var1
    end

    local var3 = var1(arg6)
    return var3 and var3.data
end

local function resolveOrderedIdentifiers(arg1, arg2, arg3, arg4, arg5, arg6) -- Luacid: unused: defined but never referenced
    if arg1 == nil or arg1.kind == nil then
        return resolvePropToValue(nil, nil, nil, nil, nil, nil)
    end

    local var1, var2 = SduiClientBindingBuilder.buildProp(arg1, arg3, arg4, arg5, arg6)

    if var2 == PropResultCategory.PropSignal and var1 ~= nil then
        var1 = var1(arg2)
        if var1 then
            return var1.data
        end
    end

    return var1
end

local function resolveItemSortRank(sortRankProp, arg1, template, arg2, arg3, arg4)
    if sortRankProp == nil or sortRankProp.kind == nil then
        return nil
    end

    local kind = template and template.kind
    local value = kind and kind.value
    local data = value and value.shared and value.shared.data
    if typeof(arg1) ~= "table" then
        arg1 = tbl1
    end

    local dataBindingSourcesForTemplate = buildDataBindingSourcesForTemplate(arg1, data or tbl1)

    local success, result = pcall(resolvePropToValue, sortRankProp, function() -- name: sourcesGetter
        return dataBindingSourcesForTemplate
    end, function() -- name: itemInputGetter
        return arg1
    end, arg2, arg3, arg4)
    if not success then
        return nil
    end
    return tonumber(result)
end

local function compareEntryRank(arg1, arg2): boolean
    if arg1.rank == arg2.rank then
        return arg1.originalIndex < arg2.originalIndex
    end

    if arg1.rank == nil then
        return false
    end

    if arg2.rank == nil then
        return true
    end

    return arg1.rank < arg2.rank
end

return {
    applyOrder = function(tbl2, arg1, arg2, arg3, arg4, arg5, arg6)
        local var1 = resolvePropToValue(arg1, arg3, arg4, arg5, arg6, arg2)

        if var1 then
            local tbl3 = {}
            for _, value in tbl2 do
                if value.identifier then
                    tbl3[value.identifier] = value
                end
            end
            tbl2 = {}
            for _, value in var1 do
                if tbl3[value] then
                    table.insert(tbl2, tbl3[value])
                end
            end
        end

        local bool1 = false
        for _, value in tbl2 do
            if value.sortRankProp ~= nil then
                bool1 = true
                break
            end
        end

        if not bool1 then
            return tbl2
        end

        local tbl3 = ({})
        for value, value2 in tbl2 do
            if value2.template then
                tbl3[value] = resolveItemSortRank(value2.sortRankProp, value2.item, value2.template, arg5, arg6, arg2)
            end
        end

        local tbl4 = {}
        for originalIndex, entry in tbl2 do
            table.insert(tbl4, { entry = entry, rank = tbl3[originalIndex], originalIndex = originalIndex })
        end
        table.sort(tbl4, compareEntryRank)

        local result = {}
        for _, value in tbl4 do
            table.insert(result, value.entry)
        end
        return result
    end
}
