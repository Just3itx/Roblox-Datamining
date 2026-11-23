-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Rodux = require(BulkPurchaseAppParent.Rodux)
local ReactRoblox = require(BulkPurchaseAppParent.ReactRoblox)
local RoactRodux = require(BulkPurchaseAppParent.RoactRodux)
local React = require(BulkPurchaseAppParent.React)
local HttpRequest = require(BulkPurchaseAppParent.HttpRequest)
local DesignTokenProvider = require(BulkPurchaseAppParent.Style).DesignTokenProvider
local AppStyleProvider = require(BulkPurchaseAppParent.Style).AppStyleProvider
local LocalizationProvider = require(BulkPurchaseAppParent.Localization).LocalizationProvider
local Localization = require(BulkPurchaseAppParent.InExperienceLocales).Localization
local ReactFocusNavigation = require(BulkPurchaseAppParent.ReactFocusNavigation)
local Provider = require(BulkPurchaseAppParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local UIBlox = require(BulkPurchaseAppParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider
local UniversalAppPolicy = require(BulkPurchaseAppParent.UniversalAppPolicy)
local UniversalAppPolicy2 = UniversalAppPolicy.UniversalAppPolicy
local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies

local BulkPurchaseApp2 = require(BulkPurchaseApp.BulkPurchaseApp)
local BulkPurchaseReducer = require(BulkPurchaseApp.Store.Reducers.BulkPurchaseReducer)
local NetworkContext = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).NetworkContext

local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)

local style = { themeName = "dark", fontName = "gotham" }

local function createFocusNavigationService() -- Luacid: Inlined by compiler; 1 call site recovered
    return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

local function createNetworkImpl()
    return HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            return (HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3))
        end,
        maxRetryCount = game:DefineFastInt("BulkPurchaseMaxHttpRequestRetries", 2),
        maxWaitTime = game:DefineFastInt("BulkPurchaseMaxHttpRequestWaitTime", 1)
    })
end

local function createStore() -- Luacid: Inlined by compiler; 1 call site recovered
    return Rodux.Store.new(BulkPurchaseReducer, nil, { Rodux.makeThunkMiddleware() })
end

local function renderBulkPurchaseApp()
    local bulkPurchaseApp = Instance.new("Folder")
    bulkPurchaseApp.Name = "BulkPurchaseApp"
    bulkPurchaseApp.Parent = CoreGui
    local store = createStore()

    local value = createNetworkImpl()
    local focusNavigationService = createFocusNavigationService()

    local element = React.createElement(
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
                                            FocusNavigationRegistryProvider = React.createElement(
                                                Provider,
                                                nil,
                                                FFlagAXAddPlusUpsellToBulkPurchase
                                                    and {
                                                        PolicyProvider = React.createElement(
                                                            UniversalAppPolicy2.Provider,
                                                            {
                                                                policy = { AppFeaturePolicies }
                                                            },
                                                            {
                                                                BulkPurchaseApp = React.createElement(BulkPurchaseApp2)
                                                            }
                                                        )
                                                    }
                                                    or {
                                                        BulkPurchaseApp = React.createElement(BulkPurchaseApp2)
                                                    }
                                            )
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

    local root = ReactRoblox.createRoot(bulkPurchaseApp)
    root:render(element)
    return root
end

return renderBulkPurchaseApp
