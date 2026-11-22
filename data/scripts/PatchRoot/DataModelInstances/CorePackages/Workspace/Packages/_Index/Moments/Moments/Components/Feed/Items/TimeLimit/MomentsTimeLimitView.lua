-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local FeedMessageView = require(Moments.Components.Feed.FeedMessageView)

local useTokens = Foundation.Hooks.useTokens

local function MomentsTimeLimitView(tbl1)
    local var1 = useTokens()

    return React.createElement(FeedMessageView, {
        iconName = BuilderIcons.Icon.LockClosed,
        iconSize = var1.Size.Size_1600,
        tilted = true,
        frameRadiusTag = "radius-small",
        title = tbl1.title,
        description = tbl1.description,
        testId = "moments-time-limit"
    })
end

return MomentsTimeLimitView
