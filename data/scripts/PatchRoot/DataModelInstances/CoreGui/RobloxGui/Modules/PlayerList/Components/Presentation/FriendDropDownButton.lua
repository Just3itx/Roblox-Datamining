-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local LocalizationService = game:GetService("LocalizationService")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local DropDownButtonAnimator = require(script.Parent.DropDownButtonAnimator)

local Images = UIBlox.App.ImageSet.Images

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local LocalPlayer = Players.LocalPlayer

local var1 = Roact.PureComponent:extend("FriendDropDownButton")

var1.validateProps = t.strictInterface({
    layoutOrder = t.integer,
    playerRelationship = t.strictInterface(
        {
            isBlocked = t.boolean,
            friendStatus = t.enum(Enum.FriendStatus),
            isFollowing = t.boolean,
            isFollower = t.boolean
        }
    ),
    selectedPlayer = t.optional(t.instanceIsA("Player")),
    dropDownOpen = t.boolean,
    requestFriendship = t.callback,
    contentVisible = t.optional(t.boolean)
})

local function getFriendTextAndIcon(friendStatus)
    local iconsActionsFriendsFriendAdd = Images["icons/actions/friends/friendAdd"]
    local iconsActionsFriendsFriendRemove = Images["icons/actions/friends/friendRemove"]

    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    if friendStatus == Enum.FriendStatus.Friend then
        return localization:Format("Feature.Friends.Action.Unfriend"), iconsActionsFriendsFriendRemove
    elseif friendStatus == Enum.FriendStatus.Unknown or friendStatus == Enum.FriendStatus.NotFriend then
        return localization:Format("Feature.Friends.Label.FriendRequest"), iconsActionsFriendsFriendAdd
    elseif friendStatus == Enum.FriendStatus.FriendRequestSent then
        return RobloxTranslator:FormatByKey("InGame.PlayerDropDown.CancelRequest"), iconsActionsFriendsFriendAdd
    elseif friendStatus == Enum.FriendStatus.FriendRequestReceived then
        return RobloxTranslator:FormatByKey("InGame.PlayerDropDown.Accept"), iconsActionsFriendsFriendAdd
    end
    return localization:Format("Feature.Friends.Label.FriendRequest"), iconsActionsFriendsFriendAdd
end

function var1.init(arg1)
    arg1.state = { unfriendConfirm = false }
end

function var1.render(arg1)
    local playerRelationship = arg1.props.playerRelationship
    local selectedPlayer = arg1.props.selectedPlayer

    local onActivated = playerRelationship.friendStatus == Enum.FriendStatus.Friend and not arg1.state.unfriendConfirm and function()
        arg1:setState({ unfriendConfirm = true })
    end or function()
        if playerRelationship.friendStatus == Enum.FriendStatus.Friend then
            LocalPlayer:RevokeFriendship(selectedPlayer)
        elseif playerRelationship.friendStatus == Enum.FriendStatus.Unknown
            or playerRelationship.friendStatus == Enum.FriendStatus.NotFriend
        then
            arg1.props.requestFriendship(selectedPlayer, false)
        elseif playerRelationship.friendStatus == Enum.FriendStatus.FriendRequestSent then
            RbxAnalyticsService:ReportCounter("PlayerDropDown-RevokeFriendship")
            RbxAnalyticsService:TrackEvent("Game", "RevokeFriendship", "PlayerDropDown")
            LocalPlayer:RevokeFriendship(selectedPlayer)
        elseif playerRelationship.friendStatus == Enum.FriendStatus.FriendRequestReceived then
            RbxAnalyticsService:ReportCounter("PlayerDropDown-RequestFriendship")
            RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "PlayerDropDown")
            arg1.props.requestFriendship(selectedPlayer, true)
        end
    end

    local onDecline = playerRelationship.friendStatus == Enum.FriendStatus.FriendRequestReceived and function()
        LocalPlayer:RevokeFriendship(selectedPlayer)
    end or nil

    local onDismiss = arg1.state.unfriendConfirm and function()
        arg1:setState({ unfriendConfirm = false })
    end or nil

    local text, icon = getFriendTextAndIcon(playerRelationship.friendStatus)
    return Roact.createElement(DropDownButtonAnimator, {
        layoutOrder = arg1.props.layoutOrder,
        text = text,
        icon = icon,
        lastButton = false,
        onActivated = onActivated,
        forceShowOptions = arg1.state.unfriendConfirm,
        selectedPlayer = selectedPlayer,
        onDecline = onDecline,
        onDismiss = onDismiss
    })
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.playerRelationship.friendStatus ~= arg1.props.playerRelationship.friendStatus then
        arg1:setState({ unfriendConfirm = false })
    end

    if arg2.selectedPlayer ~= arg1.props.selectedPlayer or arg2.dropDownOpen ~= arg1.props.dropDownOpen then
        arg1:setState({ unfriendConfirm = false })
    end
end

return var1
