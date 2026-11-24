-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local ReactRoblox = require(CurrencyTransfersParent.ReactRoblox)
local Rodux = require(CurrencyTransfersParent.Rodux)
local RoactRodux = require(CurrencyTransfersParent.RoactRodux)
local React = require(CurrencyTransfersParent.React)
local HttpRequest = require(CurrencyTransfersParent.HttpRequest)
local DesignTokenProvider = require(CurrencyTransfersParent.Style).DesignTokenProvider
local AppStyleProvider = require(CurrencyTransfersParent.Style).AppStyleProvider
local LocalizationProvider = require(CurrencyTransfersParent.Localization).LocalizationProvider
local Localization = require(CurrencyTransfersParent.InExperienceLocales).Localization
local ReactFocusNavigation = require(CurrencyTransfersParent.ReactFocusNavigation)
local Provider = require(CurrencyTransfersParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local UIBlox = require(CurrencyTransfersParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider

local InExperienceTransferApp = require(CurrencyTransfers.Components.InExperienceTransferApp)
local NetworkContext = require(CurrencyTransfersParent.EconomyCommonCoreScriptHooks).NetworkContext

local style = { themeName = "dark", fontName = "gotham" }

local function createFocusNavigationService() -- Luacid: Inlined by compiler; 1 call site recovered
    return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

local function createNetworkImpl()
    return HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            return (HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3))
        end,
        maxRetryCount = game:DefineFastInt("InExperienceTransferMaxHttpRequestRetries", 2),
        maxWaitTime = game:DefineFastInt("InExperienceTransferMaxHttpRequestWaitTime", 1)
    })
end

local function renderInExperienceTransferApp()
    local inExperienceTransferApp = Instance.new("Folder")
    inExperienceTransferApp.Name = "InExperienceTransferApp"
    inExperienceTransferApp.Parent = CoreGui

    local value = createNetworkImpl()
    local focusNavigationService = createFocusNavigationService()

    local store = Rodux.Store.new(function(arg1)
        return arg1 or {}
    end)

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
                                            FocusNavigationRegistryProvider = React.createElement(Provider, nil, { InExperienceTransferApp = React.createElement(InExperienceTransferApp) })
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

    local root = ReactRoblox.createRoot(inExperienceTransferApp)
    root:render(element)
    return root
end

return renderInExperienceTransferApp
