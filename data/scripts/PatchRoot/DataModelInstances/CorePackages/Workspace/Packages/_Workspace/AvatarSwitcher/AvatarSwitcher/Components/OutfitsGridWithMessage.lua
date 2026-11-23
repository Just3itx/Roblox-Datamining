-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)

local AvatarsUnsupportedMessage = require(AvatarSwitcher.Components.Messages.AvatarsUnsupportedMessage)
local PendingAvatarSwitchMessage = require(AvatarSwitcher.Components.Messages.PendingAvatarSwitchMessage)
local OutfitsGridContainer = require(AvatarSwitcher.Components.OutfitsGrid.OutfitsGridContainer)

local function OutfitsGridWithMessage()
    return (React.createElement(Foundation.View, { tag = "size-full-full col gap-large" }, {
        AvatarsUnsupportedMessage = React.createElement(AvatarsUnsupportedMessage, { LayoutOrder = 1 }),
        PendingAvatarSwitchMessage = React.createElement(PendingAvatarSwitchMessage, { LayoutOrder = 2 }),
        GridContainer = React.createElement(
            Foundation.View,
            { tag = "size-full-0 grow", LayoutOrder = 3 },
            {
                OutfitsGridContainer = React.createElement(OutfitsGridContainer)
            }
        )
    }))
end

return OutfitsGridWithMessage
