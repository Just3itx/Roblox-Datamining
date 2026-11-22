-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local _FeedTypes = require(script.Parent.FeedTypes)
local NavigationBar = require(script.Parent.NavigationBar)

local function FeedNavigationBar(tbl1)
    local var1 = SignalsReact.useSignalState(tbl1.pager.getItems)
    local var2 = SignalsReact.useSignalState(tbl1.pager.getCurrentIndex)

    local num1 = #var1
    local var3 = var1[num1]
    if var3 ~= nil and var3.kind == "skeleton" then
        num1 -= 1
    end

    local currentIndex = math.min(var2, math.max(num1, 1))

    return React.createElement(NavigationBar, {
        active = tbl1.active,
        currentIndex = currentIndex,
        numItems = num1,
        onScrollToNext = tbl1.onScrollToNext,
        onScrollToPrevious = tbl1.onScrollToPrevious,
        zIndex = tbl1.zIndex
    })
end

return FeedNavigationBar
