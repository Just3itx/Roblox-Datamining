-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppUpdateParent = script:FindFirstAncestor("RobloxAppUpdate").Parent

local SetCentralOverlay = require(RobloxAppUpdateParent.CentralOverlay).Actions.SetCentralOverlay
local CentralOverlayType = require(RobloxAppUpdateParent.RobloxAppEnums).CentralOverlayType

return function(canPerformBinaryUpdate, showInternalChannelMessage, updateMessageType)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.UpdateRequiredPrompt, {
                canPerformBinaryUpdate = canPerformBinaryUpdate,
                showInternalChannelMessage = showInternalChannelMessage,
                updateMessageType = updateMessageType
            }, { DisableBackButtonClose = true })
        )
    end
end
