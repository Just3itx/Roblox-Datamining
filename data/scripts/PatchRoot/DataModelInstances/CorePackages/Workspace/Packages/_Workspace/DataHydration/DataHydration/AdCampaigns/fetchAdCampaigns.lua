-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpService = game:GetService("HttpService")

local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local _AdCampaignsTypes = require(script.Parent.AdCampaignsTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local module = {}

local function fetchBillingAccounts(tbl1)
    local var1 = fetch({
        network = tbl1.network,
        method = "GET",
        url = (tbl1.baseUrl or UrlBase.APIS) .. "/ads-management/v1/billing-accounts",
        analyticsKey = "ads-billing-accounts.list",
        decode = function(arg1)
            local billingAccounts = if type(arg1) == "table" then arg1.billingAccounts else nil

            if type(billingAccounts) ~= "table" then
                error("Billing accounts response is missing billingAccounts")
            end
            return billingAccounts
        end
    })

    return asPromise(var1)
end

local function mapCampaign(arg1)
    local schedule = arg1.schedule or {}
    return {
        id = arg1.id,
        name = arg1.name,
        status = arg1.status,
        deliveryStatus = arg1.deliveryStatus,
        targetUniverseId = arg1.targetUniverseId,
        schedule = {
            startTime = schedule.startTime,
            durationInDays = if type(schedule.durationInDays) ~= "number" then 0 else schedule.durationInDays
        }
    }
end

local function fetchAllCampaigns(tbl1)
    local var1 = tbl1.baseUrl or UrlBase.APIS

    return Promise.new(function(callback, callback2)
        local tbl2 = {}

        local function fetchPage(input: string?, num1: number)
            local str1 = ("%s%s?maxPageSize=%d"):format(var1, "/ads-management/v1/campaigns", 100)
            if input ~= nil and input ~= "" then
                str1 ..= "&pageToken=" .. HttpService:UrlEncode(input)
            end

            local var2 = fetch({
                network = tbl1.network,
                method = "GET",
                url = str1,
                analyticsKey = "ads-campaigns.list",
                decode = function<T>(arg1: T): T
                    return arg1
                end
            })

            asPromise(var2):andThen(function(arg1)
                local campaigns = if arg1 == nil then nil else arg1.campaigns

                if campaigns ~= nil then
                    for _, campaign in campaigns do
                        table.insert(tbl2, (mapCampaign(campaign)))
                    end
                end

                local nextPageToken = if arg1 == nil then nil else arg1.nextPageToken

                if nextPageToken == nil or nextPageToken == "" then
                    callback(tbl2)
                elseif num1 >= 10 then
                    callback2({ errorMessage = "Ad campaigns pagination exceeded the page limit" })
                else
                    fetchPage(nextPageToken, num1 + 1)
                end
            end):catch(function(arg1)
                callback2(arg1)
            end)
        end

        fetchPage(nil, 1)
    end)
end

function module.fetchAdCampaigns(tbl1)
    local tbl2 = tbl1 or {}
    local delay = tbl2.delay or Promise.delay
    local timeoutSec = tbl2.timeoutSec or 25

    local var1 = fetchBillingAccounts(tbl2):andThen(function(arg1)
        if #arg1 == 0 then
            return {}
        end
        return fetchAllCampaigns(tbl2)
    end)

    local var2 = delay(timeoutSec):andThen(function()
        return Promise.reject({ errorMessage = "Ad campaigns fetch timed out" })
    end)

    return Promise.race({ var1, var2 })
end

return module
