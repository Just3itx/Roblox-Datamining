-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ExpChatParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint

local _createPresetChatStore = require(ExpChat.Stores.GetPresetChatStore.createPresetChatStore)
local Constants = require(ExpChat.PresetChat.Constants)

local SearchMode = { Substring = 0, WordStart = 1 }

local var1 = nil
local var2 = nil

local function flatten(categoryGroups)
    local values = {}
    local lowerValues = {}
    local presetIdByValue = ({})

    for _, categoryGroup in categoryGroups do
        for _, value in categoryGroup.categories do
            for _, value2 in if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then value.contents else value.messages do
                if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint and value2.kind == "Emoji" then
                    continue
                end

                local var3 = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then value2.text else value2.value

                if presetIdByValue[var3] == nil then
                    presetIdByValue[var3] = value2.presetId
                    table.insert(values, var3)
                    table.insert(lowerValues, string.lower(var3))
                end
            end
        end
    end

    return { values = values, lowerValues = lowerValues, presetIdByValue = presetIdByValue }
end

local function getCatalog(arg1)
    if not arg1.getIsEnabled(false) or arg1.getAccessLevel(false) ~= Constants.AccessLevel.Enabled then
        return nil
    end

    local categoryGroups = arg1.getCategoryGroups(false)
    if var2 == nil or var1 ~= categoryGroups then
        var1 = categoryGroups
        var2 = flatten(categoryGroups)
    end

    return var2
end

local function getRank(str1: string, str2: string)
    local var3 = string.find(str1, str2, 1, true)
    if var3 == nil then
        return nil
    elseif var3 == 1 then
        return 1
    end

    return if string.match(string.sub(str1, var3 - 1, var3 - 1), "%w") == nil then 2 else 3
end

local function getWordStartRank(str1: string, str2: string)
    local var3 = string.find(str1, str2, 1, true)
    while var3 ~= nil do
        if var3 == 1 then
            return 1
        end
        local match = string.match

        if match(string.sub(str1, var3 - 1, var3 - 1), "%w") == nil then
            return 2
        end
        var3 = string.find(str1, str2, var3 + 1, true)
    end

    return nil
end

return {
    MIN_QUERY_LENGTH = 2,
    SearchMode = SearchMode,
    findMatchingPresets = function(arg1, str1: string, tbl2)
        if (if tbl2 and tbl2.minQueryLength then tbl2.minQueryLength else 2) > (utf8.len(str1) or #str1) then
            return {}
        end

        local presetCooldownEndsAt = arg1.getPresetCooldownEndsAt(false)
        if presetCooldownEndsAt ~= nil and os.clock() < presetCooldownEndsAt then
            return {}
        end

        local catalog = getCatalog(arg1)
        if catalog == nil then
            return {}
        end

        local str2 = string.lower(str1)
        local func1 = if tbl2 and tbl2.mode == SearchMode.WordStart then getWordStartRank else getRank
        local tbl3 = {}
        for index, value2 in catalog.lowerValues do
            local rank = func1(value2, str2)
            if rank ~= nil then
                table.insert(tbl3, { rank = rank, index = index })
            end
        end

        table.sort(tbl3, function(arg2, arg3): boolean
            if arg2.rank == arg3.rank then
                return arg2.index < arg3.index
            end

            return arg2.rank < arg3.rank
        end)

        local var3 = table.create(#tbl3)
        for _, value in tbl3 do
            table.insert(var3, catalog.values[value.index])
        end

        return var3
    end,
    getPresetIdForValue = function(arg1, str1: string)
        local catalog = getCatalog(arg1)
        return if catalog == nil then nil else catalog.presetIdByValue[str1]
    end
}
