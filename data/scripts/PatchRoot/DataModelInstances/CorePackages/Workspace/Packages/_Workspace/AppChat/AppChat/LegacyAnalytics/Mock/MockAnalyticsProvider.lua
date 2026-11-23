-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local Analytics = require(AppChatParent.Analytics).Analytics
local RoactChatAnalytics = require(script.Parent.Parent.RoactChatAnalytics)
local AnalyticsContext = require(script.Parent.Parent.AnalyticsContext)

return function(arg1)
    local var1 = Analytics.mock()

    local str1 = tostring(math.random(999999999))

    return Roact.createElement(
        AnalyticsContext.Provider,
        {
            value = RoactChatAnalytics.new(var1, str1)
        },
        Roact.oneChild(arg1[Roact.Children])
    )
end
