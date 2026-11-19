-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local PlayerServiceConnector = require(script.Parent.PlayerServiceConnector)
local CoreGuiConnector = require(script.Parent.CoreGuiConnector)
local SocialConnector = require(script.Parent.SocialConnector)
local GuiServiceConnector = require(script.Parent.GuiServiceConnector)
local UserInputServiceConnector = require(script.Parent.UserInputServiceConnector)
local ScreenSizeConnector = require(script.Parent.ScreenSizeConnector)

local var1 = Roact.PureComponent:extend("EventConnections")

function var1.render(_)
    return Roact.createFragment({
        PlayerServiceConnector = Roact.createElement(PlayerServiceConnector),
        CoreGuiConnector = Roact.createElement(CoreGuiConnector),
        SocialConnector = Roact.createElement(SocialConnector),
        GuiServiceConnector = Roact.createElement(GuiServiceConnector),
        UserInputServiceConnector = Roact.createElement(UserInputServiceConnector),
        ScreenSizeConnector = Roact.createElement(ScreenSizeConnector)
    })
end

return var1
