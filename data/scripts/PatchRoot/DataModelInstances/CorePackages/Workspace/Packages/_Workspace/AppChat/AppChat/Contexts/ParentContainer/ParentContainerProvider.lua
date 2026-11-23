-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)
local ParentContainerContext = require(script.Parent.ParentContainerContext)

local function ParentContainerProvider(arg1)
    return React.createElement(ParentContainerContext.Provider, {
        value = {
            getParentContainer = arg1.getParentContainer,
            visibilitySignal = arg1.visibilitySignal,
            getRequestedRoute = arg1.getRequestedRoute,
            requestedRouteSignal = arg1.requestedRouteSignal,
            clearRequestedRoute = arg1.clearRequestedRoute,
            getShouldSetAppChatVisible = arg1.getShouldSetAppChatVisible,
            entryPoint = arg1.entryPoint,
            hideParentContainer = arg1.hideParentContainer,
            showParentContainer = arg1.showParentContainer,
            updateCurrentSquadId = arg1.updateCurrentSquadId,
            openFriendsChatConversation = arg1.openFriendsChatConversation
        }
    }, arg1.children)
end

return ParentContainerProvider
