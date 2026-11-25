-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local NotificationCardContext = require(scriptParent.NotificationCardContext)

local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local _type = require(scriptParentParent.type)
local constants = require(scriptParentParent.constants)

local analyticsService = require(scriptParentParent.analytics.analyticsService)
local utils = scriptParentParent.utils
local toastNotificationHelper = require(utils.toastNotificationHelper)

local function NotificationCardProvider(tbl1)
    local eventStream = analyticsService.EventStream
    local cardSize = {
        thumbnail = constants.CardSizeDefault.thumbnail,
        cardPadding = constants.Padding.DefaultCardPadding
    }
    if tbl1.isCompact then
        cardSize.thumbnail = constants.CardSizeCompact.thumbnail
        cardSize.cardPadding = constants.Padding.CompactCardPadding
    end

    local cardTransparency = if tbl1.isCompact then constants.CardTransparency.Compact else constants.CardTransparency.Default

    return React.createElement(NotificationCardContext.Provider, {
        value = {
            state = tbl1.state,
            cardSize = cardSize,
            handleActions = tbl1.handleActions,
            sendEvent = function(arg1)
                toastNotificationHelper.fireEvent(eventStream, arg1)
            end,
            cardTransparency = cardTransparency,
            notificationReceivedTimestampMs = tbl1.notificationReceivedTimestampMs,
            timers = tbl1.timers,
            displayTimestampMs = tbl1.displayTimestampMs
        }
    }, tbl1.children)
end

return NotificationCardProvider
