-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Players = game:GetService("Players")

local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)
local Url = require(RobloxSubscriptionPurchaseAppParent.Http).Url

local HttpRequest = require(script.Parent.HttpRequest)
local _types = require(RobloxSubscriptionPurchaseApp.types)

local flattenMapValue = nil

local function parseEvaluationValue(arg1)
    if type(arg1) ~= "table" then
        return nil
    elseif arg1.boolValue ~= nil then
        return arg1.boolValue
    elseif arg1.stringValue ~= nil then
        return arg1.stringValue
    elseif arg1.doubleValue ~= nil then
        return arg1.doubleValue
    elseif arg1.int64Value ~= nil then
        return tonumber(arg1.int64Value) or arg1.int64Value
    elseif arg1.mapValue ~= nil then
        return flattenMapValue(arg1.mapValue)
    end

    return arg1
end

flattenMapValue = function(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local entries = arg1.entries
    if entries == nil then
        return {}
    end
    if type(entries) ~= "table" then
        return nil
    end

    local result = ({})
    for _, value in entries do
        if type(value) ~= "table" then
            return nil
        end

        local var1 = parseEvaluationValue(value.key)
        if type(var1) ~= "string" then
            return nil
        end
        local var2 = parseEvaluationValue(value.value)

        if var2 == nil then
            return nil
        end
        result[var1] = var2
    end
    return result
end

local function findMembershipResult(arg1)
    if type(arg1) ~= "table" then
        return nil
    end
    local evaluationResponses = arg1.evaluationResponses
    if type(evaluationResponses) ~= "table" then
        return nil
    end
    for _, value in evaluationResponses do
        if type(value) ~= "table" then
            continue
        end
        local request = value.request

        if type(request) == "table" and request.fullFeatureName == "subscriptions/PlusSubscription.RobloxSubscriptionMembership" then
            return value.result
        end
    end

    return nil
end

local function getRobloxSubscriptionMembershipConfig()
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        return Promise.resolve(nil)
    end

    return HttpRequest.new():post(Url.APIS_URL .. "access-management/v2/feature-evaluation", {{
        userId = localPlayer.UserId,
        featureName = "RobloxSubscriptionMembership",
        namespace = "subscriptions/PlusSubscription"
    }}):andThen(
        function(arg1)
            local membershipResult = findMembershipResult(arg1)
            if type(membershipResult) ~= "table" or membershipResult.errorValue ~= nil then
                return nil
            end

            return flattenMapValue(membershipResult.mapValue)
        end
    ):catch(
        function()
            return Promise.resolve(nil)
        end
    )
end
return getRobloxSubscriptionMembershipConfig
