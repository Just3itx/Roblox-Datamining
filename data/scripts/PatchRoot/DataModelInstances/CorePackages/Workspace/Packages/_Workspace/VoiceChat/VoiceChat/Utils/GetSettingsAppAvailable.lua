-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")

local dependencies = require(VoiceChat.dependencies)

local SharedFlags = dependencies.SharedFlags

local default = dependencies.LinkingProtocol.LinkingProtocol.default
local SettingsRoute = dependencies.LinkingProtocol.Enums.SettingsRoute

local FFlagEnableRetryForLinkingProtocolFetch = SharedFlags.FFlagEnableRetryForLinkingProtocolFetch
local FIntLinkingProtocolFetchRetries = SharedFlags.FIntLinkingProtocolFetchRetries
local FIntLinkingProtocolFetchTimeoutMS = SharedFlags.FIntLinkingProtocolFetchTimeoutMS

return function()
    local bool1 = false
    local bool2 = false

    if FFlagEnableRetryForLinkingProtocolFetch then
        for _ = 0, FIntLinkingProtocolFetchRetries do
            local var1 = task.spawn(function()
                bool1, bool2 = default:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
            end)
            task.wait(FIntLinkingProtocolFetchTimeoutMS / 1000)
            task.cancel(var1)

            if bool2 ~= nil then
                break
            end
        end
    else
        bool1, bool2 = default:supportsSwitchToSettingsApp(SettingsRoute.Microphone):await()
    end

    return bool1 and bool2 == true
end
