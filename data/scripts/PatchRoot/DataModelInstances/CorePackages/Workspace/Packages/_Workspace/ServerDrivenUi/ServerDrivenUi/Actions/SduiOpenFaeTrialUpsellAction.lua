-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local getSduiApiStore = require(ServerDrivenUiParent.SduiSharedUtilities).getSduiApiStore
local setPromptDismissedInPageScope = require(ServerDrivenUiParent.PromptsServerDrivenUi).setPromptDismissedInPageScope
local startFacialAgeEstimation = require(ServerDrivenUiParent.SocialUpsell).Thunks.startFacialAgeEstimation
local RobloxSubscriptionPurchaseApp = require(ServerDrivenUiParent.RobloxSubscriptionPurchaseApp)
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local SubscriptionGrantType = RobloxSubscriptionPurchaseApp.SubscriptionGrantType
local claimTrial = RobloxSubscriptionPurchaseApp.Network.claimTrial

local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local NavigateDown = require(ServerDrivenUiParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagRobloxPlusUpsellRefreshOnComplete = SharedFlags.FFlagRobloxPlusUpsellRefreshOnComplete
local FFlagSduiDismissPromptPageScope = SharedFlags.FFlagSduiDismissPromptPageScope
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local UrlBuilder = require(ServerDrivenUiParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerDrivenUiParent.UrlBuilder).UrlBase

local urlBuilder = UrlBuilder.new({
    base = UrlBase.WWW,
    path = "plus",
    query = {
        { name = "faeFreeTrialConfirmation", value = "true", optional = false },
        { name = "t", value = "{t}", optional = false }
    }
})

local function SduiOpenFaeTrialUpsellAction(arg1, _, arg2)
    local dispatch = arg2.dependencies.dispatch
    local localization = arg2.dependencies.localization
    local actionParams = if FFlagRobloxPlusUpsellRefreshOnComplete then arg1 and arg1.actionParams or nil else nil
    local promptType = if FFlagRobloxPlusUpsellRefreshOnComplete then actionParams and actionParams.promptType else nil
    local title = localization:Format("Feature.RobloxSubscription.Title.AgeCheckTrial")
    local description = localization:Format("Feature.RobloxSubscription.Description.AgeCheckTrial")
    local ctaText = localization:Format("Feature.FAE.Action.Continue")

    local tbl1 = {
        name = AppPage.RobloxSubscriptionUpsell,
        extraProps = {
            purchaseUIOptions = {
                title = title,
                description = description,
                ctaText = ctaText,
                skipGuacPolicy = true,
                showLegalDisclosure = true,
                noPurchaseMethodRequired = true
            },
            surfaceName = SurfaceName.HomepageFaeTrialBanner,
            surfaceContext = SurfaceContext.InApp,
            onCtaOverride = function(callback, arg3)
                local function openConfirmationWebview(onClose)
                    local tbl1 = {
                        name = AppPage.GenericWebPage,
                        detail = urlBuilder({ t = tostring(os.time()) }),
                        extraProps = { title = "", onClose = onClose }
                    }

                    if FFlagSignalsNavP3Dispatch then
                        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
                        return
                    end
                    dispatch(NavigateDown(tbl1))
                end

                dispatch(startFacialAgeEstimation("FacialAgeEstimationHomepagePlusFreeTrialBanner", function() -- name: onFaeSuccess
                    claimTrial(SubscriptionGrantType.FaeFreeTrial):andThen(function()
                        local var4 = callback
                        var4 = FFlagRobloxPlusUpsellRefreshOnComplete and function()
                            local dismissEntry = getSduiApiStore().dismissEntry
                            if FFlagSduiDismissPromptPageScope then
                                if typeof(promptType) == "string" then
                                    if dismissEntry then
                                        dismissEntry(promptType)
                                    end

                                    if typeof(arg2.configKey) == "string" and arg2.configKey ~= "" then
                                        setPromptDismissedInPageScope(arg2.configKey, promptType)
                                    end
                                end
                            elseif dismissEntry and typeof(promptType) == "string" then
                                dismissEntry(promptType)
                            end

                            callback()
                        end or var4

                        task.delay(1, function()
                            openConfirmationWebview(var4)
                        end)
                    end):catch(function(arg4)
                        arg2.dependencies.logger.reportError(SduiErrorType.ActionNetworkRequestFailed, {
                            name = SduiActionType.OpenFaeTrialUpsell,
                            message = `claimTrial failed: {SduiParseHelpers.stringifyValue(arg4)}`
                        }, arg2.appPage)
                    end)
                end, arg3, "HomepagePlusFreeTrialBanner", false, true))
            end
        }
    }

    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    dispatch(NavigateDown(tbl1))
end

return SduiOpenFaeTrialUpsellAction
