-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)
local NotificationsUpsell = require(ServerTriggeredModalsParent.NotificationsUpsell)
local usePushPermissionClientAttributes = NotificationsUpsell.usePushPermissionClientAttributes
local useOpenPendingLegacyUpsell = NotificationsUpsell.ChatPushUpsellLegacyPrompt.useOpenPendingLegacyUpsell

local PromptsHandler = require(script.Parent.PromptsHandler).PromptsHandler
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)

local function ChatPromptsHandler()
    local clientAttributes = usePushPermissionClientAttributes()
    useOpenPendingLegacyUpsell()

    if clientAttributes == nil then
        return nil
    end

    return React.createElement(
        PromptsHandler,
        {
            entryPoint = PromptsEntryPoint.ChatLandingOpen,
            clientAttributes = clientAttributes
        }
    )
end
return ChatPromptsHandler
