-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local MockAnalyticsProvider = require(script.Parent.MockAnalyticsProvider)

return function(analyticsElement)
    return Roact.createElement(MockAnalyticsProvider, {}, { AnalyticsElement = analyticsElement })
end
