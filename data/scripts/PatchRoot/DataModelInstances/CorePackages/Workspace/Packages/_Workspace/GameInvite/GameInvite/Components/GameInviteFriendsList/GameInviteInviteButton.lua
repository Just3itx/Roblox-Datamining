-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local Foundation = require(GameInviteParent.Foundation)
local FriendsMenu = require(GameInviteParent.FriendsMenu)
local NotificationsCommon = require(GameInviteParent.NotificationsCommon)
local RoactUtils = require(GameInviteParent.RoactUtils)
local Signals = require(GameInviteParent.Signals)
local useSignalState = require(GameInviteParent.SignalsReact).useSignalState
local FFlagGameInviteInExpJoinCta = require(GameInvite.Flags.FFlagGameInviteInExpJoinCta)
local GameInviteConstants = require(GameInvite.GameInviteConstants)

local FFlagUseSignalsForGameInvitesStatus = require(GameInviteParent.SharedFlags).FFlagUseSignalsForGameInvitesStatus
local GetGameInvitesStatusStore = if FFlagUseSignalsForGameInvitesStatus then NotificationsCommon.GetGameInvitesStatusStore else nil
local getLocalizedStrings = NotificationsCommon.LocalizationHelper.getLocalizedStrings
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local InviteStatus = FriendsMenu.InviteStatus

local Button = Foundation.Button
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local FillBehavior = Foundation.Enums.FillBehavior

local sizeConstraint = {
    MinSize = Vector2.new(GameInviteConstants.Layout.JoinCtaMinWidth, 0),
    MaxSize = Vector2.new(GameInviteConstants.Layout.JoinCtaMaxWidth, math.huge)
}

local tbl2 = {
    inviteFriend = "Feature.SettingsHub.Action.InviteFriend",
    [InviteStatus.Success] = "Feature.SettingsHub.Label.Invited",
    [InviteStatus.Moderated] = "Feature.SettingsHub.Label.Moderated",
    [InviteStatus.Pending] = "Feature.SettingsHub.Label.Sending"
}

local function GameInviteInviteButton(tbl3)
    local userId = tbl3.userId
    local rowNumber = tbl3.rowNumber
    local isFetchingFriends = React.useContext(FriendsMenu.FriendsListContext).isFetchingFriends
    local inviteSingleFriend = React.useContext(FriendsMenu.InviteFriendContext).inviteSingleFriend
    local onActivated = React.useCallback(function()
        inviteSingleFriend(userId, rowNumber)
    end, { inviteSingleFriend, userId, rowNumber })

    local var2 = if FFlagUseSignalsForGameInvitesStatus then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return GetGameInvitesStatusStore(false).getGameInvitesStatus(arg1)[userId]
        end)
    end, { userId }) else nil

    local var3 = if FFlagUseSignalsForGameInvitesStatus then useSignalState(var2) else useSelector(function(arg1)
        return arg1.GameInvitesStatus[userId]
    end)

    local localizedStrings = getLocalizedStrings(tbl2)

    if FFlagGameInviteInExpJoinCta then
        local element

        if var3 == nil or var3 == InviteStatus.Failed then
            element = React.createElement(Button, {
                text = localizedStrings.inviteFriend,
                variant = ButtonVariant.Standard,
                size = InputSize.Small,
                fillBehavior = FillBehavior.Fill,
                isDisabled = isFetchingFriends,
                onActivated = onActivated
            })
        else
            element = React.createElement(FoundationText, {
                tag = "fill auto-xy text-caption-large text-wrap text-align-x-center content-default",
                Text = localizedStrings[var3] or localizedStrings.inviteFriend
            })
        end
        return React.createElement(
            View,
            {
                tag = "row align-x-center align-y-center auto-xy",
                sizeConstraint = sizeConstraint,
                LayoutOrder = tbl3.layoutOrder
            },
            { Content = element }
        )
    elseif var3 == nil or var3 == InviteStatus.Failed then
        return React.createElement(Button, {
            text = localizedStrings.inviteFriend,
            variant = ButtonVariant.Standard,
            size = InputSize.Small,
            isDisabled = isFetchingFriends,
            onActivated = onActivated,
            LayoutOrder = tbl3.layoutOrder
        })
    else
        return React.createElement(FoundationText, {
            tag = "auto-xy text-caption-large content-default",
            Text = localizedStrings[var3] or localizedStrings.inviteFriend,
            LayoutOrder = tbl3.layoutOrder
        })
    end
end

return GameInviteInviteButton
