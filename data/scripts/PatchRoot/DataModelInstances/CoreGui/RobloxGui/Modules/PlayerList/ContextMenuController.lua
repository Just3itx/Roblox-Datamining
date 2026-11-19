-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParent = script.Parent
local RequestFriendship = require(scriptParent.Thunks.RequestFriendship)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local PlayerListVisibilityStore = PlayerList.PlayerListVisibilityStore
local PlayerContextualMenuStore = PlayerList.PlayerContextualMenuStore
local builderIcon = PlayerList.builderIcon
local buildMenuHeader = PlayerContextualMenuStore.buildMenuHeader

local LocalPlayer = Players.LocalPlayer

local var1 = builderIcon("person-plus")
local icon = builderIcon("person-trash-can")
local var2 = builderIcon("circle-slash")
local var3 = builderIcon("speech-bubble-exclamation")
local var4 = builderIcon("magnifying-glass-plus")

local function translate(str1: string, str2: string) -- Luacid: Inlined by compiler; 10 call sites recovered
    local success, result = pcall(function()
        return RobloxTranslator:FormatByKey(str1)
    end)
    return if success and result and result ~= "" then result else str2
end

local function getFriendLabelAndIcon(friendStatus)
    if friendStatus == Enum.FriendStatus.Friend then
        return translate("InGame.PlayerDropDown.Unfriend", "Unfriend"), icon
    elseif friendStatus == Enum.FriendStatus.FriendRequestSent then
        return translate("InGame.PlayerDropDown.CancelRequest", "Cancel request"), var1
    elseif friendStatus == Enum.FriendStatus.FriendRequestReceived then
        return translate("InGame.PlayerDropDown.Accept", "Accept request"), var1
    end

    return translate("InGame.PlayerDropDown.Action.ConnectionRequest", "Friend request"), var1
end

local function getFriendTelemetryAction(friendStatus): string -- Luacid: Inlined by compiler; 1 call site recovered
    if friendStatus == Enum.FriendStatus.Friend then
        return "friend_remove"
    end

    if friendStatus == Enum.FriendStatus.FriendRequestSent then
        return "friend_cancel"
    end

    if friendStatus == Enum.FriendStatus.FriendRequestReceived then
        return "friend_accept"
    end

    return "friend_send"
end

local function openReportDialog(player: Player)
    if require(RobloxGui.Modules.isNewInGameMenuEnabled)() then
        require(RobloxGui.Modules.InGameMenuInit).openReportDialog(player, "PlayerListReskin")
        return
    end
    require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenuContainerPage):ReportPlayer(player, "PlayerListReskin")
end

local function assembleMenuItems(tbl1)
    local result = {}

    if not (tbl1.isSelf or tbl1.isBlocked) then
        local label, var5 = getFriendLabelAndIcon(tbl1.friendStatus)
        local bool1 = tbl1.friendStatus == Enum.FriendStatus.Friend
        table.insert(result, {
            key = "friend",
            label = label,
            icon = var5,
            onActivated = tbl1.actions.onFriend,
            telemetryAction = getFriendTelemetryAction(tbl1.friendStatus),
            onceGroup = "friending",
            requiresConfirm = if bool1 then true else nil,
            confirmLabel = if bool1 then translate("InGame.PlayerDropDown.ConfirmUnfriend", "Tap to confirm unfriend") else nil
        })

        if tbl1.friendStatus == Enum.FriendStatus.FriendRequestReceived then
            table.insert(result, {
                key = "decline",
                label = translate("InGame.PlayerDropDown.Decline", "Decline"),
                icon = icon,
                onActivated = tbl1.actions.onDecline,
                telemetryAction = "friend_decline",
                onceGroup = "friending"
            })
        end
    end

    if tbl1.inspectMenuEnabled then
        table.insert(result, {
            key = "examine",
            label = translate("InGame.PlayerDropDown.Examine", "Examine avatar"),
            icon = var4,
            onActivated = tbl1.actions.onExamine,
            telemetryAction = "avatar_examine"
        })
    end

    if not tbl1.isSelf then
        table.insert(result, {
            key = "block",
            label = if tbl1.isBlocked then translate("InGame.PlayerDropDown.UnBlock", "Unblock") else translate("InGame.PlayerDropDown.Block", "Block"),
            icon = var2,
            onActivated = tbl1.actions.onBlock,
            telemetryAction = if tbl1.isBlocked then "user_unblock" else "user_block"
        })
        table.insert(result, {
            key = "report",
            label = translate("InGame.PlayerDropDown.Report", "Report abuse"),
            icon = var3,
            onActivated = tbl1.actions.onReport,
            telemetryAction = "user_report"
        })
    end

    return result
end

return {
    buildMenuData = function(player: Player, callback: (...any) -> (...any), bool1: boolean?, arg1)
        local userId = player.UserId
        local isSelf = not (LocalPlayer == nil) and player == LocalPlayer
        local isPlayerBlockedByUserId = false
        local unknown = Enum.FriendStatus.Unknown
        if not isSelf then
            pcall(function()
                isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(userId)
            end)
            if not isPlayerBlockedByUserId then
                if arg1 ~= nil then
                    unknown = arg1
                else
                    pcall(function()
                        unknown = LocalPlayer:GetFriendStatus(player)
                    end)
                end
            end
        end

        local items = assembleMenuItems({
            isSelf = isSelf,
            isBlocked = isPlayerBlockedByUserId,
            friendStatus = unknown,
            inspectMenuEnabled = GuiService:GetInspectMenuEnabled(),
            actions = {
                onFriend = function()
                    if unknown == Enum.FriendStatus.Friend or unknown == Enum.FriendStatus.FriendRequestSent then
                        RbxAnalyticsService:TrackEvent("Game", "RevokeFriendship", "PlayerDropDown")
                        LocalPlayer:RevokeFriendship(player)
                    elseif unknown == Enum.FriendStatus.FriendRequestReceived then
                        RequestFriendship(player, true)()
                    else
                        RequestFriendship(player)()
                    end
                end,
                onDecline = function()
                    RbxAnalyticsService:TrackEvent("Game", "DeclineFriendship", "PlayerDropDown")
                    LocalPlayer:RevokeFriendship(player)
                end,
                onExamine = function()
                    if bool1 then
                        PlayerContextualMenuStore.setSuppressNextDismissRestore(true)
                        PlayerListVisibilityStore.setVisible(false)
                    end
                    GuiService:InspectPlayerFromUserIdWithCtx(userId, "leaderBoard")
                    callback()
                end,
                onBlock = function()
                    if bool1 and not isPlayerBlockedByUserId then
                        PlayerContextualMenuStore.setSuppressNextDismissRestore(true)
                        PlayerListVisibilityStore.setVisible(false)
                    end
                    if isPlayerBlockedByUserId then
                        coroutine.wrap(function()
                            BlockingUtility:UnblockPlayerAsync(player)
                        end)()
                    else
                        require(RobloxGui.Modules.Settings.onBlockButtonActivated)(player, nil, "PlayerListReskin", {})
                    end
                    callback()
                end,
                onReport = function()
                    if bool1 then
                        PlayerContextualMenuStore.setSuppressNextDismissRestore(true)
                        PlayerListVisibilityStore.setVisible(false)
                    end
                    openReportDialog(player)
                    callback()
                end
            }
        })

        return {
            player = player,
            header = buildMenuHeader(player),
            items = items,
            telemetry = {
                isSelf = isSelf,
                friendStatus = if isSelf then nil else unknown.Name
            }
        }
    end,
    assembleMenuItems = assembleMenuItems,
    getFriendLabelAndIcon = getFriendLabelAndIcon
}
