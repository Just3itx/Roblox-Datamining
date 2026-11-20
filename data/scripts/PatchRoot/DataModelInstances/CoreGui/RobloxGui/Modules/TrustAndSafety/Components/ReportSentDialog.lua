-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local withStyle = UIBlox.Core.Style.withStyle

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)
local FocusHandler = require(Dependencies.FocusHandler)
local playerInterface = require(Dependencies.playerInterface)
local Divider = require(Dependencies.Divider)
local ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withLocalization = require(Dependencies.withLocalization)

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local BlockPlayer = require(scriptParentParent.Thunks.BlockPlayer)
local BlockPlayerItem = require(scriptParentParent.Components.BlockPlayerItem)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local _OpenBlockPlayerDialog = require(scriptParentParent.Actions.OpenBlockPlayerDialog)
local ShowToast = require(scriptParentParent.Actions.ShowToast)
local Constants = require(scriptParentParent.Resources.Constants)
local Assets = require(scriptParentParent.Resources.Assets)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)

local var1 = Roact.PureComponent:extend("ReportSentDialog")

var1.validateProps = t.strictInterface({
    isReportSentOpen = t.boolean,
    screenSize = t.Vector2,
    inputType = t.optional(t.string),
    reportType = t.optional(t.valueOf(Constants.ReportType)),
    targetPlayer = t.optional(playerInterface),
    blockPlayer = t.callback,
    showToast = t.callback,
    closeDialog = t.callback,
    reportCategory = t.optional(t.string)
})

function isPlayerUserIdMuted(userId)
    local bool1 = false
    if default.participants then
        local participant = default.participants[tostring(userId)]
        if participant then
            bool1 = participant.isMutedLocally
        end
    end
    return bool1
end

function var1.init(arg1)
    arg1:clearState()
    arg1.buttonRef = Roact.createRef()

    function arg1.onBlockCheckBoxActivated(isBlockCheckBoxSelected)
        arg1:setState({
            isBlockCheckBoxSelected = isBlockCheckBoxSelected,
            isMuteCheckBoxSelected = if isBlockCheckBoxSelected and arg1:isVoiceReport() then true else arg1.state.isMuteCheckBoxSelected
        })
    end

    function arg1.onMuteCheckBoxActivated(isMuteCheckBoxSelected)
        arg1:setState({ isMuteCheckBoxSelected = isMuteCheckBoxSelected })
    end

    function arg1.hasMuteChanged(): boolean
        return arg1.state.isMuteCheckBoxSelected ~= arg1.state.wasPlayerMutedWhenDialogOpened
    end

    function arg1.getToastMessage(arg2)
        local tbl1 = {
            title = arg2.toastDefaultTitle,
            description = arg2.toastDefaultDescription
        }

        if arg1.state.isMuteCheckBoxSelected and arg1.state.isBlockCheckBoxSelected then
            tbl1.title = arg2.toastMutedAndBlockedTitle
            tbl1.description = arg2.toastMutedAndBlockedDescription
            return tbl1
        end

        if arg1.state.isMuteCheckBoxSelected then
            tbl1.title = arg2.toastMutedTitle
            tbl1.description = arg2.toastMutedDescription
            return tbl1
        end

        if arg1.state.isBlockCheckBoxSelected then
            tbl1.title = arg2.toastBlockedTitle
            tbl1.description = arg2.toastBlockedDescription
        end

        return tbl1
    end

    function arg1.onConfirm(arg2)
        if arg1:isReportingPlayer() then
            local toastMessage = arg1.getToastMessage(arg2)
            if arg1:hasMuteChanged() then
                default:ToggleMutePlayer(arg1.props.targetPlayer.UserId, Constants2.VOICE_CONTEXT_TYPE.REPORT_MENU)
            end

            if arg1.state.isBlockCheckBoxSelected then
                arg1.props.blockPlayer(arg1.props.targetPlayer, toastMessage.title, toastMessage.description)
            else
                arg1.props.showToast(toastMessage.title, toastMessage.description)
            end
        end
        arg1.props.closeDialog()
        arg1:clearState()
    end

    function arg1.onCancel()
        arg1.props.closeDialog()
        arg1:clearState()
    end
end

function var1.clearState(arg1)
    arg1:setState(
        {
            wasPlayerMutedWhenDialogOpened = false,
            isMuteCheckBoxSelected = false,
            isBlockCheckBoxSelected = false
        }
    )
end

