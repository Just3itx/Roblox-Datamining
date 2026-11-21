-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local HttpService = game:GetService("HttpService")
local GamePlayButtonParent = GamePlayButton.Parent

local ApiFetchGameDetails = require(GamePlayButtonParent.GameDetailRodux).GameDetails.ApiFetchGameDetails
local FetchGamePlayabilityAndProductInfo = require(GamePlayButtonParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local PerformFetch = require(GamePlayButtonParent.Http).PerformFetch
local Promise = require(GamePlayButtonParent.Promise)

local FiatPaidAccessPostPreparePurchaseRequest = require(GamePlayButton.FiatPaidAccessPostPreparePurchaseRequest)
local OpenFiatPurchasePage = require(GamePlayButton.OpenFiatPurchasePage)

local module = {}

local function func1(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.fiatpaidaccess.prepare-purchase." .. arg1
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (func1(arg2)))
end

function module.Fetch(arg1, arg2, arg3, arg4)
    return PerformFetch.Single(func1(arg3), function(arg5)
        return FiatPaidAccessPostPreparePurchaseRequest(arg1, arg2, arg4):andThen(function(arg6)
            local checkoutUrl = arg6 and arg6.responseBody and arg6.responseBody.checkoutUrl

            if checkoutUrl then
                local var1 = HttpService:JSONDecode(checkoutUrl)

                if var1 and var1.checkoutUrl then
                    arg5:dispatch(OpenFiatPurchasePage(var1.checkoutUrl, function()
                        arg5:dispatch(ApiFetchGameDetails.Fetch(arg1, { arg3 }))
                        arg5:dispatch(FetchGamePlayabilityAndProductInfo.Fetch(arg1, arg3))
                    end))

                    return Promise.resolve(arg6)
                end
            end

            return Promise.reject("Invalid Response")
        end)
    end)
end

return module
