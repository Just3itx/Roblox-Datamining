-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local UrlBuilder = require(AmpUpsellParent.UrlBuilder).UrlBuilder
local UrlBase = require(AmpUpsellParent.UrlBuilder).UrlBase
local HttpService = game:GetService("HttpService")
local VPCRequestTypeEnum = require(AmpUpsell.Common.Enums).VPCRequestTypeEnum

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "child-requests-api/v1/send-request-to-new-parent" })

local urlBuilder2 = UrlBuilder.new({ base = UrlBase.APIS, path = "child-requests-api/v1/send-request-to-all-parents" })

local urlBuilder3 = UrlBuilder.new({ base = UrlBase.APIS, path = "user-settings-api/v1/account-insights/parent-emails" })

return {
    sendRequestToNewParent = function(arg1, email: string, tbl1, requestDetails, analyticsSessionId: string?)
        local var1 = urlBuilder()
        local requestType = tbl1 == nil and VPCRequestTypeEnum.LinkToChild or tbl1[1]
        local httpService = HttpService
        local input = {
            email = email,
            requestType = requestType,
            requestDetails = requestDetails,
            analyticsSessionId = 0
        }

        if analyticsSessionId == "" then
            analyticsSessionId = nil
        end

        input.analyticsSessionId = analyticsSessionId

        return arg1(var1, "POST", {
            postBody = httpService:JSONEncode(input),
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):andThen(
            function(arg2)
                return {
                    sessionId = arg2.responseBody.sessionId,
                    lockedUntil = arg2.responseBody.lockedUntil
                }
            end
        ):catch(
            function(arg2)
                local _success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)
                error({ code = result.code, message = result.message })
            end
        )
    end,
    sendRequestToAllParents = function(arg1, tbl1, requestDetails, analyticsSessionId: string?)
        local var1 = urlBuilder2()
        local requestType = tbl1[1]
        local httpService = HttpService
        local input = {
            requestType = requestType,
            requestDetails = requestDetails,
            analyticsSessionId = 0
        }

        if analyticsSessionId == "" then
            analyticsSessionId = nil
        end

        input.analyticsSessionId = analyticsSessionId

        return arg1(var1, "POST", {
            postBody = httpService:JSONEncode(input),
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):andThen(
            function(arg2)
                return {
                    sessionId = arg2.responseBody.sessionId,
                    lockedUntil = arg2.responseBody.lockedUntil
                }
            end
        ):catch(
            function(arg2)
                local _success, result = pcall(function()
                    return HttpService:JSONDecode(arg2.Body)
                end)
                error({ code = result.code, message = result.message })
            end
        )
    end,
    getLinkedParentEmails = function(arg1)
        return arg1(urlBuilder3(), "GET", { headers = { ["Content-Type"] = "application/json", Accept = "application/json" } }):andThen(
            function(arg2)
                return {
                    parentEmails = arg2.responseBody.parentEmails
                }
            end
        ):catch(
            function(_)
                error({})
            end
        )
    end
}
