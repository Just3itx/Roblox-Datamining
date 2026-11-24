-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local React = require(CommercePurchaseAppParent.React)
local ReactRoblox = require(CommercePurchaseAppParent.ReactRoblox)
local UIBlox = require(CommercePurchaseAppParent.UIBlox)
local DesignTokenProvider = require(CommercePurchaseAppParent.Style).DesignTokenProvider
local LocalizationProvider = require(CommercePurchaseAppParent.Localization).LocalizationProvider
local Localization = require(CommercePurchaseAppParent.InExperienceLocales).Localization
local RoactRodux = require(CommercePurchaseAppParent.RoactRodux)
local Rodux = require(CommercePurchaseAppParent.Rodux)

UIBlox.init(require(CommercePurchaseAppParent.Dev.RobloxAppUIBloxConfig))
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
    name = "CommercePurchaseApp",
    storyRoot = CommercePurchaseApp,
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
