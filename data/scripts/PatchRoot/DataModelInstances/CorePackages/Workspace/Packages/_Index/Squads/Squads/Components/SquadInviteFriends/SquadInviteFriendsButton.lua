-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local Cryo = require(SquadsParent.Cryo)
local FriendsMenu = require(SquadsParent.FriendsMenu)
local SquadExternalContractProvider = require(SquadsParent.SquadsCore.SquadExternalContractProvider)
local UIBlox = require(SquadsParent.UIBlox)
local UserModel = require(SquadsParent.UserLib).Models.UserModel
local UniversalAppPolicy = require(SquadsParent.UniversalAppPolicy)
local dependencies = require(Squads.dependencies)
local useIsInviteButtonDisabled = require(Squads.Hooks.useIsInviteButtonDisabled)

local React = dependencies.React
local useLocalization = dependencies.Hooks.useLocalization

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local FriendsListContext = FriendsMenu.FriendsListContext
local InviteCallbackContext = FriendsMenu.InviteCallbackContext
local SelectedUsersContext = FriendsMenu.SelectedUsersContext

local FFlagEnablePartyQuickStartButton = require(SquadsParent.SharedFlags).FFlagEnablePartyQuickStartButton

local encodeUserIds = require(SquadsParent.SquadsCore.encodeUserIds)
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadRootViewType = require(SquadsParent.SquadsCore.Enums).SquadRootViewType

local tbl1 = {
    [UserModel.PresenceType.OFFLINE] = 0,
    [UserModel.PresenceType.ONLINE] = 1,
    [UserModel.PresenceType.IN_GAME] = 2,
    [UserModel.PresenceType.IN_STUDIO] = 3
}

local function getFFlagRenameFriendsToConnectionsPartyLobby() -- Luacid: Inlined by compiler; 1 call site recovered
    return UniversalAppPolicy.getAppFeaturePolicies().getRenameFriendsToConnections()
end

local function SquadInviteFriendsButton(tbl2)
    local var1 = React.useContext(SelectedUsersContext)
    local var2 = React.useContext(InviteCallbackContext)
    local var3 = React.useContext(FriendsListContext)
    local var4 = React.useContext(SquadExternalContractContext)

    local selectedFriendsSize = var1.selectedFriendsSize

    local isDisabled = useIsInviteButtonDisabled(selectedFriendsSize, var1.selectedFriends or {}, var1.preselectedUsers or {})

    local var6 = useLocalization(
        {
            addFriendsText = "Feature.Chat.Label.AddFriends",
            addConnectionsText = "CommonUI.Features.Label.AddConnections"
        }
    )
    local var7

    if FFlagEnablePartyQuickStartButton then
        local var8 = var4.useSquadRootView()

        local var9 = React.useRef({})

        local var10 = React.useCallback(function()
            if var3.isFetchingFriends then
                return {}, {}
            end

            local tbl3 = {}
            local tbl4 = {}
            for _, friend in pairs(var3.friends) do
                if friend.presence ~= UserModel.PresenceType.OFFLINE then
                    table.insert(tbl3, tonumber(friend.id))
                    table.insert(tbl4, tbl1[friend.presence])
                end
            end

            return tbl3, tbl4
        end, { var3.isFetchingFriends, var3.friends })

        local var11 = React.useCallback(function()
            local tbl3 = {}
            local tbl4 = {}

            local tbl5 = ({})
            for k, _ in pairs(var1.selectedFriends) do
                tbl5[k] = true
            end

            for _, friend in ipairs(var3.friends) do
                if tbl5[friend.id] then
                    table.insert(tbl3, tonumber(friend.id))
                    table.insert(tbl4, tbl1[friend.presence])
                end
            end
            return tbl3, tbl4
        end, { var1.selectedFriends, var3.friends })

        React.useEffect(function()
            local onlineFriendsIds, onlineFriendsPresence = var10()
            local selectedFriendsIds, selectedFriendsPresence = var11()
            var9.current = {
                onlineFriendsIds = onlineFriendsIds,
                onlineFriendsPresence = onlineFriendsPresence,
                selectedFriendsIds = selectedFriendsIds,
                selectedFriendsPresence = selectedFriendsPresence,
                numActiveFriends = #onlineFriendsIds,
                numSelectedFriends = #selectedFriendsIds
            }
        end, { var10, var11 })

        local var12 = React.useCallback(function(actionType)
            local current = var9.current

            local var12 = Cryo.Dictionary.join(tbl2.analyticsInfo, {
                actionLocation = var4.squadLocation,
                actionType = actionType,
                activeFriendsUserIds = encodeUserIds(current.onlineFriendsIds),
                activeFriendsPresences = encodeUserIds(current.onlineFriendsPresence),
                selectedFriendsUserIds = encodeUserIds(current.selectedFriendsIds),
                selectedFriendsPresences = encodeUserIds(current.selectedFriendsPresence),
                numActiveFriends = current.numActiveFriends,
                numSelectedFriends = current.numSelectedFriends,
                clientTimeStamp = os.time()
            })

            var4.fireSquadAnalytics(EventNames.MultiInviteMenuActionStatus, var12)
        end, { var4.squadLocation, var4.fireSquadAnalytics, tbl2.analyticsInfo })

        React.useEffect(function()
            return function()
                if not tbl2.partyStartedRef.current then
                    var12("leave_page")
                    return
                end
                var12("multi_invite_attempted")
            end
        end, {})

        React.useEffect(function()
            if var8 == SquadRootViewType.None then
                var12("leave_page")
            end
        end, { var8, var12 })

        var7 = React.useCallback(function()
            var12("multi_invite_button_clicked")
            var2.inviteMultiFriends(var1.selectedFriends)
        end, { var12, var2.inviteMultiFriends, var1.selectedFriends })
    else
        var7 = React.useCallback(function()
            var2.inviteMultiFriends(var1.selectedFriends)
        end, { var2.inviteMultiFriends, var1.selectedFriends })
    end

    return React.createElement(Button, {
        onActivated = var7,
        buttonTextOverride = { TextWrapped = false },
        buttonType = ButtonType.PrimarySystem,
        size = UDim2.new(1, 0, 0, 36),
        text = if FFlagEnablePartyQuickStartButton then tbl2.buttonText elseif getFFlagRenameFriendsToConnectionsPartyLobby() then var6.addConnectionsText else var6.addFriendsText,
        isDisabled = isDisabled
    })
end

return SquadInviteFriendsButton
