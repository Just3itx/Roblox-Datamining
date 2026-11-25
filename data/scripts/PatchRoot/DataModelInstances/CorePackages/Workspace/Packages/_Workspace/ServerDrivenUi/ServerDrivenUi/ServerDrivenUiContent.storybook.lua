-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local Rodux = require(ServerDrivenUiParent.Rodux)
local Foundation = require(ServerDrivenUiParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device
local ReactRoblox = require(ServerDrivenUiParent.Dev.ReactRoblox)
local RoactRodux = require(ServerDrivenUiParent.Dev.RoactRodux)

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local store = Rodux.Store.new(function<T>(arg1: T): T
    return arg1
end, {
    ScreenSize = Vector2.new(1920, 1080),
    TopBar = { topBarHeight = 10 },
    GlobalGuiInset = { bottom = 0, left = 0, right = 0, top = 0 },
    GamesProductInfoKey = {},
    PlayabilityStatus = {},
    FetchingStatus = {},
    GameDetails = {},
    Personalization = {
        GameInfosKey = {}
    },
    GameIconsKey = {},
    UserGameVotes = {},
    AgeRecommendations = {},
    ShowAgeVerificationOverlay = {}
}, {})

return {
    name = "ServerDrivenUiContent",
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
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
                    StoreProvider = React.createElement(RoactRodux.StoreProvider, { store = store }, {
                        FoundationContext = React.createElement(FoundationProvider, {
                            colorMode = tbl1[arg2.theme],
                            device = Device[arg2.platform],
                            preferences = arg2.settings,
                            scale = arg2.settings and arg2.settings.scale
                        }, {
                            Child = React.createElement(arg1, arg2)
                        })
                    })
                }
            )
        end
    end,
    storyRoot = script.Parent.Content
}