function var1.isVoiceReport(arg1)
    return arg1:isReportingPlayer() and arg1.props.reportCategory == Constants.Category.Voice
end

function var1.doesRequireConfirmation(arg1)
    return arg1.state.isBlockCheckBoxSelected or arg1:hasMuteChanged()
end

function var1.isReportingPlayer(arg1): boolean
    return arg1.props.reportType == Constants.ReportType.Player and arg1.props.targetPlayer ~= nil
end

function var1.renderFocusHandler(arg1)
    local createElement = Roact.createElement
    local var2 = FocusHandler
    local tbl1 = {
        isFocused = arg1.props.inputType == Constants.InputType.Gamepad and arg1.props.isReportSentOpen,
        didFocus = 0,
        didBlur = 0
    }

    function tbl1.didFocus()
        GuiService:RemoveSelectionGroup("ReportSentDialogGroup")
        GuiService:AddSelectionParent("ReportSentDialogGroup", arg1.buttonRef:getValue())
        GuiService.SelectedCoreObject = arg1.buttonRef:getValue()

        ContextActionService:BindCoreAction("ReporSentDialogSinkAction", function(_, _): Enum.ContextActionResult
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonY, Enum.KeyCode.ButtonX)
    end
    function tbl1.didBlur()
        ContextActionService:UnbindCoreAction("ReporSentDialogSinkAction")
        GuiService:RemoveSelectionGroup("ReportSentDialogGroup")
    end

    return createElement(var2, tbl1)
end

function var1.renderBlockFrame(arg1)
    if not arg1:isReportingPlayer() then
        return nil
    end
    return withLocalization({
        mutePlayerText = "CoreScripts.InGameMenu.Report.Mute",
        mutePlayerDescription = "CoreScripts.InGameMenu.Report.MuteDescription",
        blockPlayerText = "CoreScripts.InGameMenu.Report.Block",
        blockPlayerDescription = "CoreScripts.InGameMenu.Report.BlockDescription"
    })(
        function(arg2)
            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl1 = {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 1, 0)
            }
            local tbl2 = {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Divider = Roact.createElement(Divider, { LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 1) }),
                MutePlayerItem = 0,
                BlockPlayerItem = 0
            }
            local element

            if arg1:isVoiceReport() then
                element = Roact.createElement(BlockPlayerItem, {
                    layoutOrder = 2,
                    size = UDim2.new(1, 0, 0, 72),
                    text = arg2.mutePlayerText,
                    description = arg2.mutePlayerDescription,
                    icon = Assets.Images.MuteIcon.Image,
                    iconSize = Assets.Images.MuteIcon.Size,
                    isDisabled = arg1.state.isBlockCheckBoxSelected,
                    isCheckBoxSelected = arg1.state.isMuteCheckBoxSelected,
                    onCheckBoxActivated = arg1.onMuteCheckBoxActivated
                })
            else
                element = nil
            end

            tbl2.MutePlayerItem = element

            tbl2.BlockPlayerItem = Roact.createElement(BlockPlayerItem, {
                layoutOrder = 3,
                size = UDim2.new(1, 0, 0, 72),
                text = arg2.blockPlayerText,
                description = arg2.blockPlayerDescription,
                icon = Assets.Images.BlockIcon.Image,
                iconSize = Assets.Images.BlockIcon.Size,
                isCheckBoxSelected = arg1.state.isBlockCheckBoxSelected,
                onCheckBoxActivated = arg1.onBlockCheckBoxActivated
            })
            return createElement(str1, tbl1, tbl2)
        end
    )
end

function var1.renderContents(arg1)
    return withStyle(function(_)
        return withLocalization({
            bodyText = "CoreScripts.InGameMenu.Report.ThanksForReportDescription",
            otherStepsText = {
                "CoreScripts.InGameMenu.Report.OtherStepsTitle",
                RBX_NAME = arg1.props.targetPlayer.Name
            }
        })(
            function(arg2)
                return Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0)
                }, {
                    Layout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    BodyFrame = Roact.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            Size = UDim2.new(1, 0, 0, 0),
                            LayoutOrder = 1
                        },
                        {
                            Layout = Roact.createElement("UIListLayout", {
                                FillDirection = Enum.FillDirection.Vertical,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                Padding = UDim.new(0, 12)
                            }),
                            Padding = Roact.createElement("UIPadding", {
                                PaddingTop = UDim.new(0, 12),
                                PaddingBottom = UDim.new(0, 12),
                                PaddingLeft = UDim.new(0, 24),
                                PaddingRight = UDim.new(0, 24)
                            }),
                            BodyText = Roact.createElement(ThemedTextLabel, {
                                LayoutOrder = 1,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                Size = UDim2.new(1, 0, 0, 0),
                                themeKey = "TextEmphasis",
                                Text = arg2.bodyText,
                                TextWrapped = true,
                                TextXAlignment = Enum.TextXAlignment.Left
                            }),
                            OtherStepsText = Roact.createElement(ThemedTextLabel, {
                                LayoutOrder = 2,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                Position = UDim2.new(0, 0, 0, 12),
                                Size = UDim2.new(1, 0, 0, 0),
                                fontKey = "Footer",
                                themeKey = "TextDefault",
                                Text = arg2.otherStepsText,
                                TextWrapped = true,
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                        }
                    ),
                    BlockFrame = arg1:renderBlockFrame()
                })
            end
        )
    end)
