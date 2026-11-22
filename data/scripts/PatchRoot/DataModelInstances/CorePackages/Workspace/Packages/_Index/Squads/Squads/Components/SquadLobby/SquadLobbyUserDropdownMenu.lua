-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local dependencies = require(Squads.dependencies)

local SquadsParent = Squads.Parent
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local ExperienceService = require(SquadsParent.ExperienceService)
local FocusNavigationUtils = require(SquadsParent.FocusNavigationUtils)
local InputHandlers = require(SquadsParent.InputHandlers)
local UIBlox = require(SquadsParent.UIBlox)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local SquadPartySheetActionEnum = require(Squads.Enums.SquadPartySheetActionEnum)
local _ModelTypes = require(Squads.Common.ModelTypes)
local Cryo = dependencies.Cryo
local PresenceType = dependencies.RoduxPresence.Enums.PresenceType
local React = dependencies.React
local SharedFlags = dependencies.SharedFlags

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local PresenceType2 = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.DataHydration).Presence.PresenceEnums.PresenceType else nil
local Images = UIBlox.App.ImageSet.Images

local ModalBottomSheet = UIBlox.ModalBottomSheet
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization
local useStore = dependencies.Hooks.useStore
local useSelector = dependencies.Hooks.useSelector
local useBackgroundExperience = CrossExperienceVoice.Hooks.useBackgroundExperience
local useParticipants = CrossExperienceVoice.Hooks.useParticipants
local useVoiceStatus = CrossExperienceVoice.Hooks.useVoiceStatus
local useSquadUserDropdownMenuButtons = require(Squads.Hooks.useSquadUserDropdownMenuButtons)

local GameParams = ExperienceService.GameParams
local ExperienceService2 = ExperienceService.ExperienceService

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadLocationEnum = require(SquadsParent.SquadsCore.Enums).SquadLocationEnum
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local FFlagSquadLaunchExperienceMobileFix = SharedFlags.FFlagSquadLaunchExperienceMobileFix

local useIsParticipantMutedLocally = CrossExperienceVoice.Hooks.useIsParticipantMutedLocally
local default = CrossExperienceVoice.CrossExperienceVoiceManager.default

local iconsCommonPlay = Images["icons/common/play"]
local iconsMenuProfile = Images["icons/menu/profile"]
local iconsActionsFeedback = Images["icons/actions/feedback"]
local iconsActionsLeave = Images["icons/actions/leave"]
local iconsControlsHeadphoneDeafen_small = Images["icons/controls/headphoneDeafen_small"]
local iconsControlsMicrophoneMute = Images["icons/controls/microphoneMute"]
local iconsControlsMicrophone = Images["icons/controls/microphone"]

local tbl1 = {
    isInExperience = false,
    onDismiss = function() end,
    openViewProfile = function() end,
    openVoiceAbuseReport = function() end,
    parentChannelId = "",
    userId = ""
}

