-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)

local HomeConstants = require(Home.HomeConstants)
local HomeSortDetailConstants = require(Home.HomeSortDetailPage.HomeSortDetailConstants)
local isHomeSortDetailSortIncluded = require(Home.HomeSortDetailPage.isHomeSortDetailSortIncluded)

local function readSortInputData(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if typeof(arg1) ~= "table" then
        return nil
    end
    local inputData = arg1.input_data
    local kind = if typeof(inputData) == "table" then inputData.kind else nil
    return if typeof(kind) == "table" and typeof(kind.value) == "table" then kind.value else nil
end

local function readSortInputDataType(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local inputData = if typeof(arg1) == "table" then arg1.input_data else nil
    local kind = if typeof(inputData) == "table" then inputData.kind else nil
    return if typeof(kind) == "table" and typeof(kind.type) == "string" then kind.type else nil
end

local function matchesSort(arg1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = readSortInputData(arg1)
    local var2 = if var1 then tostring(var1.sort_id) else nil
    return not (var2 == nil or var2 == "") and isHomeSortDetailSortIncluded(var2, readSortInputDataType(arg1)) and var2 == str1
end

local function findFeedEntry(entryOrder, entryMap, str1: string, num1: number?)
    if num1 ~= nil and num1 >= 1 and num1 % 1 == 0 then
        local var1 = entryOrder[num1]
        local var2 = if var1 == nil then nil else entryMap[var1]

        if matchesSort(var2, str1) then
            return var1, var2
        end
    end

    for _, value in entryOrder do
        local var1 = entryMap[value]

        if matchesSort(var1, str1) then
            return value, var1
        end
    end
    return nil
end

local function selectHomeSortDetailFeedEntry(homeInputData, str1: string, num1: number?)
    if typeof(homeInputData) ~= "table" then
        return nil
    end
    local entryOrder = homeInputData.entry_order
    local entryMap = homeInputData.entry_map
    if typeof(entryOrder) ~= "table" or typeof(entryMap) ~= "table" then
        return nil
    end

    local identifier, feedEntry = findFeedEntry(entryOrder, entryMap, str1, num1)
    if identifier == nil or feedEntry == nil then
        return nil
    end
    local robloxComponent = feedEntry.roblox_component
    if typeof(robloxComponent) ~= "string" or robloxComponent == "" then
        return nil
    end

    local inputData = readSortInputData(feedEntry)
    return if inputData == nil then nil else {
        identifier = identifier,
        feedEntry = feedEntry,
        inputData = inputData,
        contentPools = homeInputData.content_pools or {}
    }
end

local function buildVerticalFeedInputData(tbl1)
    local var1 = table.clone(tbl1.inputData)
    var1.entry_order = { HomeSortDetailConstants.DropDownIdentifier, tbl1.identifier }

    var1.entry_map = {
        [HomeSortDetailConstants.DropDownIdentifier] = {
            roblox_component = HomeSortDetailConstants.DropDownRobloxComponent
        },
        [tbl1.identifier] = tbl1.feedEntry
    }
    var1.content_pools = tbl1.contentPools
    return var1
end

local function getHomeInputData(sduiApiStore, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local inputData = sduiApiStore.getInputData(HomeConstants.ConfigKey, HomeConstants.ContentIdentifier, arg1)
    if inputData ~= nil then
        return inputData
    end
    return sduiApiStore.getInputData(HomeConstants.ConfigKey, nil, arg1)
end

local function buildHomeSortDetailPageEntry(str1: string, num1: number?)
    if str1 == "" then
        return nil
    end

    local sduiApiStore = SduiSharedUtilities.getSduiApiStore()
    return if selectHomeSortDetailFeedEntry(getHomeInputData(sduiApiStore, nil), str1, num1) == nil then nil else {
        robloxComponentType = HomeSortDetailConstants.RobloxComponent,
        identifier = HomeSortDetailConstants.Identifier,
        componentInputDataGetter = function(arg1)
            local var1 = selectHomeSortDetailFeedEntry(getHomeInputData(sduiApiStore, arg1), str1, num1)
            if var1 then
                return (buildVerticalFeedInputData(var1))
            end

            return {}
        end
    }
end

return buildHomeSortDetailPageEntry
