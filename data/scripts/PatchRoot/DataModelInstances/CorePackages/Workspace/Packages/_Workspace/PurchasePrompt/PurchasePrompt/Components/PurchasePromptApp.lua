-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)
local Roact = PurchasePromptDeps.Roact
local _Rodux = PurchasePromptDeps.Rodux
local RoactRodux = PurchasePromptDeps.RoactRodux
local _Provider = PurchasePromptDeps.UIBlox.Style.Provider
local LocaleProvider = require(PurchasePromptParent.IAPExperience).Locale.LocaleProvider
local Toast = require(PurchasePromptParent.ToastLite).Components.Toast

local _Reducer = require(PurchasePrompt.Reducers.Reducer)
local _ABTest = require(PurchasePrompt.Services.ABTest)
local _Network = require(PurchasePrompt.Services.Network)
local _Analytics = require(PurchasePrompt.Services.Analytics)
local _PlatformInterface = require(PurchasePrompt.Services.PlatformInterface)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local _Thunk = require(PurchasePrompt.Thunk)

local EventConnections = require(script.Parent.Connection.EventConnections)
local LayoutValuesProvider = require(script.Parent.Connection.LayoutValuesProvider)
local provideRobloxLocale = require(script.Parent.Connection.provideRobloxLocale)
local PurchasePromptPolicy = require(PurchasePrompt.Components.Connection.PurchasePromptPolicy)

local ProductPurchaseContainer = require(script.Parent.ProductPurchase.ProductPurchaseContainer)
local RobuxUpsellContainer = require(script.Parent.RobuxUpsell.RobuxUpsellContainer)
local SubscriptionPurchaseContainer = require(script.Parent.SubscriptionPurchase.SubscriptionPurchaseContainer)
local renderWithCoreScriptsStyleProvider = require(script.Parent.Connection.renderWithCoreScriptsStyleProvider)
local FocusNavigationOptimizationTelemetry = require(PurchasePrompt.Events.FocusNavigationOptimizationTelemetry)
local SelectionCursorProvider = require(PurchasePromptParent.UIBlox).App.SelectionImage.SelectionCursorProvider
local ReactFocusNavigation = require(PurchasePromptParent.ReactFocusNavigation)

local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
local FocusNavigationUtils = require(PurchasePromptParent.FocusNavigationUtils)
local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local GetFFlagEnableToastLiteRender = require(PurchasePrompt.Flags.GetFFlagEnableToastLiteRender)
local SharedFlags = require(PurchasePromptParent.SharedFlags)
local FFlagAddCursorProviderToPurchasePromptApp = SharedFlags.FFlagAddCursorProviderToPurchasePromptApp
local FFlagPurchasePromptSubtitleForTimedOptions = SharedFlags.FFlagPurchasePromptSubtitleForTimedOptions

local RequestType = require(PurchasePrompt.Enums.RequestType)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local bool1 = game:DefineFastFlag("PurchasePromptAppConditionalFocusNavigation", false)

local bool2 = game:DefineFastFlag("PurchasePromptAppTrackRenderPerformance", false)

local var1 = Roact.Component:extend("PurchasePromptApp")

function var1.init(arg1)
    arg1.state = {
        isTenFootInterface = ExternalSettings.new().isTenFootInterface()
    }

    arg1.renderCount = 0
    arg1.lastRenderTime = 0
end

function var1.hasAnyActivePrompt(arg1): boolean
    if not bool1 then
        return true
    end

    if not arg1.props.store then
        return false
    end

    local state = arg1.props.store:getState()
    local promptState = state.promptState
    local requestType = state.promptRequest.requestType

    return not (promptState == PromptState.None and requestType == RequestType.None)
end

function var1.trackRenderPerformance(arg1)
    if not bool2 then
        return
    end

    arg1.renderCount += 1
    local lastRenderTime = tick()
    local var2 = lastRenderTime - arg1.lastRenderTime

    if arg1.renderCount > 1 then
        local var3 = var2 * 1000
        LoggingProtocol.default:logRobloxTelemetryStat(
            FocusNavigationOptimizationTelemetry.RerenderTimingStat,
            var3,
            {
                optimizationEnabled = tostring(bool1)
            }
        )
    end
    arg1.lastRenderTime = lastRenderTime
end

function var1.renderWithStyle(_, arg1)
    return renderWithCoreScriptsStyleProvider(arg1)
end

function var1.render(arg1)
    return provideRobloxLocale(function()
        local tbl1 = { LocaleProvider = 0, EventConnections = 0, Toast = 0 }
        local createElement = Roact.createElement
        local var2 = LocaleProvider
        local tbl2 = {
            locale = LocalizationService.RobloxLocaleId
        }
        local tbl3 = {
            ProductPurchaseContainer = Roact.createElement(ProductPurchaseContainer, {
                subtitleView = if FFlagPurchasePromptSubtitleForTimedOptions then arg1.props.subtitleView else nil,
                network = arg1.props.network
            }),
            RobuxUpsellContainer = Roact.createElement(RobuxUpsellContainer, { network = arg1.props.network }),
            SubscriptionPurchaseContainer = Roact.createElement(SubscriptionPurchaseContainer)
        }
        tbl1.LocaleProvider = createElement(var2, tbl2, tbl3)

        tbl1.EventConnections = Roact.createElement(EventConnections)
        tbl1.Toast = if GetFFlagEnableToastLiteRender() then Roact.createElement(Toast) else nil

        local var3 = FFlagAddCursorProviderToPurchasePromptApp and arg1:hasAnyActivePrompt()
        local element = Roact.createElement("Folder", nil, tbl1)

        if var3 then
            arg1:trackRenderPerformance()

            element = {
                CursorProvider = Roact.createElement(SelectionCursorProvider, {}, {
                    FocusNavigationProvider = Roact.createElement(
                        ReactFocusNavigation.FocusNavigationContext.Provider,
                        { value = focusNavigationService },
                        {
                            FocusNavigationRegistryProvider = Roact.createElement(Provider, nil, {
                                FocusNavigationCoreScriptsWrapper = Roact.createElement(
                                    FocusRoot,
                                    {
                                        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                                        isIsolated = true,
                                        isAutoFocusRoot = true
                                    },
                                    element
                                )
                            })
                        }
                    )
                })
            }
        end

        return Roact.createElement(RoactRodux.StoreProvider, {
            store = arg1.props.store
        }, {
            StyleProvider = arg1:renderWithStyle({
                LayoutValuesProvider = Roact.createElement(
                    LayoutValuesProvider,
                    {
                        isTenFootInterface = arg1.state.isTenFootInterface
                    },
                    {
                        PolicyProvider = Roact.createElement(PurchasePromptPolicy.Provider, { policy = { PurchasePromptPolicy.Mapper } }, element)
                    }
                )
            })
        })
    end)
end

return var1
