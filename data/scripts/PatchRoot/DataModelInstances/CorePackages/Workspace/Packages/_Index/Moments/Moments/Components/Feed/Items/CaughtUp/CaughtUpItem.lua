-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local useFeed = require(Moments.Components.Feed.FeedContext).useFeed

local View = Foundation.View

local function CaughtUpItem(tbl1)
    local var1 = useFeed()

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col align-x-center align-y-center size-full padding-xlarge clip bg-surface-0",
        testId = "--moments-feed-caught-up-page"
    }, {
        Content = var1.caughtUpState
    })
end

return CaughtUpItem
