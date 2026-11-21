-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent

local dependencies = require(FriendsLanding.dependencies)
local llama = dependencies.llama
local Roact = dependencies.Roact
local memoize = dependencies.memoize

local Dictionary = llama.Dictionary

local FriendsLandingPage = require(FriendsLanding.Components.FriendsLandingPage)
local limitFriends = require(script.helpers.limitFriends)
local updateFriendsWithWidth = require(script.helpers.updateFriendsWithWidth)
local loadFriendGroup = require(script.helpers.loadFriendGroup)
local friendsPerRow = require(script.helpers.friendsPerRow)
local friendsPerLoadGroup = require(script.helpers.friendsPerLoadGroup)
local ShowMoreButton = require(FriendsLanding.Components.ShowMoreButton)
local ButtonClickEvents = require(FriendsLanding.FriendsLandingAnalytics.ButtonClickEvents)
local filterStates = require(FriendsLanding.Friends.filterStates)
local ShowMoreSectionTypeEnum = require(FriendsLanding.Enums.ShowMoreSectionTypeEnum)

local React = dependencies.React
local GridMetrics = dependencies.UIBlox.App.Grid.GridMetrics
local useDesignTokens = require(FriendsLandingParent.Style).useDesignTokens
local useUiModeInfo = require(FriendsLandingParent.RobloxAppHooks).useUiModeInfo
local UiMode = require(FriendsLandingParent.RobloxAppEnums).UiMode

local var1 = Roact.PureComponent:extend("ShowMoreWrapper")

var1.defaultProps = {
    listComponent = FriendsLandingPage,
    itemSize = 175,
    visibleRows = 6,
    friends = {},
    analytics = nil,
    filter = filterStates.All,
    overrideRenderShowMore = nil,
    handleShowMore = nil,
    spacingIfEmpty = 48,
    sectionType = ShowMoreSectionTypeEnum.Friends
}

function var1.init(arg1)
    arg1.state = {
        width = 100,
        filterFriendCounts = Dictionary.map(filterStates, function()
            return arg1.props.visibleRows
        end),
        selectedItemIndex = nil
    }

    function arg1.updateWidth(arg2)
        arg1:setState(updateFriendsWithWidth(arg2.AbsoluteSize.X))

        if arg1.props.onWidthUpdated then
            arg1.props.onWidthUpdated(arg2.AbsoluteSize.X)
        end
    end

    function arg1.reset()
        arg1:setState(function(arg2, arg3)
            local tbl1 = {
                filterFriendCounts = Dictionary.join(arg1.state.filterFriendCounts, { [arg1.props.filter] = friendsPerLoadGroup(arg2, arg3) })
            }
            return tbl1
        end)
    end

    function arg1.showMore()
        if arg1.props.analytics then
            arg1.props.analytics:buttonClick(ButtonClickEvents.LoadMoreUsers, { sectionType = arg1.props.sectionType })
        end

        if arg1.props.fireOnShowMore then
            arg1.props.fireOnShowMore(arg1.props.sectionType)
        end

        if arg1.props.handleShowMore then
            arg1.props.handleShowMore(friendsPerRow(Dictionary.join({ width = arg1.state.width }, arg1.props)))
            return
        end

        arg1:setState(function(arg2, arg3)
            local filterFriendCount = arg2.filterFriendCounts[arg3.filter]

            return Dictionary.join(loadFriendGroup(arg2, arg3), { selectedItemIndex = filterFriendCount + 1 })
        end)
    end

    arg1.limitFriends = memoize(limitFriends)

    arg1.renderShowMore = memoize(function(arg2, arg3, arg4)
        return function(layoutOrder)
            local var2 = arg4 and arg4(arg3)

            if arg3 < arg2 or var2 then
                return Roact.createElement(
                    ShowMoreButton,
                    {
                        layoutOrder = layoutOrder,
                        onSizeChange = arg1.updateWidth,
                        onActivated = arg1.showMore
                    }
                )
            end

            return Roact.createElement("Frame", {
                Name = "showMoreSpacing",
                Size = UDim2.fromOffset(0, arg1.props.spacingIfEmpty),
                BackgroundTransparency = 1,
                LayoutOrder = layoutOrder
            })
        end
    end)

    function arg1.checkAndResetIfNeeded(arg2)
        if #arg1.props.friends ~= #arg2.friends or arg2.visibleRows ~= arg1.props.visibleRows then
            arg1.reset()
        end
    end
end

function var1.didUpdate(arg1, arg2)
    arg1.checkAndResetIfNeeded(arg2)
end

function var1.render(arg1)
    local filterFriendCount = arg1.state.filterFriendCounts[arg1.props.filter]
    return Roact.createElement(
        arg1.props.listComponent,
        Dictionary.join(arg1.props, {
            friends = arg1.limitFriends(filterFriendCount, arg1.props.friends),
            showMore = arg1.showMore,
            totalFilteredFriends = #arg1.props.friends,
            renderShowMore = arg1.renderShowMore(#arg1.props.friends, filterFriendCount, arg1.props.overrideRenderShowMore),
            resetShowMore = arg1.reset,
            totalInactiveFriends = arg1.props.totalInactiveFriends,
            selectedItemIndex = arg1.state.selectedItemIndex
        })
    )
end

local function ShowMoreWrapperFn(arg1)
    local var2 = useDesignTokens()
    local bool1 = useUiModeInfo().uiMode == UiMode.TenFoot

    local gridViewItemMetrics = var2.LuaApps.FriendsLanding.FriendsLandingPage.GridViewItemMetrics
    local gridHorizontalSpacing = var2.LuaApps.FriendsLanding.FriendsLandingPage.GridHorizontalSpacing
    local gridVerticalSpacing = var2.LuaApps.FriendsLanding.FriendsLandingPage.GridVerticalSpacing

    local getItemMetrics = React.useMemo(function()
        if bool1 then
            return GridMetrics.makeCustomMetricsGetter(gridViewItemMetrics)
        end
        return nil
    end, { bool1, gridViewItemMetrics })

    local var4, var5 = React.useState(100)

    local itemSize = React.useMemo(function()
        return if bool1 and getItemMetrics and gridHorizontalSpacing then getItemMetrics(var4, gridHorizontalSpacing).itemWidth else nil
    end, {
        bool1,
        getItemMetrics,
        var4,
        gridHorizontalSpacing
    })
    local createElement = React.createElement
    local var7 = var1
    local join = llama.Dictionary.join
    local tbl1 = {
        onWidthUpdated = 0,
        itemSize = 0,
        getItemMetrics = 0,
        gridHorizontalSpacing = 0,
        gridVerticalSpacing = 0
    }

    if not bool1 then
        var5 = nil
    end

    tbl1.onWidthUpdated = var5
    tbl1.itemSize = itemSize
    tbl1.getItemMetrics = getItemMetrics
    tbl1.gridHorizontalSpacing = gridHorizontalSpacing
    tbl1.gridVerticalSpacing = gridVerticalSpacing
    return createElement(var7, join(tbl1, arg1))
end

return ShowMoreWrapperFn
