-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local NotificationCardContext = require(scriptParent.NotificationCardContext)

local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local _type = require(scriptParentParent.type)
local constants = require(scriptParentParent.constants)

local function NotificationCardProvider(tbl1)
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
            notificationPayload = tbl1.notificationPayload,
            state = tbl1.state,
            cardSize = cardSize,
            handleActions = tbl1.handleActions,
            openMetaActions = tbl1.openMetaActions,
            readOnly = tbl1.readOnly,
            cardTransparency = cardTransparency
        }
    }, tbl1.children)
end

return NotificationCardProvider
