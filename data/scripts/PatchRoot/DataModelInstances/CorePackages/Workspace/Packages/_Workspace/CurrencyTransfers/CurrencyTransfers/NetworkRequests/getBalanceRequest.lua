-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _CurrencyTransfersParent = CurrencyTransfers.Parent

local ContentProvider = game:GetService("ContentProvider")

local HttpRequest = require(CurrencyTransfers.NetworkRequests.HttpRequest)

local function getEconomyUserCurrencyUrl()
    local var1 = string.gsub(ContentProvider.BaseUrl:lower(), "/m.", "/www.")
    local var2 = string.gsub(var1, "http:", "https:")
    return string.gsub(var2, "https://www.", "https://economy.") .. "v1/user/currency"
end

local function getBalanceRequest(arg1, arg2)
    local var1 = if arg2 ~= nil then HttpRequest.fromNetworkImpl(arg2) else HttpRequest.new(arg1)

    return var1:get((getEconomyUserCurrencyUrl())):andThen(function(arg3)
        return (if arg3.robux ~= nil then arg3.robux else arg3.Robux) or 0
    end)
end

return getBalanceRequest
