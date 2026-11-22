-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local useSignalState = require(MomentsParent.SignalsReact).useSignalState

local _createPostInsightsPageStore = require(script.Parent.createPostInsightsPageStore)
local getPostInsightsPageStore = require(script.Parent.getPostInsightsPageStore)
local PostInsightsPageView = require(script.Parent.PostInsightsPageView)
local usePostInsightsPageViewModel = require(script.Parent.usePostInsightsPageViewModel)

local function PostInsightsPage(tbl1)
    local var1 = usePostInsightsPageViewModel(tbl1.context, tbl1.onBack)
    return React.createElement(PostInsightsPageView, var1)
end

return React.memo(function() -- name: PostInsightsPageContainer
    local postInsightsPageStore = getPostInsightsPageStore(false)
    local var1 = useSignalState(postInsightsPageStore.getIsOpen)
    local context = useSignalState(postInsightsPageStore.getContext)

    if not var1 or context == nil then
        return nil
    end

    return React.createElement(
        PostInsightsPage,
        {
            key = context.moment.momentId,
            context = context,
            onBack = postInsightsPageStore.close
        }
    )
end)
