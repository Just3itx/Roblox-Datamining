-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local OmniFeedTypes = require(ServerDrivenUiParent.DiscoveryTypes).OmniFeedTypes
local _LuauPolyfill = require(ServerDrivenUiParent.LuauPolyfill)
local MakeOmniRecommendationsRequest = require(ServerDrivenUiParent.GraphQlShared).MakeOmniRecommendationsRequest
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local SduiLoadTimer = require(ServerDrivenUiParent.SduiSharedUtilities).SduiLoadTimer

local seedHomeOmniSduiV2Payload = require(ServerDrivenUi.Migration.seedHomeOmniSduiV2Payload)

local FStringLuaEnabledSduiTreatmentTypes = require(ServerDrivenUiParent.SharedFlags).FStringLuaEnabledSduiTreatmentTypes

local tbl1 = ({})

local function getRefreshRequestKey(str1: string, str2: string, str3: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{str1}:{str2}:{str3}`
end

local function isCurrentRequest(refreshRequestKey: string, str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return tbl1[refreshRequestKey] == str1
end

local function getSupportedSduiTreatmentTypes()
    local robloxVersion = RunService:GetRobloxVersion()
    local var1 = tonumber(string.match(robloxVersion, ".(%d+)."))
    local supportedSduiTreatmentTypes = {}
    local tbl2 = string.split(FStringLuaEnabledSduiTreatmentTypes, ",")
    for _, value in ipairs(tbl2) do
        if value == "" then
            continue
        end

        local var2, var3 = string.match(value, "(.*):(.*)")
        local var4 = tonumber(var3)
        if var2 and var4 and var4 <= var1 then
            table.insert(supportedSduiTreatmentTypes, var2)
        end
    end

    return supportedSduiTreatmentTypes
end

local function findSortByTopicId(sorts, str1: string)
    for _, sort in sorts do
        if typeof(sort) == "table" and sort.topicId and tostring(sort.topicId) == str1 then
            return sort
        end
    end
    return nil
end

local function hasPageEntryForFeedItemKey(sduiv2, identifier: string)
    local pageEntries = sduiv2.pageEntries
    if typeof(pageEntries) ~= "table" then
        return false
    end

    for _, value in pageEntries do
        if value and typeof(value) == "table" and value.pageEntry and value.pageEntry.identifier == identifier then
            return true
        end
    end

    return false
end

local function reportValidationError(callback: (...any) -> (...any), str1: string, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    callback(
        tbl2.errorType,
        {
            name = "discovery-api/omni-recommendation/sduiv2",
            message = `{tbl2.message}, topicIds: {str1}`
        }
    )
end

local function reportNetworkError(callback: (...any) -> (...any), str1: string, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    callback(SduiErrors.SduiErrorType.FailedToFetchPage, {
        name = "discovery-api/omni-recommendation/sduiv2",
        message = `Omni recommendation feed item refresh failed: {SduiParseHelpers.stringifyValue(arg1)}, topicIds: {str1}`
    })
end

local function validateResponseBody(arg1, str1: string, identifier: string)
    if arg1 == nil or typeof(arg1) ~= "table" then
        return false, {
            errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
            message = "No response data from omni recommendation feed item refresh"
        }
    elseif arg1.sorts == nil or typeof(arg1.sorts) ~= "table" or #arg1.sorts == 0 then
        return false, {
            errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
            message = "No sort data in omni recommendation feed item refresh response"
        }
    else
        local sortByTopicId = findSortByTopicId(arg1.sorts, str1)
        if sortByTopicId == nil then
            return false, {
                errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
                message = "Requested sort not found in omni recommendation feed item refresh response"
            }
        elseif sortByTopicId.treatmentType ~= OmniFeedTypes.ServerDrivenUiV2 then
            return false, {
                errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
                message = `Requested sort is not SDUI V2 in omni recommendation feed item refresh response: {sortByTopicId.treatmentType}`
            }
        else
            local feedItemKey = if typeof(sortByTopicId) == "table" then sortByTopicId.feedItemKey else nil

            if typeof(feedItemKey) ~= "string" or feedItemKey == "" then
                return false, {
                    errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
                    message = "Missing feedItemKey in omni recommendation feed item refresh response"
                }
            elseif feedItemKey ~= identifier then
                return false, {
                    errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
                    message = `Wrong feedItemKey in omni recommendation feed item refresh response: {feedItemKey}`
                }
            elseif arg1.sduiv2 == nil or typeof(arg1.sduiv2) ~= "table" then
                return false, {
                    errorType = SduiErrors.SduiErrorType.NilSduiTreeInResponse,
                    message = "No sduiv2 field in omni recommendation feed item refresh response"
                }
            elseif not hasPageEntryForFeedItemKey(arg1.sduiv2, identifier) then
                return false, {
                    errorType = SduiErrors.SduiErrorType.InvalidFeedInResponse,
                    message = "Requested feed item not found in sduiv2 page entries"
                }
            end

            return true, nil
        end
    end
end

local function refreshOmniRecommendationFeedItem(arg1, str1: string, str2: string, identifier: string, str3: string, callback: (...any) -> (...any), tbl2)
    local loadTimer = tbl2.loadTimer or SduiLoadTimer.createLoadTimer(str1)
    loadTimer.start("feed-item-refresh")

    local tbl3 = {}
    for _, value in pairs(OmniFeedTypes) do
        table.insert(tbl3, value)
    end

    local success, result = pcall(getSupportedSduiTreatmentTypes)
    if not success then
        result = nil
    end

    local refreshRequestKey = getRefreshRequestKey(str1, str2, identifier)

    local str4 = HttpService:GenerateGUID(false):lower()
    tbl1[refreshRequestKey] = str4

    return MakeOmniRecommendationsRequest(
        arg1,
        str1,
        HttpService:GenerateGUID(false):lower(),
        nil,
        tbl3,
        str3,
        { str2 },
        result,
        tbl2.contextFeatures
    ):andThen(
        function(arg2)
            if not isCurrentRequest(refreshRequestKey, str4) then
                return
            end

            local responseBody = if typeof(arg2) == "table" then arg2.responseBody else nil
            local bool1, var1 = validateResponseBody(responseBody, str2, identifier)
            if not bool1 then
                assert(var1, "Validation error should exist when response is invalid")
                reportValidationError(callback, str2, var1)
                return
            end

            local success2, result2 = pcall(function()
                seedHomeOmniSduiV2Payload(responseBody.sduiv2, str1, loadTimer)
            end)

            if success2 then
                return
            end

            callback(SduiErrors.SduiErrorType.ErrorStoringOmniData, {
                name = "discovery-api/omni-recommendation/sduiv2",
                message = `Error seeding omni recommendation feed item: {result2}, topicIds: {str2}`
            })
        end
    ):catch(
        function(arg2)
            if not isCurrentRequest(refreshRequestKey, str4) then
                return
            end

            reportNetworkError(callback, str2, arg2)
        end
    ):finally(
        function()
            if isCurrentRequest(refreshRequestKey, str4) then
                loadTimer.logRefreshComplete()

                tbl1[refreshRequestKey] = nil
            end
        end
    )
end
return refreshOmniRecommendationFeedItem
