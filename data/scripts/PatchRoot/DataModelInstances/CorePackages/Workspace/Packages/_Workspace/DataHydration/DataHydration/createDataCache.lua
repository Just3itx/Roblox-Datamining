-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Cryo = require(DataHydrationParent.Cryo)
local Signals = require(DataHydrationParent.Signals)
local SignalsExperimental = require(DataHydrationParent.SignalsExperimental)

local DataStatus = require(DataHydration.DataHydrationTypes).DataStatus
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)
local getLocalPlayerUserId = DataHydrationUtils.getLocalPlayerUserId
local observeLocalPlayerUserId = DataHydrationUtils.observeLocalPlayerUserId
local SharedFlags = require(DataHydrationParent.SharedFlags)
local FFlagDataHydrationAccountReset = SharedFlags.FFlagDataHydrationAccountReset
local FFlagDataHydrationStaleTime = SharedFlags.FFlagDataHydrationStaleTime
local FFlagSduiReleaseSearchResultsPageState = SharedFlags.FFlagSduiReleaseSearchResultsPageState

local FFlagDataHydrationPreserveIncompleteCatalogResults = require(DataHydration.Flags.FFlagDataHydrationPreserveIncompleteCatalogResults)

local num1 = game:DefineFastInt("LuaAppDefaultDataTtlSec", 3600)

local num2 = game:DefineFastInt("LuaAppDefaultFailedDataTtlSec", 60)

