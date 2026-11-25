-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local Signals = require(ServerDrivenUiParent.Signals)
local _SduiFeedStoreTypes = require(ServerDrivenUi.DataStore.SduiFeedStoreTypes)
local DiscoveryEventErrorLogger = require(ServerDrivenUiParent.DiscoveryUtils).DiscoveryEventErrorLogger
local FFlagLuaAppRfySignalApportioning = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppRfySignalApportioning
local bool1 = game:DefineFastFlag("LuaAppNilApportionedItems", false)

local FFlagLuaAppAddRequestIdToRfySignalApportioning = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddRequestIdToRfySignalApportioning

local num1 = game:DefineFastInt("SduiCreateSduiFeedStoreLogDelayMs", 1000) / 1000

local function createSduiFeedStore()
    local tbl1 = ({})

    local tbl2 = ({})

    local tbl3 = ({})

    local getTemplates, var2 = Signals.createSignal({})
    local getDataUpdatedTimestamp, var4 = Signals.createSignal(0)

    local getItemCollectionKeys, var6 = Signals.createSignal({})
    local var7 = var6

    local function createItemCollectionSignal(str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local get, set = Signals.createSignal(arg1)
        tbl1[str1] = { get = get, set = set }

        return tbl1[str1]
    end

    local function getItemCollection(str1: string, bool2: boolean?)
        local var8 = tbl1[str1]
        if var8 == nil then
            if bool2 then
                var8 = createItemCollectionSignal(str1, nil)
            else
                error(`createSduiFeedStore missing item collection for feedItemKey {str1}`)
            end
        end
        return var8.get
    end

    local function getFirstItemCollectionWithFilter(func1: (...any) -> (...any))
        for _, value in tbl1 do
            if func1(value.get(false)) then
                return value.get
            end
        end

        return nil
    end

    local function setItemCollections(itemCollections)
        for k, itemCollection in itemCollections do
            if tbl1[k] then
                tbl1[k].set(itemCollection)
            else
                createItemCollectionSignal(k, itemCollection)
            end
        end
    end

    local setApportioningData = nil
    local updateApportioningCapacity = nil
    local getSingleGridApportioningMetadata = nil
    local getApportionedItems

    if FFlagLuaAppRfySignalApportioning then
        local var8 = FFlagLuaAppAddRequestIdToRfySignalApportioning and function(str1: string, str2: string?): string
            return if str2 then str1 .. "_" .. str2 else str1
        end or nil

        local function createApportioningDataSignals(currentKey: string, tbl4, str1: string?)
            local var1 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(currentKey, str1) else currentKey
            local getItems, setItems = Signals.createSignal(tbl4.items)

            local getGridApportioningMetadata, setGridApportioningMetadata = Signals.createSignal(tbl4.gridApportioningMetadata)

            local get, set = Signals.createSignal({
                getItems = getItems,
                setItems = setItems,
                getGridApportioningMetadata = getGridApportioningMetadata,
                setGridApportioningMetadata = setGridApportioningMetadata,
                scheduledCapacityUpdates = {},
                isCapacityUpdateScheduled = false,
                capacityUpdateCoroutine = nil
            })
            tbl2[var1] = { get = get, set = set }

            if not FFlagLuaAppAddRequestIdToRfySignalApportioning then
                return
            end

            local previousKey = tbl3[currentKey] and tbl3[currentKey].previousKey
            local currentKey2 = tbl3[currentKey] and tbl3[currentKey].currentKey

            if previousKey then
                tbl2[previousKey] = nil
            end
            tbl3[currentKey] = { previousKey = currentKey2, currentKey = var1 }
        end

        local function func1(currentKey: string, str1: string?)
            local var9 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(currentKey, str1) else currentKey

            if not tbl2[var9] then
                local func2 = createApportioningDataSignals

                local tbl4 = {
                    items = {},
                    gridApportioningMetadata = {}
                }

                if not FFlagLuaAppAddRequestIdToRfySignalApportioning then
                    str1 = nil
                end

                func2(currentKey, tbl4, str1)
            end

            return tbl2[var9].get
        end

        setApportioningData = function(tbl4, str1: string?)
            for value, value2 in tbl4 do
                local var9 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(value, str1) else value

                if tbl2[var9] then
                    local var10 = tbl2[var9].get(false)

                    var10.setItems(value2.items)
                    var10.setGridApportioningMetadata(value2.gridApportioningMetadata)
                    var10.scheduledCapacityUpdates = {}
                    var10.isCapacityUpdateScheduled = false
                    if var10.capacityUpdateCoroutine then
                        task.cancel(var10.capacityUpdateCoroutine)
                        var10.capacityUpdateCoroutine = nil
                    end
                else
                    createApportioningDataSignals(value, value2, if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil)
                end
            end
        end

        local function updateGridApportioningMetadata(apportioningKey: string, str2: string?)
            local func2 = func1
            local var9 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then str2 else nil
            local var10 = func2(apportioningKey, var9)(false)

            local gridApportioningMetadata = var10.getGridApportioningMetadata(false)
            local scheduledCapacityUpdates = var10.scheduledCapacityUpdates

            if #gridApportioningMetadata == 0 then
                if FFlagLuaAppAddRequestIdToRfySignalApportioning then
                    apportioningKey = var8(apportioningKey, str2)
                end

                task.delay(num1, function()
                    local var11 = tbl2[apportioningKey].get(false)
                    if #(var11 and var11.getGridApportioningMetadata(false) or {}) == 0 then
                        DiscoveryEventErrorLogger.reportError(
                            "ApportioningEmptyGridMetadata",
                            `Apportioning grid metadata is empty for {apportioningKey} in updateGridApportioningMetadata`,
                            { apportioningKey = apportioningKey }
                        )
                    end
                end)

                return
            end

            local num2 = 1
            local tbl4 = {}
            for _, value in gridApportioningMetadata do
                local capacity = if scheduledCapacityUpdates[value.sortIndex] then scheduledCapacityUpdates[value.sortIndex] else value.capacity
                table.insert(tbl4, { sortIndex = value.sortIndex, startingItemIndex = num2, capacity = capacity })

                num2 += capacity
            end

            var10.setGridApportioningMetadata(tbl4)
        end

        updateApportioningCapacity = function(currentKey: string, num2: number, num3: number, str1: string?)
            local func2 = func1
            local var9 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil
            local var10 = func2(currentKey, var9)(false)

            var10.scheduledCapacityUpdates[num2] = num3

            if var10.isCapacityUpdateScheduled then
                return
            end

            var10.isCapacityUpdateScheduled = true
            var10.capacityUpdateCoroutine = task.defer(function()
                updateGridApportioningMetadata(currentKey, if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil)

                var10.scheduledCapacityUpdates = {}
                var10.isCapacityUpdateScheduled = false
                var10.capacityUpdateCoroutine = nil
            end)
        end

        getSingleGridApportioningMetadata = function(apportioningKey: string, sortIndex: number, str1: string?)
            return Signals.createComputed(function(arg1)
                local var9 = func1(apportioningKey, if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil)(arg1).getGridApportioningMetadata(
                    arg1
                )
                if #var9 ~= 0 then
                    for _, value in var9 do
                        if value.sortIndex == sortIndex then
                            return value
                        end
                    end

                    return nil
                end

                task.delay(num1, function()
                    local var1 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(apportioningKey, str1) else apportioningKey
                    local var11 = tbl2[var1].get(false)
                    if #(var11 and var11.getGridApportioningMetadata(false) or {}) == 0 then
                        DiscoveryEventErrorLogger.reportError(
                            "ApportioningEmptyGridMetadata",
                            `Apportioning grid metadata is empty for {var1} in getSingleGridApportioningMetadata`,
                            { apportioningKey = var1, sortIndex = sortIndex }
                        )
                    end
                end)

                return nil
            end)
        end

        getApportionedItems = function(apportioningKey: string, sortIndex: number, str1: string?)
            return Signals.createComputed(function(arg1)
                local var9 = func1(apportioningKey, if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil)(arg1)

                local items = var9.getItems(arg1)
                local var10 = getSingleGridApportioningMetadata(
                    apportioningKey,
                    sortIndex,
                    if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil
                )(
                    arg1
                )
                if #items == 0 and #var9.getGridApportioningMetadata(false) == 0 then
                    local var1 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(apportioningKey, str1) else apportioningKey

                    task.delay(num1, function()
                        local var12 = tbl2[var1].get(false)
                        local var13 = not var12 and {} or var12.getItems(false) or {}
                        local gridApportioningMetadata = var12 and var12.getGridApportioningMetadata(false) or {}

                        if #var13 == 0 and #gridApportioningMetadata == 0 then
                            DiscoveryEventErrorLogger.reportError(
                                "ApportioningEmptyData",
                                `All apportioning data is empty for {var1} in getApportionedItems`,
                                { apportioningKey = var1, sortIndex = sortIndex }
                            )
                        end
                    end)

                    return if bool1 then nil else {}
                end

                if var10 then
                    local startingItemIndex = var10.startingItemIndex
                    local num2 = math.min(startingItemIndex + var10.capacity - 1, #items)
                    local result = {}

                    for i = startingItemIndex, num2 do
                        table.insert(result, items[i])
                    end

                    return result
                end

                local var11 = nil

                task.delay(num1, function()
                    local var1 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var8(apportioningKey, str1) else apportioningKey
                    local func2 = getSingleGridApportioningMetadata
                    local str2 = apportioningKey
                    local num2 = sortIndex
                    local var13 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then str1 else nil

                    if func2(str2, num2, var13)(false) then
                        return
                    end
                    local var14 = tbl2[var1].get(false)

                    local tbl4 = {}

                    for _, value in var14 and var14.getGridApportioningMetadata(false) or {} do
                        table.insert(tbl4, value.sortIndex)
                    end
                    var11 = if #tbl4 > 0 then table.concat(tbl4, ",") else "none"

                    DiscoveryEventErrorLogger.reportError(
                        "ApportioningSortIndexNotFound",
                        `Sort index {sortIndex} not found in apportioning data for {var1}`,
                        {
                            apportioningKey = var1,
                            sortIndex = sortIndex,
                            availableSortIndices = var11
                        }
                    )
                end)

                return {}
            end)
        end
    else
        getApportionedItems = nil
    end

    local function updateData(arg1, str1: string?)
        if arg1.templates then
            var2(arg1.templates)
        end
        if arg1.dataUpdatedTimestamp then
            var4(arg1.dataUpdatedTimestamp)
        end
        if arg1.itemCollections then
            setItemCollections(arg1.itemCollections)
            local tbl4 = {}
            for k in arg1.itemCollections do
                table.insert(tbl4, k)
            end
            var7(tbl4)
        end
        if not FFlagLuaAppRfySignalApportioning or not arg1.apportioningData then
            return
        end

        local var8 = setApportioningData
        local apportioningData = arg1.apportioningData
        if not FFlagLuaAppAddRequestIdToRfySignalApportioning then
            str1 = nil
        end

        var8(apportioningData, str1)
    end

    local tbl4 = {
        getFirstItemCollectionWithFilter = getFirstItemCollectionWithFilter,
        getItemCollection = getItemCollection,
        getTemplates = getTemplates,
        getDataUpdatedTimestamp = getDataUpdatedTimestamp,
        getItemCollectionKeys = getItemCollectionKeys,
        updateApportioningCapacity = 0,
        getSingleGridApportioningMetadata = 0,
        getApportionedItems = 0,
        updateData = 0
    }

    if not FFlagLuaAppRfySignalApportioning then
        updateApportioningCapacity = nil
    end

    tbl4.updateApportioningCapacity = updateApportioningCapacity

    tbl4.getSingleGridApportioningMetadata = if FFlagLuaAppRfySignalApportioning then getSingleGridApportioningMetadata else nil

    if not FFlagLuaAppRfySignalApportioning then
        getApportionedItems = nil
    end

    tbl4.getApportionedItems = getApportionedItems
    tbl4.updateData = updateData
    return tbl4
end

return createSduiFeedStore
