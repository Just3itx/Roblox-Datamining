-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local CentralOverlayType = require(VoiceChatParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(VoiceChatParent.CentralOverlay).Actions.SetCentralOverlay

return function(arg1)
    return function(arg2)
        arg2:dispatch(SetCentralOverlay(CentralOverlayType.VerifiedEnableVoice, arg1 or {}))
    end
end