end

function var1.render(arg1)
    if not arg1:isReportingPlayer() then
        return nil
    end
    return withLocalization({
        titleText = "CoreScripts.InGameMenu.Report.ThanksForReport",
        dismissText = if arg1:doesRequireConfirmation() then "CoreScripts.InGameMenu.Report.Confirm" else "CoreScripts.InGameMenu.Report.Done",
        toastDefaultTitle = "CoreScripts.InGameMenu.Report.Confirmation.ThanksForReport",
        toastDefaultDescription = "CoreScripts.InGameMenu.Report.Confirmation.ThanksForReportDescription",
        toastMutedTitle = "CoreScripts.InGameMenu.Report.Confirmation.Muted",
        toastMutedDescription = {
            "CoreScripts.InGameMenu.Report.Confirmation.MutedDescriptionWithUser",
            RBX_NAME = arg1.props.targetPlayer.Name
        },
        toastMutedAndBlockedTitle = "CoreScripts.InGameMenu.Report.Confirmation.MutedAndBlocked",
        toastMutedAndBlockedDescription = {
            "CoreScripts.InGameMenu.Report.Confirmation.MutedAndBlockedDescriptionWithUser",
            RBX_NAME = arg1.props.targetPlayer.Name
        },
        toastBlockedTitle = "CoreScripts.InGameMenu.Report.Confirmation.Blocked",
        toastBlockedDescription = {
            "CoreScripts.InGameMenu.Report.Confirmation.MutedAndBlockedDescriptionWithUser",
            RBX_NAME = arg1.props.targetPlayer.Name
        }
    })(
        function(arg2)
            local createFragment = Roact.createFragment
            local tbl1 = { ModalDialog = 0, FocusHandler = 0 }
            local createElement = Roact.createElement
            local var2 = ModalDialog

            local tbl2 = {
                visible = arg1.props.isReportSentOpen,
                screenSize = arg1.props.screenSize,
                titleText = arg2.titleText,
                contents = arg1:renderContents(),
                actionButtons = Roact.createElement(Button, {
                    buttonType = ButtonType.PrimarySystem,
                    size = UDim2.new(1, 0, 1, 0),
                    onActivated = function()
                        return arg1.onConfirm(arg2)
                    end,
                    text = arg2.dismissText,
                    [Roact.Ref] = arg1.buttonRef
                }),
                onDismiss = arg1.onCancel
            }

            tbl1.ModalDialog = createElement(var2, tbl2)

            tbl1.FocusHandler = arg1:renderFocusHandler()
            return createFragment(tbl1)
        end
    )
end

function var1.didUpdate(arg1, arg2, _)
    if arg2.isReportSentOpen or not arg1.props.isReportSentOpen or not arg1:isVoiceReport() then
        return
    end

    local var2 = isPlayerUserIdMuted(arg1.props.targetPlayer.UserId)
    arg1:setState({ wasPlayerMutedWhenDialogOpened = var2, isMuteCheckBoxSelected = var2 })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isReportSentOpen = arg1.report.currentPage == Constants.Page.ReportSent,
        reportType = arg1.report.reportType,
        targetPlayer = arg1.report.targetPlayer,
        screenSize = arg1.displayOptions.screenSize,
        reportCategory = arg1.report.reportCategory
    }
end, function(callback)
    return {
        closeDialog = function()
            callback(EndReportFlow())
        end,
        blockPlayer = function(arg1, arg2, arg3)
            callback(BlockPlayer(arg1, arg2, arg3))
        end,
        showToast = function(arg1, arg2)
            callback(ShowToast(arg1, arg2))
        end
    }
end)(var1)
