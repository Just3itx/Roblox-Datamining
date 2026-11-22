-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local React = require(SquadsParent.React)
local Foundation = require(SquadsParent.Foundation)
local ExperienceService = require(SquadsParent.ExperienceService)
local FocusNavigationUtils = require(SquadsParent.FocusNavigationUtils)
local InputHandlers = require(SquadsParent.InputHandlers)
local _ReactFocusNavigation = require(SquadsParent.ReactFocusNavigation)
local UserProfiles = require(SquadsParent.UserProfiles)
local useVoiceStatus = require(SquadsParent.CrossExperienceVoice).Hooks.useVoiceStatus

local dependencies = require(Squads.dependencies)
local SquadPartySheetActionEnum = require(Squads.Enums.SquadPartySheetActionEnum)

local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadLocationEnum = require(SquadsParent.SquadsCore.Enums).SquadLocationEnum
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local _SquadLobbyJoinDialogView = require(script.Parent.SquadLobbyJoinDialogView)
local isPresenceJoinable = require(Squads.Common.isPresenceJoinable)

local FFlagSquadLaunchExperienceMobileFix = dependencies.SharedFlags.FFlagSquadLaunchExperienceMobileFix
local useLocalization = dependencies.Hooks.useLocalization
local useSelector = dependencies.Hooks.useSelector

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local GameParams = ExperienceService.GameParams
local ExperienceService2 = ExperienceService.ExperienceService
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function nonEmpty(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 == nil or arg1 == "" then
        return nil
    end
    return tostring(arg1)
end

local function useSquadLobbyJoinDialogViewModel(tbl2)
    local userId = tbl2.userId
    local onClose = tbl2.onClose
    local var1 = React.useContext(SquadExternalContractContext)
    local voiceStatus = useVoiceStatus()
    local parentChannelId = useCurrentSquadParentChannelId() or ""

    local var4 = React.useCallback(function(arg1)
        return arg1.Squad.Presence.byUserId[userId]
    end, { userId })

    local var5 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(userId) else useSelector(var4)
    local placeId = if var5 and nonEmpty(var5.placeId) then var5.placeId else nil
    local var6 = isPresenceJoinable(var5)
    local var7 = var5 and (nonEmpty(var5.rootPlaceId) or nonEmpty(var5.placeId))
    local experienceName = var5 and nonEmpty(var5.lastLocation)

    local var9 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { userId },
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local combinedNameFromId = if var9.data then UserProfiles.Selectors.getCombinedNameFromId(var9.data, userId) else nil
    local var10 = useLocalization({
        inExperience = "Common.Presence.Label.InExperience",
        isPlaying = "Feature.Friends.Text.IsPlaying",
        join = "Feature.Profile.Action.JoinGame",
        viewProfile = "Feature.Profile.Action.ViewProfile"
    })

    local var11 = React.useRef(false)
    React.useEffect(function()
        if var6 then
            var11.current = true
        elseif var11.current then
            onClose()
        end
    end, { var6, onClose })

    local onJoin = React.useCallback(function()
        onClose()
        if tbl2.isInExperience and FFlagSquadLaunchExperienceMobileFix then
            game:Shutdown()
        end
        local str1 = "SquadLobby"
        if var1.squadLocation == SquadLocationEnum.UniversalApp then
            str1 = "SquadLobbyFromUA"
        elseif var1.squadLocation == SquadLocationEnum.InExperience then
            str1 = "SquadLobbyFromInExp"
        end

        ExperienceService2:LaunchExperience(GameParams.fromUserId(userId, placeId), str1, nil)
    end, {
        placeId,
        onClose,
        tbl2.isInExperience,
        var1.squadLocation,
        userId
    })
    local var13 = React.useCallback(function()
        var1.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = parentChannelId,
            actionType = SquadPartySheetActionEnum.ViewProfileButtonClicked,
            voiceStatus = voiceStatus
        })
        onClose()
        tbl2.openViewProfile(userId)
    end, {
        var1.fireSquadAnalytics,
        parentChannelId,
        voiceStatus,
        onClose,
        tbl2.openViewProfile,
        userId
    })

    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onClose()
                    arg1:cancel()
                end)
            }
        }
    end, { onClose })

    local dialogRef = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local bool1 = useLastInputMode() == "Focus"

    local tbl3 = {
        userId = tonumber(userId) or 0,
        gameImage = if var7 then getRbxThumb(ThumbnailType.GameThumbnail, var7, ThumbnailSize.Large) else nil,
        playerName = nonEmpty(combinedNameFromId),
        isPlayingText = var10.isPlaying,
        experienceName = experienceName or var10.inExperience,
        joinText = var10.join,
        onJoin = onJoin,
        viewProfileText = if tbl2.isInExperience then nil else var10.viewProfile,
        onViewProfile = 0,
        onClose = 0,
        dialogRef = 0,
        testId = 0
    }

    if tbl2.isInExperience then
        var13 = nil
    end

    tbl3.onViewProfile = var13
    tbl3.onClose = if bool1 then nil else onClose
    tbl3.dialogRef = dialogRef
    tbl3.testId = `--social-squad-lobby-join-dialog-{userId}`
    return tbl3
end

return useSquadLobbyJoinDialogViewModel
