-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent
local React = require(RobloxSubscriptionPurchaseAppParent.React)
local ReactRoblox = require(RobloxSubscriptionPurchaseAppParent.ReactRoblox)
local UIBlox = require(RobloxSubscriptionPurchaseAppParent.UIBlox)
local DesignTokenProvider = require(RobloxSubscriptionPurchaseAppParent.Style).DesignTokenProvider
local LocalizationProvider = require(RobloxSubscriptionPurchaseAppParent.Localization).LocalizationProvider
local Localization = require(RobloxSubscriptionPurchaseAppParent.AppLocales).Localization
local RoactRodux = require(RobloxSubscriptionPurchaseAppParent.RoactRodux)
local Rodux = require(RobloxSubscriptionPurchaseAppParent.Rodux)

pcall(function()
    UIBlox.init(require(RobloxSubscriptionPurchaseAppParent.Dev.RobloxAppUIBloxConfig))
end)
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
    name = "RobloxSubscriptionPurchaseApp",
    storyRoot = script.Parent.Parent,
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
