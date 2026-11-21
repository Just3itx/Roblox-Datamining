-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:00:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent
local React = require(GameJoinCardParent.React)
local ReactRoblox = require(GameJoinCardParent.Dev.ReactRoblox)
local Cryo = require(GameJoinCardParent.Dev.Cryo)
local Style = require(GameJoinCardParent.Style)
local StyleProviderWithDefaultTheme = Style.StyleProviderWithDefaultTheme
local DesignTokenProvider = Style.DesignTokenProvider
local mockLocale = require(GameJoinCardParent.Dev.SocialTestHelpers).StoryHelpers.mockLocale
local Rodux = require(GameJoinCardParent.Dev.Rodux)
local RoactRodux = require(GameJoinCardParent.Dev.RoactRodux)

local tbl1 = {}

local function createStore(_)
    return Rodux.Store.new(function()
        return {
            ScreenSize = Vector2.new(600, 600),
            TopBar = { topBarHeight = 0 },
            GlobalGuiInset = { left = 0, top = 0, right = 0, bottom = 0 }
        }
    end, {}, { Rodux.thunkMiddleware })
end

return {
    name = "GameJoinCard",
    storyRoot = GameJoinCard.Stories,
    roact = React,
    reactRoblox = ReactRoblox,
    mapDefinition = function(arg1)
        local controls = Cryo.Dictionary.join(tbl1, arg1.controls or {})
        return Cryo.Dictionary.join(arg1, { controls = controls })
    end,
    mapStory = function(arg1)
        return function(arg2)
            local withDarkTheme = arg2.theme == nil or arg2.theme ~= "Light"
            return React.createElement(
                StyleProviderWithDefaultTheme,
                { withDarkTheme = withDarkTheme, withUiModeSupport = false },
                { React.createElement(RoactRodux.StoreProvider, {
                        store = createStore(nil)
                    }, {
                        designTokenProvider = React.createElement(DesignTokenProvider, { tokenMappers = {} }, { Child = mockLocale(arg1, arg2) })
                    }) }
            )
        end
    end
}
