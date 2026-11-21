-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local Rodux = require(AvatarExperienceCatalogParent.Rodux)
local RoactRodux = require(AvatarExperienceCatalogParent.RoactRodux)
local LocalizationProvider = require(AvatarExperienceCatalogParent.Localization).LocalizationProvider
local AppStyleProvider = require(AvatarExperienceCatalogParent.UIBlox).App.Style.AppStyleProvider

local DesignTokenProvider = require(AvatarExperienceCatalogParent.Dev.Style).DesignTokenProvider
local ReactRoblox = require(AvatarExperienceCatalogParent.Dev.ReactRoblox)
local Localization = require(AvatarExperienceCatalogParent.Dev.AppLocales).Localization
local AppStyleProvider2 = require(AvatarExperienceCatalogParent.Dev.Style).AppStyleProvider

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
    name = "AvatarExperienceCatalog",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]

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
                    LocalizationProvider = React.createElement(LocalizationProvider, {
                        localization = Localization.new("en-us")
                    }, {
                        AppStyleProvider = React.createElement(AppStyleProvider, {
                            style = arg2 and tbl3[arg2.theme] or tbl3.Default
                        }, {
                            StyleProvider = React.createElement(AppStyleProvider2, {
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
                    })
                }
            )
        end
    end
}
