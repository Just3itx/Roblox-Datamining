-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local FFlagBuildExperienceMyCreationsLongPressMenu = require(BuildExperience.Flags.FFlagBuildExperienceMyCreationsLongPressMenu)
local descriptionWithGroupIcon = require(BuildExperience.utils.descriptionWithGroupIcon)
local ExperienceResultsLoadingSkeleton = require(script.Parent.ExperienceResultsLoadingSkeleton)
local ExperienceRowActionsMenu = require(script.Parent.ExperienceRowActionsMenu)
local _useMyCreationsResults = require(script.Parent.useMyCreationsResults)

local Badge = Foundation.Badge
local List = Foundation.List
local View = Foundation.View
local useMeasurableRef = Foundation.Hooks.useMeasurableRef

local BadgeShape = Foundation.Enums.BadgeShape
local BadgeSize = Foundation.Enums.BadgeSize
local BadgeVariant = Foundation.Enums.BadgeVariant
local InputSize = Foundation.Enums.InputSize
local ListItemInputType = Foundation.Enums.ListItemInputType

local function useRowActionsMenu()
    local var1 = useMeasurableRef(Vector2.zero, Vector2.zero)
    local rowActions, var3 = React.useState(nil)
    local isOpen, var5 = React.useState(false)
    local open = React.useCallback(function(target, vector2: Vector2, isAtPointer: boolean)
        var1.current:SetPosition(vector2)
        var3({ target = target, isAtPointer = isAtPointer })

        var5(true)
    end, { var1 })
    local close = React.useCallback(function()
        var5(false)
    end, {})
    return {
        rowActions = rowActions,
        anchor = var1.current,
        isOpen = isOpen,
        open = open,
        close = close
    }
end

