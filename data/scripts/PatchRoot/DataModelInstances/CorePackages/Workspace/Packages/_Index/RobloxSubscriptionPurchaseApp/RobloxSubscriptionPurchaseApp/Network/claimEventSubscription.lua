-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local UrlBuilder = require(RobloxSubscriptionPurchaseAppParent.UrlBuilder).UrlBuilder
local UrlBase = require(RobloxSubscriptionPurchaseAppParent.UrlBuilder).UrlBase

local HttpRequest = require(script.Parent.HttpRequest)

local eventType = game:DefineFastString("AXGetEventEligibilityEventName", "TurkeyTrot")
local id = game:DefineFastString("AXGetEventEligibilityProductId", "3401490850583284716")
local type = game:DefineFastString("AXGetEventEligibilityProductType", "RobloxPlus")

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "subscriptions/v2/events/claim" })

return function()
    return HttpRequest.new():post(urlBuilder(), { eventType = eventType, subscriptionProductKey = { id = id, type = type } })
end
