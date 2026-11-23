-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VerifiedParentalConsentDialog = script:FindFirstAncestor("VerifiedParentalConsentDialog")
local VerifiedParentalConsentDialogParent = VerifiedParentalConsentDialog.Parent
local React = require(VerifiedParentalConsentDialogParent.React)
local ReactRoblox = require(VerifiedParentalConsentDialogParent.ReactRoblox)
local UIBlox = require(VerifiedParentalConsentDialogParent.UIBlox)
local DesignTokenProvider = require(VerifiedParentalConsentDialogParent.Style).DesignTokenProvider
local LocalizationProvider = require(VerifiedParentalConsentDialogParent.Localization).LocalizationProvider
local Localization = require(VerifiedParentalConsentDialogParent.RobloxAppLocales).Localization
local RoactRodux = require(VerifiedParentalConsentDialogParent.RoactRodux)
local Rodux = require(VerifiedParentalConsentDialogParent.Rodux)

UIBlox.init(require(VerifiedParentalConsentDialogParent.Dev.RobloxAppUIBloxConfig))
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local function createStore()
    local reducer = Rodux.createReducer({}, {})
    return Rodux.Store.new(reducer, nil, { Rodux.makeThunkMiddleware({}) })
end

local tbl1 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    name = "VerifiedParentalConsentDialog",
    storyRoot = VerifiedParentalConsentDialog,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(LocalizationProvider, {
                localization = Localization.new("en-us")
            }, {
                AppStyleProvider = React.createElement(AppStyleProvider, {
                    style = arg2 and tbl1[arg2.theme] or tbl1.Default
                }, {
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                        store = createStore()
                    }, {
                        DesignTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = React.createElement(arg1, arg2) })
                    })
                })
            })
        end
    end
}
