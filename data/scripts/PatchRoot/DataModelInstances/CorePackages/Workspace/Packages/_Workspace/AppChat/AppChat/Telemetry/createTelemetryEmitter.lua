-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)
local LoggingProtocol = require(AppChatParent.LoggingProtocol)

local Logger = require(script.Parent.Logger)

return function(getSharedInfo: (...any) -> (...any))
    return SocialLuaAnalytics.Telemetry.createEmitter({
        telemetryImpl = LoggingProtocol.default,
        loggerImpl = Logger,
        defaultTelemetryConfig = { throttlingThousandths = 10000, links = "example.com" },
        getSharedInfo = getSharedInfo,
        shouldUseTelemetryService = true
    })
end
