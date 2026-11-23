-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _Signals = require(AppChatParent.Signals)
local _SocialCommon = require(AppChatParent.SocialCommon)
local createSessionScopedSignal = require(AppChatParent.SignalsUtils).createSessionScopedSignal

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local trackChatLanding = require(AppChat.Telemetry.trackChatLanding)

local function createLastEntryPointStore()
    local getLastEntryPoint, var2 = createSessionScopedSignal("NotSet")

    return {
        getLastEntryPoint = getLastEntryPoint,
        enteredChatFromEntryPoint = function(arg1)
            if FFlagAppChatPerfTracking then
                trackChatLanding(arg1)
            end

            var2(arg1 or "NotSet")
        end,
        reset = function()
            var2("NotSet")
        end
    }
end
return createLastEntryPointStore
