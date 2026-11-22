-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local useFeed = require(Moments.Components.Feed.FeedContext).useFeed
local MomentsEndStateView = require(script.Parent.MomentsEndStateView)

local signal = Signals.createSignal(true)

local function MomentsEndStateItem(tbl1)
    local var1 = useFeed()

    local showLoadMore = SignalsReact.useSignalState(var1.getCanLoadMoreBeyondLimit or signal)

    local loadMoreBeyondLimit = var1.loadMoreBeyondLimit
    local onLoadMore = React.useCallback(function()
        if loadMoreBeyondLimit ~= nil then
            loadMoreBeyondLimit()
        end
    end, { loadMoreBeyondLimit })

    return React.createElement(
        MomentsEndStateView,
        {
            LayoutOrder = tbl1.LayoutOrder,
            onLoadMore = onLoadMore,
            showLoadMore = showLoadMore
        }
    )
end
return MomentsEndStateItem
