-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local useRoactService = require(GroupsParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GroupsParent.RoactServiceTags).RoactNetworking

local React = require(GroupsParent.React)
local ReactUtils = require(GroupsParent.ReactUtils)
local UserLib = require(GroupsParent.UserLib)
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = UserLib.Utils.Constants
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization
local FFlagAddCommunityDeactivatedToJoinPrompt = require(GroupsParent.SharedFlags).FFlagAddCommunityDeactivatedToJoinPrompt

local useContext = React.useContext
local useEventConnection = ReactUtils.useEventConnection
local Enums = require(GroupsParent.ProfilePlatform.Enums)

local fetchGroupDetails = require(Groups.Common.fetchGroupDetails)
local postJoinGroup = require(Groups.Common.postJoinGroup)
local fetchGroupActions = require(Groups.Common.fetchGroupActions)

local ServiceOverrideContext = require(Groups.Components.CoreUI.ServiceOverrideContext)

local _Types = require(Groups.Common.Types)
local THUMBNAIL_SIZE = require(Groups.Common.constants).THUMBNAIL_SIZE

local function parseMembershipStatusFromActions(tbl1)
    local var1 = tbl1.buttons or {}
    local type, disabledReason

    if #var1 > 0 then
        type = var1[1].type
        disabledReason = var1[1].disabledReason
    else
        type = nil
        disabledReason = nil
    end

    return {
        isAlreadyMember = (type == Enums.ProfileActions.ViewCommunity or type == Enums.ProfileActions.ViewFullProfile) and not disabledReason,
        hasPendingRequest = type == Enums.ProfileActions.CancelJoinCommunityRequest,
        isEligible = (type == Enums.ProfileActions.JoinCommunity or type == Enums.ProfileActions.Follow) and not disabledReason,
        disabledReason = disabledReason
    }
end

local function buildGroupJoinPromptData(tbl1): {disabledReason: number, groupName: any, hasPendingRequest: number, hasSocialModules: number, isAlreadyMember: number, isEligible: number, isGroupVerified: any, membersCount: number, ownerIsVerified: any, ownerName: any, ownerUserId: any}?
    if not tbl1 then
        return nil
    end

    local var1 = tbl1.components or {}
    local communityProfileHeader = var1.CommunityProfileHeader or {}
    local var2 = var1.Actions or {}

    local tbl2 = parseMembershipStatusFromActions(var2)

    return {
        groupName = communityProfileHeader.name,
        isGroupVerified = communityProfileHeader.isVerified,
        ownerName = communityProfileHeader.ownerName,
        ownerIsVerified = communityProfileHeader.ownerIsVerified,
        ownerUserId = communityProfileHeader.ownerUserId,
        membersCount = if communityProfileHeader.counts then communityProfileHeader.counts.membersCount else nil,
        isAlreadyMember = tbl2.isAlreadyMember,
        hasPendingRequest = tbl2.hasPendingRequest,
        isEligible = tbl2.isEligible,
        disabledReason = tbl2.disabledReason,
        hasSocialModules = communityProfileHeader.hasSocialModules
    }
end

