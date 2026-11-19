-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local scriptParentParent = script.Parent.Parent

local ThemedTextLabel = require(scriptParentParent.Components.ThemedTextLabel)
local GameIcon = require(scriptParentParent.Components.GameIcon)

return RoactRodux.UNSTABLE_connect2(function(arg1)
    return {
        gameName = arg1.gameInfo.name
    }
end)(function(arg1) -- name: GameIconHeader
    return Roact.createElement("ImageLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 148)
    }, {
        Padding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 24),
            PaddingLeft = UDim.new(0, 24),
            PaddingRight = UDim.new(0, 24),
            PaddingTop = UDim.new(0, 24)
        }),
        GameIcon = Roact.createElement(GameIcon, { gameId = game.GameId, iconSize = 100 }),
        GameName = Roact.createElement(ThemedTextLabel, {
            fontKey = "Title",
            themeKey = "TextEmphasis",
            Position = UDim2.new(0, 112, 0, 0),
            Size = UDim2.new(1, -112, 1, 0),
            Text = arg1.gameName,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        })
    })
end)
