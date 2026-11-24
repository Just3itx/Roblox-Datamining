-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local FFlagEnableOffersPrefetch = require(InExperienceOffersParent.SharedFlags).FFlagEnableOffersPrefetch
local FIntOffersPrefetchDelayMs = require(InExperienceOffers.Flags.FIntOffersPrefetchDelayMs)
local FStringOffersPrefetchFeatureKeys = require(InExperienceOffers.Flags.FStringOffersPrefetchFeatureKeys)

local GetOffersStore = require(InExperienceOffers.Stores.GetOffersStore)
local _FeatureKey = require(InExperienceOffers.Enums.FeatureKey)
local whenJoinSettles = require(InExperienceOffers.JoinLifecycle.whenJoinSettles)
local schedulePrefetchDelay = require(InExperienceOffers.JoinLifecycle.schedulePrefetchDelay)
local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)

local function parseFeatureKeys(fStringOffersPrefetchFeatureKeys: string)
    local result = {}
    for _, value in string.split(fStringOffersPrefetchFeatureKeys, ",") do
        local var1 = value:match("^%s*(.-)%s*$")
        if var1 and var1 ~= "" then
            table.insert(result, var1)
        end
    end
    return result
end

local tbl1 = parseFeatureKeys(FStringOffersPrefetchFeatureKeys)

local function triggerFetch() -- Luacid: Inlined by compiler; 1 call site recovered
    if #tbl1 == 0 then
        return
    end
    GetOffersStore(false).fetchOffers(tbl1)
end

local function prefetchOffersOnGameJoin()
    if not FFlagEnableOffersPrefetch then
        return
    end
    OffersDebugLogger.log("prefetchOffersOnGameJoin: waiting for join to settle")
    whenJoinSettles(function(arg1)
        OffersDebugLogger.logLazy(function()
            return "prefetchOffersOnGameJoin: join settled path=" .. arg1
        end)
        local var1 = FIntOffersPrefetchDelayMs
        if var1 <= 0 then
            triggerFetch()
            return
        end

        schedulePrefetchDelay(var1 / 1000, triggerFetch)
    end)
end

return prefetchOffersOnGameJoin
