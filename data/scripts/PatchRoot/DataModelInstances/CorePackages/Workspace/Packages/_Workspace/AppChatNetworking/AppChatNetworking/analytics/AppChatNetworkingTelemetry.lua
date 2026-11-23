-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworkingParent = script:FindFirstAncestor("AppChatNetworking").Parent

local LoggingProtocol = require(AppChatNetworkingParent.LoggingProtocol)
return require(AppChatNetworkingParent.SocialLuaAnalytics).Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = game:DefineFastInt("AppChatNetworkingTelemetryThrottlingThousandths", 800),
        links = ""
    },
    getSharedInfo = function()
        return {}
    end
})
