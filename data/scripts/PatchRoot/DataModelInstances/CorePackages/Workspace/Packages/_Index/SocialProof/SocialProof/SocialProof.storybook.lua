-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent

local React = require(SocialProofParent.React)
local ReactRoblox = require(SocialProofParent.ReactRoblox)
local RoactRodux = require(SocialProofParent.RoactRodux)
local Rodux = require(SocialProofParent.Rodux)
local Style = require(SocialProofParent.Style)
local Foundation = require(SocialProofParent.Foundation)
local RoactNavigation = require(SocialProofParent.RoactNavigation)

local FoundationProvider = Foundation.FoundationProvider
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local DesignTokenProvider = Style.DesignTokenProvider

local function createStore(_)
    return Rodux.Store.new(function()
        return {
            ScreenSize = Vector2.new(600, 600),
            TopBar = { topBarHeight = 100 },
            GlobalGuiInset = { left = 0, top = 0, right = 0, bottom = 34 }
        }
    end, {}, { Rodux.thunkMiddleware })
end

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
    name = "SocialProof",
    storyRoot = SocialProof,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(StyleProviderWithDefaultTheme, {
                withDarkTheme = true,
                withUiModeSupport = false
            }, { React.createElement(RoactRodux.StoreProvider, {
                    store = createStore(nil)
                }, {
                    navigationProvider = mockNavigation(
                        React.createElement(
                            FoundationProvider,
                            {
                                colorMode = Foundation.Enums.ColorMode.Light
                            },
                            {
                                designTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = arg1(arg2) })
                            }
                        )
                    )
                }) })
        end
    end
}
