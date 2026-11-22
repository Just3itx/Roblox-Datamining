-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local React = require(SquadsParent.React)
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local FocusNavigationUtils = require(SquadsParent.FocusNavigationUtils)
local InputHandlers = require(SquadsParent.InputHandlers)
local _ReactFocusNavigation = require(SquadsParent.ReactFocusNavigation)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local dependencies = require(Squads.dependencies)
local _ModelTypes = require(Squads.Common.ModelTypes)
local SquadPartySheetActionEnum = require(Squads.Enums.SquadPartySheetActionEnum)
local useSquadUserDropdownMenuButtons = require(Squads.Hooks.useSquadUserDropdownMenuButtons)

local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local _SquadLobbyUserOverflowMenuView = require(script.Parent.SquadLobbyUserOverflowMenuView)

local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization
local useStore = dependencies.Hooks.useStore
local useBackgroundExperience = CrossExperienceVoice.Hooks.useBackgroundExperience
local useParticipants = CrossExperienceVoice.Hooks.useParticipants
local useVoiceStatus = CrossExperienceVoice.Hooks.useVoiceStatus
local useIsParticipantMutedLocally = CrossExperienceVoice.Hooks.useIsParticipantMutedLocally
local default = CrossExperienceVoice.CrossExperienceVoiceManager.default
local GetFFlagEnableCrossExpVoice = dependencies.SharedFlags.GetFFlagEnableCrossExpVoice

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local tbl2 = {
    "MuteVoiceButton",
    "ReportButton",
    "RemoveUserButton",
    "VoiceIneligibleButton"
}

local function useSquadLobbyUserOverflowMenuViewModel(tbl3)
    local userId = tbl3.userId
    local var1, var2 = React.useState(false)

    local var3 = React.useContext(SquadExternalContractContext)
    local var4 = useDispatch()
    local var5 = useStore()
    local var6 = useLocalUserId()
    local voiceStatus = useVoiceStatus()
    local parentChannelId = useCurrentSquadParentChannelId() or ""
    local var9 = useSquadUserDropdownMenuButtons(userId, tbl3.isInExperience)
    local var10 = useIsParticipantMutedLocally(tonumber(userId) or -1)

    local var11 = useLocalization({
        removeFromGroup = "Feature.Chat.Action.RemoveFromGroup",
        reportUser = "Feature.Chat.Action.ReportUser",
        muteVoice = "Feature.Chat.Action.MuteVoice",
        unmuteVoice = "Feature.Chat.Action.UnmuteVoice",
        voiceIneligible = "Feature.Squads.Label.UserDropdownMenuVoiceErrorUserIneligible"
    })

    local voiceChannelId = nil
    local voiceSessionId = nil
    local tbl4 = {}
    if GetFFlagEnableCrossExpVoice() then
        local var12 = useBackgroundExperience()
        local var13 = useParticipants() or {}
        tbl4 = React.useMemo(function()
            local result = {}
            for _, value in pairs(var13) do
                table.insert(result, value.userId)
            end
            return result
        end, { var13 })
        if var12 then
            voiceChannelId = var12.voiceChannelId
        else
            voiceChannelId = nil
        end

        if var12 then
            voiceSessionId = var12.voiceSessionId
        else
            voiceSessionId = nil
        end
    end
    local onClose = React.useCallback(function()
        var2(false)
    end, {})

    local onTriggerActivated = React.useCallback(function()
        var2(function(arg1): boolean
            return not arg1
        end)
    end, {})

    local var14 = React.useCallback(function()
        var3.fireSquadAnalytics(EventNames.PartySheetAction, {
            parentChannelId = parentChannelId,
            actionType = SquadPartySheetActionEnum.RemoveUserDropDownButtonClicked,
            voiceStatus = voiceStatus
        })
        var3.setSquadPrompt(var5, {
            promptType = SquadPromptType.RemoveFromChat,
            onConfirm = function()
                if userId == "" or parentChannelId == "" then
                    return nil
                end
                var3.fireSquadAnalytics(EventNames.PartySheetAction, {
                    parentChannelId = parentChannelId,
                    actionType = SquadPartySheetActionEnum.RemoveUserDialogButtonClicked,
                    voiceStatus = voiceStatus
                })
                return var3.removeUserFromParentChannel(var4, parentChannelId, userId)
            end
        })
    end, {
        var3,
        var5,
        var4,
        parentChannelId,
        userId,
        voiceStatus
    })
    local var15 = React.useCallback(function()
        tbl3.openSquadVoiceAbuseReport({
            submitterUserId = tostring(var6),
            abuserUserId = userId,
            reportBeginTimestampMs = workspace:GetServerTimeNow() * 1000,
            voiceChannelId = voiceChannelId,
            voiceSessionId = voiceSessionId,
            voiceUserIds = tbl4,
            voiceUserCount = #tbl4
        })
    end, {
        tbl3.openSquadVoiceAbuseReport,
        var6,
        userId,
        voiceChannelId,
        voiceSessionId,
        tbl4
    })

    local var16 = React.useCallback(function()
        local var16 = tonumber(userId)
        if not var16 then
            return
        end

        if var10 then
            default:unmuteVoiceParticipant(var16)
        else
            default:muteVoiceParticipant(var16)
        end
    end, { userId, var10 })

    local items = React.useMemo(function()
        local function closeThen(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
            return function()
                onClose()
                callback()
            end
        end

        local tbl5 = {
            MuteVoiceButton = {
                id = "MuteVoiceButton",
                text = if var10 then var11.unmuteVoice else var11.muteVoice,
                onActivated = closeThen(var16)
            },
            ReportButton = {
                id = "ReportButton",
                text = var11.reportUser,
                onActivated = closeThen(var15)
            },
            RemoveUserButton = {
                id = "RemoveUserButton",
                text = var11.removeFromGroup,
                onActivated = closeThen(var14)
            },
            VoiceIneligibleButton = {
                id = "VoiceIneligibleButton",
                text = var11.voiceIneligible,
                isDisabled = true
            }
        }

        local result = {}
        for _, value in tbl2 do
            if table.find(var9, value) then
                table.insert(result, tbl5[value])
            end
        end
        return result
    end, {
        var9,
        var11,
        var10,
        onClose,
        var14,
        var15,
        var16
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

    return {
        isOpen = var1,
        items = items,
        onTriggerActivated = onTriggerActivated,
        onClose = onClose,
        menuRef = useFocusRoot({
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
            isFocusable = var1,
            isAutoFocusRoot = true,
            shouldRestoreFocus = false,
            eventMap = eventMap,
            eventHandlers = eventHandlers
        }),
        testId = `--social-squad-lobby-user-card-{userId}--overflow`
    }
end

return useSquadLobbyUserOverflowMenuViewModel
