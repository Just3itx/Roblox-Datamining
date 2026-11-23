-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTile = script:FindFirstAncestor("UserTile")
local UserTileParent = UserTile.Parent
local React = require(UserTileParent.React)
local ReactRoblox = require(UserTileParent.ReactRoblox)
local Foundation = require(UserTileParent.Foundation)
local Style = require(UserTileParent.Style)
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local FoundationProvider = Foundation.FoundationProvider
local DesignTokenProvider = Style.DesignTokenProvider
local LocalizationProvider = require(UserTileParent.Localization).LocalizationProvider
local Rodux = require(UserTileParent.Rodux)
local RoactNavigation = require(UserTileParent.RoactNavigation)
local RoactRodux = require(UserTileParent.RoactRodux)
local ColorMode = Foundation.Enums.ColorMode

local tbl1 = {
    Light = ColorMode.Light,
    Dark = ColorMode.Dark
}

local function createStore(_)
    return Rodux.Store.new(function()
        return {
            ScreenSize = Vector2.new(600, 600),
            TopBar = { topBarHeight = 100 },
            GlobalGuiInset = { left = 0, top = 0, right = 0, bottom = 0 }
        }
    end, {}, { Rodux.thunkMiddleware })
end

local localization = {
    Format = function(_, str1: string): string
        return str1
    end,
    GetLocale = function(): string
        return "en-us"
    end,
    changed = {
        connect = function(_, _)
            return {
                disconnect = function() end
            }
        end
    }
}

local function mockNavigation(child)
    return React.createElement(RoactNavigation.Provider, {
        value = {
            state = { routeName = "appPage" },
            isFocused = function(): boolean
                return true
            end,
            addListener = function()
                return {
                    remove = function() end
                }
            end,
            getParam = function<T>(_, arg1: T): T
                return arg1
            end,
            navigate = function() end
        }
    }, { Child = child })
end

return {
    name = "UserTile",
    storyRoot = UserTile.Stories,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            local colorMode = tbl1[arg2.theme]
            return React.createElement(LocalizationProvider, { localization = localization }, {
                StyleProvider = React.createElement(
                    StyleProviderWithDefaultTheme,
                    { withDarkTheme = true, withUiModeSupport = false },
                    { React.createElement(RoactRodux.StoreProvider, {
                            store = createStore(nil)
                        }, {
                            navigationProvider = mockNavigation(
                                React.createElement(
                                    FoundationProvider,
                                    { colorMode = colorMode },
                                    {
                                        designTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = arg1(arg2) })
                                    }
                                )
                            )
                        }) }
                )
            })
        end
    end
}