return function(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2 = React.useContext(SquadExternalContractContext)

    local var3 = useDispatch()
    local var4 = useLocalUserId()
    local var5 = useStore()
    local voiceStatus = useVoiceStatus()
    local var7 = useSquadUserDropdownMenuButtons(var1.userId, var1.isInExperience)
    local var8 = useIsParticipantMutedLocally(tonumber(var1.userId) or -1)

    local var9 = useLocalization({
        joinButtonText = "Common.VisitGame.Label.Play",
        viewProfileText = "Feature.Chat.Label.ViewProfile",
        reportUserText = "Feature.Chat.Action.ReportUser",
        removeFromGroupText = "Feature.Chat.Action.RemoveFromGroup",
        voiceIneligibleText = "Feature.Squads.Label.UserDropdownMenuVoiceErrorUserIneligible",
        muteVoiceButtonText = "Feature.Chat.Action.MuteVoice",
        unmuteVoiceButtonText = "Feature.Chat.Action.UnmuteVoice"
    })

    local onActivated = React.useCallback(function()
        var2.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = var1.parentChannelId,
            actionType = SquadPartySheetActionEnum.ViewProfileButtonClicked,
            voiceStatus = voiceStatus
        })
        var1.openViewProfile()
    end, {
        var1.parentChannelId,
        var1.openViewProfile,
        var2.fireSquadAnalytics,
        voiceStatus
    })

    local var6 = React.useCallback(function()
        var2.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = var1.parentChannelId,
            actionType = SquadPartySheetActionEnum.RemoveUserDropDownButtonClicked,
            voiceStatus = voiceStatus
        })

        var2.setSquadPrompt(var5, {
            promptType = SquadPromptType.RemoveFromChat,
            onConfirm = function()
                if var1.userId == "" or var1.parentChannelId == "" then
                    return nil
                end

                var2.fireSquadAnalytics(EventNames.PartySheetAction, {
                    parentChannelId = var1.parentChannelId,
                    actionType = SquadPartySheetActionEnum.RemoveUserDialogButtonClicked,
                    voiceStatus = voiceStatus
                })
                return var2.removeUserFromParentChannel(var3, var1.parentChannelId, var1.userId)
            end
        })
    end, {
        var3,
        var1.userId,
        var1.parentChannelId,
        var2.fireSquadAnalytics,
        var2.setSquadPrompt,
        var2.removeUserFromParentChannel,
        voiceStatus
    })

    local var12 = nil
    local var13 = nil
    local tbl3 = {}
    local var14 = nil
    local var15 = nil
    if GetFFlagEnableCrossExpVoice() then
        var12 = useBackgroundExperience()
        var13 = useParticipants() or {}
        tbl3 = React.useMemo(function()
            local result = {}
            for _, value in pairs(var13) do
                table.insert(result, value.userId)
            end
            return result
        end, { var13 })
        var14 = React.useMemo(function()
            return if var12 then var12.voiceChannelId else nil
        end, { var12 })
        var15 = React.useMemo(function()
            return if var12 then var12.voiceSessionId else nil
        end, { var12 })
    end

    local var16 = React.useCallback(function(arg1)
        return arg1.Squad.Presence.byUserId[var1.userId]
    end, { var1.userId })

    local var17 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(tostring(var1.userId)) else useSelector(var16)

    local var18 = React.useMemo(function()
        local placeId

        if table.find(var7, "JoinButton") == nil then
            placeId = false
        else
            placeId = var17

            if placeId then
                placeId = false
                local userPresenceType = var17.userPresenceType
                local inGame = if FFlagSquadsPresenceStoreMigration then PresenceType2.InGame else PresenceType.InGame

                if userPresenceType == inGame then
                    if FFlagSquadsPresenceStoreMigration then
                        return var17.placeId ~= ""
                    end

                    placeId = var17.placeId
                end
            end
        end

        return placeId
    end, { var17, var7 })

    local var10 = React.useCallback(function()
        if not var18 then
            return
        end

        local userId = GameParams.fromUserId(var1.userId, if FFlagSquadsPresenceStoreMigration then var17 and var17.placeId else var17.placeId)

        if var1.isInExperience and FFlagSquadLaunchExperienceMobileFix then
            game:Shutdown()
        end
        local str1 = "SquadLobby"
        if var2.squadLocation == SquadLocationEnum.UniversalApp then
            str1 = "SquadLobbyFromUA"
        elseif var2.squadLocation == SquadLocationEnum.InExperience then
            str1 = "SquadLobbyFromInExp"
        end

        ExperienceService2:LaunchExperience(userId, str1, nil)
    end, {
        var18,
        var2.squadLocation,
        var1.isInExperience,
        var1.userId,
        var17
    })

    local buttonModels = React.useMemo(function()
        local tbl4 = {
            VoiceIneligibleButton = {
                icon = iconsControlsHeadphoneDeafen_small,
                text = var9.voiceIneligibleText,
                stayOnActivated = true
            },
            JoinButton = {
                icon = iconsCommonPlay,
                text = var9.joinButtonText,
                onActivated = var10
            },
            RemoveUserButton = {
                icon = iconsActionsLeave,
                text = var9.removeFromGroupText,
                onActivated = var6
            },
            ViewProfileButton = {
                icon = iconsMenuProfile,
                text = var9.viewProfileText,
                onActivated = onActivated
            },
            ReportButton = {
                icon = iconsActionsFeedback,
                text = var9.reportUserText,
                onActivated = function()
                    local tbl4 = {
                        submitterUserId = tostring(var4),
                        abuserUserId = var1.userId,
                        reportBeginTimestampMs = workspace:GetServerTimeNow() * 1000,
                        voiceChannelId = var14,
                        voiceSessionId = var15,
                        voiceUserIds = tbl3,
                        voiceUserCount = #tbl3
                    }
                    var1.openSquadVoiceAbuseReport(tbl4)
                end
            },
            MuteVoiceButton = 0
        }

        local muteVoiceButton = {
            icon = if var8 then iconsControlsMicrophoneMute else iconsControlsMicrophone,
            text = if var8 then var9.unmuteVoiceButtonText else var9.muteVoiceButtonText,
            onActivated = 0
        }

        function muteVoiceButton.onActivated()
            local var20 = tonumber(var1.userId)
            if not var20 then
                warn("Invalid userId: " .. tostring(var1.userId))

                return
            end

            if var8 then
                default:unmuteVoiceParticipant(var20)
                return
            end
            default:muteVoiceParticipant(var20)
        end

        tbl4.MuteVoiceButton = muteVoiceButton

        local result = {}

        for _, value in var7 do
            local var20 = tbl4[value]

            if var20 then
                table.insert(result, var20)
            end
        end

        return result
    end, {
        var1.userId,
        var1.openSquadVoiceAbuseReport,
        var9.joinButtonText,
        var9.removeFromGroupText,
        var9.reportUserText,
        var9.viewProfileText,
        var9.voiceIneligibleText,
        var9.muteVoiceButtonText,
        var9.unmuteVoiceButtonText,
        var4,
        var14,
        var15,
        tbl3,
        var6,
        var7,
        var10,
        onActivated,
        var8
    })

    if not (#buttonModels > 0) then
        var1.onDismiss()
        return nil
    end

    local createElement = React.createElement
    local var21 = FocusNavigableSurfaceWrapper

    local tbl4 = {
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var1.onDismiss()
                    arg1:cancel()
                end)
            }
        },
        isAutoFocusRoot = true,
        isFocusable = true,
        isIsolated = true,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }

    return createElement(var21, tbl4, {
        React.createElement(ModalBottomSheet, {
            bottomGap = 20,
            buttonModels = buttonModels,
            onDismiss = function()
                var1.onDismiss()
            end,
            screenWidth = 400,
            showImages = true
        })
    })
end
