-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local CancelSubscriptionApp = script:FindFirstAncestor("CancelSubscriptionApp")
local CancelSubscriptionAppParent = CancelSubscriptionApp.Parent
local Rodux = require(CancelSubscriptionAppParent.Rodux)
local ReactRoblox = require(CancelSubscriptionAppParent.ReactRoblox)
local RoactRodux = require(CancelSubscriptionAppParent.RoactRodux)
local React = require(CancelSubscriptionAppParent.React)
local HttpRequest = require(CancelSubscriptionAppParent.HttpRequest)
local DesignTokenProvider = require(CancelSubscriptionAppParent.Style).DesignTokenProvider
local AppStyleProvider = require(CancelSubscriptionAppParent.Style).AppStyleProvider
local LocalizationProvider = require(CancelSubscriptionAppParent.Localization).LocalizationProvider
local Localization = require(CancelSubscriptionAppParent.InExperienceLocales).Localization
local ReactFocusNavigation = require(CancelSubscriptionAppParent.ReactFocusNavigation)
local Provider = require(CancelSubscriptionAppParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider

local Foundation = require(CancelSubscriptionAppParent.Foundation)
local UIBlox = require(CancelSubscriptionAppParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider

local CancelSubscriptionReducer = require(CancelSubscriptionApp.Store.Reducers.CancelSubscriptionReducer)
local CancelSubscriptionApp2 = require(CancelSubscriptionApp.CancelSubscriptionApp)
local NetworkContext = require(CancelSubscriptionAppParent.EconomyCommonCoreScriptHooks).NetworkContext
local FFlagLuaAppDefaultHttpRetry = require(CancelSubscriptionAppParent.SharedFlags).FFlagLuaAppDefaultHttpRetry

local style = { themeName = "dark", fontName = "gotham" }

local function createFocusNavigationService() -- Luacid: Inlined by compiler; 1 call site recovered
    return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

local function createNetworkImpl()
    return HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            return (HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3))
        end,
        maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("RenderCancelSubscriptionAppHttpRetryCount", 4) else nil
    })
end

local function createStore() -- Luacid: Inlined by compiler; 1 call site recovered
    return Rodux.Store.new(CancelSubscriptionReducer, nil, { Rodux.makeThunkMiddleware() })
end

local function renderCancelSubscriptionApp()
    local cancelSubscriptionApp = Instance.new("Folder")
    cancelSubscriptionApp.Name = "CancelSubscriptionApp"
    cancelSubscriptionApp.Parent = CoreGui
    local store = createStore()

    local value = createNetworkImpl()
    local focusNavigationService = createFocusNavigationService()

    local localizationProvider = React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            StyleProvider = React.createElement(AppStyleProvider, { style = style }, {
                NetworkProvider = React.createElement(NetworkContext.Provider, { value = value }, {
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, { store = store }, {
                        DesignTokenProvider = React.createElement(DesignTokenProvider, {
                            tokenMappers = {}
                        }, {
                            CursorProvider = React.createElement(SelectionCursorProvider, {}, {
                                NewCursorProvider = React.createElement(CursorProvider, {}, {
                                    FocusNavigationProvider = React.createElement(
                                        ReactFocusNavigation.FocusNavigationContext.Provider,
                                        { value = focusNavigationService },
                                        {
                                            FocusNavigationRegistryProvider = React.createElement(Provider, nil, { CancelSubscriptionApp = React.createElement(CancelSubscriptionApp2) })
                                        }
                                    )
                                })
                            })
                        })
                    })
                })
            })
        }
    )

    local element2 = React.createElement(
        Foundation.FoundationProvider,
        {
            colorMode = Foundation.Enums.ColorMode.Dark
        },
        { LocalizationProvider = localizationProvider }
    )

    local root = ReactRoblox.createRoot(cancelSubscriptionApp)
    root:render(element2)
    return root
end

return renderCancelSubscriptionApp
