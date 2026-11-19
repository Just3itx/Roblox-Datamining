-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local Promise = require(CorePackages.Packages.Promise)
local enumerate = require(CorePackages.Packages.enumerate)

local withStyle = require(CorePackages.Packages.UIBlox).Core.Style.withStyle

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Constants = require(RobloxGui.Modules.VoiceChat.Constants)

local GetFFlagVoiceARUnblockingUnmutingEnabled = require(RobloxGui.Modules.Flags.GetFFlagVoiceARUnblockingUnmutingEnabled)

local ReportActionSelection = require(script.Parent.ReportActionSelection)
local ReportActionAreYouSure = require(script.Parent.ReportActionAreYouSure)

local var1 = enumerate("ReportPages", { SelectActions = 1, ConfirmAction = 2 })

local var2 = Roact.PureComponent:extend("ReportConfirmationContainer")

var2.defaultProps = {
    blockingUtility = BlockingUtility,
    voiceChatServiceManager = default,
    isVoiceReport = false,
    closeMenu = function() end
}

var2.validateProps = t.interface({
    player = t.strictInterface({ UserId = t.number, Name = t.string, DisplayName = t.string }),
    isVoiceReport = t.boolean,
    closeMenu = t.callback,
    blockingAnalytics = t.optional(t.table),
    reportAbuseAnalytics = t.optional(t.table)
})

local function getIsPlayerBlockedByUserId(blockingUtility, userId) -- Luacid: Inlined by compiler; 1 call site recovered
    return Promise.new(function(callback, _)
        callback(blockingUtility:IsPlayerBlockedByUserId(userId))
    end)
end

function var2.init(arg1)
    local player = arg1.props.player
    local participants = arg1.props.voiceChatServiceManager.participants

    arg1:setState({ absoluteWidth = 0 })

    if arg1.props.onSizeChanged then
        arg1.props.onSizeChanged:Connect(function(arg2)
            arg1:setState({ absoluteWidth = arg2.X })
        end)
    end

    local participant = participants[tostring(player.UserId)]

    arg1.userFullName = player.DisplayName .. "(@" .. player.Name .. ")"

    function arg1.onMuteCheckboxActivated(muteFlipped)
        arg1:setState({ muteFlipped = muteFlipped })
    end

    function arg1.onBlockCheckboxActivated(blockFlipped)
        arg1:setState({ blockFlipped = blockFlipped })
    end

    function arg1.processMuteAndBlocking()
        local blockFlipped = arg1.state.blockFlipped
        local muteFlipped = arg1.state.muteFlipped

        if blockFlipped and not arg1.state.targetInitiallyBlocked then
            if arg1.props.blockingUtility:BlockPlayerAsync(player) then
                arg1.props.blockingAnalytics:action("SettingsHub", "blockUser", { blockeeUserId = player.UserId })
            end
        elseif not blockFlipped
            and arg1.state.targetInitiallyBlocked
            and GetFFlagVoiceARUnblockingUnmutingEnabled()
            and arg1.props.blockingUtility:UnblockPlayerAsync(player)
        then
            arg1.props.blockingAnalytics:action("SettingsHub", "unblockUser", { blockeeUserId = player.UserId })
        end

        local participant2 = arg1.props.voiceChatServiceManager.participants[tostring(player.UserId)]

        if muteFlipped and not arg1.state.targetInitiallyVoiceMuted then
            arg1.props.blockingUtility:MutePlayer(player)
            arg1.props.reportAbuseAnalytics:reportEventAndIncrement("muteUser")

            if participant2 and not participant2.isMutedLocally then
                arg1.props.voiceChatServiceManager:ToggleMutePlayer(player.UserId, Constants.VOICE_CONTEXT_TYPE.REPORT_MENU)
            end
        elseif not muteFlipped and arg1.state.targetInitiallyVoiceMuted and GetFFlagVoiceARUnblockingUnmutingEnabled() then
            arg1.props.blockingUtility:UnmutePlayer(player)
            arg1.props.reportAbuseAnalytics:reportEventAndIncrement("unmuteUser")

            if participant2 and participant2.isMutedLocally then
                arg1.props.voiceChatServiceManager:ToggleMutePlayer(player.UserId, Constants.VOICE_CONTEXT_TYPE.REPORT_MENU)
            end
        end

        arg1.props.closeMenu()
    end

    function arg1.onActionSelectionDoneActivated(blockFlipped, muteFlipped)
        arg1:setState({ blockFlipped = blockFlipped, muteFlipped = muteFlipped })

        if not (blockFlipped or muteFlipped)
            or muteFlipped == arg1.state.targetInitiallyVoiceMuted and blockFlipped == arg1.state.targetInitiallyBlocked
        then
            arg1.processMuteAndBlocking()
            return
        end
        arg1:setState({ currentPage = var1.ConfirmAction })
    end

    function arg1.onYesOrNoConfirmation()
        arg1.processMuteAndBlocking()
    end

    function arg1.onYesOrNoCancel()
        arg1:setState({ currentPage = var1.SelectActions })
    end

    arg1:setState({ currentPage = var1.SelectActions })

    if participant then
        arg1:setState({ targetInitiallyVoiceMuted = participant.isMutedLocally, muteFlipped = participant.isMutedLocally })
    else
        arg1:setState({ targetInitiallyVoiceMuted = false, muteFlipped = false })
    end

    getIsPlayerBlockedByUserId(arg1.props.blockingUtility, player.UserId):andThen(function(arg2)
        arg1:setState({ targetInitiallyBlocked = arg2, blockFlipped = arg2 })
    end)
