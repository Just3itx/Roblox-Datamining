-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:21:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local VoiceChatCoreParent = script:FindFirstAncestor("VoiceChatCore").Parent

local IXPServiceWrapper = require(VoiceChatCoreParent.IXPServiceWrapper).IXPServiceWrapper
game:DefineFastFlag("BatchVoiceParticipantsUpdates", false)
local str1 = game:DefineFastString("ThrottleVoiceParticipantsUpdateLayerName", "Voice.Performance")
local str2 = game:DefineFastString("ThrottleVoiceParticipantsUpdateLayerValue", "BatchVoiceParticipantsUpdates")
local var1 = nil
local var2 = nil

if game:GetFastFlag("BatchVoiceParticipantsUpdates") then
    var1, var2 = pcall(function()
        return IXPServiceWrapper:GetLayerData(str1)
    end)
end

return function()
    return game:GetFastFlag("BatchVoiceParticipantsUpdates") and var1 and var2 and var2[str2]
end
