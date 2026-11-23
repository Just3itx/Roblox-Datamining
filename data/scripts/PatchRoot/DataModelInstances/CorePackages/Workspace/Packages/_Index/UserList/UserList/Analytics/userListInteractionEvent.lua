-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local SocialLuaAnalytics = require(UserListParent.SocialLuaAnalytics)

local _Types = require(UserList.Common.Types)

local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends

return SocialLuaAnalytics.Telemetry.new({
    name = "UserListInteraction",
    description = "A user interacted with a user-list row",
    lastUpdated = { 2026, 9, 14 },
    backendsList = {{
        type = SupportedTelemetryBackends.EventIngest,
        standardizedFields = { "addSessionInfo", "addSessionId" },
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})
