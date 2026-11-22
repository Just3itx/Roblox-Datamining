-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local ReactRoblox = require(RobloxSubscriptionPurchaseAppParent.ReactRoblox)
local SignalsReact = require(RobloxSubscriptionPurchaseAppParent.SignalsReact)
local Style = require(RobloxSubscriptionPurchaseAppParent.Style)
local RoactRodux = require(RobloxSubscriptionPurchaseAppParent.RoactRodux)
local Rodux = require(RobloxSubscriptionPurchaseAppParent.Rodux)
local useSelectedTheme = require(RobloxSubscriptionPurchaseAppParent.RoactUtils).Hooks.useSelectedTheme
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local FoundationProvider = require(RobloxSubscriptionPurchaseAppParent.Foundation).FoundationProvider
local UIBlox = require(RobloxSubscriptionPurchaseAppParent.UIBlox)
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local CursorProvider = UIBlox.App.SelectionCursor.CursorProvider

local Localization = require(RobloxSubscriptionPurchaseAppParent.AppLocales).Localization
local LocalizationProvider = require(RobloxSubscriptionPurchaseAppParent.Localization).LocalizationProvider

local ProviderContainer = require(RobloxSubscriptionPurchaseAppParent.RoactUtils).Components.ProviderContainer

local RobloxSubscriptionContainer = require(RobloxSubscriptionPurchaseApp.Components.RobloxSubscriptionContainer)
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local FFlagSubscriptionPurchaseFollowsAppTheme = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagSubscriptionPurchaseFollowsAppTheme
local FFlagAppClassicThemeGreenButtonColors = Style.FFlagAppClassicThemeGreenButtonColors

local var1 = nil

local tbl1 = { Rodux.thunkMiddleware }

local function close()
    if var1 then
        var1()
        var1 = nil
    end
end

local function ThemedOverlay(tbl2)
    local var2 = useSelectedTheme()
    local themeName = if FFlagSubscriptionPurchaseFollowsAppTheme then SignalsReact.useSignalState(Style.AppFoundationThemeName.getAppFoundationThemeName) else nil

    local store = React.useMemo(function()
        return Rodux.Store.new(Rodux.combineReducers({}), nil, tbl1)
    end, {})

    local providers = React.useMemo(function()
        local result = {}
        table.insert(result, { class = RoactRodux.StoreProvider, props = { store = store } })

        table.insert(
            result,
            {
                class = StyleProviderWithDefaultTheme,
                props = {
                    withDarkTheme = var2 ~= "light",
                    withUiModeSupport = false
                }
            }
        )
        table.insert(
            result,
            {
                class = LocalizationProvider,
                props = {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                }
            }
        )
        table.insert(result, { class = SelectionCursorProvider, props = {} })

        table.insert(result, { class = CursorProvider, props = {} })

        return result
    end, { var2, store })

    local colorMode = if var2 == "light" then "Light" else "Dark"
    local tokenOverrides = if FFlagSubscriptionPurchaseFollowsAppTheme and FFlagAppClassicThemeGreenButtonColors then Style.getClassicThemeTokenOverrides(themeName, colorMode) else nil
    local createElement = React.createElement
    local var6 = FoundationProvider
    local tbl3 = { colorMode = colorMode, themeName = themeName, tokenOverrides = tokenOverrides }
    local tbl4 = { Providers = 0 }
    local createElement2 = React.createElement
    local var7 = ProviderContainer
    local tbl5 = { providers = providers }
    local tbl6 = {
        Sheet = React.createElement(RobloxSubscriptionContainer, {
            title = if tbl2.params then tbl2.params.title or nil else nil,
            message = if tbl2.params then tbl2.params.message or nil else nil,
            onClose = tbl2.onClose
        })
    }
    tbl4.Providers = createElement2(var7, tbl5, tbl6)
    return createElement(var6, tbl3, tbl4)
end

return {
    render = function(params)
        local var2 = RobloxSubscriptionStore.get()
        var2.triggerUnmountUI()

        local robloxSubscriptionPurchaseOverlay = Instance.new("Folder")
        robloxSubscriptionPurchaseOverlay.Name = "RobloxSubscriptionPurchaseOverlay"
        robloxSubscriptionPurchaseOverlay.Parent = game:GetService("CoreGui")

        local root = ReactRoblox.createRoot(robloxSubscriptionPurchaseOverlay)
        root:render(React.createElement(ThemedOverlay, { params = params, onClose = close }))

        local function cleanup()
            root:unmount()
            robloxSubscriptionPurchaseOverlay:Destroy()
        end

        var1 = cleanup
        var2.setOnUnmountUI(cleanup)

        return cleanup
    end,
    close = close
}
