-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local ColorMode = require(InExperienceSideSheetParent.Foundation).Enums.ColorMode

local Chrome = require(InExperienceSideSheetParent.Chrome)
local isPioneerLaunch = require(InExperienceSideSheetParent.PioneerUtils).isPioneerLaunch
local Localization = require(InExperienceSideSheetParent.InExperienceLocales).Localization
local LocalizationProvider = require(InExperienceSideSheetParent.Localization).LocalizationProvider
local React = require(InExperienceSideSheetParent.React)
local RoactNavigation = require(InExperienceSideSheetParent.RoactNavigation)
local RoactRodux = require(InExperienceSideSheetParent.RoactRodux)
local Rodux = require(InExperienceSideSheetParent.Rodux)
local Style = require(InExperienceSideSheetParent.Style)
local UIBlox = require(InExperienceSideSheetParent.UIBlox)

local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagEnableDrawerFocusNav = SharedFlags.FFlagEnableDrawerFocusNav
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav

local UniversalAppPolicy = require(InExperienceSideSheetParent.UniversalAppPolicy)
local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies
local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy

local Constants = UIBlox.App.Style.Constants
local UiModeStyleProvider = Style.UiModeStyleProvider
local UnibarStyle = Chrome.UnibarStyle

local ReactFocusNavigation = require(InExperienceSideSheetParent.ReactFocusNavigation)
local Provider = require(InExperienceSideSheetParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local focusNavigationService = if FFlagSideSheetFocusNav then ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui) else nil

local value = {
    isFocused = function(): boolean
        return true
    end,
    addListener = function(_: string, _: (...any) -> (...any))
        return {
            remove = function() end
        }
    end
}

local function wrapWithProviders(arg1, tbl2, arg2)
    local store = arg2 or Rodux.Store.new(function(arg3)
        return arg3 or {}
    end)

    if isPioneerLaunch() then
        arg1 = React.createElement(RoactAppPolicy.Provider, { policy = { AppFeaturePolicies } }, arg1)
    end

    for _, value in tbl2 do
        arg1 = React.createElement(value, nil, arg1)
    end

    if FFlagEnableDrawerFocusNav then
        arg1 = React.createElement(RoactNavigation.Provider, { value = value }, arg1)
    end

    local createElement = React.createElement
    local storeProvider = RoactRodux.StoreProvider
    local tbl3 = { store = store }
    local tbl4 = { LocalizationProvider = 0 }
    local createElement2 = React.createElement
    local var2 = LocalizationProvider
    local tbl5 = {
        localization = Localization.new(LocalizationService.RobloxLocaleId)
    }
    local tbl6 = {
        UiModeStyleProvider = React.createElement(
            UiModeStyleProvider,
            {
                style = {
                    themeName = ColorMode.Dark,
                    fontName = Constants.FontName.Gotham
                }
            },
            {
                UnibarStyleProvider = if FFlagSideSheetFocusNav then React.createElement(UnibarStyle.Provider, {}, {
                    FocusNavigationProvider = React.createElement(
                        ReactFocusNavigation.FocusNavigationContext.Provider,
                        { value = focusNavigationService },
                        {
                            Registry = React.createElement(Provider, nil, arg1)
                        }
                    )
                }) else React.createElement(UnibarStyle.Provider, {}, arg1)
            }
        )
    }
    tbl4.LocalizationProvider = createElement2(var2, tbl5, tbl6)
    return createElement(storeProvider, tbl3, tbl4)
end

return wrapWithProviders
