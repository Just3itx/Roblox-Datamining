-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:21:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local VoiceChatCore = script:FindFirstAncestor("VoiceChatCore")
local Constants = require(VoiceChatCore.Constants)

game:DefineFastFlag("EnableSeamlessVoiceFeature", false)

game:DefineFastFlag("EnableConnectDisconnect", false)
game:DefineFastFlag("EnableHearingWithoutMicPermissions", false)
game:DefineFastFlag("EnableDeferVoiceConnection", false)

game:DefineFastFlag("EnableJoinVoiceIsMutedMic", false)
game:DefineFastFlag("EnableJoinVoiceTooltip", false)
game:DefineFastFlag("EnableInitialJoinVoiceButton", false)

game:DefineFastFlag("EnableHideJoinToastSubtitle", false)

local tbl1 = {}
tbl1[Constants.SeamlessVoiceFeatures.ConnectDisconnect] = function(): boolean
    return game:GetFastFlag("EnableConnectDisconnect")
end

tbl1[Constants.SeamlessVoiceFeatures.HearingWithoutMicPermissions] = function(): boolean
    return game:GetFastFlag("EnableHearingWithoutMicPermissions")
end

tbl1[Constants.SeamlessVoiceFeatures.JoinVoiceIsMutedMic] = function(): boolean
    return game:GetFastFlag("EnableJoinVoiceIsMutedMic")
end

tbl1[Constants.SeamlessVoiceFeatures.JoinVoiceTooltip] = function(): boolean
    return game:GetFastFlag("EnableJoinVoiceTooltip")
end

tbl1[Constants.SeamlessVoiceFeatures.InitialJoinVoice] = function(): boolean
    return game:GetFastFlag("EnableInitialJoinVoiceButton")
end

tbl1[Constants.SeamlessVoiceFeatures.DeferConnection] = function(): boolean
    return game:GetFastFlag("EnableDeferVoiceConnection")
end

tbl1[Constants.SeamlessVoiceFeatures.HideJoinToastSubtitle] = function(): boolean
    return game:GetFastFlag("EnableHideJoinToastSubtitle")
end

return function(arg1)
    arg1 = type(arg1) == "string" and { arg1 } or arg1

    if arg1 == nil or #arg1 == 0 or not game:GetFastFlag("EnableSeamlessVoiceFeature") then
        return game:GetFastFlag("EnableSeamlessVoiceFeature")
    end

    for _, value in pairs(arg1) do
        local var1 = tbl1[value]
        if not (var1 and var1()) then
            return false
        end
    end

    return true
end
