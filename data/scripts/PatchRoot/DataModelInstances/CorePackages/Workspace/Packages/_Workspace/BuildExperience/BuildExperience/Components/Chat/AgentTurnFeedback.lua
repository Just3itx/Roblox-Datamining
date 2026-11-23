-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = Localization.Hooks.useLocalization

local default = require(BuildExperienceParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local ChatPermissionsContext = require(BuildExperience.Chat.ChatPermissionsContext)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FeedbackAction = require(BuildExperience.Components.MessageUtilities.FeedbackAction)
local UserFeedback = require(BuildExperience.Components.MessageUtilities.UserFeedback)
local feedbackIcons = require(BuildExperience.Components.MessageUtilities.feedbackIcons)
local sendAgentTurnFeedback = require(BuildExperience.Components.MessageUtilities.sendAgentTurnFeedback)
local AgentRollbackSnackbar = require(BuildExperience.Components.VersionHistory.AgentRollbackSnackbar)
local RestoreVersionDialog = require(BuildExperience.Components.VersionHistory.RestoreVersionDialog)
local GetAgentRollbackRequestStore = require(BuildExperience.Stores.GetAgentRollbackRequestStore)
local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)

local IconName = Foundation.Enums.IconName
local FFlagEnableTeamTestLua = SharedFlags.FFlagEnableTeamTestLua

local signal = Signals.createSignal(false)

local function useAgentMessageCopy(text: string?)
    local var1, var2 = React.useState(false)
    local var3 = React.useRef(nil)

    local var4 = React.useCallback(function()
        if text ~= nil and text ~= "" then
            default:setClipboardText({ context = "Build-AgentMessage", text = text })
        end

        var2(true)
        if var3.current ~= nil then
            task.cancel(var3.current)
        end
        var3.current = task.delay(2, function()
            var3.current = nil
            var2(false)
        end)
    end, { text })

    React.useEffect(function()
        return function()
            if var3.current ~= nil then
                task.cancel(var3.current)
            end
        end
    end, {})

    return if var1 then IconName.CheckLarge else IconName.TwoStackedSquares, var4
end

local function AgentTurnFeedback(tbl1)
    local bool1

    if FFlagBuildCheckGamePermissions then
        local var1 = React.useContext(ChatPermissionsContext)
        if var1 == nil then
            bool1 = false
        else
            bool1 = not var1.canEditOnBuild
        end
    else
        bool1 = false
    end
    local turnFeedbackIds = tbl1.turnFeedbackIds
    local placeId = if turnFeedbackIds == nil then nil else turnFeedbackIds.placeId
    local versionNumber = if turnFeedbackIds == nil then nil else feedbackIcons.getRollbackTargetVersionNumber(turnFeedbackIds)
    local var1 = React.useContext(Localization.LocalizationRoactContext)
    local var2 = useLocalization({
        revertConfirmationTitle = LocalizationStrings.CHAT_REVERT_CONFIRMATION_TITLE,
        revertConfirmationDescription = LocalizationStrings.CHAT_REVERT_CONFIRMATION_DESCRIPTION,
        revertFailure = LocalizationStrings.CHAT_REVERT_FAILURE
    })

    local revertFailure = var2.revertFailure
    local revertConfirmationTitle = var2.revertConfirmationTitle
    local revertConfirmationDescription = var2.revertConfirmationDescription
    if versionNumber ~= nil then
        local var3 = if versionNumber < 10 then LocalizationStrings.VERSION_HISTORY_VERSION_PADDED else LocalizationStrings.VERSION_HISTORY_VERSION_COMPACT
        local version = var1:Format(var3, { VERSION_NUMBER = versionNumber })

        if FFlagEnableTeamTestLua then
            revertConfirmationDescription = var1:Format(LocalizationStrings.CHAT_REVERT_TO_VERSION, { VERSION = version })
        else
            revertConfirmationTitle = version
        end
    end

    local var3, var4 = React.useState(false)
    local isLoading, var6 = React.useState(false)

    local selectedAction, var8 = React.useState(nil)
    local title, var10 = React.useState("")

    local copyIconName, var12 = useAgentMessageCopy(tbl1.messageText)
    local var13 = var12
    local var14 = React.useCallback(function(arg1): boolean
        local playtestLoadingStore = GetPlaytestLoadingStore(arg1)
        return not (placeId == nil) and playtestLoadingStore.getAgentStatusForPlaceId(placeId)(arg1) == "Loading"
    end, { placeId })
    local isRevertDisabled = SignalsReact.useSignalState(var14)
    local var16 = if placeId ~= nil then GetAgentRollbackRequestStore(false).getIsPendingForPlaceId(placeId) else signal
    local var17 = SignalsReact.useSignalState(var16)
    local onClose = React.useCallback(function()
        var10("")
    end, {})
    local onActivated = React.useCallback(function(arg1)
        if turnFeedbackIds == nil then
            return
        end

        if arg1.action == FeedbackAction.REVERT then
            var4(true)
            return
        end

        if arg1.action == FeedbackAction.COPY then
            var13()
            sendAgentTurnFeedback(arg1.action, turnFeedbackIds)
        else
            var8(arg1.action)
            sendAgentTurnFeedback(arg1.action, turnFeedbackIds)
        end
    end, { turnFeedbackIds, var13 })

    if turnFeedbackIds == nil or turnFeedbackIds.sequenceId == nil then
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var20 = nil

    local tbl2 = {
        Feedback = React.createElement(UserFeedback, {
            layoutOrder = tbl1.LayoutOrder,
            icons = feedbackIcons.getFeedbackIcons({
                includeCopy = not (tbl1.messageText == nil) and tbl1.messageText ~= "",
                copyIconName = copyIconName,
                copyTestId = `{tbl1.testId}-copy`,
                includeRevert = feedbackIcons.canRevert(turnFeedbackIds),
                isRevertDisabled = isRevertDisabled or var17 or bool1,
                isRatingDisabled = bool1
            }),
            onActivated = onActivated,
            selectedAction = selectedAction,
            testId = tbl1.testId
        }),
        RevertSnackbar = if title == "" then nil else React.createElement(AgentRollbackSnackbar, { title = title, onClose = onClose }),
        RevertDialog = if var3 and versionNumber ~= nil then React.createElement(RestoreVersionDialog, {
            isOpen = true,
            isLoading = isLoading,
            title = revertConfirmationTitle,
            description = revertConfirmationDescription,
            onRestore = function()
                if var14(false) or var16(false) then
                    return
                end

                var8(FeedbackAction.REVERT)
                sendAgentTurnFeedback(FeedbackAction.REVERT, turnFeedbackIds)
                var6(true)

                var10("")
                feedbackIcons.requestAgentRollback(turnFeedbackIds):andThen(function()
                    var6(false)
                    var4(false)
                end):catch(function()
                    var6(false)
                    var10(revertFailure)
                end)
            end,
            onCancel = function()
                var4(false)
            end
        }) else nil
    }

    return createElement(fragment, var20, tbl2)
end

return AgentTurnFeedback
