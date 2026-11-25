-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local Navigation = require(ProfilePlatformParent.Navigation)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)

local useNavigation = Navigation.useNavigation
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local NumberLocalization = require(ProfilePlatformParent.Localization).NumberLocalization

local AvatarSaveContext = require(ProfilePlatformParent.AvatarExperienceSave).Context.AvatarSaveContext

local getIsInsufficientRobuxError = require(ProfilePlatformParent.AvatarExperienceCommon).Utils.getIsInsufficientRobuxError
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)

local MarketplaceUnifiedAction = require(ProfilePlatformParent.AvatarExperienceAnalytics).UnifiedEventLogEnums.MarketplaceUnifiedAction

local Enums = require(ProfilePlatform.Common.Enums)
local PurchaseBulkItems = require(ProfilePlatform.Networking.PurchaseBulkItems)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local HandlePurchaseItemsSuccess = require(script.Parent.HandlePurchaseItemsSuccess)
local sendProfilePurchaseEvents = require(ProfilePlatform.Analytics.sendProfilePurchaseEvents)

local FFlagProfileUnifiedPurchaseLogging = require(ProfilePlatform.Flags.FFlagProfileUnifiedPurchaseLogging)

local FFlagSocialEnableProfileInspectAndBuyAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyAnalytics

local FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav = require(ProfilePlatformParent.SharedFlags).FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav
local FFlagProfileInspectAndBuyAutoFocus = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyAutoFocus)

local ReactFocusNavigation = require(ProfilePlatformParent.ReactFocusNavigation)
local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(ProfilePlatformParent.InputHandlers)

local View = Foundation.View
local FoundationText = Foundation.Text
local Checkbox = Foundation.Checkbox
local Dialog = Foundation.Dialog
local InputSize = Foundation.Enums.InputSize
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText

