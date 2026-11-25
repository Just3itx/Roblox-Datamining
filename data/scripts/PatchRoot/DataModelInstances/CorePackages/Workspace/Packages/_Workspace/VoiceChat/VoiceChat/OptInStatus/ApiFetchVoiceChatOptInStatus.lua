-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local GetVoiceChatOptInStatus = require(VoiceChat.OptInStatus.GetVoiceChatOptInStatus)
local SetVoiceChatOptInStatus = require(VoiceChat.OptInStatus.SetVoiceChatOptInStatus)
local VoiceChatParent = VoiceChat.Parent
local Promise = require(VoiceChatParent.Promise)
local PerformFetch = require(VoiceChatParent.Http).PerformFetch

local Logging = require(VoiceChatParent.AppCommonLib).Logging

local module = { KeyMapper = "luaapp.voicechatoptinstatus" }

function module.Fetch(arg1)
    return PerformFetch.Single("luaapp.voicechatoptinstatus", function(arg2)
        return GetVoiceChatOptInStatus(arg1):andThen(function(arg3)
            local responseBody = arg3.responseBody
            if responseBody ~= nil and responseBody.isUserOptIn ~= nil then
                arg2:dispatch(SetVoiceChatOptInStatus(responseBody.isUserOptIn))
                return Promise.resolve(arg3)
            end
            Logging.warn("Response from GetVoiceChatOptInStatus is malformed!")
            return Promise.reject({ HttpError = Enum.HttpError.OK })
        end)
    end)
end

function module.GetFetchingStatus(arg1)
    return PerformFetch.GetStatus(arg1, "luaapp.voicechatoptinstatus")
end

return module
