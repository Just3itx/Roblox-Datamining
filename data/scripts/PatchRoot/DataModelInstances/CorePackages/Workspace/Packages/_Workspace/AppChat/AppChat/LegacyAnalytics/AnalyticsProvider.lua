-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local Analytics = require(AppChatParent.Analytics).Analytics
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RoactChatAnalytics = require(script.Parent.RoactChatAnalytics)

local AnalyticsContext = require(AppChat.LegacyAnalytics.AnalyticsContext)

return function(tbl1)
    local analytics = Analytics.new(RbxAnalyticsService)

    return Roact.createElement(
        AnalyticsContext.Provider,
        {
            value = RoactChatAnalytics.new(analytics, tbl1.localUserId)
        },
        Roact.oneChild(tbl1[Roact.Children])
    )
end
