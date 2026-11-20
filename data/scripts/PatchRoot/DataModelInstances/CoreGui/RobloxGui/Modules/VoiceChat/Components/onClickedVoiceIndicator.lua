-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Constants = require(CorePackages.Workspace.Packages.VoiceChat).Constants
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local var1 = require(RobloxGui.Modules.SelfView.Analytics).new()

return function(arg1, arg2, str1: string?)
    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end

    if arg1 == tostring(localPlayer.UserId) then
        if arg2 == Constants.VOICE_STATE.ERROR then
            default:RejoinPreviousChannel()
            return
        elseif arg2 == Constants.VOICE_STATE.CONNECTING then
            default:ShowVoiceChatLoadingMessage()
            return
        else
            var1:setLastCtx("bubbleChatToggle")
            default:ToggleMic(str1)
            return
        end
    end
    default:ToggleMutePlayer(tonumber(arg1), str1)
end
