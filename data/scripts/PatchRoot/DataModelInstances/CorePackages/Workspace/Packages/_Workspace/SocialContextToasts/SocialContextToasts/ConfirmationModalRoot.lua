-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialContextToastsParent = script:FindFirstAncestor("SocialContextToasts").Parent
local useSelector = require(SocialContextToastsParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(SocialContextToastsParent.React)

local DeeplinkConfirmationModal = require(SocialContextToastsParent.NotificationsCommon).DeeplinkConfirmationModal

local function ConfirmationModalRoot()
    local var1 = useSelector(function(arg1)
        return arg1.ConfirmationModal
    end)
    return {
        DeeplinkConfirmationModal = var1 and var1.isOpen and React.createElement(DeeplinkConfirmationModal, { closeCallback = var1.closeCallback })
    }
end

return ConfirmationModalRoot
