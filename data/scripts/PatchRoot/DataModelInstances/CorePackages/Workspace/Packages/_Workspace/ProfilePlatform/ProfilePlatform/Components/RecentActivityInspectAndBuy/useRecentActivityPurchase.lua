-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local getIsInsufficientRobuxError = require(ProfilePlatformParent.AvatarExperienceCommon).Utils.getIsInsufficientRobuxError
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage

local MarketplaceUnifiedAction = require(ProfilePlatformParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedAction

local _Types = require(ProfilePlatform.Common.Types)
local PurchaseBulkItems = require(ProfilePlatform.Networking.PurchaseBulkItems)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local HandlePurchaseItemsSuccess = require(ProfilePlatform.Components.InspectAvatar.HandlePurchaseItemsSuccess)
local sendProfilePurchaseEvents = require(ProfilePlatform.Analytics.sendProfilePurchaseEvents)

local FFlagProfileUnifiedPurchaseLogging = require(ProfilePlatform.Flags.FFlagProfileUnifiedPurchaseLogging)

local useRecentActivityPurchaseSelection = require(script.Parent.useRecentActivityPurchaseSelection)

local function useRecentActivityPurchase(tbl1)
    local dispatch = useDispatch()
    local var2 = RobloxAppHooks.useLocalRobuxBalance()

    local profileWrapperContext = useProfileWrapperContext()

    local localUserId = tbl1.localUserId
    local var4 = useRecentActivityPurchaseSelection(tbl1.displayItems)
    local purchaseData = var4.purchaseData

    local isPurchasing, var6 = React.useState(false)
    local isConfirmingPurchase, var8 = React.useState(false)
    local isShowingInsufficientRobux, var10 = React.useState(false)

    local var11 = useLocalization({
        purchaseSuccessSingular = {
            "Feature.Avatar.Message.LooksPurchaseSuccessSingular",
            numItems = 1
        },
        purchaseSuccessPlural = {
            "Feature.Avatar.Message.LooksPurchaseSuccessPlural",
            numItems = purchaseData.count
        },
        purchasePartialFailure = "Feature.Avatar.Heading.LooksPurchasePartialSuccess",
        purchaseFailed = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName"
    })

    local localized = React.useMemo(function()
        return {
            purchaseSuccessSingular = var11.purchaseSuccessSingular,
            purchaseSuccessPlural = var11.purchaseSuccessPlural,
            purchasePartialFailure = var11.purchasePartialFailure
        }
    end, { var11.purchaseSuccessSingular, var11.purchaseSuccessPlural, var11.purchasePartialFailure })

    local onBuyAll = React.useCallback(function()
        if #purchaseData.lineItems == 0 or not localUserId then
            return
        end
        if var2 ~= nil and purchaseData.totalPrice > var2 then
            var10(true)
            return
        end
        var8(true)
    end, { purchaseData, localUserId, var2 })

    local onCancelPurchase = React.useCallback(function()
        var8(false)
    end, {})

    local onDismissInsufficientRobux = React.useCallback(function()
        var10(false)
    end, {})

    local onConfirmPurchase = React.useCallback(function()
        if isPurchasing or #purchaseData.lineItems == 0 or not localUserId then
            return
        end

        var6(true)

        if FFlagProfileUnifiedPurchaseLogging then
            sendProfilePurchaseEvents(
                MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
                purchaseData.purchasedItems or {},
                profileWrapperContext.profileType
            )
        end

        PurchaseBulkItems({ userId = localUserId, lineItems = purchaseData.lineItems }):andThen(function(arg1)
            HandlePurchaseItemsSuccess({
                result = arg1,
                purchasedItems = if FFlagProfileUnifiedPurchaseLogging then purchaseData.purchasedItems else nil,
                profileWrapperContext = profileWrapperContext,
                dispatch = dispatch,
                localized = localized
            })
            var8(false)
            tbl1.onClose()
        end):catch(function(arg1)
            var8(false)
            if getIsInsufficientRobuxError(arg1) then
                var10(true)
                return
            end
            dispatch(
                SetCurrentToastMessage({ toastMessage = var11.purchaseFailed, isLocalized = true, toastType = "PurchaseMessage" })
            )

            tbl1.onClose()
        end):finally(function()
            var6(false)
        end)
    end, {
        isPurchasing,
        purchaseData,
        localUserId,
        profileWrapperContext,
        dispatch,
        localized,
        var11.purchaseFailed,
        tbl1.onClose
    })

    return {
        selectedItems = var4.selectedItems,
        purchaseSummary = {
            totalPrice = purchaseData.totalPrice,
            count = purchaseData.count
        },
        isPurchasing = isPurchasing,
        isConfirmingPurchase = isConfirmingPurchase,
        isShowingInsufficientRobux = isShowingInsufficientRobux,
        robuxBalance = if var2 == nil then 0 else var2,
        onToggleItem = var4.onToggleItem,
        onBuyAll = onBuyAll,
        onConfirmPurchase = onConfirmPurchase,
        onCancelPurchase = onCancelPurchase,
        onDismissInsufficientRobux = onDismissInsufficientRobux
    }
end

return useRecentActivityPurchase
