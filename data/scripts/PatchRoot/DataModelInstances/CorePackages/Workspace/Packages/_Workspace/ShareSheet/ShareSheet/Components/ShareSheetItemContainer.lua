-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Foundation = require(ShareSheetParent.Foundation)
local FriendsCommon = require(ShareSheetParent.FriendsCommon)
local React = require(ShareSheetParent.React)
local SocialCommon = require(ShareSheetParent.SocialCommon)

local FFlagShareSheetDesktopReadiness = require(ShareSheet.Flags.FFlagShareSheetDesktopReadiness)
local ShareSheetItemView = require(script.Parent.ShareSheetItemView)

local useGetPresenceByUserId = FriendsCommon.Hooks.useGetPresenceByUserId
local convertToFoundationPresenceEnum = SocialCommon.Utils.convertToFoundationPresenceEnum

local function ShareSheetItemContainer(tbl1)
    local var1 = useGetPresenceByUserId(tbl1.primaryUserId)
    local userPresence = if var1 and var1.userPresenceType then convertToFoundationPresenceEnum(var1.userPresenceType) else Foundation.Enums.UserPresence.None
    return React.createElement(ShareSheetItemView, {
        icon = tbl1.icon,
        isSelected = tbl1.isSelected,
        primaryUserId = tbl1.primaryUserId,
        secondUserId = tbl1.secondUserId,
        label = tbl1.label,
        onActivated = tbl1.onActivated,
        shouldAnimate = tbl1.shouldAnimate,
        userPresence = userPresence,
        width = if FFlagShareSheetDesktopReadiness then tbl1.width else nil,
        LayoutOrder = tbl1.LayoutOrder
    })
end

return ShareSheetItemContainer
