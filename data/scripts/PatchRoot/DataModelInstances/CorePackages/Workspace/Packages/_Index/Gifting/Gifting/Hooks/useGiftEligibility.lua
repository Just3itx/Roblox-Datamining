-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local DataHydration = require(GiftingParent.DataHydration)
local React = require(GiftingParent.React)
local Signals = require(GiftingParent.Signals)
local SignalsReact = require(GiftingParent.SignalsReact)

local DataStatus = DataHydration.DataStatus

local _CanGiftResponseModel = require(Gifting.Models.CanGiftResponseModel)
local _createCanGiftStore = require(Gifting.Stores.createCanGiftStore)
local getCanGiftStore = require(Gifting.Stores.getCanGiftStore)
local GiftEligibility = require(Gifting.Enums.GiftEligibility)
local itemGiftabilityCacheKey = require(Gifting.Stores.itemGiftabilityCacheKey)
local _Types = require(Gifting.Types)

local buildItemGiftabilityKey = itemGiftabilityCacheKey.buildItemGiftabilityKey

local tbl1 = {}

local function buildItemsSignature(current)
    if current == nil or #current == 0 then
        return nil
    end

    local tbl2 = {}
    for _, value in current do
        table.insert(tbl2, buildItemGiftabilityKey(value))
    end
    return table.concat(tbl2, ",")
end

local function createEligibilitySignal(arg1, current)
    local bool1 = not (current == nil) and #current > 0
    local senderEligibility = arg1.getSenderEligibility()
    local var1 = (current == nil or not (#current > 0)) and {} or arg1.getAndFetchItemGiftabilities(current)

    return Signals.createComputed(function(arg2)
        local var2 = senderEligibility.status(arg2)
        local var3 = senderEligibility.data(arg2)
        local var4 = if var3 ~= nil then var3.eligibility else GiftEligibility.Unknown
        local requiredActions = if var3 ~= nil then var3.requiredActions else tbl1
        local bool2 = false
        local bool3 = false
        local bool4 = false

        for _, value in var1 do
            local var6 = value.status(arg2)
            if var6 == DataStatus.NotReady then
                bool2 = true
            elseif var6 == DataStatus.Failed then
                bool3 = true
            end

            local var7 = value.data(arg2)
            if var7 == nil or not var7.isGiftable then
                bool4 = true
            end
        end

        local isLoading = var2 == DataStatus.NotReady or bool2
        local hasFailed = var2 == DataStatus.Failed or bool3
        local areItemsGiftable = bool1 and not bool2 and not (bool3 or bool4)

        local tbl2 = {
            canGift = 0,
            areItemsGiftable = 0,
            senderEligibility = 0,
            requiredActions = 0,
            isLoading = 0,
            hasFailed = 0
        }
        local bool8 = not (isLoading or hasFailed)

        if bool8 then
            if var4 == GiftEligibility.Eligible then
                bool8 = not bool4
            else
                bool8 = false
            end
        end

        tbl2.canGift = bool8

        tbl2.areItemsGiftable = areItemsGiftable
        tbl2.senderEligibility = var4
        tbl2.requiredActions = requiredActions
        tbl2.isLoading = isLoading
        tbl2.hasFailed = hasFailed
        return tbl2
    end)
end

local function useGiftEligibility(current, tbl2)
    local var1 = (if tbl2 then tbl2.store else nil) or getCanGiftStore(false)

    local itemsSignature = buildItemsSignature(current)

    local var2 = React.useRef(current)
    var2.current = current

    local var3 = React.useMemo(function()
        return createEligibilitySignal(var1, var2.current)
    end, { var1, itemsSignature })

    return SignalsReact.useSignalState(var3)
end

return useGiftEligibility