local function PurchaseConfirmationModal(tbl1)
    local var1 = useNavigation()
    local var2 = useProfileAnalyticsContext()
    local dispatch = useDispatch()
    local profileWrapperContext = useProfileWrapperContext()
    local avatarSaveContext = React.useContext(AvatarSaveContext)

    local var6 = tbl1.navigation.state.params or {}
    local totalPrice = var6.totalPrice or 0
    local lineItems = var6.purchasableLineItems or {}
    local purchasedItems = if FFlagProfileUnifiedPurchaseLogging then var6.purchasedItems else nil
    local userId = var6.userId or ""
    local purchasedWearIds = var6.purchasedWearIds or {}
    local ownedAssetIds = var6.ownedAssetIds or {}
    local wearTypeMap = var6.wearTypeMap or {}
    local var10 = RobloxAppHooks.useLocalRobuxBalance()
    if var10 == nil then
        var10 = var6.robuxBalance or 0
    end
    local var11 = React.useCallback(function()
        var1.navigate(Enums.Screens.InsufficientRobuxDialog, { totalPrice = totalPrice, robuxBalance = var10 })
    end, { var1, totalPrice, var10 })

    local var12 = useLocalization({
        buyTitle = "IAPExperience.PurchasePrompt.Header.BuyAvatar",
        buyAction = "IAPExperience.PurchasePrompt.Action.Buy",
        totalPrice = "IAPExperience.PurchasePrompt.Label.TotalPriceV2",
        wearAfterPurchase = "Feature.Catalog.Label.WearAvatarAfterPurchase",
        purchaseSuccessSingular = {
            "Feature.Avatar.Message.LooksPurchaseSuccessSingular",
            numItems = 1
        },
        purchaseSuccessPlural = {
            "Feature.Avatar.Message.LooksPurchaseSuccessPlural",
            numItems = #lineItems
        },
        purchasePartialFailure = "Feature.Avatar.Heading.LooksPurchasePartialSuccess",
        purchaseFailed = "CoreScripts.PurchasePrompt.PurchaseFailed.UnknownFailureNoItemName"
    })

    local localized = React.useMemo(function()
        return {
            purchaseSuccessSingular = var12.purchaseSuccessSingular,
            purchaseSuccessPlural = var12.purchaseSuccessPlural,
            purchasePartialFailure = var12.purchasePartialFailure
        }
    end, { var12.purchaseSuccessSingular, var12.purchaseSuccessPlural, var12.purchasePartialFailure })

    local isDisabled, var15 = React.useState(false)
    local var16, var17 = React.useState(true)

    local onClose = React.useCallback(function()
        if isDisabled then
            return
        end
        var1.goBack()
    end, { isDisabled, var1 })

    local useCallback = React.useCallback
    local function func1()
        if isDisabled or #lineItems == 0 then
            return
        end

        var15(true)

        if FFlagSocialEnableProfileInspectAndBuyAnalytics then
            var2.fireAnalyticsEvent(
                EventNames.InspectAvatarPurchaseConfirmed,
                {
                    profileSessionId = profileWrapperContext.profileSessionId
                }
            )
        else
            var2.fireAnalyticsEvent(EventNames.CatalogItemOpened, { btnContext = "InspectAvatarBuyAll" })
        end

        if FFlagProfileUnifiedPurchaseLogging then
            sendProfilePurchaseEvents(
                MarketplaceUnifiedAction.PURCHASE_ATTEMPT,
                purchasedItems or {},
                profileWrapperContext.profileType
            )
        end

        PurchaseBulkItems({ userId = userId, lineItems = lineItems }):andThen(function(arg1)
            HandlePurchaseItemsSuccess({
                result = arg1,
                isWearAfterPurchaseChecked = var16,
                purchasedWearIds = purchasedWearIds,
                ownedAssetIds = ownedAssetIds,
                wearTypeMap = wearTypeMap,
                purchasedItems = if FFlagProfileUnifiedPurchaseLogging then purchasedItems else nil,
                profileWrapperContext = profileWrapperContext,
                avatarSaveContext = avatarSaveContext,
                dispatch = dispatch,
                localized = localized
            })
            var1.goBack()
        end):catch(function(arg1)
            if getIsInsufficientRobuxError(arg1) then
                var11()
                return
            end
            dispatch(
                SetCurrentToastMessage({ toastMessage = var12.purchaseFailed, isLocalized = true, toastType = "PurchaseMessage" })
            )

            var1.goBack()
        end):finally(function()
            var15(false)
        end)
    end

    local purchaseFailed = var12.purchaseFailed
    local var19 = if FFlagProfileUnifiedPurchaseLogging then purchasedItems else nil
    local onActivated = useCallback(func1, {
        isDisabled,
        lineItems,
        userId,
        purchasedWearIds,
        ownedAssetIds,
        wearTypeMap,
        var16,
        var2,
        var1,
        dispatch,
        localized,
        profileWrapperContext,
        avatarSaveContext,
        var11,
        purchaseFailed,
        var19
    })

    local var21 = React.useMemo(function(): string
        local var21 = NumberLocalization.localize(totalPrice, LocalizationService.RobloxLocaleId)
        return `{getIconRichText(IconName.Robux)} {var21}`
    end, { totalPrice, LocalizationService.RobloxLocaleId })

    local priceTotal = React.createElement(View, {
        LayoutOrder = 1,
        tag = "size-full-1300 padding-left-xxsmall padding-right-xxsmall padding-top-small padding-bottom-large"
    }, {
        BorderContainer = React.createElement(
            View,
            {
                tag = "auto-xy align-y-center align-x-center radius-medium padding-x-large row stroke-default padding-y-xsmall"
            },
            {
                LeftSide = React.createElement(
                    View,
                    {
                        LayoutOrder = 1,
                        tag = "row align-y-center gap-small padding-y-xsmall",
                        Size = UDim2.new(0.5, 0, 1, 0)
                    },
                    {
                        Label = React.createElement(FoundationText, {
                            LayoutOrder = 1,
                            Text = var12.totalPrice,
                            tag = "auto-xy text-title-medium content-default text-align-x-left padding-y-xsmall"
                        })
                    }
                ),
                RightSide = React.createElement(
                    View,
                    {
                        LayoutOrder = 2,
                        tag = "row align-y-center align-x-right gap-large padding-y-xsmall",
                        Size = UDim2.new(0.5, 0, 1, 0)
                    },
                    {
                        Price = React.createElement(FoundationText, {
                            LayoutOrder = 1,
                            Text = var21,
                            tag = "auto-xy text-title-medium content-emphasis text-align-x-right padding-y-xsmall",
                            RichText = true
                        })
                    }
                )
            }
        )
    })

    local handler = if FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav then React.useMemo(function()
        return InputHandlers.onRelease(function(arg1)
            arg1:cancel()
            onClose()
        end)
    end, { onClose }) else nil

    local var23, var24

    if FFlagProfileInspectAndBuyAutoFocus then
        var23, var24 = ReactFocusNavigation.useDefaultFocusBehavior()
    else
        var24 = nil
        var23 = nil
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Small,
        onClose = onClose,
        ref = 0,
        hasBackdrop = 0
    }

    if not FFlagProfileInspectAndBuyAutoFocus then
        var24 = nil
    end

    tbl2.ref = var24

    tbl2.hasBackdrop = if FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav then true else nil
    local tbl3 = {
        DialogTitle = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var12.buyTitle }),
        DialogContent = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
            Body = React.createElement(View, {
                tag = "col gap-medium auto-y size-full-0 align-x-left"
            }, {
                PriceTotal = priceTotal,
                WearCheckbox = React.createElement(Checkbox, {
                    LayoutOrder = 2,
                    label = var12.wearAfterPurchase,
                    size = InputSize.XSmall,
                    isChecked = var16,
                    onActivated = function()
                        var17(not var16)
                    end,
                    isDisabled = isDisabled
                })
            })
        }),
        DialogActions = 0
    }

    local createElement2 = React.createElement
    local actions = Dialog.Actions
    local tbl4 = {
        LayoutOrder = 3,
        orientation = EnumsOrientation.Horizontal,
        actions = 0
    }
    local tbl5 = {
        text = var12.buyAction,
        variant = ButtonVariant.Emphasis,
        onActivated = onActivated,
        ref = 0
    }

    if not FFlagProfileInspectAndBuyAutoFocus then
        var23 = nil
    end

    tbl5.ref = var23
    tbl4.actions = { tbl5 }
    tbl3.DialogActions = createElement2(actions, tbl4)
    local dialog = createElement(root, tbl2, tbl3)

    if not FFlagSocialEnableProfileInspectAndBuyConsoleFocusNav then
        return dialog
    end

    return React.createElement(AppFocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        isIsolated = true,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = { handler = handler }
        }
    }, { Dialog = dialog })
end

return PurchaseConfirmationModal
