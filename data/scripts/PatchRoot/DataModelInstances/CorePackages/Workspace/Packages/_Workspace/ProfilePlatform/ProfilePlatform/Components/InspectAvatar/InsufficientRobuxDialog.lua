-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local NumberLocalization = require(ProfilePlatformParent.Localization).NumberLocalization

local useOpenRobuxUpsell = require(script.Parent.useOpenRobuxUpsell)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)

local FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase)
local FFlagProfileInspectAndBuyAutoFocus = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyAutoFocus)

local FFlagProfileInspectAndBuyKeepUpsellDialogOpen = require(ProfilePlatform.Flags.FFlagProfileInspectAndBuyKeepUpsellDialogOpen)

local ReactFocusNavigation = require(ProfilePlatformParent.ReactFocusNavigation)

local FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 = require(ProfilePlatform.Flags.FFlagSocialEnableProfileInspectAndBuyAnalyticsV2)

local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(ProfilePlatformParent.InputHandlers)

local View = Foundation.View
local FoundationText = Foundation.Text
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local EnumsOrientation = Foundation.Enums.Orientation
local IconName = Foundation.Enums.IconName
local getIconRichText = Foundation.Utility.getIconRichText

local function AmountLine(tbl1)
    local var1 = NumberLocalization.localize(tbl1.amount, LocalizationService.RobloxLocaleId)
    local str1 = if tbl1.isAlert then "text-title-medium content-alert" else "text-body-medium content-default"

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "row align-y-center gap-large size-full-0 auto-y"
        },
        {
            Label = React.createElement(View, { LayoutOrder = 1, tag = "fill auto-y" }, {
                Text = React.createElement(FoundationText, { Text = tbl1.label, tag = `auto-xy text-align-x-left {str1}` })
            }),
            Amount = React.createElement(View, { LayoutOrder = 2, tag = "auto-xy" }, {
                Text = React.createElement(FoundationText, {
                    Text = `{getIconRichText(IconName.Robux)} {var1}`,
                    RichText = true,
                    tag = `auto-xy text-align-x-right {str1}`
                })
            })
        }
    )
end

local function InsufficientRobuxDialog(tbl1)
    local var1 = useNavigation()
    local var2 = if FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then useProfileAnalyticsContext() else nil
    local var3 = tbl1.navigation.state.params or {}
    local totalPrice = var3.totalPrice or 0
    local var4 = if FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase then RobloxAppHooks.useLocalRobuxBalance() else nil

    if not FFlagProfileInspectAndBuyRefreshBalanceAfterPurchase or var4 == nil then
        var4 = var3.robuxBalance or 0
    end

    local amount = math.max(totalPrice - var4, 0)

    if FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then
        React.useEffect(function()
            var2.fireAnalyticsEvent(EventNames.InspectAvatarInsufficientRobuxShown, { totalPrice = totalPrice })
        end, { var2, totalPrice })
    end

    local var5 = useLocalization({
        title = "IAPExperience.InsufficientRobux.Title.InsufficientRobux",
        currentBalance = "IAPExperience.InsufficientRobux.Text.CurrentBalance",
        missingRobux = "IAPExperience.InsufficientRobux.Text.MissingRobux",
        orderTotal = "IAPExperience.PurchasePrompt.Label.TotalPriceV2",
        buyRobux = "IAPExperience.InsufficientRobux.Action.BuyRobux"
    })

    local onClose = React.useCallback(function()
        var1.goBack()
    end, { var1 })

    local var7 = useOpenRobuxUpsell(totalPrice)

    local var8 = if FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then React.useCallback(function()
        var2.fireAnalyticsEvent(EventNames.InspectAvatarBuyRobuxClicked, { totalPrice = totalPrice })

        var7()
    end, { var7, var2, totalPrice }) else nil

    if FFlagProfileInspectAndBuyKeepUpsellDialogOpen then
        React.useEffect(function()
            if totalPrice <= var4 then
                onClose()
            end
        end, { var4, totalPrice, onClose })
    end

    local var9, var10

    if FFlagProfileInspectAndBuyAutoFocus then
        var9, var10 = ReactFocusNavigation.useDefaultFocusBehavior()
    else
        var10 = nil
        var9 = nil
    end

    local customEventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    arg1:cancel()
                    onClose()
                end)
            }
        }
    end, { onClose })

    local createElement = React.createElement
    local var12 = AppFocusRoot
    local tbl2 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        isIsolated = true,
        customEventHandlers = customEventHandlers
    }
    local tbl3 = { Dialog = 0 }
    local createElement2 = React.createElement
    local root = Dialog.Root
    local tbl4 = {
        size = DialogSize.Small,
        onClose = onClose,
        hasBackdrop = true,
        ref = 0
    }
    if not FFlagProfileInspectAndBuyAutoFocus then
        var10 = nil
    end

    tbl4.ref = var10
    local tbl5 = {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var5.title }),
        Content = React.createElement(Dialog.Content, { LayoutOrder = 2 }, {
            PriceBoxPadding = React.createElement(View, {
                tag = "size-full-0 auto-y padding-xxsmall"
            }, {
                PriceBox = React.createElement(
                    View,
                    {
                        tag = "col gap-large size-full-0 auto-y padding-medium stroke-standard stroke-default radius-medium"
                    },
                    {
                        BalanceLines = React.createElement(View, {
                            LayoutOrder = 1,
                            tag = "col gap-xsmall size-full-0 auto-y"
                        }, {
                            CurrentBalance = React.createElement(AmountLine, { layoutOrder = 1, label = var5.currentBalance, amount = var4 }),
                            MissingRobux = React.createElement(AmountLine, { layoutOrder = 2, label = var5.missingRobux, amount = amount, isAlert = true })
                        }),
                        OrderTotal = React.createElement(AmountLine, { layoutOrder = 2, label = var5.orderTotal, amount = totalPrice })
                    }
                )
            })
        }),
        Actions = 0
    }

    local createElement3 = React.createElement
    local actions = Dialog.Actions
    local tbl6 = {
        LayoutOrder = 3,
        orientation = EnumsOrientation.Horizontal,
        actions = 0
    }
    local tbl7 = {
        text = var5.buyRobux,
        variant = ButtonVariant.Emphasis,
        ref = 0,
        onActivated = 0
    }

    if not FFlagProfileInspectAndBuyAutoFocus then
        var9 = nil
    end

    tbl7.ref = var9

    if not FFlagSocialEnableProfileInspectAndBuyAnalyticsV2 then
        var8 = var7
    end

    tbl7.onActivated = var8
    tbl6.actions = { tbl7 }
    tbl5.Actions = createElement3(actions, tbl6)
    tbl3.Dialog = createElement2(root, tbl4, tbl5)
    return createElement(var12, tbl2, tbl3)
end

return InsufficientRobuxDialog
