-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local React = require(GameInviteParent.React)
local FocusNavigationUtils = require(GameInviteParent.FocusNavigationUtils)
local DeeplinkConfirmationModal = require(GameInviteParent.NotificationsCommon).DeeplinkConfirmationModal

local useGameInviteLeaveServerConfirmationViewModel = require(script.Parent.useGameInviteLeaveServerConfirmationViewModel)

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function GameInviteLeaveServerConfirmation(arg1)
    local var1 = useGameInviteLeaveServerConfirmationViewModel(arg1)
    return React.createElement(FocusRoot, {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = var1.focusEventHandlers
    }, {
        Confirmation = React.createElement(
            DeeplinkConfirmationModal,
            {
                closeCallback = var1.closeCallback,
                titleKey = var1.titleKey,
                bodyKey = var1.bodyKey
            }
        )
    })
end
return GameInviteLeaveServerConfirmation
