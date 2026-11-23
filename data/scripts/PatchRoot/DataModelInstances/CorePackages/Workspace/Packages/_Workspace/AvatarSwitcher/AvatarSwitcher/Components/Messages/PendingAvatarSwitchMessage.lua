-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local useSignalState = require(AvatarSwitcherParent.SignalsReact).useSignalState

local MessageCard = require(AvatarSwitcher.Components.Messages.MessageCard)
local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)

local function PendingAvatarSwitchMessage(tbl1)
    local var1 = useSignalState(getAvatarSwitcherStore)
    local avatarName = useSignalState(var1.getPendingAvatarName)

    local var3 = useLocalization({
        messageHeader = {
            "Feature.AvatarSwitcher.Heading.AvatarSwitchedConfirmation",
            avatarName = avatarName
        },
        messageContent = "Feature.AvatarSwitcher.Message.SwitchingDeferred"
    })

    if avatarName == nil then
        return nil
    end

    return (React.createElement(Foundation.View, { tag = "size-full-0 auto-y" }, {
        WarningMessage = React.createElement(MessageCard, {
            icon = "Info",
            headerText = var3.messageHeader,
            contentText = var3.messageContent,
            onClose = var1.clearPendingAvatarName,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = tbl1.LayoutOrder
        })
    }))
end

return PendingAvatarSwitchMessage
