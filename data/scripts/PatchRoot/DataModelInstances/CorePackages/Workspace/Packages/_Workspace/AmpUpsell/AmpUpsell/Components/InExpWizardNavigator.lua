-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local RoactNavigation = require(AmpUpsellParent.RoactNavigation)
local React = require(AmpUpsellParent.React)
local WizardContainer = require(AmpUpsell.Components.WizardContainer)
local ActionTypeEnum = require(AmpUpsell.Common.Enums).ActionTypeEnum

local useNavigation = require(AmpUpsellParent.Navigation).useNavigation
local createLazyComponent = require(AmpUpsellParent.RoactUtils).Components.createLazyComponent
local FAEUpsellContainer = require(AmpUpsell.Components.Upsells.FacialAgeEstimation.FAEUpsellContainer)
local IDVUpsellContainer = require(AmpUpsell.Components.Upsells.IdentityVerification.IDVUpsellContainer)
local Cryo = require(AmpUpsellParent.Cryo)
local AppScreens = require(AmpUpsell.Common.AppScreens)
local WebViewServiceWrapper = require(AmpUpsell.Components.WebViewServiceWrapper)
local UrlBuilder = require(AmpUpsellParent.UrlBuilder).UrlBuilder
local AccountSettingsUpsell = require(AmpUpsell.Components.Upsells.AccountSettingsUpsell)
local VPCUpsellContainer = require(AmpUpsell.Components.Upsells.ParentalRequest.VPCUpsellContainer)
local RobloxSubscriptionPurchaseApp = require(AmpUpsellParent.RobloxSubscriptionPurchaseApp)
local RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionPurchaseApp.RobloxSubscriptionFlowCompleteReason
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName

local function func1(arg1)
    local var1 = useNavigation()

    local openAccountSettingsUpsell = React.useCallback(function(arg2)
        local extraProps = Cryo.Dictionary.join(arg2 or {}, {
            openAccountSettings = function(title)
                var1.push(AppScreens.GenericWebPage, { detail = UrlBuilder.static.settings.account(), extraProps = { title = title } })
            end
        })

        var1.push("AccountSettingsUpsell", { extraProps = extraProps })
    end, { var1 })

    local var3 = React.useCallback(function(extraProps)
        var1.push("IDVUpsell", { extraProps = extraProps })
    end, { var1 })

    local openUpsells = {
        [ActionTypeEnum.AgeEstimation] = React.useCallback(function(extraProps)
            var1.push("FAEUpsell", { extraProps = extraProps })
        end, { var1 }),
        [ActionTypeEnum.GovernmentId] = var3,
        [ActionTypeEnum.Subscription] = React.useCallback(function(extraProps)
            var1.push("SubscriptionUpsell", { extraProps = extraProps })
        end, { var1 }),
        [ActionTypeEnum.ParentConsent] = React.useCallback(function(extraProps)
            var1.push("VPCUpsell", { extraProps = extraProps })
        end, { var1 }),
        [ActionTypeEnum.ParentLink] = React.useCallback(function(extraProps)
            var1.push("VPCUpsell", { extraProps = extraProps })
        end, { var1 })
    }

    local var4 = Cryo.Dictionary.join(arg1 or {}, { openUpsells = openUpsells, openAccountSettingsUpsell = openAccountSettingsUpsell })

    return React.createElement(WizardContainer, var4)
end

local createRobloxStackNavigator = RoactNavigation.createRobloxStackNavigator

local tbl1 = {
    FAEUpsell = {
        screen = createLazyComponent(function()
            return FAEUpsellContainer
        end),
        navigationOptions = { transparent = true, overlayEnabled = true }
    }
}

local tbl2 = {
    IDVUpsell = {
        screen = createLazyComponent(function()
            return function()
                local var1 = useNavigation().getParam("extraProps")
                return React.createElement(IDVUpsellContainer, var1)
            end
        end),
        navigationOptions = { transparent = true, overlayEnabled = true }
    }
}

local tbl3 = {
    AccountSettingsUpsell = {
        screen = createLazyComponent(function()
            return function()
                local var1 = useNavigation().getParam("extraProps")
                return React.createElement(AccountSettingsUpsell, var1)
            end
        end),
        navigationOptions = { transparent = true, overlayEnabled = true }
    }
}

local tbl4 = {
    VPCUpsell = {
        screen = createLazyComponent(function()
            return function()
                local var1 = useNavigation().getParam("extraProps")
                return React.createElement(VPCUpsellContainer, var1)
            end
        end),
        navigationOptions = { transparent = true, overlayEnabled = true }
    }
}

local tbl5 = {
    [AppScreens.GenericWebPage] = {
        screen = function()
            local var1 = useNavigation()
            local url = var1.getParam("detail")
            local param2 = var1.getParam("extraProps")
            WebViewServiceWrapper.new({
                url = url,
                title = param2.title or "",
                closeCallback = function()
                    var1.pop()

                    if param2.onClose then
                        param2.onClose()
                    end
                end
            }):open()
        end,
        navigationOptions = { transparent = true, overlayEnabled = true }
    }
}

local robloxStackNavigator = createRobloxStackNavigator({
    {
        Wizard = {
            screen = function(arg1)
                local var1 = useNavigation().getParam("extraProps")

                if not var1 and arg1 and arg1.screenProps then
                    var1 = arg1.screenProps.extraProps
                end
                return React.createElement(func1, var1)
            end,
            navigationOptions = { transparent = true, overlayEnabled = true }
        }
    },
    tbl1,
    tbl2,
    {
        SubscriptionUpsell = {
            screen = function(arg1)
                local param = arg1.navigation.getParam("extraProps") or {}

                React.useEffect(function()
                    local var1 = RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
                        param.purchaseUIOptions,
                        {
                            onFlowComplete = function(arg2)
                                if arg2 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
                                    if param.onSuccess then
                                        param.onSuccess()
                                    end

                                    return
                                end
                                if arg2 ~= RobloxSubscriptionFlowCompleteReason.UpsellPurchaseFailed then
                                    if param.onCancel then
                                        param.onCancel()
                                    end

                                    return
                                end

                                if param.onFailure then
                                    param.onFailure()
                                    return
                                end
                                if param.onCancel then
                                    param.onCancel()
                                end
                            end
                        },
                        nil,
                        param.surfaceName or SurfaceName.Unspecified,
                        param.surfaceContext or RobloxSubscriptionPurchaseApp.SurfaceContext.Unspecified,
                        nil,
                        param.analyticsContext
                    )
                    return function()
                        if var1 then
                            var1()
                        end
                    end
                end, {
                    param.analyticsContext,
                    param.onCancel,
                    param.onFailure,
                    param.onSuccess,
                    param.purchaseUIOptions,
                    param.surfaceContext,
                    param.surfaceName
                })

                return React.createElement(React.Fragment, {})
            end,
            navigationOptions = { transparent = true, overlayEnabled = false }
        }
    },
    tbl3,
    tbl4,
    tbl5
}, {
    initialRouteName = "Wizard",
    transitionConfig = function()
        return {
            transitionSpec = { frequency = 100000, dampingRatio = 1 }
        }
    end
})

return (RoactNavigation.createAppContainer(robloxStackNavigator))
