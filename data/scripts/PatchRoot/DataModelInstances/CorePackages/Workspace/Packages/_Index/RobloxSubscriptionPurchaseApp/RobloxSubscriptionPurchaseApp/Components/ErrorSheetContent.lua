-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)

local Sheet = Foundation.Sheet
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Button = Foundation.Button
local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens
local FillBehavior = Foundation.Enums.FillBehavior
local ButtonVariant = Foundation.Enums.ButtonVariant

local function mapErrorReasonToCopy(arg1, tbl1)
    local var1 = ({
        [ErrorReason.GenericError] = { tbl1.GenericErrorTitle, tbl1.GenericErrorBody },
        [ErrorReason.AlreadySubscribed] = { tbl1.AlreadySubscribedTitle, tbl1.AlreadySubscribedBody },
        [ErrorReason.UnsupportedPlatform] = { tbl1.UnsupportedPlatformTitle, tbl1.UnsupportedPlatformBody },
        [ErrorReason.ReferralIneligible] = { tbl1.GenericErrorTitle, tbl1.ReferralIneligibleBody },
        [ErrorReason.ReferralSelfReferral] = { tbl1.GenericErrorTitle, tbl1.ReferralSelfReferralBody }
    })[arg1]
    return if var1 then {
        title = var1[1],
        body = var1[2]
    } else {
        title = tbl1.GenericErrorTitle,
        body = tbl1.GenericErrorBody
    }
end

local function useErrorSheetSlots()
    local var1 = RobloxSubscriptionStore.get()
    local var2 = SignalsReact.useSignalState(var1.getErrorReason)
    local var3 = useTokens()
    local var4 = useLocalization({
        okButton = "Features.Transfers.Action.Ok",
        GenericErrorTitle = "Feature.RobloxSubscription.Title.GenericError",
        GenericErrorBody = "Feature.RobloxSubscription.Body.GenericError",
        AlreadySubscribedTitle = "Feature.RobloxSubscription.Title.AlreadySubscribed",
        AlreadySubscribedBody = "Feature.RobloxSubscription.Body.AlreadySubscribed",
        UnsupportedPlatformTitle = "Feature.RobloxSubscription.Title.UnsupportedPlatform",
        UnsupportedPlatformBody = "Feature.RobloxSubscription.Body.UnsupportedPlatform",
        ReferralIneligibleBody = "Feature.RobloxSubscription.Description.NoLongerValidReferralGenericError",
        ReferralSelfReferralBody = "Feature.RobloxSubscription.Message.AlreadySubscribed"
    })

    local var5 = React.useMemo(function()
        return (mapErrorReasonToCopy(var2, var4))
    end, { var2, var4 })

    local onActivated = React.useCallback(function()
        completeRobloxSubscriptionUpsellFlow()
    end, {})

    return React.useMemo(function()
        return {
            Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
                TitleRow = React.createElement(View, {
                    LayoutOrder = 1,
                    tag = "auto-xy gap-small row"
                }, {
                    Title = React.createElement(
                        FoundationText,
                        {
                            Text = var5.title,
                            tag = "auto-xy text-heading-small content-emphasis text-align-x-center"
                        }
                    )
                })
            }),
            Content = React.createElement(Sheet.Content, { LayoutOrder = 2 }, {
                Body = React.createElement(View, {
                    tag = "col size-full-0 auto-y align-x-center gap-medium padding-x-large"
                }, {
                    CenterIcon = React.createElement(Icon, { LayoutOrder = 1, name = IconName.TriangleExclamation, size = var3.Size.Size_1200 }),
                    BodyText = React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        Text = var5.body,
                        tag = "size-full-0 auto-y text-body-medium content-default text-align-x-center text-wrap"
                    })
                })
            }),
            Actions = React.createElement(Sheet.Actions, { LayoutOrder = 3 }, { React.createElement(
                    View,
                    {
                        LayoutOrder = 1,
                        tag = "row wrap auto-xy align-y-center align-x-center size-full-0 gap-medium"
                    },
                    { React.createElement(Button, {
                            LayoutOrder = 1,
                            text = var4.okButton,
                            onActivated = onActivated,
                            fillBehavior = FillBehavior.Fill,
                            variant = ButtonVariant.Emphasis
                        }) }
                ) })
        }
    end, { var5, var4.okButton, onActivated })
end

return useErrorSheetSlots
