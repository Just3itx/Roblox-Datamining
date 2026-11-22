-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent

local Dash = require(ProfileShareLinksParent.Dash)
local SupportedTelemetryBackends = require(ProfileShareLinksParent.SocialLuaAnalytics).Analytics.Enums.SupportedTelemetryBackends
local EventNames = require(script.Parent.EventNames)

local identity = Dash.identity

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("ProfileShareLinksAnalyticsThrottlingThousandths", 1000),
        links = ""
    },
    [EventNames.ProfileShareLinkActivated] = {
        description = "Profile share link button activated",
        lastUpdated = { 24, 6, 11 },
        backendsList = {{
            type = SupportedTelemetryBackends.RobloxTelemetryCounter,
            dynamicCustomFields = { context = identity, shareType = identity }
        }}
    }
}
