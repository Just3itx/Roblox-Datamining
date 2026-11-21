-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local SocialLuaAnalytics = require(FriendsCommonParent.SocialLuaAnalytics)
local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends
local LoggingProtocol = require(FriendsCommonParent.LoggingProtocol)

local emitter = SocialLuaAnalytics.Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = game:DefineFastInt("FriendsCommonAnalyticsThrottlingThousandths", 10000),
        links = "https://docs.google.com/document/d/1uRCdl8pEuiW9wDiOTL39JPMGLhgxtpvVgiXovE8Xof4"
    },
    getSharedInfo = function()
        return {}
    end
})

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "FriendsSortFeRtnMessage",
    description = "User received an rtn message v2",
    lastUpdated = { 2026, 6, 18 },
    backendsList = {{
        type = SupportedTelemetryBackends.EventIngest,
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

local function fireFriendsSortFeRtnMessageReceived(messageId: string?, tbl1)
    if messageId == nil or not tbl1 then
        return
    end

    pcall(function()
        local tbl2 = {}
        for _, value in pairs(tbl1) do
            table.insert(tbl2, tostring(value.userId))
        end

        emitter.emit(telemetry, {
            messageId = messageId,
            userId = Players.LocalPlayer and Players.LocalPlayer.UserId or nil,
            friendIds = table.concat(tbl2, ","),
            sortType = "Carousel"
        })
    end)
end

return fireFriendsSortFeRtnMessageReceived
