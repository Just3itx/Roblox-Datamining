-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local HttpService = game:GetService("HttpService")

local UrlBuilder = require(AmpUpsellParent.UrlBuilder).UrlBuilder
local UrlBase = require(AmpUpsellParent.UrlBuilder).UrlBase
local Fetch = require(AmpUpsellParent.Fetch)
local Promise = require(AmpUpsellParent.Promise)
local SharedFlags = require(AmpUpsellParent.SharedFlags)

local fetch = Fetch.fetch
local Response = Fetch.Response
local AccessResponseEnum = require(AmpUpsell.Common.Enums).AccessResponseEnum
local _Types = require(AmpUpsell.Common.Types)
local gql = require(AmpUpsellParent.ApolloClient).gql
local Base64 = require(AmpUpsellParent.AuthCommon).Utils.Base64
local GetFFlagAmpGqlPassSuccessfulActions = require(AmpUpsell.Flags.GetFFlagAmpGqlPassSuccessfulActions)
local FFlagAllowAmpV2FeatureAccessCall = SharedFlags.FFlagAllowAmpV2FeatureAccessCall

local urlBuilder = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "access-management/v1/upsell-feature-access",
    query = {
        { name = "featureName", value = "{featureName}", optional = false },
        { name = "successfulActions", value = "{successfulActions}", optional = false },
        { name = "nameSpace", value = "{nameSpace}", optional = true },
        { name = "extraParameters", value = "{extraParameters}", optional = true }
    }
})

local urlBuilder2 = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "access-management/v1/feature-access",
    query = FFlagAllowAmpV2FeatureAccessCall and {
        featureNames = "{featureNames}",
        nameSpace = "{nameSpace}"
    }
        or { featureNames = "{featureNames}" }
})

local function getUpsellFeatureAccessFromFeatureName(featureName: string, tbl1, nameSpace: string?, extraParameters: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = fetch
    return Promise.new(function(callback, callback2)
        local successfulActions = table.concat(tbl1, ",")
        local var2 = urlBuilder({
            featureName = featureName,
            successfulActions = successfulActions,
            nameSpace = nameSpace,
            extraParameters = extraParameters
        })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if var3.status == 304 then
            callback2("Got Response: 304")
            return
        end

        if not var3.ok then
            callback2("Failed to find upsell feature access values")
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2("Failed to decode HTTP response as JSON for AMP Upsell Feature Access API")
            return
        end

        callback(
            {
                access = var4.access,
                recourse = var4.recourse,
                recourses = var4.recourses,
                shouldPrompt = var4.shouldPrompt
            }
        )
    end)
end
return {
    upsellFeatureAccess = function(featureName: string, tbl1, nameSpace: string?, input)
        local extraParameters = if input then Base64.Encode(HttpService:JSONEncode(input)) else nil

        return (getUpsellFeatureAccessFromFeatureName(featureName, tbl1, nameSpace, extraParameters):catch(function(_)
            return {
                access = AccessResponseEnum.Error
            }
        end):expect())
    end,
    upsellFeatureAccessGql = function(arg1, featureName: string, tbl1, nameSpace: string?, input)
        local query = gql(require(script.Parent.GetUpsellFeatureAccess))
        local extraParameters = if input then Base64.Encode(HttpService:JSONEncode(input)) else nil

        local var3 = arg1:query({
            query = query,
            variables = {
                featureName = featureName,
                successfulActions = not GetFFlagAmpGqlPassSuccessfulActions() and {} or tbl1,
                nameSpace = nameSpace,
                extraParameters = extraParameters
            },
            fetchPolicy = "network-only"
        }):catch(
            function(_)
                return {
                    access = AccessResponseEnum.Error
                }
            end
        ):expect()

        if var3.data and var3.data.getUpsellFeatureAccess.featureAccess then
            return var3.data.getUpsellFeatureAccess.featureAccess
        end

        return {
            access = AccessResponseEnum.Error
        }
    end,
    getFeatureAccess = function(tbl1, str1: string?)
        local var1 = fetch
        return (Promise.new(function(callback, callback2)
            local featureNames = table.concat(tbl1, ",")
            local var2 = if FFlagAllowAmpV2FeatureAccessCall then urlBuilder2({ featureNames = featureNames, nameSpace = str1 or "" }) else urlBuilder2({ featureNames = featureNames })

            local var3 = var1(var2, { method = "GET" }):catch(function()
                return Response.error()
            end):expect()

            if var3.status == 304 then
                callback2("Got Response: 304")
                return
            end

            if not var3.ok then
                callback2("Failed to find get feature access values")
                return
            end

            local var4 = var3:json():catch(function()
                return nil
            end):expect()

            if not var4 then
                callback2("Failed to decode HTTP response as JSON for AMP Upsell Feature Access API")
                return
            end

            local featureAccessList = {}

            for _, value in var4.features do
                table.insert(featureAccessList, { feature = value.featureName, access = value.access })
            end

            callback({ featureAccessList = featureAccessList })
        end):catch(function(_)
            return {
                access = AccessResponseEnum.Error
            }
        end):expect())
    end
}
