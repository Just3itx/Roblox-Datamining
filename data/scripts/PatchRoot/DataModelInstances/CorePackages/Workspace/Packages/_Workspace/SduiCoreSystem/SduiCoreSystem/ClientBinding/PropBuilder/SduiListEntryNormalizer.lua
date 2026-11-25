-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local FFlagSduiErrorPaths = require(SduiCoreSystem.Parent.SharedFlags).FFlagSduiErrorPaths

local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)

local function tryResolveTemplatePair(str1: string?, arg1, arg2) -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 ~= nil then
        return arg1, true, nil
    end
    if str1 and str1 ~= "" then
        local templateForRobloxComponent = arg2.getTemplateForRobloxComponent(str1)
        if templateForRobloxComponent then
            local bool1 = false

            if FFlagSduiErrorPaths then
                return templateForRobloxComponent, bool1, str1
            end

            return templateForRobloxComponent, bool1, nil
        end
    end
    return nil, false, nil
end

local function resolveItemOverrides(tbl1, arg1)
    if tbl1 == nil or next(tbl1) == nil then
        return nil
    end
    local result = ({})
    for value, value2 in tbl1 do
        local template, isInline, var2 = tryResolveTemplatePair(value2.roblox_component, value2.inline_component, arg1)
        local tbl2 = {
            template = template,
            isInline = isInline,
            robloxComponent = 0,
            inputs = 0,
            sortRankProp = 0
        }

        if not FFlagSduiErrorPaths then
            var2 = nil
        end

        tbl2.robloxComponent = var2
        tbl2.inputs = value2.inputs
        tbl2.sortRankProp = value2.sort_rank
        result[value] = tbl2
    end

    return result
end

local function pickTemplate(arg1, tbl1, arg2, bool1: boolean, str1: string?, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
    local robloxComponent = if typeof(arg1) == "table" then arg1.roblox_component else nil
    local inlineComponent = if typeof(arg1) == "table" then arg1.inline_component else nil
    local var1, bool2, var2 = tryResolveTemplatePair(robloxComponent, inlineComponent, arg3)

    if var1 then
        if FFlagSduiErrorPaths then
            return var1, bool2, var2
        end

        return var1, bool2, nil
    elseif tbl1 and tbl1.template then
        local template = tbl1.template
        local isInline = tbl1.isInline
        if FFlagSduiErrorPaths then
            return template, isInline, tbl1.robloxComponent
        end

        return template, isInline, nil
    elseif FFlagSduiErrorPaths then
        return arg2, bool1, str1
    else
        return arg2, bool1, nil
    end
end

local function resolveDefaultTemplate(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return nil, false, nil
    end
    return tryResolveTemplatePair(arg1.roblox_component, arg1.inline_component, arg2)
end

local function buildBoundEntry(arg1, identifier: string?, arg2, bool1: boolean, str1: string?, inputs, arg3, tbl2, arg4)
    local var1 = if tbl2 and identifier then tbl2[identifier] else nil
    local func1 = pickTemplate

    if not FFlagSduiErrorPaths then
        str1 = nil
    end

    local template, isInline, var4 = func1(arg1, var1, arg2, bool1, str1, arg4)
    local sortRank = if typeof(arg1) == "table" then arg1.sort_rank else nil
    local tbl3 = {
        item = arg1,
        identifier = identifier,
        sourceMode = "data",
        inputs = 0,
        template = 0,
        isInline = 0,
        robloxComponent = 0,
        sortRankProp = 0
    }
    if var1 then
        inputs = var1.inputs or inputs
    end

    tbl3.inputs = inputs
    tbl3.template = template
    tbl3.isInline = isInline
    if not FFlagSduiErrorPaths then
        var4 = nil
    end

    tbl3.robloxComponent = var4
    if sortRank then
        arg3 = sortRank
    elseif var1 then
        arg3 = var1.sortRankProp or arg3
    end

    tbl3.sortRankProp = arg3
    return tbl3
end

return {
    normalizeLiteralItems = function(tbl1, arg1, arg2)
        local inputs = if arg1 then arg1.inputs else nil
        local sortRank = if arg1 then arg1.sort_rank else nil
        local var1, bool1, var2 = resolveDefaultTemplate(arg1, arg2)
        local result = {}
        for _, value in tbl1 do
            local identifier = value.identifier
            if identifier == "" then
                identifier = nil
            end

            local template, isInline, var5 = pickTemplate(value, false, var1, bool1, if FFlagSduiErrorPaths then var2 else nil, arg2)
            local tbl2 = {
                item = value,
                identifier = identifier,
                sourceMode = "literal",
                inputs = value.inputs or inputs,
                template = template,
                isInline = isInline,
                robloxComponent = 0,
                sortRankProp = 0
            }

            if not FFlagSduiErrorPaths then
                var5 = nil
            end

            tbl2.robloxComponent = var5
            tbl2.sortRankProp = value.sort_rank or sortRank
            table.insert(result, tbl2)
        end

        return result
    end,
    normalizeBoundData = function(arg1, arg2, tbl1, arg3)
        if typeof(arg1) ~= "table" then
            return {}
        end

        local inputs = if arg2 then arg2.inputs else nil
        local sortRank = if arg2 then arg2.sort_rank else nil
        local var1, bool1, var2 = resolveDefaultTemplate(arg2, arg3)
        local var3 = resolveItemOverrides(tbl1, arg3)
        local result = {}

        if arg1[1] == nil and next(arg1) ~= nil then
            for value, value2 in arg1 do
                local func1 = buildBoundEntry

                local str1 = tostring(value)
                local var4 = if FFlagSduiErrorPaths then var2 else nil
                table.insert(result, (func1(value2, str1, var1, bool1, var4, inputs, sortRank, var3, arg3)))
            end

            return result
        end

        for _, value in arg1 do
            local identifier = if typeof(value) == "table" then value.identifier else nil

            if identifier == "" then
                identifier = nil
            end

            local func1 = buildBoundEntry
            local var4 = if FFlagSduiErrorPaths then var2 else nil
            table.insert(result, (func1(value, identifier, var1, bool1, var4, inputs, sortRank, var3, arg3)))
        end

        return result
    end
}
