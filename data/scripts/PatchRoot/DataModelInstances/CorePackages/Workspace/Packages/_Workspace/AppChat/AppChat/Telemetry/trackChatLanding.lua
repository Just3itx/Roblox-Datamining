-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _SocialCommon = require(AppChatParent.SocialCommon)

local FFlagAppChatTTIStaleGuard = require(AppChat.Flags.FFlagAppChatTTIStaleGuard)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)

local bool1 = false

local function trackChatLanding(entryPoint)
    pcall(function()
        if entryPoint == nil then
            AppChatPerfTracker.cancel(AppChatPerfTracker.Events.ChatLandingTTI, {})
            if FFlagAppChatTTIStaleGuard then
                AppChatPerfTracker.cancel(AppChatPerfTracker.Events.ChatConversationTTI, {})
            end
        else
            AppChatPerfTracker.start(AppChatPerfTracker.Events.ChatLandingTTI, { entryPoint = entryPoint, coldStart = not bool1 })

            bool1 = true
        end
    end)
end

return trackChatLanding
