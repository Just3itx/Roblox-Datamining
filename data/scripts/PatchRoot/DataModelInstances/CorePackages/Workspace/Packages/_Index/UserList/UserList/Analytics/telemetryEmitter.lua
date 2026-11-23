-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local LoggingProtocol = require(UserListParent.LoggingProtocol)
return require(UserListParent.SocialLuaAnalytics).Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = game:DefineFastInt("UserListAnalyticsThrottlingThousandths", 10000),
        links = "https://github.rbx.com/Roblox/proto-schemas/blob/master/production/eventstream/social/user_list_interactions.proto"
    },
    getSharedInfo = function()
        return {}
    end
})
