-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local ReactRoblox = require(BulkPurchaseAppParent.ReactRoblox)
local UIBlox = require(BulkPurchaseAppParent.UIBlox)
local DesignTokenProvider = require(BulkPurchaseAppParent.Style).DesignTokenProvider
local LocalizationProvider = require(BulkPurchaseAppParent.Localization).LocalizationProvider
local Localization = require(BulkPurchaseAppParent.InExperienceLocales).Localization
local RoactRodux = require(BulkPurchaseAppParent.RoactRodux)
local Rodux = require(BulkPurchaseAppParent.Rodux)

UIBlox.init(require(BulkPurchaseAppParent.Dev.RobloxAppUIBloxConfig))
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
    name = "BulkPurchaseApp",
    storyRoot = BulkPurchaseApp,
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
