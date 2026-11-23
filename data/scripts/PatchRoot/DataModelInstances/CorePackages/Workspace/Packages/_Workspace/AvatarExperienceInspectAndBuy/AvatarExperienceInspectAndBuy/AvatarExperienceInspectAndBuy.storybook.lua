-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")

local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local ReactRoblox = require(AvatarExperienceInspectAndBuyParent.Dev.ReactRoblox)
local UIBlox = require(AvatarExperienceInspectAndBuyParent.UIBlox)
local DesignTokenProvider = require(AvatarExperienceInspectAndBuyParent.Style).DesignTokenProvider
local LocalizationProvider = require(AvatarExperienceInspectAndBuyParent.Localization).LocalizationProvider
local RoactRodux = require(AvatarExperienceInspectAndBuyParent.RoactRodux)
local Rodux = require(AvatarExperienceInspectAndBuyParent.Rodux)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

UIBlox.init(require(AvatarExperienceInspectAndBuyParent.Dev.RobloxAppUIBloxConfig))

local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local function createLocalization()
    return {
        Format = function(_, str1: string): string
            return str1
        end,
        GetLocale = function(): string
            return "locale"
        end
    }
end

local function createStore()
    local reducer = Rodux.createReducer({}, {})
    return Rodux.Store.new(reducer, nil, { Rodux.makeThunkMiddleware({}) })
end

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local tbl2 = {
    Console = Device.Console,
    Desktop = Device.Desktop
}

local tbl3 = {
    Default = { themeName = "Dark", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

return {
    name = "AvatarExperienceInspectAndBuy",
    storyRoot = AvatarExperienceInspectAndBuy,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]

            return React.createElement(LocalizationProvider, {
                localization = createLocalization()
            }, {
                AppStyleProvider = React.createElement(AppStyleProvider, {
                    style = arg2 and tbl3[arg2.theme] or tbl3.Default
                }, {
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                        store = createStore()
                    }, {
                        DesignTokenProvider = React.createElement(DesignTokenProvider, {
                            tokenMappers = {}
                        }, {
                            FoundationProvider = React.createElement(
                                FoundationProvider,
                                {
                                    colorMode = colorMode,
                                    device = tbl2[arg2.platform],
                                    preferences = arg2.settings
                                },
                                {
                                    Child = React.createElement(arg1, arg2)
                                }
                            )
                        })
                    })
                })
            })
        end
    end
}
