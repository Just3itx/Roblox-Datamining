-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local EventNames = require(SquadsCore.Analytics.EventNames)
local useCurrentSquadId = require(SquadsCore.Hooks.useCurrentSquadId)

local React = require(SquadsCoreParent.React)
local RobloxAppHooks = require(SquadsCoreParent.RobloxAppHooks)
local UIBlox = require(SquadsCoreParent.UIBlox)
local Cryo = require(SquadsCoreParent.Cryo)
local useDispatch = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(SquadsCoreParent.Localization).Hooks.useLocalization
local UniversalAppPolicy = require(SquadsCoreParent.UniversalAppPolicy)

local _ReactFocusNavigation = require(SquadsCoreParent.ReactFocusNavigation)
local InputHandlers = require(SquadsCoreParent.InputHandlers)
local FocusNavigationUtils = require(SquadsCoreParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local bool1 = game:DefineFastFlag("EnableSquadPromptAnalytics", false)

local useScreenSize = RobloxAppHooks.useScreenSize

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert

local tbl1 = { hideCancelButton = false, bodyTextLocalizationProps = nil }

local function getFFlagRenameFriendsToConnectionsPartyLobby() -- Luacid: Inlined by compiler; 2 call sites recovered
    return UniversalAppPolicy.getAppFeaturePolicies().getRenameFriendsToConnections()
end

return function(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)
    local var2 = React.useContext(SquadExternalContractContext)

    local var3 = useDispatch()
    local squadId = useCurrentSquadId() or ""
    local screenSize = if var1.screenSize then var1.screenSize else useScreenSize()

    local var6 = React.useCallback(function(responseType: string)
        var2.fireSquadAnalytics(
            EventNames.SquadPromptResponded,
            {
                promptType = var1.promptType,
                squadId = squadId or "",
                responseType = responseType
            }
        )
    end, { var1.promptType, squadId, var2.fireSquadAnalytics })

    local onActivated = React.useCallback(function()
        if bool1 then
            var6("cancel")
        end

        var3(var2.closeSquadPrompt())

        if var1.onCancel then
            var1.onCancel()
        end
    end, {
        var3,
        var1.onCancel,
        var2.closeSquadPrompt,
        var6
    })
    local var4 = React.useCallback(function()
        if bool1 then
            var6("confirm")
        end

        var3(var2.closeSquadPrompt())

        if var1.onConfirm then
            var1.onConfirm()
        end
    end, {
        var3,
        var1.onConfirm,
        var2.closeSquadPrompt,
        var6
    })
    local var9 = React.useCallback(function(arg2)
        local str1 = "CommonUI.Controls.Action.Cancel"
        local tbl2, var9, str2

        if arg2 == SquadPromptType.AlreadyJoined then
            tbl2 = "Feature.Squads.Description.AlreadyJoined"
            var9 = "Feature.Squads.Label.Error"
            str2 = "Feature.Squads.Action.Ok"
        elseif arg2 == SquadPromptType.ConfirmInviteToSquad then
            var9 = if getFFlagRenameFriendsToConnectionsPartyLobby() then "Feature.Squads.Label.InviteConnectionsConfirmation" else "Feature.Squads.Label.InviteFriendsConfirmation"
            tbl2 = if getFFlagRenameFriendsToConnectionsPartyLobby() then "Feature.Squads.Description.InviteConnectionsToParty" else "Feature.Squads.Description.InviteFriendsToParty"
            str2 = "Feature.Squads.Action.Yes"
        elseif arg2 == SquadPromptType.AddFriends then
            tbl2 = "Feature.Squads.Description.AddFriends"
            var9 = "Feature.Squads.Label.AddFriends"
            str2 = "Feature.Squads.Action.Ok"
        elseif arg2 == SquadPromptType.FailedToJoin then
            tbl2 = "Feature.Squads.Description.FailedToJoin"
            var9 = "Feature.Squads.Label.FailedToJoin"
            str2 = "Feature.Squads.Action.Join"
        elseif arg2 == SquadPromptType.JoinAnotherSquad then
            tbl2 = "Feature.Squads.Description.JoinAnotherParty"
            var9 = "Feature.Squads.Label.JoinAnotherParty"
            str2 = "Feature.Squads.Action.Switch"
        elseif arg2 == SquadPromptType.SquadEnded then
            tbl2 = "Feature.Squads.Description.PartyEnded"
            var9 = "Feature.Squads.Label.PartyEnded"
            str2 = "Feature.Squads.Action.Start"
        elseif arg2 == SquadPromptType.SquadFull then
            tbl2 = "Feature.Squads.Description.PartyFull"
            var9 = "Feature.Squads.Label.PartyFull"
            str2 = "Feature.Squads.Action.Join"
        elseif arg2 == SquadPromptType.InvitedToExperience then
            tbl2 = "Feature.Squads.Description.InvitedToExperience"
            var9 = "Feature.Squads.Label.InvitedToExperience"
            str2 = "Feature.Squads.Action.Retry"
        elseif arg2 == SquadPromptType.RemoveFromChat then
            tbl2 = "Feature.Squads.Description.RemoveFromChat"
            var9 = "Feature.Squads.Label.RemoveFromChat"
            str2 = "Feature.Squads.Action.Remove"
        elseif arg2 == SquadPromptType.RemoveFromParty then
            tbl2 = "Feature.Squads.Description.RemoveFromParty"
            var9 = "Feature.Squads.Label.RemoveFromParty"
            str2 = "Feature.Squads.Action.Ok"
        elseif arg2 == SquadPromptType.JoinWithLowMemory then
            tbl2 = "Feature.Squads.Description.JoinWithLowMemory"
            var9 = "Feature.Squads.Label.LowMemory"
            str2 = "Feature.Squads.Action.ContinueWithoutVoice"
            str1 = "Feature.Squads.Action.ConnectToVoice"
        elseif arg2 == SquadPromptType.ConnectVoiceWithLowMemory then
            tbl2 = "Feature.Squads.Description.ConnectVoiceWithLowMemory"
            var9 = "Feature.Squads.Label.LowMemory"
            str2 = "Feature.Squads.Action.ContinueWithoutVoice"
            str1 = "Feature.Squads.Action.ConnectToVoice"
        elseif arg2 == SquadPromptType.DisconnectVoiceDueToLowMemory then
            tbl2 = "Feature.Squads.Description.DisconnectVoiceDueToLowMemory"
            var9 = "Feature.Squads.Label.LowMemory"
            str2 = "Feature.Squads.Action.DisconnectFromVoice"
            str1 = "Feature.Chat.Action.Continue"
        elseif arg2 == SquadPromptType.ParticipantChatDisabled then
            tbl2 = "Feature.Chat.Toast.Error.InvalidUserSelected"
            var9 = "Feature.Squads.Label.Error"
            str2 = "Feature.Squads.Action.Ok"
        elseif arg2 == SquadPromptType.EuVoiceConsentPrompt then
            tbl2 = "Feature.Squads.Description.VoiceRecordedDisclosure"
            var9 = "Feature.Squads.Label.VoiceRecordedTitle"
            str2 = "Feature.Chat.Action.Continue"
            str1 = "Feature.Squads.Action.JoinWithoutVoice"
        elseif arg2 == SquadPromptType.ConfirmDeleteScheduledSquad then
            tbl2 = "Feature.Squads.Description.DeleteScheduledSquad"
            var9 = "Feature.Squads.Label.DeleteScheduledParty"
            str2 = "CommonUI.Controls.Action.Yes"
        elseif arg2 == SquadPromptType.ScheduledSquadConflict then
            tbl2 = "Feature.Squads.Description.ScheduledPartyAlreadyExists"
            var9 = "Feature.Squads.Label.PartyOperationFailed"
            str2 = "Feature.Squads.Action.Ok"
        elseif arg2 == SquadPromptType.CannotExpandToGroupChatActiveParty then
            tbl2 = "Feature.Squads.Description.OneOnOneExpandedChatFeaturesActivePartyError"
            var9 = "Feature.Squads.Label.PartyOperationFailed"
            str2 = "Feature.Squads.Action.Ok"
        else
            tbl2 = "Feature.Squads.Description.PleaseTryAgain"
            var9 = "Feature.Squads.Label.PartyOperationFailed"
            str2 = "Feature.Squads.Action.Ok"
        end

        if var1.bodyTextLocalizationProps then
            tbl2 = { tbl2 }

            for k, bodyTextLocalizationProp in pairs(var1.bodyTextLocalizationProps) do
                tbl2[k] = bodyTextLocalizationProp
            end
        end

        return { title = var9, bodyText = tbl2, confirmText = str2, cancelButtonText = str1 }
    end, {})

    local var10 = React.useMemo(function()
        return var9(var1.promptType)
    end, { var1.promptType })

    local var11 = useLocalization({
        title = var10.title,
        bodyText = var10.bodyText,
        confirmText = var10.confirmText,
        cancelButtonText = var10.cancelButtonText
    })

    local var12 = React.useCallback(function()
        local result = {}
        if not var1.hideCancelButton then
            table.insert(result, { props = { onActivated = onActivated, text = var11.cancelButtonText } })
        end

        table.insert(
            result,
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = var4,
                    text = var11.confirmText
                }
            }
        )
        return result
    end, {
        var11.cancelButtonText,
        var11.confirmText,
        var1.hideCancelButton,
        var4,
        onActivated
    })

    local eventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg2)
                onActivated()
                arg2:cancel()
            end)
        }
        return result
    end, { onActivated })

    return (React.createElement(FocusRoot, {
        eventHandlers = eventHandlers,
        isAutoFocusRoot = true,
        isIsolated = true,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }, { React.createElement(
            InteractiveAlert,
            {
                screenSize = screenSize,
                title = var11.title,
                bodyText = var11.bodyText,
                buttonStackInfo = {
                    buttons = var12()
                }
            }
        ) }))
end
