-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local ReactRoblox = require(GameInviteParent.ReactRoblox)
local RoactRodux = require(GameInviteParent.RoactRodux)
local Rodux = require(GameInviteParent.Rodux)
local Style = require(GameInviteParent.Style)
local Foundation = require(GameInviteParent.Foundation)

local GameInviteReducer = require(GameInvite.State.Reducers.GameInviteReducer)

return {
    name = "GameInvite",
    storyRoot = GameInvite,
    roact = React,
    reactRoblox = ReactRoblox,
    mapStory = function(arg1)
        return function(arg2)
            return React.createElement(Style.StyleProviderWithDefaultTheme, { withDarkTheme = true }, {
                StoreProvider = React.createElement(
                    RoactRodux.StoreProvider,
                    {
                        store = Rodux.Store.new(GameInviteReducer, nil, { Rodux.thunkMiddleware })
                    },
                    {
                        FoundationProvider = React.createElement(
                            Foundation.FoundationProvider,
                            {
                                colorMode = Foundation.Enums.ColorMode.Dark
                            },
                            {
                                Story = arg1(arg2)
                            }
                        )
                    }
                )
            })
        end
    end
}
