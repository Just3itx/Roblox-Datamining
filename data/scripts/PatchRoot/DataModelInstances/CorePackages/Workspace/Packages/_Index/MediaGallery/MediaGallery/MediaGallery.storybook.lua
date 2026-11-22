-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")

local MediaGalleryParent = MediaGallery.Parent
local React = require(MediaGalleryParent.React)
local ReactRoblox = require(MediaGalleryParent.ReactRoblox)
local Rodux = require(MediaGalleryParent.Dev.Rodux)
local RoactRodux = require(MediaGalleryParent.Dev.RoactRodux)
local RoactNavigation = require(MediaGalleryParent.Dev.RoactNavigation)
local UIBlox = require(MediaGalleryParent.UIBlox)
UIBlox.init(require(MediaGalleryParent.Dev.RobloxAppUIBloxConfig))
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider
local Foundation = require(MediaGalleryParent.Foundation)

local FoundationProvider = Foundation.FoundationProvider
local ColorMode = Foundation.Enums.ColorMode
local Device = Foundation.Enums.Device

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local store = Rodux.Store.new(function<T>(arg1: T): T
    return arg1
end, {
    ScreenSize = Vector2.new(1920, 1080),
    TopBar = { topBarHeight = 0 },
    GlobalGuiInset = { bottom = 0, left = 0, right = 0, top = 0 }
}, {})

local value = {
    isFocused = function(): boolean
        return true
    end,
    addListener = function(_, _, _)
        return {
            remove = function() end
        }
    end
}
return {
    name = MediaGallery.Name,
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
                        NavigationContext = React.createElement(RoactNavigation.Context.Provider, {
                            value = value
                        }, {
                            FoundationContext = React.createElement(FoundationProvider, {
                                colorMode = tbl1[arg2.theme],
                                device = Device[arg2.platform],
                                preferences = arg2.settings,
                                scale = arg2.settings and arg2.settings.scale
                            }, {
                                StyleProvider = React.createElement(
                                    AppStyleProvider,
                                    {
                                        style = { themeName = "Dark", fontName = "Gotham" }
                                    },
                                    {
                                        Child = React.createElement(arg1, arg2)
                                    }
                                )
                            })
                        })
                    })
                }
            )
        end
    end,
    storyRoots = { MediaGallery }
}
