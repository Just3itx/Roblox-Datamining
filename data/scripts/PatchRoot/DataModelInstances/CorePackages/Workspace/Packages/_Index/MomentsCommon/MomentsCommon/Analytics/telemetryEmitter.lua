-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local LoggingProtocol = require(MomentsCommonParent.LoggingProtocol)
return require(MomentsCommonParent.SocialLuaAnalytics).Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    shouldUseTelemetryService = true,
    defaultTelemetryConfig = { throttlingThousandths = 10000, links = "" },
    getSharedInfo = function()
        return {}
    end
})