return function(tbl1)
    local var1 = useRoactService(RoactNetworking)

    local var2 = useContext(ServiceOverrideContext)
    local groupService = var2.groupService
    local guiService = var2.guiService

    local var3 = useLocalization({
        notificationJoined = "Feature.Groups.Notification.Joined",
        notificationFollowing = "Feature.Groups.Notification.Following",
        notificationJoinRequestPending = "Feature.Groups.Notification.JoinRequestPending",
        notificationFailedToLoad = "Feature.Groups.Notification.FailedToLoad",
        notificationFailedToJoin = "Feature.Groups.Notification.FailedToJoin",
        notificationFailedToFollow = "Feature.Groups.Notification.FailedToFollow",
        notificationGroupDoesNotExist = "Feature.Groups.Notification.GroupDoesNotExist",
        notificationGroupModerated = "Feature.Groups.Notification.GroupModerated",
        notificationGroupDeactivated = if FFlagAddCommunityDeactivatedToJoinPrompt then "Feature.Groups.Notification.GroupDeactivated" else nil
    })

    local var4 = React.useRef(nil)

    local function closePrompt() -- Luacid: Inlined by compiler; 3 call sites recovered
        var4.current = nil
        tbl1.closePrompt()
    end

    local var5 = React.useCallback(function(num1: number, str1: string, title: string?)
        groupService:PromptJoinCompleted(num1, false, Enum.GroupMembershipStatus.None, str1)

        guiService:SendNotification({ Title = title, Icon = "rbxasset://textures/ui/ErrorIcon.png" })
        closePrompt()
    end, { groupService, guiService, tbl1.closePrompt })

    local var6 = React.useCallback(function(num1: number, bool1: boolean, str1: string, bool2: boolean?)
        local var6 = if bool2 then var3.notificationFailedToLoad elseif bool1 then var3.notificationFailedToJoin else var3.notificationFailedToFollow
        var5(num1, str1, var6)
    end, { var5 })

    local var7 = React.useCallback(function(num1: number, arg1)
        return function()
            local var7 = not arg1 or arg1.hasSocialModules == nil or arg1.hasSocialModules

            local groupName = arg1 and arg1.groupName or ""

            postJoinGroup(var1, num1):andThen(function()
                return fetchGroupActions(var1, num1):andThen(function(arg2)
                    if arg2.errors then
                        var6(num1, var7, "Network error on join prompt: Some group components failed to load", false)

                        return
                    end
                    local var8 = (arg2.components or {}).Actions or {}
                    local tbl2 = parseMembershipStatusFromActions(var8)
                    local var9, var10

                    if tbl2.isAlreadyMember then
                        var9 = Enum.GroupMembershipStatus.Joined
                        if var7 then
                            var10 = var3.notificationJoined
                        else
                            var10 = var3.notificationFollowing
                        end
                    else
                        if not tbl2.hasPendingRequest then
                            var6(num1, var7, "Unexpected membership status after join prompt", false)

                            return
                        end

                        var9 = Enum.GroupMembershipStatus.JoinRequestPending
                        var10 = var3.notificationJoinRequestPending
                    end

                    groupService:PromptJoinCompleted(num1, true, var9, "")
                    closePrompt()
                    local title = string.gsub(var10, "{groupName}", groupName)
                    local icon = getRbxthumbWithTypeSizeAndOptions(tostring(num1), Constants.RbxthumbTypes.GroupIcon, THUMBNAIL_SIZE)

                    guiService:SendNotification({ Title = title, Icon = icon })
                end, function(arg2)
                    var6(num1, var7, "Network error on join prompt: " .. arg2.StatusMessage, false)
                end)
            end, function(arg2)
                var6(num1, var7, "Network error on join prompt: " .. arg2.StatusMessage, false)
            end)
        end
    end, {
        var1,
        var6,
        var3,
        groupService,
        guiService,
        tbl1.closePrompt
    })

    local var8 = React.useCallback(function(num1: number, arg1)
        return function()
            local bool1 = if arg1 then not not arg1.isAlreadyMember else false
            local bool2 = if arg1 then not not arg1.hasPendingRequest else false
            local groupMembershipStatus = if bool1 then Enum.GroupMembershipStatus.AlreadyMember elseif bool2 then Enum.GroupMembershipStatus.JoinRequestPending else Enum.GroupMembershipStatus.None
            groupService:PromptJoinCompleted(num1, true, groupMembershipStatus, "")
            closePrompt()
        end
    end, { groupService, tbl1.closePrompt })

    local var9 = React.useCallback(function(num1: number)
        local current = {}
        var4.current = current

        local tbl3 = {
            onJoin = var7(num1, nil),
            onClose = var8(num1, nil)
        }

        tbl1.openGroupJoinPrompt(num1, nil, tbl3)

        fetchGroupDetails(var1, num1):andThen(function(arg1)
            if var4.current ~= current then
                return
            end

            local var9 = arg1.components or {}
            local bool1 = next(var9) ~= nil
            local bool2 = var9.CommunityLocked ~= nil
            local bool3 = arg1.errors ~= nil
            local var10 = FFlagAddCommunityDeactivatedToJoinPrompt and var9.CommunityDeactivated ~= nil

            local communityProfileHeader = var9.CommunityProfileHeader or {}
            local var11 = communityProfileHeader.hasSocialModules == nil or communityProfileHeader.hasSocialModules

            if bool3 then
                if var4.current ~= current then
                    return
                end
                var6(num1, var11, "Network error on join prompt: Some group components failed to load", true)
                return
            end
            if not bool1 then
                if var4.current ~= current then
                    return
                end
                var5(num1, "Group does not exist", var3.notificationGroupDoesNotExist)
                return
            end

            if var10 then
                if var4.current ~= current then
                    return
                end
                var5(num1, "Group is deactivated", var3.notificationGroupDeactivated)
                return
            end

            if bool2 then
                if var4.current ~= current then
                    return
                end
                var5(num1, "Group is currently moderated", var3.notificationGroupModerated)
                return
            end
            if var4.current ~= current then
                return
            end

            local groupJoinPromptData = buildGroupJoinPromptData(arg1)

            local tbl4 = {
                onJoin = var7(num1, groupJoinPromptData),
                onClose = var8(num1, groupJoinPromptData)
            }
            tbl1.openGroupJoinPrompt(num1, groupJoinPromptData, tbl4)
        end, function(arg1)
            if var4.current ~= current then
                return
            end
            var5(num1, "Network error on join prompt: " .. arg1.StatusMessage, var3.notificationFailedToLoad)
        end)
    end, {
        tbl1.openGroupJoinPrompt,
        var1,
        var3,
        var7,
        var8,
        var5,
        var6
    })

    useEventConnection(groupService.ShowJoinPrompt, var9)

    return React.createElement(React.Fragment, {}, {})
end