local function createDataCache(num3: number?, num4: number?, arg1)
    local num5 = num3 or num1
    local num6 = num4 or num2
    local sanitizeItem = if arg1 then arg1.sanitizeItem else nil
    local ttlSecondsForItem = if FFlagDataHydrationPreserveIncompleteCatalogResults and arg1 then arg1.ttlSecondsForItem else nil
    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})

    local tbl5 = ({})

    local function expiryFor(arg2, num7: number) -- Luacid: Inlined by compiler; 4 call sites recovered
        if ttlSecondsForItem then
            return os.clock() + (ttlSecondsForItem(arg2) or num5)
        end

        return num7
    end

    local function getOrCreateSignals(str1: string)
        if tbl1[str1] == nil or tbl2[str1] == nil then
            tbl1[str1] = {}
            local var1 = tbl1[str1]
            local tbl6 = tbl2
            local var2, var3 = Signals.createSignal(nil)
            var1.data = var2
            tbl6[str1] = var3
            local var4 = tbl1[str1]
            local tbl7 = tbl3
            local status, var6 = Signals.createSignal(DataStatus.NotReady)
            var4.status = status
            tbl7[str1] = var6
        end
        return tbl1[str1], tbl2[str1]
    end

    local function getItem(str1: string, func1: ((...any) -> (...any))?, num7: number?)
        local orCreateSignals = getOrCreateSignals(str1)

        if FFlagDataHydrationStaleTime and num7 ~= nil then
            local var1 = orCreateSignals.data(false)
            if orCreateSignals.status(false) ~= DataStatus.Failed then
                local var2 = tbl5[str1]
                local bool1 = not (var1 == nil or var2 == nil) and os.clock() - var2 < num7

                if bool1 and func1 then
                    return orCreateSignals, func1(var1)
                end
                return orCreateSignals, not bool1
            end
        end

        local bool1 = true
        if tbl4[str1] and os.clock() < tbl4[str1] then
            local var1 = orCreateSignals.data(false)
            local var2 = orCreateSignals.status(false)
            if var1 ~= nil or var2 == DataStatus.Failed then
                if func1 then
                    return orCreateSignals, (func1(var1))
                end

                bool1 = false
            end
        end

        return orCreateSignals, bool1
    end

    local function getItems(tbl6, func1: ((...any) -> (...any))?, num7: number?)
        local tbl7 = ({})
        local tbl8 = ({})
        if not tbl6 then
            return tbl7, tbl8
        end

        for _, value in tbl6 do
            local var1, var2 = getItem(value, func1, num7)
            tbl7[value] = var1
            tbl8[value] = var2
        end

        return tbl7, tbl8
    end

    local function replaceItems(tbl6)
        local now = os.clock()
        local num7 = now + num5
        SignalsExperimental.batch(function() -- name: batchUpdate
            for value, value2 in tbl6 do
                local _, var1 = getOrCreateSignals(value)
                var1(if sanitizeItem then sanitizeItem(value2) else value2)
                tbl3[value](DataStatus.Ready)
                tbl4[value] = expiryFor(value2, num7)
                if FFlagDataHydrationStaleTime then
                    tbl5[value] = now
                end
            end
        end)
    end

    local function updateItems(tbl6, bool1: boolean?)
        local now = os.clock()
        local num7 = now + num5
        SignalsExperimental.batch(function() -- name: batchUpdate
            for value, value2 in tbl6 do
                local var1, var2 = getOrCreateSignals(value)
                local var3 = var1.data(false)
                if var3 and type(var3) == "table" and type(value2) == "table" then
                    value2 = Cryo.Dictionary.join(var3, value2)
                end
                var2(if sanitizeItem then sanitizeItem(value2) else value2)

                tbl3[value](DataStatus.Ready)
                if bool1 == false then
                    continue
                end

                tbl4[value] = expiryFor(value2, num7)
                if FFlagDataHydrationStaleTime then
                    tbl5[value] = now
                end
            end
        end)
    end

    local function updateItem(str1: string, arg2, bool1: boolean?)
        local var1, var2 = getOrCreateSignals(str1)
        local var3 = var1.data(false)
        if var3 and type(var3) == "table" and type(arg2) == "table" then
            arg2 = Cryo.Dictionary.join(var3, arg2)
        end
        var2(if sanitizeItem then sanitizeItem(arg2) else arg2)

        tbl3[str1](DataStatus.Ready)
        if bool1 == false then
            return
        end

        tbl4[str1] = expiryFor(arg2, os.clock() + num5)
        if FFlagDataHydrationStaleTime then
            tbl5[str1] = os.clock()
        end
    end

    local function replaceItem(str1: string, arg2)
        local _, var1 = getOrCreateSignals(str1)
        var1(if sanitizeItem then sanitizeItem(arg2) else arg2)

        tbl3[str1](DataStatus.Ready)
        tbl4[str1] = expiryFor(arg2, os.clock() + num5)
        if FFlagDataHydrationStaleTime then
            tbl5[str1] = os.clock()
        end
    end

    local function resetFailedItem(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl1[str1]
        if var1 and var1.status(false) == DataStatus.Failed then
            tbl3[str1](DataStatus.NotReady)
        end
    end

    local function resetFailedItems(tbl6)
        for _, value in tbl6 do
            resetFailedItem(value)
        end
    end

    local function markItemsAsFailed(tbl6)
        local num7 = os.clock() + num6
        SignalsExperimental.batch(function() -- name: batchUpdate
            for _, value in tbl6 do
                if tbl3[value] then
                    tbl3[value](DataStatus.Failed)
                end
                tbl4[value] = num7
            end
        end)
    end

    local function releaseEntries()
        tbl4 = {}
        if FFlagDataHydrationStaleTime then
            tbl5 = {}
        end
        tbl1 = {}
        tbl2 = {}
        tbl3 = {}
    end

    local function removeItem(str1: string)
        tbl1[str1] = nil
        tbl2[str1] = nil
        tbl3[str1] = nil
        tbl4[str1] = nil
        tbl5[str1] = nil
    end

    local function invalidateEntries() -- Luacid: Inlined by compiler; 4 call sites recovered
        SignalsExperimental.batch(function()
            table.clear(tbl4)
            if FFlagDataHydrationStaleTime then
                table.clear(tbl5)
            end
            for value in tbl1 do
                tbl2[value](nil)
                tbl3[value](DataStatus.NotReady)
            end
        end)
    end

    local function clear() -- Luacid: Inlined by compiler; 3 call sites recovered
        if FFlagDataHydrationAccountReset then
            invalidateEntries()
            return
        end

        releaseEntries()
    end

    local localPlayerUserId = getLocalPlayerUserId()
    local connection = nil
    local var1 = nil
    if FFlagDataHydrationAccountReset then
        if not arg1 or arg1.observeLocalUser == nil or arg1.observeLocalUser then
            var1 = observeLocalPlayerUserId(function(arg2)
                localPlayerUserId = arg2
                clear()
            end)
        end
    else
        connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
            local localPlayerUserId2 = getLocalPlayerUserId()
            if localPlayerUserId2 ~= localPlayerUserId then
                localPlayerUserId = localPlayerUserId2
                clear()
            end
        end)
    end

    local function dispose()
        if FFlagDataHydrationAccountReset then
            if var1 then
                var1()
                var1 = nil
            end
            releaseEntries()
            return
        end
        if connection then
            connection:Disconnect()
            connection = nil
        end

        clear()
    end

    local tbl6 = {
        getItem = getItem,
        getItems = getItems,
        updateItems = updateItems,
        updateItem = updateItem,
        replaceItems = replaceItems,
        replaceItem = replaceItem,
        markItemsAsFailed = markItemsAsFailed,
        resetFailedItem = resetFailedItem,
        resetFailedItems = resetFailedItems,
        removeItem = 0,
        clear = 0,
        dispose = 0
    }

    if not FFlagSduiReleaseSearchResultsPageState then
        removeItem = nil
    end

    tbl6.removeItem = removeItem
    tbl6.clear = clear
    tbl6.dispose = dispose
    return tbl6
end

return createDataCache
