-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent
local Context = FriendsMenu.Context

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local normalizeFontFace = require(FriendsMenuParent.Foundation).Utility.normalizeFontFace
local RoactUtils = require(FriendsMenuParent.RoactUtils)
local Signals = require(FriendsMenuParent.Signals)
local useSignalState = require(FriendsMenuParent.SignalsReact).useSignalState

local FFlagUseSignalsForGameInvitesStatus = require(FriendsMenuParent.SharedFlags).FFlagUseSignalsForGameInvitesStatus
local GetGameInvitesStatusStore = if FFlagUseSignalsForGameInvitesStatus then require(FriendsMenuParent.NotificationsCommon).GetGameInvitesStatusStore else nil
local LocalizationHelper = require(FriendsMenuParent.NotificationsCommon).LocalizationHelper
local Constants = require(FriendsMenu.Constants)
local FriendsListContext = require(Context.FriendsListContext)
local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local useStyle = UIBlox.Core.Style.useStyle
local InviteStatus = Constants.InviteStatus
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

local tbl1 = {
    inviteFriend = "Feature.SettingsHub.Action.InviteFriend",
    [InviteStatus.Success] = "Feature.SettingsHub.Label.Invited",
    [InviteStatus.Moderated] = "Feature.SettingsHub.Label.Moderated",
    [InviteStatus.Pending] = "Feature.SettingsHub.Label.Sending"
}

return function(tbl2)
    local var1

    if FFlagUseSignalsForGameInvitesStatus then
        local id = tbl2.friend and tbl2.friend.id
        local var2 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                return GetGameInvitesStatusStore(false).getGameInvitesStatus(arg1)[id]
            end)
        end, { id })
        var1 = useSignalState(var2)
    else
        var1 = useSelector(function(arg1)
            local friend = tbl2.friend
            assert(friend, "friend should be non-nil. Silence type checker.")

            return arg1.GameInvitesStatus[friend.id]
        end)
    end

    local localizedStrings = getLocalizedStrings(tbl1)

    local var2 = React.useContext(FriendsListContext)

    local var3 = useStyle()
    local theme = var3 and var3.Theme
    local font = var3 and var3.Font

    local isFetchingFriends = var2.isFetchingFriends
    local textSize = font.BaseSize * font.CaptionHeader.RelativeSize

    if (not var1 or var1 == InviteStatus.Failed) and not tbl2.isFullRowActivatable then
        return React.createElement(Button, {
            buttonType = ButtonType.Secondary,
            isDisabled = isFetchingFriends,
            isLoading = false,
            onActivated = tbl2.onInvite,
            standardSize = StandardButtonSize.XSmall,
            fitContent = true,
            anchorPoint = tbl2.anchorPoint,
            position = tbl2.position,
            text = localizedStrings.inviteFriend,
            layoutOrder = tbl2.layoutOrder
        })
    end
    local var5 = localizedStrings[var1] or localizedStrings.inviteFriend

    return React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        Text = var5,
        TextSize = textSize,
        TextWrapped = true,
        Size = tbl2.size,
        AnchorPoint = tbl2.anchorPoint,
        Position = tbl2.position,
        TextColor3 = theme.TextDefault.Color,
        FontFace = normalizeFontFace(var3.Tokens.Typography.CaptionLarge.Font),
        LayoutOrder = tbl2.layoutOrder
    })
end
