-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Component = require(AppChatParent.PlayerContextualMenu).Component
local React = require(AppChatParent.React)
local SharedFlags = require(AppChatParent.SharedFlags)
local SocialCommon = require(AppChatParent.SocialCommon)
local UIBlox = require(AppChatParent.UIBlox)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local Responsive = require(AppChatParent.Responsive)
local memo = React.memo

local convertUserPresenceTypeToString = SocialCommon.Utils.convertUserPresenceTypeToString
local Images = UIBlox.App.ImageSet.Images
local Interactable = UIBlox.Core.Control.Interactable
local useEffect = React.useEffect

local useIsInExperience = require(AppChat.Hooks.useIsInExperience)

local var1 = require(AppChat.Logger):new(script.Name)
local NetworkingFriends = require(AppChat.Http.NetworkingFriends)
local _types = require(AppChat.types)
local useGetFriendshipStatus = require(AppChatParent.FriendsHydrationReact).useGetFriendshipStatus

local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local FFlagAppChatMigrateFriendshipStatuses = require(AppChat.Flags.FFlagAppChatMigrateFriendshipStatuses)
local FFlagSkipBlockModal = SharedFlags.FFlagSkipBlockModal
local useGetPresenceByUserId = if FFlagAppChatPresenceStoreMigration then require(AppChatParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil

function PlayerContextualMenuWrapper(tbl1)
    local var2 = useDispatch()
    local var3 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)
    local tbl2

    if FFlagAppChatPresenceStoreMigration then
        local var4 = useGetPresenceByUserId(tbl1.participantId)

        if var4 then
            tbl2 = {
                locationString = var4.lastLocation,
                locationPlaceId = if var4.placeId == "" then nil else var4.placeId,
                locationRootPlaceId = if var4.rootPlaceId == "" then nil else var4.rootPlaceId,
                locationUniverseId = if var4.universeId == "" then nil else var4.universeId,
                status = var4.userPresenceType
            }
        else
            tbl2 = nil
        end
    else
        local var4 = useSelector(function(arg1)
            return arg1.ChatAppReducer.Presence.byUserId
        end)[tbl1.participantId]

        tbl2 = var4
            and {
                locationString = var4.lastLocation,
                locationPlaceId = var4.placeId,
                locationRootPlaceId = var4.rootPlaceId,
                locationUniverseId = var4.universeId,
                status = convertUserPresenceTypeToString(var4.userPresenceType)
            }
            or nil
    end

    local var4

    if FFlagAppChatMigrateFriendshipStatuses then
        var4 = useGetFriendshipStatus(tbl1.participantId)
    else
        var4 = useSelector(function(arg1)
            return arg1.ChatAppReducer.Friends.friendshipStatus
        end)[tbl1.participantId]

        useEffect(function()
            var2(NetworkingFriends.GetExtendedFriendshipStatus.API({ targetUserId = tbl1.participantId }))
        end, { tbl1.participantId })
    end

    local enableExperienceCtAs = not useIsInExperience()

    local createElement = React.createElement
    local var5 = Interactable
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        onStateChanged = function() end,
        Selectable = false,
        [React.Event.Activated] = tbl1.onDismiss
    }

    return createElement(var5, tbl3, {
        PCM = React.createElement(Component, {
            enableExperienceCTAs = enableExperienceCtAs,
            subjectPresence = tbl2,
            subjectUserId = tbl1.participantId,
            robloxFriendshipStatus = var4,
            closeCentralOverlayThunk = function() end,
            onReportActivated = tbl1.openReportUser and function()
                var1:info("User activated reportUser | userId: {}, conversationId: {}", tbl1.participantId, tbl1.conversationId)

                tbl1.openReportUser(tbl1.participantId, tbl1.conversationId)
            end,
            onBlockActivated = tbl1.openBlockingModal and function()
                tbl1.openBlockingModal(tbl1.participantId, tbl1.conversationId)
            end,
            skipBlockModal = FFlagSkipBlockModal,
            additionalButtons = tbl1.showRemoveUserButton
                and {{
                    icon = Images["icons/actions/leave"],
                    text = tbl1.removeFromGroupText,
                    onActivated = function()
                        tbl1.openRemoveUserDialog(tbl1.participantId, tbl1.conversationId)
                    end
                }}
                or nil,
            width = UDim.new(0, if var3 then 300 else 400)
        })
    })
end

return memo(PlayerContextualMenuWrapper)
