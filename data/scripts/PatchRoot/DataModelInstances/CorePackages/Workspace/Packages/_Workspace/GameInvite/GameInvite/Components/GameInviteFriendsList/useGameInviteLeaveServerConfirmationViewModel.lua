-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local DataHydration = require(GameInviteParent.DataHydration)
local FocusNavigationUtils = require(GameInviteParent.FocusNavigationUtils)
local InputHandlers = require(GameInviteParent.InputHandlers)
local _ReactFocusNavigation = require(GameInviteParent.ReactFocusNavigation)
local useGetPresenceByUserId = require(GameInviteParent.FriendsCommon).Hooks.useGetPresenceByUserId

local isInThisServer = require(GameInvite.utils.isInThisServer)
local _joinFriendFromExperience = require(script.Parent.joinFriendFromExperience)

local NavigateBack = FocusNavigationUtils.FocusNavigationEventNameEnum.NavigateBack

local InGame = DataHydration.Presence.PresenceEnums.PresenceType.InGame

local tbl1 = { skipFetch = true }

local function getJoinTarget(userId: string, arg1)
    if arg1 == nil or arg1.userPresenceType ~= InGame or arg1.universeId == "" or isInThisServer(arg1, game.JobId) then
        return nil
    end

    return {
        userId = userId,
        placeId = arg1.placeId,
        rootPlaceId = arg1.rootPlaceId,
        universeId = arg1.universeId
    }
end

local function useGameInviteLeaveServerConfirmationViewModel(tbl2)
    local userId = tbl2.userId
    local onJoin = tbl2.onJoin
    local onClose = tbl2.onClose

    local var1 = useGetPresenceByUserId(userId, tbl1)
    local var2 = React.useMemo(function()
        return (getJoinTarget(userId, var1))
    end, { userId, var1 })

    local var3 = React.useRef(false)
    local closeCallback = React.useCallback(function(bool1: boolean)
        if bool1 and var2 ~= nil then
            if var3.current then
                return nil
            end
            var3.current = true
            onJoin(var2)
        end
        onClose()
        return nil
    end, { var2, onJoin, onClose })

    return {
        closeCallback = closeCallback,
        titleKey = "Notifications.ToastNotifications.Title.LeavingServer",
        bodyKey = "Notifications.ToastNotifications.Label.LeaveServerConfirmation",
        focusEventHandlers = React.useMemo(function()
            return {
                [NavigateBack] = {
                    handler = InputHandlers.onRelease(function(arg1)
                        closeCallback(false)
                        arg1:cancel()
                    end)
                }
            }
        end, { closeCallback })
    }
end

return useGameInviteLeaveServerConfirmationViewModel
