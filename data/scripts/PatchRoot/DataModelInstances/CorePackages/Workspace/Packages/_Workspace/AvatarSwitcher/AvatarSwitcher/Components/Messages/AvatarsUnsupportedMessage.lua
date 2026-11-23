-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local useLocalization = require(AvatarSwitcherParent.Localization).Hooks.useLocalization
local useSignalState = require(AvatarSwitcherParent.SignalsReact).useSignalState

local MessageCard = require(AvatarSwitcher.Components.Messages.MessageCard)
local ExperienceAvatarSupportType = require(AvatarSwitcher.Enums.ExperienceAvatarSupportType)
local getAvatarSwitcherStore = require(AvatarSwitcher.Stores.getAvatarSwitcherStore)

local FFlagAvatarSwitcherUiFixes = require(AvatarSwitcherParent.AvatarExperienceFlags).FFlagAvatarSwitcherUiFixes

local function AvatarsUnsupportedMessage(tbl1)
    local var1 = useSignalState(getAvatarSwitcherStore)
    local var2 = useSignalState(var1.getExperienceAvatarSupportType)

    local var3 = useLocalization(
        FFlagAvatarSwitcherUiFixes and {
            messageHeader = "Feature.AvatarSwitcher.Heading.PresetAvatars"
        }
            or {
                messageHeader = "Feature.AvatarSwitcher.Heading.Unsupported",
                messageContent = "Feature.AvatarSwitcher.Message.Unsupported"
            }
    )

    if var2 ~= ExperienceAvatarSupportType.NoSupport then
        return nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        WarningMessage = React.createElement(MessageCard, {
            icon = "Info",
            headerText = var3.messageHeader,
            contentText = if FFlagAvatarSwitcherUiFixes then nil else var3.messageContent,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        })
    }
    return (createElement(view, tbl2, tbl3))
end

return AvatarsUnsupportedMessage
