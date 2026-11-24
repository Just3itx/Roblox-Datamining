-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local Rodux = require(CommercePurchaseAppParent.Rodux)
local ReactRoblox = require(CommercePurchaseAppParent.ReactRoblox)
local RoactRodux = require(CommercePurchaseAppParent.RoactRodux)
local React = require(CommercePurchaseAppParent.React)
local HttpRequest = require(CommercePurchaseAppParent.HttpRequest)
local DesignTokenProvider = require(CommercePurchaseAppParent.Style).DesignTokenProvider
local AppStyleProvider = require(CommercePurchaseAppParent.Style).AppStyleProvider
local LocalizationProvider = require(CommercePurchaseAppParent.Localization).LocalizationProvider
local Localization = require(CommercePurchaseAppParent.InExperienceLocales).Localization
local ReactFocusNavigation = require(CommercePurchaseAppParent.ReactFocusNavigation)
local Provider = require(CommercePurchaseAppParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local UIBlox = require(CommercePurchaseAppParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider

local CommercePurchaseApp2 = require(CommercePurchaseApp.CommercePurchaseApp)
local CommercePurchaseReducer = require(CommercePurchaseApp.Store.Reducers.CommercePurchaseReducer)
local NetworkContext = require(CommercePurchaseAppParent.EconomyCommonCoreScriptHooks).NetworkContext

local style = { themeName = "dark", fontName = "gotham" }

local function createFocusNavigationService() -- Luacid: Inlined by compiler; 1 call site recovered
    return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

local function createNetworkImpl()
    return HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            return (HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3))
        end,
        maxRetryCount = game:DefineFastInt("CommercePurchaseMaxHttpRequestRetries", 2),
        maxWaitTime = game:DefineFastInt("CommercePurchaseMaxHttpRequestWaitTime", 1)
    })
end

local function createStore() -- Luacid: Inlined by compiler; 1 call site recovered
    return Rodux.Store.new(CommercePurchaseReducer, nil, { Rodux.makeThunkMiddleware() })
end

local function renderCommercePurchaseApp()
    local commercePurchaseApp = Instance.new("Folder")
    commercePurchaseApp.Name = "CommercePurchaseApp"
    commercePurchaseApp.Parent = CoreGui
    local store = createStore()

    local value = createNetworkImpl()
    local focusNavigationService = createFocusNavigationService()

    local element = React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        { React.createElement(AppStyleProvider, { style = style }, {
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
                                            FocusNavigationRegistryProvider = React.createElement(Provider, nil, { CommercePurchaseApp = React.createElement(CommercePurchaseApp2) })
                                        }
                                    )
                                })
                            })
                        })
                    })
                })
            }) }
    )

    local root = ReactRoblox.createRoot(commercePurchaseApp)
    root:render(element)
    return root
end

return renderCommercePurchaseApp
