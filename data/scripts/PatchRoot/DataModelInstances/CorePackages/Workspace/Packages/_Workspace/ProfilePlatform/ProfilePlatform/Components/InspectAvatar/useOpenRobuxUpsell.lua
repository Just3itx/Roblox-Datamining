-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Promise = require(ProfilePlatformParent.Promise)
local Navigation = require(ProfilePlatformParent.Navigation)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)

local useNavigation = Navigation.useNavigation
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

local FFlagProfileInspectAndBuyKeepUpsellDialogOpen = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyKeepUpsellDialogOpen)

local FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 = require(ProfilePlatform.Flags.FFlagSocialEnableProfileInspectAndBuyAnalyticsV2)
local FFlagEnableRecentActivityInspectAndBuy = require(ProfilePlatformParent.SharedFlags).FFlagEnableRecentActivityInspectAndBuy

local function useOpenRobuxUpsell(priceInRobux: number, callback: ((...any) -> (...any))?)
    local var1 = useDispatch()
    local var2 = useNavigation()
    local var3 = useProfileWrapperContext()

    local useCallback = React.useCallback
    local function func1()
        local purchasePromptLite = require(ProfilePlatformParent.PurchasePromptLite)
        local closeCentralOverlay = require(ProfilePlatformParent.CentralOverlay).Thunks.CloseCentralOverlay

        var1(
            purchasePromptLite.Thunks.OpenCentralOverlayForUnifiedPurchasePrompt({
                productPayload = { kind = "RobuxUpsell" },
                purchaseAnalyticsMetadata = FFlagSocialEnableProfileInspectAndBuyAnalyticsV2
                    and {
                        surface = purchasePromptLite.Enums.ProductPurchaseSurface.Profile
                    }
                    or nil,
                purchaseCallbacks = {
                    onFlowComplete = function()
                        var1(closeCentralOverlay())
                        local refreshRobuxBalance = if var3.postPurchase then var3.postPurchase.refreshRobuxBalance else nil

                        if refreshRobuxBalance then
                            refreshRobuxBalance()
                        end
                        if FFlagEnableRecentActivityInspectAndBuy and callback then
                            callback()
                        elseif not FFlagProfileInspectAndBuyKeepUpsellDialogOpen then
                            var2.goBack()
                        end
                    end,
                    fetchProductInfo = function()
                        return Promise.resolve({ PriceInRobux = priceInRobux, IsForSale = true, Name = "RobuxUpsell" })
                    end
                }
            })
        )
    end

    local postPurchase = var3.postPurchase
    local var4 = if FFlagEnableRecentActivityInspectAndBuy then callback else nil
    return useCallback(func1, { var1, var2, postPurchase, priceInRobux, var4 })
end

return useOpenRobuxUpsell
