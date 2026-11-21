-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local UIBlox = require(AvatarExperienceUIKitParent.UIBlox)

UIBlox.init(require(AvatarExperienceUIKitParent.Dev.RobloxAppUIBloxConfig))
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local Rodux = require(AvatarExperienceUIKitParent.Dev.Rodux)
local DesignTokenProvider = require(AvatarExperienceUIKitParent.Style).DesignTokenProvider
local RoactRodux = require(AvatarExperienceUIKitParent.Dev.RoactRodux)
local AppStyleProvider = require(AvatarExperienceUIKitParent.Style).AppStyleProvider
local AppStyleProvider2 = UIBlox.App.Style.AppStyleProvider
local ReactRoblox = require(AvatarExperienceUIKitParent.Dev.ReactRoblox)
local LocalizationProvider = require(AvatarExperienceUIKitParent.Localization).LocalizationProvider

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
    return Rodux.Store.new(Rodux.createReducer({}, {}))
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
    name = "UIKit",
    group = "AvatarExperience",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]

            local var2 = arg2.definition.foundationOnly
                and {
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                        store = createStore()
                    }, {
                        FoundationProvider = React.createElement(FoundationProvider, {
                            colorMode = colorMode,
                            device = tbl2[arg2.platform],
                            preferences = arg2.settings,
                            scale = arg2.settings and arg2.settings.scale
                        }, {
                            Child = React.createElement(arg1, arg2)
                        })
                    })
                }
                or {
                    AppStyleProvider = React.createElement(AppStyleProvider2, {
                        style = arg2 and tbl3[arg2.theme] or tbl3.Default
                    }, {
                        StyleProvider = React.createElement(AppStyleProvider, {
                            style = arg2 and tbl3[arg2.theme] or tbl3.Default
                        }, {
                            StoreProvider = React.createElement(RoactRodux.StoreProvider, {
                                store = createStore()
                            }, {
                                DesignTokenProvider = React.createElement(DesignTokenProvider, {
                                    tokenMappers = {}
                                }, {
                                    FoundationProvider = React.createElement(FoundationProvider, {
                                        colorMode = colorMode,
                                        device = tbl2[arg2.platform],
                                        preferences = arg2.settings,
                                        scale = arg2.settings and arg2.settings.scale
                                    }, {
                                        Child = React.createElement(arg1, arg2)
                                    })
                                })
                            })
                        })
                    })
                }

            return React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1
                },
                {
                    UIPadding = React.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, 10),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingLeft = UDim.new(0, 10),
                        PaddingRight = UDim.new(0, 10)
                    }),
                    LocalizationProvider = React.createElement(LocalizationProvider, { localization = createLocalization() }, var2)
                }
            )
        end
    end
}
