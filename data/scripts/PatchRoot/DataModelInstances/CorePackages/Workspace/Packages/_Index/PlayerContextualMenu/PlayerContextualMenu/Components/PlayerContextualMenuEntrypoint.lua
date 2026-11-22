-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")
local PlayerContextualMenuParent = PlayerContextualMenu.Parent
local React = require(PlayerContextualMenuParent.React)

local HttpRequestContext = require(script.Parent.HttpRequest.HttpRequestContext)
local DefaultHttpRequestInstance = require(script.Parent.HttpRequest.DefaultHttpRequestInstance)

local PlayerContextualMenuContainer = require(PlayerContextualMenu.Components.PlayerContextualMenuContainer)

local function PlayerContextualMenuEntrypoint(arg1)
    return React.createElement(
        HttpRequestContext.Provider,
        {
            value = arg1.httpRequest or DefaultHttpRequestInstance
        },
        {
            app = React.createElement(PlayerContextualMenuContainer, arg1)
        }
    )
end
return PlayerContextualMenuEntrypoint
