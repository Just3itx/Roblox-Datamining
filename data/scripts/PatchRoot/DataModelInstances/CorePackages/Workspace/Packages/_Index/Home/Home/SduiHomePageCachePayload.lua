-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HomeParent = script:FindFirstAncestor("Home").Parent

local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local HomeOmniFeedCache = require(HomeParent.DiscoveryUtils).HomeOmniFeedCache
local getSduiTemplateStore = require(HomeParent.SduiSharedUtilities).getSduiTemplateStore

local FFlagSduiUniverseItemConnectionsPlayed = require(HomeParent.SharedFlags).FFlagSduiUniverseItemConnectionsPlayed

local tbl1 = {
    universe = { "player_count" }
}

local var1 = FFlagSduiUniverseItemConnectionsPlayed
    and { "connection_played_display_name", "connection_played_num_others", "connection_played_total_count" }
    or nil

local function cloneMessage(arg1) -- Luacid: Inlined by compiler; 17 call sites recovered
    return table.clone(arg1)
end

local function readInputValue(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    local kind = if arg1 == nil then nil else arg1.kind
    return if kind == nil then nil else kind.value
end

local function replaceInputValue(inputData, value) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = cloneMessage(inputData)

    var2.kind = {
        type = inputData.kind.type,
        value = value
    }
    return var2
end

local function isFeed(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "table" and type(arg1.entry_map) == "table"
end

local function itemListFields(tbl2)
    local result = {}
    for value, value2 in tbl2 do
        if type(value2) == "table" and #value2 > 0 and type(value2[1]) == "table" then
            table.insert(result, value)
        end
    end
    table.sort(result)
    return result
end

local function readPoolId(tbl2): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    local poolId = tbl2.pool_id
    return if type(poolId) == "string" and poolId ~= "" then poolId else nil
end

local function hasViewerScopedItemField(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    for _, value in var1 do
        if arg1[value] ~= nil then
            return true
        end
    end
    return false
end

local function clearViewerFields(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not hasViewerScopedItemField(arg1) then
        return arg1
    end

    local var2 = cloneMessage(arg1)

    for _, value in var1 do
        var2[value] = nil
    end
    return var2
end

local function clearItemViewerFields(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end
    local kind = arg1.kind
    if type(kind) ~= "table" or type(kind.value) ~= "table" then
        return clearViewerFields(arg1)
    end

    local value = clearViewerFields(kind.value)
    if value == kind.value then
        return arg1
    end

    local var3 = cloneMessage(arg1)

    var3.kind = {
        type = kind.type,
        value = value
    }
    return var3
end

local function takeItems(tbl2, num1: number)
    local result = ({})
    if tbl2 == nil then
        return result
    end
    local num2 = #tbl2

    for i = 1, math.min(num2, num1) do
        local var2 = if FFlagSduiUniverseItemConnectionsPlayed then clearItemViewerFields(tbl2[i]) else tbl2[i]
        result[i] = var2
    end

    return result
end

local function readSortId(str1: string, arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local sortId = arg1.sort_id
    if sortId ~= nil and sortId ~= "" then
        return tostring(sortId)
    end

    warn(`Home SDUI cache entry "{str1}" has no sort_id; using its identifier`)
    return str1
end

local function collectReferencedKeys(arg1, tbl2)
    local str1 = type(arg1)
    if str1 == "table" then
        for _, value in arg1 do
            collectReferencedKeys(value, tbl2)
        end

        return
    end
    if str1 == "string" or str1 == "number" then
        tbl2[tostring(arg1)] = true
    end
end

local function filterOrder(tbl2, tbl3)
    local result = {}
    if tbl2 == nil then
        return result
    end
    for _, value in tbl2 do
        if tbl3[value] ~= nil then
            table.insert(result, value)
        end
    end
    return result
end

local function filterOrderMap(entryOrderMap, tbl2)
    local result = ({})
    if entryOrderMap == nil then
        return result
    end
    for value, value2 in entryOrderMap do
        local items = filterOrder(value2.items, tbl2)
        if #items > 0 then
            local var2 = cloneMessage(value2)

            var2.items = items
            result[value] = var2
        end
    end
    return result
end

local function pruneFeed(arg1, topicIdToNumCacheItems)
    local entryMap = ({})
    local contentPools = ({})

    local tbl4 = {}
    local tbl5 = ({})
    if arg1.entry_order ~= nil then
        for _, value in arg1.entry_order do
            if tbl5[value] then
                continue
            end

            tbl5[value] = true
            table.insert(tbl4, value)
        end
    end

    local tbl6 = {}
    for value in arg1.entry_map do
        if tbl5[value] then
            continue
        end

        tbl5[value] = true
        table.insert(tbl6, value)
    end

    table.sort(tbl6)
    for _, value in tbl6 do
        table.insert(tbl4, value)
    end

    for _, value in tbl4 do
        local var2 = arg1.entry_map[value]
        if var2 == nil then
            continue
        end

        local var3 = readInputValue(var2.input_data)
        if type(var3) ~= "table" then
            continue
        end

        local var4 = readPoolId(var3)
        local tbl7 = itemListFields(var3)

        if var4 == nil and #tbl7 == 0 then
            continue
        end

        local topicIdToNumCacheItem = topicIdToNumCacheItems[readSortId(value, var3)]

        if topicIdToNumCacheItem == nil then
            continue
        end

        local var5 = cloneMessage(var3)

        if var4 == nil then
            for _, value2 in tbl7 do
                local tbl8 = takeItems(var3[value2], math.max(topicIdToNumCacheItem.cap - topicIdToNumCacheItem.count, 0))
                topicIdToNumCacheItem.count += #tbl8
                var5[value2] = tbl8
            end
        else
            local var6 = (arg1.content_pools or {})[var4]
            if var6 == nil then
                continue
            end

            if contentPools[var4] == nil then
                local var7 = cloneMessage(var6)

                var7.items = takeItems(var6.items, math.max(topicIdToNumCacheItem.cap - topicIdToNumCacheItem.count, 0))
                topicIdToNumCacheItem.count += #var7.items
                contentPools[var4] = var7
            end
        end

        local var6 = cloneMessage(var2)
        local inputData = replaceInputValue(var2.input_data, var5)
        var6.input_data = inputData
        entryMap[value] = var6
    end

    if next(entryMap) == nil then
        return nil
    end

    local var2 = cloneMessage(arg1)

    var2.entry_map = entryMap

    if arg1.content_pools ~= nil then
        var2.content_pools = contentPools
    end
    if arg1.entry_order ~= nil then
        var2.entry_order = filterOrder(arg1.entry_order, entryMap)
    end
    if arg1.entry_order_map ~= nil then
        var2.entry_order_map = filterOrderMap(arg1.entry_order_map, entryMap)
    end
    return var2
end

local function pruneHydration(hydrationData, tbl2)
    if hydrationData == nil then
        return nil
    end

    local var2 = cloneMessage(hydrationData)

    for value, value2 in hydrationData do
        if type(value2) ~= "table" then
            continue
        end

        local var3 = tbl1[value]
        local tbl3 = ({})
        for value3, value4 in value2 do
            if type(value4) ~= "table" or not tbl2[tostring(value3)] then
                continue
            end

            local var4 = cloneMessage(value4)

            if var3 ~= nil then
                for _, value5 in var3 do
                    var4[value5] = nil
                end
            end
            tbl3[value3] = var4
        end

        var2[value] = tbl3
    end
    return var2
end

local function fillMissingTemplatesFromStore(arg1)
    local sduiTemplateStore = getSduiTemplateStore()
    local cachedRobloxComponentToTemplateId = sduiTemplateStore.getCachedRobloxComponentToTemplateId(AppPage.Home)
    if next(cachedRobloxComponentToTemplateId) == nil then
        return
    end

    local templates = cloneMessage(arg1.templates or {})
    local templateEntry = require(HomeParent.ServiceContractsProto).apppageplatform.shared.template_entry.TemplateEntry

    for robloxComponent, value2 in cachedRobloxComponentToTemplateId do
        if templates[value2] ~= nil then
            continue
        end

        local template = sduiTemplateStore.getTemplate(value2)
        if template ~= nil then
            templates[value2] = templateEntry.new({ template = template, roblox_component = robloxComponent })
        end
    end

    arg1.templates = templates
end

local function deserializeSduiHomePageCache(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == nil then
        return nil
    end

    local serviceContractsProto = require(HomeParent.ServiceContractsProto)
    local var2 = serviceContractsProto.proto.json.deserializeBuffer(str1)
    return serviceContractsProto.apppageplatform.home.home_page.HomePageResponse.decode(var2)
end

return {
    buildSduiHomePageCachePayload = function(arg1)
        local topicIdToNumCacheItems = HomeOmniFeedCache.getTopicIdToNumCacheItems()
        local tbl2 = {}
        local pageEntries = {}

        for _, value in arg1.page_entries or {} do
            local var2 = readInputValue(value.input_data)

            if not isFeed(var2) then
                continue
            end

            local var3 = pruneFeed(var2, topicIdToNumCacheItems)
            if var3 == nil then
                continue
            end

            local var4 = cloneMessage(value)
            local inputData = replaceInputValue(value.input_data, var3)
            var4.input_data = inputData
            table.insert(pageEntries, var4)
            collectReferencedKeys(var4, tbl2)
        end

        if #pageEntries == 0 then
            return nil
        end

        local var2 = cloneMessage(arg1)

        var2.page_entries = pageEntries
        var2.hydration_data = pruneHydration(arg1.hydration_data, tbl2)

        var2.request_id = ""
        fillMissingTemplatesFromStore(var2)
        return var2
    end,
    serializeSduiHomePageCache = function(arg1)
        return require(HomeParent.ServiceContractsProto).proto.json.serializeBuffer(arg1:encode())
    end,
    deserializeSduiHomePageCache = deserializeSduiHomePageCache,
    getSduiHomePageItemsForSortId = function(str1: string)
        local var2 = deserializeSduiHomePageCache((HomeOmniFeedCache.getCachedSduiHomePageData()))
        if var2 == nil then
            return nil
        end

        for _, value in var2.page_entries do
            local var3 = readInputValue(value.input_data)

            if not isFeed(var3) then
                continue
            end

            for value2, value3 in var3.entry_map do
                local var4 = readInputValue(value3.input_data)
                if type(var4) ~= "table" then
                    continue
                end

                local var5 = readPoolId(var4)
                local tbl2 = itemListFields(var4)

                if var5 == nil and #tbl2 == 0 or readSortId(value2, var4) ~= str1 then
                    continue
                end

                if var5 == nil then
                    return var4[tbl2[1]]
                end

                local sduiHomePageItemsForSortId = {}
                for _, value4 in ((var3.content_pools or {})[var5] or {}).items or {} do
                    local var6 = readInputValue(value4)

                    if var6 ~= nil then
                        table.insert(sduiHomePageItemsForSortId, var6)
                    end
                end
                return sduiHomePageItemsForSortId
            end
        end

        return nil
    end
}
