-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local UIBlox = require(AvatarExperienceCommonParent.UIBlox)

UIBlox.init(require(AvatarExperienceCommonParent.Dev.RobloxAppUIBloxConfig))
local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local Rodux = require(AvatarExperienceCommonParent.Rodux)
local DesignTokenProvider = require(AvatarExperienceCommonParent.Style).DesignTokenProvider
local RoactRodux = require(AvatarExperienceCommonParent.RoactRodux)
local AppStyleProvider = require(AvatarExperienceCommonParent.Style).AppStyleProvider
local AppStyleProvider2 = UIBlox.App.Style.AppStyleProvider
local ReactRoblox = require(AvatarExperienceCommonParent.ReactRoblox)

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
    name = "AvatarExperienceCommon",
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
                }
            )
        end
    end
}
