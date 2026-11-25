-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local AppNotificationService = require(ProfilePlatformParent.RoactServiceTags).AppNotificationService

local convertPresenceEnum = require(ProfilePlatform.Utils.convertPresenceEnum)
local Presence = require(ProfilePlatform.Rodux.Presence)
local PresenceType = Presence.Enums.PresenceType
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local refreshProfilePlatformUserInfo = require(ProfilePlatform.Networking.refreshProfilePlatformUserInfo)
local refreshProfilePlatformActionInfo = require(ProfilePlatform.Networking.refreshProfilePlatformActionInfo)
local useActionsComponentRequest = require(ProfilePlatform.Hooks.useActionsComponentRequest)

local FFlagProfilePlatformRefreshActionsRespectPolicies = require(ProfilePlatform.Flags.FFlagProfilePlatformRefreshActionsRespectPolicies)
local RobloxEventReceiver = require(ProfilePlatformParent.RealtimeDelivery).RobloxEventReceiver
local React = require(ProfilePlatformParent.React)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useLocalUserId = RobloxAppHooks.useLocalUserId
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useRoactService = RobloxAppHooks.useRoactService
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local Enums = require(ProfilePlatform.Common.Enums)

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local tbl1 = { skipFetch = true }

return function()
    local var1 = useProfileWrapperContext()
    local var2 = useRoactService(AppNotificationService)
    local var3 = React.useMemo(function()
        return RobloxEventReceiver.new(var2)
    end, { var2 })
    local var4 = useDispatch()
    local var5 = useLocalUserId()
    local profileId = var1.profileId
    local profileType = var1.profileType
    local var6 = if FFlagProfilePlatformRefreshActionsRespectPolicies then useActionsComponentRequest() else nil
    local var7

    if FFlagProfilePlatformPresenceStoreMigration then
        local var8 = useGetPresenceByUserId(profileId, tbl1)
        local var9 = convertPresenceEnum
        local var10 = if var8 then var8.userPresenceType else PresenceType.Offline
        local var11 = if var8 and var8.universeId ~= "" then tonumber(var8.universeId) else nil
        var7 = var9(var10, var11)
    else
        local var8 = useSelector(function(arg1)
            return Presence.Selectors.getUserPresenceByUserId(arg1, profileId)
                or {
                    userPresenceType = PresenceType.Offline,
                    lastLocation = ""
                }
        end)

        var7 = convertPresenceEnum(var8.userPresenceType, var8.universeId)
    end
    local var8 = React.useRef(var7)
    local useEffect = React.useEffect

    local function func1()
        if profileType ~= Enums.ProfileTypes.User then
            return
        end

        if var8.current == var7 then
            return
        end
        if var8.current == Enums.PresenceTypes.InGame or var7 == Enums.PresenceTypes.InGame then
            var4(refreshProfilePlatformActionInfo(profileId, var6))
        end

        var8.current = var7
    end

    local var9 = var7
    local var10 = if FFlagProfilePlatformRefreshActionsRespectPolicies then var6 else nil
    useEffect(func1, { var9, var4, profileId, profileType, var10 })

    React.useEffect(function()
        if profileType ~= Enums.ProfileTypes.User then
            return
        end

        local var11 = var3:observeEvent("UserProfileNotifications", function(arg1)
            local str1 = tostring(arg1.VieweeUserId)
            local type = arg1.Type

            if profileId == str1
                and (type == Enums.NameTypes.DisplayName or type == Enums.NameTypes.Alias or type == Enums.NameTypes.Username)
            then
                var4(refreshProfilePlatformUserInfo(str1))
            end
        end)

        return function()
            var11:disconnect()
        end
    end, {
        var3,
        var4,
        profileId,
        profileType
    })

    local useEffect2 = React.useEffect

    local function func2()
        if profileType ~= Enums.ProfileTypes.User then
            return
        end

        local var11 = var3:observeEvent("FriendshipNotifications", function(arg1)
            local str1 = tostring(var5)
            local userId1 = arg1.EventArgs.UserId1
            local var11 = if str1 == tostring(userId1) then tostring(arg1.EventArgs.UserId2) else tostring(arg1.EventArgs.UserId1)

            if profileId == var11 then
                var4(refreshProfilePlatformActionInfo(profileId, var6))
            end
        end)

        return function()
            var11:disconnect()
        end
    end

    local var11 = if FFlagProfilePlatformRefreshActionsRespectPolicies then var6 else nil
    useEffect2(func2, { var3, var4, profileId, var5, profileType, var11 })

    local useEffect3 = React.useEffect

    local function func3()
        if profileType ~= Enums.ProfileTypes.User then
            return
        end

        local var12 = var3:observeEvent("TrustedConnectionNotifications", function(arg1)
            local str1 = tostring(var5)
            local actor = arg1.Actor
            local var12 = if str1 == tostring(actor) then tostring(arg1.Target) else tostring(arg1.Actor)

            if profileId == var12 then
                var4(refreshProfilePlatformActionInfo(profileId, var6))
            end
        end)

        return function()
            var12:disconnect()
        end
    end

    local var12 = if FFlagProfilePlatformRefreshActionsRespectPolicies then var6 else nil
    useEffect3(func3, { var3, var4, profileId, var5, profileType, var12 })
end
