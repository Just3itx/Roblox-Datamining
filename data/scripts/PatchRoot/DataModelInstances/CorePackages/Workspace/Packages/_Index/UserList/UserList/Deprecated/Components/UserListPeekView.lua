-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local RobloxAppHooks = require(UserListParent.RobloxAppHooks)
local PeekView = require(UserListParent.PeekView)
local PeekViewWithTopBar = PeekView.PeekViewWithTopBar
local PeekViewState = PeekView.PeekViewState
local RoactUtils = require(UserListParent.RoactUtils)
local NavigateBack = require(UserListParent.NavigationRodux).Thunks.NavigateBack
local FFlagSignalsNavP3Dispatch = require(UserListParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(UserListParent.RobloxAppNavigation).NavigationCommands else nil
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local UserList = require(script.Parent.UserList)
local Foundation = require(UserListParent.Foundation)
local Button = Foundation.Button
local useTopBarHeight = RobloxAppHooks.useTopBarHeight
local UserListPeekViewTopBar = require(script.Parent.UserListPeekViewTopBar)
local View = Foundation.View
local FoundationText = Foundation.Text
local useLocalization = require(UserListParent.Localization).Hooks.useLocalization

return function(tbl1)
    local uDim = UDim.new(0.55, 0)
    local topBarHeight = useTopBarHeight()
    local var2 = useDispatch()

    local navigateBack = React.useCallback(function()
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            return
        end
        var2(NavigateBack(true))
    end, { var2 })

    local onViewStateChanged = React.useCallback(function(closed, _, _)
        if closed == PeekViewState.Closed then
            navigateBack()
        end
    end, { navigateBack })

    local var5 = useLocalization({ showMore = "Feature.Friends.Action.ShowMore" })

    local createElement = React.createElement
    local var6 = PeekViewWithTopBar
    local tbl2 = {
        briefViewContentHeight = uDim,
        fullViewContentHeight = UDim.new(1, -topBarHeight),
        onViewStateChanged = onViewStateChanged,
        topBarHeight = topBarHeight,
        topBarSlot = React.createElement(UserListPeekViewTopBar, { navigateBack = navigateBack }),
        contentSlot = 0
    }

    local createElement2 = React.createElement
    local var7 = View
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, -topBarHeight),
        tag = "auto-y align-x-center col padding-top-xlarge padding-x-xlarge padding-bottom-large gap-large"
    }
    local tbl4 = {
        Title = if tbl1.title then React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                tag = "text-heading-small size-full-0 text-align-x-left content-emphasis auto-y",
                Text = tbl1.title
            }
        ) else nil,
        UserList = React.createElement(UserList, { userIds = tbl1.users, onUserSelected = tbl1.onUserSelected, layoutOrder = 2 }),
        ButtonContainer = React.createElement(View, {
            LayoutOrder = 3,
            tag = "size-full-0 auto-y align-x-center col padding-top-xlarge padding-x-xlarge padding-bottom-large gap-large"
        }, {
            ShowMoreButton = if tbl1.hasMore and tbl1.onLoadMore then React.createElement(Button, { onActivated = tbl1.onLoadMore, text = var5.showMore }) else nil
        })
    }
    tbl2.contentSlot = createElement2(var7, tbl3, tbl4)
    return createElement(var6, tbl2)
end