local var1 = React.memo(function(arg1) -- name: ExperienceListItem
    local leading = React.useMemo(function()
        return {
            type = nil,
            iconName = arg1.gameIcon,
            iconVariant = nil
        }
    end, { arg1.gameIcon })
    local onActivated = React.useCallback(function()
        arg1.onOpenChat({
            universeId = arg1.universeId,
            placeId = arg1.placeId,
            sessionId = arg1.sessionId,
            experienceName = arg1.experienceName,
            creatorName = arg1.creatorName,
            gameIcon = arg1.gameIcon
        })
    end, {
        arg1.creatorName,
        arg1.experienceName,
        arg1.gameIcon,
        arg1.onOpenChat,
        arg1.placeId,
        arg1.sessionId,
        arg1.universeId
    })

    local onLongPress = arg1.onLongPress

    local var3 = if FFlagBuildExperienceMyCreationsLongPressMenu then React.useCallback(function(arg2, arg3)
        if onLongPress == nil then
            return
        end
        local tbl1 = {
            universeId = arg1.universeId,
            placeId = arg1.placeId,
            sessionId = arg1.sessionId,
            experienceName = arg1.experienceName,
            creatorName = arg1.creatorName,
            gameIcon = arg1.gameIcon
        }

        if arg3.UserInputType == Enum.UserInputType.MouseButton2 then
            onLongPress(tbl1, Vector2.new(arg3.Position.X, arg3.Position.Y), true)
            return
        end
        onLongPress(tbl1, arg2.AbsolutePosition + Vector2.new(arg2.AbsoluteSize.X, 0), false)
    end, {
        onLongPress,
        arg1.creatorName,
        arg1.experienceName,
        arg1.gameIcon,
        arg1.placeId,
        arg1.sessionId,
        arg1.universeId
    }) else nil

    local trailing = React.useMemo(function()
        if arg1.visibilityLabel == nil then
            return nil
        end

        return React.createElement(View, { tag = "row align-y-center auto-xy" }, {
            VisibilityBadge = React.createElement(Badge, {
                text = arg1.visibilityLabel,
                shape = BadgeShape.Box,
                size = BadgeSize.Small,
                variant = BadgeVariant.Neutral,
                testId = `{arg1.testIdPrefix}.VisibilityBadge.{arg1.universeId}`
            })
        })
    end, { arg1.testIdPrefix, arg1.universeId, arg1.visibilityLabel })

    local bool1 = not (var3 == nil) and onLongPress ~= nil
    local createElement = React.createElement
    local item = List.Item
    local tbl1 = {
        LayoutOrder = arg1.LayoutOrder,
        leading = leading,
        title = arg1.experienceName,
        description = descriptionWithGroupIcon(arg1.description, arg1.isGroupGame, arg1.creatorName),
        testId = `{arg1.testIdPrefix}.ExperienceRow.{arg1.universeId}`,
        onActivated = onActivated,
        onSecondaryActivated = 0,
        input = 0,
        trailing = 0
    }

    if not bool1 then
        var3 = nil
    end

    tbl1.onSecondaryActivated = var3
    tbl1.input = if bool1 then ListItemInputType.None else nil
    tbl1.trailing = trailing
    return createElement(item, tbl1)
end)
return React.memo(function(tbl1) -- name: ExperienceResultsList
    local testIdPrefix = tbl1.testIdPrefix or "MyCreationsTab"
    local firstResultLayoutOrder = tbl1.firstResultLayoutOrder or 1
    local var2 = table.clone(tbl1.leadingItems or {})
    local onOpenConfigurationPage = tbl1.onOpenConfigurationPage
    local var3 = nil

    if FFlagBuildExperienceMyCreationsLongPressMenu then
        local tbl2 = useRowActionsMenu()
        if onOpenConfigurationPage ~= nil then
            var3 = tbl2
        end
    end

    local rowActions = if var3 == nil then nil else var3.rowActions

    if tbl1.hasDisplayedResult and tbl1.hasDisplayedItems then
        for k, item in tbl1.items do
            local var4 = "U" .. item.universeId
            local layoutOrder = k + firstResultLayoutOrder - 1
            var2[var4] = React.createElement(var1, {
                LayoutOrder = layoutOrder,
                sessionId = item.sessionId,
                universeId = item.universeId,
                placeId = item.placeId,
                experienceName = item.experienceName,
                creatorName = item.creatorName,
                description = item.description,
                visibilityLabel = item.visibilityLabel,
                gameIcon = item.gameIcon,
                isGroupGame = item.isGroupGame,
                onOpenChat = tbl1.onOpenChat,
                onLongPress = if var3 == nil then nil else var3.open,
                testIdPrefix = testIdPrefix
            })
        end
    elseif tbl1.listStatus == "NotReady" or tbl1.hasPendingSummary then
        for index = 1, 2 do
            local str1 = `Loading{index}`
            var2[str1] = React.createElement(
                ExperienceResultsLoadingSkeleton,
                {
                    LayoutOrder = index + firstResultLayoutOrder - 1,
                    index = index,
                    testIdPrefix = testIdPrefix
                }
            )
        end
    elseif tbl1.listStatus == "Failed" then
        var2.Error = React.createElement(List.Item, { LayoutOrder = firstResultLayoutOrder, title = tbl1.loadError })
    end

    if tbl1.failedLoadMore then
        var2.LoadMoreError = React.createElement(List.Item, {
            LayoutOrder = #tbl1.items + firstResultLayoutOrder,
            title = tbl1.loadError,
            testId = `{testIdPrefix}.LoadMoreError`,
            onActivated = tbl1.retryLoadMore
        })
    end
    if var3 ~= nil then
        var2.RowActionsMenu = React.createElement(ExperienceRowActionsMenu, {
            target = if rowActions == nil then nil else rowActions.target,
            anchor = if rowActions == nil then nil else var3.anchor,
            isAtPointer = if rowActions == nil then nil else rowActions.isAtPointer,
            isOpen = var3.isOpen,
            onClose = var3.close,
            onOpenConfigurationPage = onOpenConfigurationPage
        })
    end

    return React.createElement(
        List.Root,
        {
            hasDivider = false,
            isContained = { isContained = false, hasMargin = false },
            size = InputSize.Large
        },
        var2
    )
end)