end

function var2.renderContent(arg1)
    local currentPage = arg1.state.currentPage
    local var3

    if arg1.props.onSizeChanged then
        local absoluteWidth = arg1.state.absoluteWidth

        var3 = if absoluteWidth >= 800 then 1.3 elseif absoluteWidth > 600 then 1 else absoluteWidth / 600
    else
        var3 = 1.3
    end

    local muteFlipped = not (arg1.state.muteFlipped == nil) and arg1.state.muteFlipped
    local blockFlipped = not (arg1.state.blockFlipped == nil) and arg1.state.blockFlipped
    local element = Roact.createElement(ReportActionSelection, {
        titleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.Heading.Report.ThanksForReport"),
        subtitleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.ThankYou"),
        instructionText = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Report.OtherActionsHeader"),
        muteText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.MutePlayer", { Player = arg1.userFullName }),
        blockText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.BlockPlayer", { Player = arg1.userFullName }),
        doneText = RobloxTranslator:FormatByKey("Feature.SettingsHub.Action.Report.Done"),
        showVoiceMuting = arg1.props.isVoiceReport,
        isVoiceMuted = muteFlipped or arg1.state.targetInitiallyVoiceMuted,
        isBlocked = blockFlipped or arg1.state.targetInitiallyBlocked,
        onMuteCheckboxActivated = arg1.onMuteCheckboxActivated,
        onBlockCheckboxActivated = arg1.onBlockCheckboxActivated,
        onDoneActivated = arg1.onActionSelectionDoneActivated,
        uiScale = var3,
        ZIndex = arg1.props.ZIndex
    })

    local element2 = Roact.createElement(ReportActionAreYouSure, {
        mutedTitleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.MutePlayer", { Player = arg1.userFullName }),
        blockedTitleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.BlockPlayer", { Player = arg1.userFullName }),
        mutedAndBlockedTitleText = RobloxTranslator:FormatByKey(
            "Feature.SettingsHub.ReportSubmitted.Label.MuteAndBlockPlayer",
            {
                DisplayName = arg1.userFullName
            }
        ),
        mutedSubtitleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.MutedSubtitleText", { Player = arg1.userFullName }),
        blockedSubtitleText = RobloxTranslator:FormatByKey("Feature.SettingsHub.ReportSubmitted.BlockedSubtitleText", { Player = arg1.userFullName }),
        mutedAndBlockedSubtitleText = RobloxTranslator:FormatByKey(
            "Feature.SettingsHub.ReportSubmitted.Label.MuteAndBlockWarning",
            {
                Player = arg1.userFullName
            }
        ),
        cancelText = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Cancel"),
        confirmText = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Confirm"),
        isMuted = arg1.state.muteFlipped,
        isBlocked = arg1.state.blockFlipped,
        onCancelActivated = arg1.onYesOrNoCancel,
        onConfirmActivated = arg1.onYesOrNoConfirmation,
        uiScale = var3,
        ZIndex = arg1.props.ZIndex
    })

    local var4 = nil

    if currentPage == var1.SelectActions then
        return element
    end

    if currentPage ~= var1.ConfirmAction then
        element2 = var4
    end

    return element2
end

function var2.render(arg1)
    if FFlagCoreUiMigrateUIBloxToFoundation then
        return arg1:renderContent()
    end
    return withStyle(function(_)
        return arg1:renderContent()
    end)
end

return var2
