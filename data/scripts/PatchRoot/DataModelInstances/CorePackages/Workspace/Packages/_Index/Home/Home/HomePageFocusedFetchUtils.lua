-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local SduiCoreSystem = require(HomeParent.SduiCoreSystem)
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)
local SduiRequestConcurrencyPolicy = SduiSharedUtilities.SduiRequestConcurrencyPolicy
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore

local HomeConstants = require(Home.HomeConstants)

local FFlagSduiRefreshFeedItemIsOmissionExpected = require(HomeParent.SharedFlags).FFlagSduiRefreshFeedItemIsOmissionExpected

local tbl1 = {}
local num1 = 0

local module = {}

local function getMountedInputData() -- Luacid: Inlined by compiler; 3 call sites recovered
    return getSduiApiStore().getInputData(HomeConstants.ConfigKey, HomeConstants.ContentIdentifier)
end

local function isTargetMounted(feedItemKey: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local mountedInputData = getMountedInputData()

    return typeof(mountedInputData) == "table"
        and typeof(mountedInputData.entry_map) == "table"
        and mountedInputData.entry_map[feedItemKey] ~= nil
end

function module.isCurrent(tbl2)
    local sduiApiStore = getSduiApiStore()
    return tbl1[tbl2.options.feedItemKey] == tbl2.requestId
        and sduiApiStore.getDataUpdatedTimestamp(HomeConstants.ConfigKey, false, HomeConstants.FeedEntryCacheKey) == tbl2.capturedTimestamp
        and isTargetMounted(tbl2.options.feedItemKey)
end

function module.register(options)
    local capturedTimestamp = getSduiApiStore().getDataUpdatedTimestamp(HomeConstants.ConfigKey, false, HomeConstants.FeedEntryCacheKey)

    if capturedTimestamp == nil or not isTargetMounted(options.feedItemKey) then
        return nil
    end

    num1 += 1
    tbl1[options.feedItemKey] = num1
    return {
        options = options,
        requestId = num1,
        capturedTimestamp = capturedTimestamp,
        foundTarget = false
    }
end

function module.applyToRequestConfig(tbl2, tbl3)
    tbl2.concurrencyKey = `{HomeConstants.ConfigKey}_{tbl3.options.feedItemKey}`
    tbl2.concurrencyPolicy = SduiRequestConcurrencyPolicy.LatestWins
    function tbl2.isResponseCurrent()
        return module.isCurrent(tbl3)
    end
    tbl2.enableInputDataMerge = true
    tbl2.cacheSingleEntryWithIdentifier = true
    function tbl2.mergeStrategy(tbl4)
        if #tbl4 == 1 then
            return if tbl4[1] == "entry_map" then nil elseif tbl4[1] == "content_pools" then "merge" else "preserve"
        end
        if #tbl4 ~= 2 or tbl4[1] ~= "entry_map" then
            return nil
        end

        if tbl4[2] ~= tbl3.options.feedItemKey then
            return "preserve"
        end

        tbl3.foundTarget = true
        return "replace"
    end
end

local function reportError(tbl2, failedToFetchPage, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl2.options.reportError(
        failedToFetchPage,
        {
            name = HomeConstants.ApiName,
            message = `{str1}, topicIds: {tbl2.options.topicId}`
        }
    )
end

function module.resolve(arg1, tbl2)
    return arg1:andThen(function(): boolean
        if not module.isCurrent(tbl2) then
            return false
        end
        if tbl2.foundTarget then
            return true
        end

        if not (FFlagSduiRefreshFeedItemIsOmissionExpected and tbl2.options.isOmissionExpected) then
            local tbl3 = tbl2
            local invalidFeedInResponse = SduiCoreSystem.SduiErrors.SduiErrorType.InvalidFeedInResponse
            tbl3.options.reportError(invalidFeedInResponse, {
                name = HomeConstants.ApiName,
                message = `Focused response omitted target, topicIds: {tbl3.options.topicId}`
            })
        end

        return false
    end, function(arg2): boolean
        if module.isCurrent(tbl2) then
            reportError(
                tbl2,
                SduiCoreSystem.SduiErrors.SduiErrorType.FailedToFetchPage,
                (SduiCoreSystem.SduiParseHelpers.stringifyValue(arg2))
            )
        end
        return false
    end)
end

return module
