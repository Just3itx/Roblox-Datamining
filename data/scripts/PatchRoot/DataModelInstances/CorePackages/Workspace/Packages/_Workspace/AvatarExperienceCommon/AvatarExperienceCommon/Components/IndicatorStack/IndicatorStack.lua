-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local React = require(AvatarExperienceCommonParent.React)

local ItemCardComponents = require(AvatarExperienceCommonParent.AvatarExperienceUIKit).ItemCardComponents
local ItemCardBadge = ItemCardComponents.ItemCardBadge
local ItemCardIndicatorStack = ItemCardComponents.ItemCardIndicatorStack
local ItemCardStatus = ItemCardComponents.ItemCardStatus
local ItemCardIcon = ItemCardComponents.ItemCardIcon

local _shouldRenderIndicatorStack = require(AvatarExperienceCommon.Utils.shouldRenderIndicatorStack)

local function renderStatusContent(statusContent)
    if statusContent.type == "text" then
        return React.createElement(ItemCardStatus, { text = statusContent.text })
    elseif statusContent.type == "badge" then
        return React.createElement(ItemCardBadge, { content = statusContent.content, displayBorder = statusContent.displayBorder })
    end

    return React.createElement(ItemCardIcon, { icon = statusContent.icon })
end

local function IndicatorStack(tbl1)
    return React.createElement(ItemCardIndicatorStack, {
        statusSlot = if tbl1.statusContent then renderStatusContent(tbl1.statusContent) else nil,
        itemTypeSlot = if tbl1.itemTypeContent then React.createElement(ItemCardBadge, { content = tbl1.itemTypeContent }) else nil
    })
end

return IndicatorStack
