-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local PostRecordUserSeenModal = require(VoiceChat.AgeVerificationOverlay.PostRecordUserSeenModal)
local VoiceChatParent = VoiceChat.Parent
local Promise = require(VoiceChatParent.Promise)
local PerformFetch = require(VoiceChatParent.Http).PerformFetch

local module = { KeyMapper = "luaapp.recorduserseenmodalupsell" }

function module.Fetch(arg1)
    return PerformFetch.Single("luaapp.recorduserseenmodalupsell", function(_)
        return PostRecordUserSeenModal(arg1):andThen(function(arg2)
            if arg2.responseBody ~= nil and arg2.responseCode == 200 then
                return (Promise.resolve())
            end

            return (Promise.reject())
        end)
    end)
end

function module.GetFetchingStatus(arg1)
    return PerformFetch.GetStatus(arg1, "luaapp.recorduserseenmodalupsell")
end

return module
