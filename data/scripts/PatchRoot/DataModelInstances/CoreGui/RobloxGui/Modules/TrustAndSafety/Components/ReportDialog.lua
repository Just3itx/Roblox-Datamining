-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)

local GameIcon = require(Dependencies.GameIcon)
local PlayerCell = require(Dependencies.PlayerCell)
local ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withLocalization = require(Dependencies.withLocalization)
local playerInterface = require(Dependencies.playerInterface)

local NavigateBack = require(scriptParentParent.Actions.NavigateBack)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local Constants = require(scriptParentParent.Resources.Constants)
local SendReport = require(scriptParentParent.Thunks.SendReport)
local TextEntryField = require(scriptParentParent.Components.TextEntryField)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local SessionUtility = require(scriptParentParent.Utility.SessionUtility)

local Provider = UIBlox.Core.Style.Provider
local withStyle = UIBlox.Core.Style.withStyle
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Colors = UIBlox.App.Style.Colors
local DropdownMenu = UIBlox.App.Menu.DropdownMenu

local isPlayerVerified = require(CorePackages.Workspace.Packages.UserLib).Utils.isPlayerVerified

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local VoiceIndicatorFunc = require(RobloxGui.Modules.VoiceChat.Components.VoiceIndicatorFunc)
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)
local React = require(CorePackages.Packages.React)
local function func1(arg1)
    if not React.useContext(VoiceStateContext.Context).voiceEnabled then
        return nil
    end
    return React.createElement(VoiceIndicatorFunc, Cryo.Dictionary.join(arg1, {}))
end

local DsaIllegalContentReporting = require(CorePackages.Workspace.Packages.DsaIllegalContentReporting)
local isShowUKOSAIllegalContentReportingLink = DsaIllegalContentReporting.isShowUKOSAIllegalContentReportingLink
local OSAReportLink = DsaIllegalContentReporting.OSAReportLink

local tbl1 = {
    "Swearing",
    "Inappropriate Username",
    "Bullying",
    "Scamming",
    "Dating",
    "Cheating/Exploiting",
    "Personal Question",
    "Offsite Links"
}

local tbl2 = {
    BackgroundDefault = {
        Color = Colors.Flint,
        Transparency = 1
    },
    BackgroundOnHover = {
        Color = Colors.Flint,
        Transparency = 1
    },
    BackgroundOnPress = {
        Color = Colors.Flint,
        Transparency = 1
    }
}

local var1 = Roact.PureComponent:extend("ReportDialog")

var1.validateProps = t.strictInterface({
    isReportDialogOpen = t.boolean,
    reportType = t.optional(t.valueOf(Constants.ReportType)),
    targetPlayer = t.optional(playerInterface),
    placeName = t.string,
    screenSize = t.Vector2,
    navigateBack = t.optional(t.callback),
    canNavigateBack = t.optional(t.boolean),
    sendReport = t.callback,
    closeDialog = t.optional(t.callback),
    reportCategory = t.optional(t.string)
})

function var1.init(arg1)
    arg1.state = { reasonText = nil, descriptionText = "" }

    function arg1.onReasonChanged(reasonText)
        arg1:setState({ reasonText = reasonText })
    end

    function arg1.onTextChanged(descriptionText)
        arg1:setState({ descriptionText = descriptionText })
    end

    function arg1.onReport(arg2, arg3)
        local reason = arg1:getReason()
        arg1.props.sendReport(
            arg1.props.reportType,
            arg1.props.targetPlayer,
            reason,
            arg1.state.descriptionText,
            arg1.props.reportCategory,
            arg2,
            arg3
        )
    end

    function arg1.navigateBack()
        arg1.props.navigateBack(arg1.state.reasonText, arg1.state.descriptionText ~= "")
    end

    function arg1.onCancel()
        arg1.props.closeDialog(arg1.state.reasonText, arg1.state.descriptionText ~= "")
    end
end

function var1.getReason(arg1)
    if arg1.props.reportType == Constants.ReportType.Player then
        return arg1.state.reasonText
    end

    if arg1.props.reportType == Constants.ReportType.Place then
        return "Inappropriate Content"
    end

    return nil
end

function var1.canReport(arg1): boolean
    local bool1 = arg1:getReason() ~= nil
    local var2 = utf8.len(utf8.nfcnormalize(arg1.state.descriptionText))
    local bool2 = var2 >= 0 and var2 <= 160
    return bool1 and bool2
end

function var1.renderUKOSALink(_)
    if not isShowUKOSAIllegalContentReportingLink() then
        return nil
    end

    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 40),
            Position = UDim2.new(0, 0, 1, -45),
            LayoutOrder = 99
        },
        {
            OSALink = Roact.createElement(OSAReportLink)
        }
    )
end

function var1.renderPlayerInfo(arg1)
    local bool1 = arg1.props.reportCategory == Constants.Category.Voice

    return withStyle(function(arg2)
        local theme = Cryo.Dictionary.join(arg2.Theme, tbl2)
        local style = Cryo.Dictionary.join(arg2, { Theme = theme })

        local num1 = 0
        if bool1 and arg1.props.isReportDialogOpen then
            num1 += 1
        end
        local createElement = Roact.createElement
        local var4 = Provider
        local tbl3 = { style = style }

        local createElement2 = Roact.createElement
        local var5 = PlayerCell
        local tbl4 = {
            userId = arg1.props.targetPlayer.UserId,
            username = arg1.props.targetPlayer.Name,
            displayName = arg1.props.targetPlayer.DisplayName,
            hasVerifiedBadge = isPlayerVerified(arg1.props.targetPlayer),
            isOnline = true,
            isSelected = false,
            LayoutOrder = 1,
            key = tostring(arg1.props.targetPlayer.UserId),
            memoKey = num1
        }
        local tbl5 = { VoiceIndicator = 0 }
        local var6

        if bool1 and arg1.props.isReportDialogOpen then
            local createElement3 = Roact.createElement
            local func2 = func1
            local tbl6 = {
                userId = tostring(arg1.props.targetPlayer.UserId),
                hideOnError = true,
                iconStyle = "SpeakerLight",
                size = UDim2.fromOffset(36, 36),
                onClicked = 0
            }

            function tbl6.onClicked()
                default:ToggleMutePlayer(arg1.props.targetPlayer.UserId, Constants2.VOICE_CONTEXT_TYPE.REPORT_MENU)
            end

            var6 = createElement3(func2, tbl6) or nil
        else
            var6 = nil
        end

        tbl5.VoiceIndicator = var6
        return createElement(var4, tbl3, { createElement2(var5, tbl4, tbl5) })
    end)
end

function var1.renderDropDownMenu(arg1)
    local yOffset = if isShowUKOSAIllegalContentReportingLink() then 64 else 72
    if not arg1.props.isReportDialogOpen then
        return nil
    end
    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, yOffset),
            Size = UDim2.new(1, 0, 0, 48),
            ZIndex = 10
        },
        {
            DropDown = withLocalization({
                menu1 = "CoreScripts.InGameMenu.Report.AbuseSwearing",
                menu2 = "CoreScripts.InGameMenu.Report.AbuseUsername",
                menu3 = "CoreScripts.InGameMenu.Report.AbuseBullying",
                menu4 = "CoreScripts.InGameMenu.Report.AbuseScamming",
                menu5 = "CoreScripts.InGameMenu.Report.AbuseDating",
                menu6 = "CoreScripts.InGameMenu.Report.AbuseExploiting",
                menu7 = "CoreScripts.InGameMenu.Report.AbusePersonalQuestion",
                menu8 = "CoreScripts.InGameMenu.Report.AbuseOffsiteLink",
                placeHolderText = "CoreScripts.InGameMenu.Report.AbuseTypePlaceHolder"
            })(
                function(arg2)
                    local cellDatas = {}
                    local tbl4 = ({})
                    for i, value in ipairs(tbl1) do
                        local text = arg2["menu" .. tostring(i)]
                        table.insert(cellDatas, { text = text })

                        tbl4[text] = value
                    end
                    return Roact.createElement(DropdownMenu, {
                        placeholder = arg2.placeHolderText,
                        onChange = function(arg3) -- name: onDropDownChanged
                            local var2 = tbl4[arg3]
                            arg1.onReasonChanged(var2)
                        end,
                        height = UDim.new(0, 48),
                        screenSize = arg1.props.screenSize,
                        cellDatas = cellDatas,
                        showDropShadow = true,
                        fixedListHeight = 171
                    })
                end
            )
        }
    )
end

function var1.renderPlayerContents(arg1)
    return withLocalization({ placeHolderText = "CoreScripts.InGameMenu.Report.AbuseDetailsPlaceHolder" })(function(arg2)
        local yOffset = if isShowUKOSAIllegalContentReportingLink() then 118 else 132
        local yOffset2 = if isShowUKOSAIllegalContentReportingLink() then -150 else -132
        return Roact.createFragment({
            PlayerInfo = arg1:renderPlayerInfo(),
            DropDownMenu = arg1:renderDropDownMenu(),
            TextField = Roact.createElement(TextEntryField, {
                enabled = arg1.props.isReportDialogOpen,
                text = arg1.state.descriptionText,
                textChanged = arg1.onTextChanged,
                maxTextLength = 160,
                autoFocusOnEnabled = false,
                PlaceholderText = arg2.placeHolderText,
                Position = UDim2.fromOffset(0, yOffset),
                Size = UDim2.new(1, 0, 1, yOffset2)
            }),
            OSALinkFrame = arg1:renderUKOSALink()
        })
    end)
end

function var1.renderPlaceContents(arg1)
    return withLocalization({
        labelText = {
            "CoreScripts.InGameMenu.Report.ReportingGame",
            RBX_NAME = arg1.props.placeName
        },
        placeHolderText = "CoreScripts.InGameMenu.Report.AbuseDetailsPlaceHolder"
    })(
        function(arg2)
            local yOffset = if isShowUKOSAIllegalContentReportingLink() then 12 else 24
            local yOffset2 = if isShowUKOSAIllegalContentReportingLink() then 90 else 112
            local yOffset3 = if isShowUKOSAIllegalContentReportingLink() then -135 else -112
            return Roact.createFragment({
                PlaceInfo = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Position = UDim2.fromOffset(0, yOffset),
                        Size = UDim2.new(1, 0, 0, 64)
                    },
                    {
                        GameIcon = Roact.createElement(GameIcon, { gameId = game.GameId, iconSize = 64, cornerRadius = UDim.new(0, 8) }),
                        Label = Roact.createElement(ThemedTextLabel, {
                            fontKey = "Body",
                            themeKey = "TextDefault",
                            AnchorPoint = Vector2.new(0, 0.5),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 76, 0.5, 0),
                            Size = UDim2.new(1, -76, 0, 40),
                            Text = arg2.labelText,
                            TextWrapped = true,
                            TextXAlignment = Enum.TextXAlignment.Left
                        })
                    }
                ),
                TextField = Roact.createElement(TextEntryField, {
                    enabled = arg1.props.isReportDialogOpen,
                    text = arg1.state.descriptionText,
                    textChanged = arg1.onTextChanged,
                    maxTextLength = 160,
                    autoFocusOnEnabled = false,
                    PlaceholderText = arg2.placeHolderText,
                    Position = UDim2.fromOffset(0, yOffset2),
                    Size = UDim2.new(1, 0, 1, yOffset3)
                }),
                OSALinkFrame = arg1:renderUKOSALink()
            })
        end
    )
end

function var1.renderContents(arg1)
    if arg1.props.reportType == Constants.ReportType.Player then
        return arg1:renderPlayerContents()
    elseif arg1.props.reportType == Constants.ReportType.Place then
        return arg1:renderPlaceContents()
    end
    return nil
end

local tbl3 = {
    [Constants.Category.Voice] = "CoreScripts.InGameMenu.Report.Title.VoiceChat",
    [Constants.Category.Text] = "CoreScripts.InGameMenu.Report.Title.TextChat",
    [Constants.Category.Other] = "CoreScripts.InGameMenu.Report.Title.Other",
    [Constants.Category.Experience] = "CoreScripts.InGameMenu.Report.Title.Experience"
}

function var1.categoryTitle(arg1)
    if arg1.props.reportType == Constants.ReportType.Place then
        return tbl3[Constants.Category.Experience]
    end

    return tbl3[arg1.props.reportCategory] or "CoreScripts.InGameMenu.Report.ReportTitle"
end

function var1.render(arg1)
    return withLocalization({
        titleText = arg1:categoryTitle(),
        cancelText = "CoreScripts.InGameMenu.Cancel",
        reportText = "CoreScripts.InGameMenu.Report.SendReport",
        toastDefaultTitle = "CoreScripts.InGameMenu.Report.Confirmation.ThanksForReport",
        toastDefaultDescription = "CoreScripts.InGameMenu.Report.Confirmation.ThanksForReportDescription"
    })(
        function(arg2)
            return Roact.createElement(ModalDialog, {
                visible = arg1.props.isReportDialogOpen,
                screenSize = arg1.props.screenSize,
                titleText = arg2.titleText,
                contents = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1)
                }, {
                    Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
                    Contents = arg1:renderContents()
                }),
                actionButtons = Roact.createElement(ButtonStack, {
                    buttonHeight = 48,
                    buttons = {
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = arg1.onCancel,
                                text = arg2.cancelText
                            }
                        },
                        {
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                isDisabled = not arg1:canReport(),
                                onActivated = function()
                                    return arg1.onReport(arg2.toastDefaultTitle, arg2.toastDefaultDescription)
                                end,
                                text = arg2.reportText
                            }
                        }
                    }
                }),
                onDismiss = arg1.onCancel,
                onBackButtonActivated = if arg1.props.canNavigateBack then arg1.navigateBack else nil
            })
        end
    )
end

function var1.didUpdate(arg1, arg2)
    if arg2.isReportDialogOpen and not arg1.props.isReportDialogOpen then
        arg1:setState({ reasonText = Roact.None, descriptionText = "" })
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        reportCategory = arg1.report.reportCategory,
        isReportDialogOpen = arg1.report.currentPage == Constants.Page.ReportForm,
        reportType = arg1.report.reportType,
        targetPlayer = arg1.report.targetPlayer,
        canNavigateBack = #arg1.report.history > 1,
        placeName = arg1.placeInfo.name,
        screenSize = arg1.displayOptions.screenSize
    }
end, function(callback)
    return {
        navigateBack = function(reason, descriptionTextChanged)
            callback(NavigateBack())
            SendAnalytics(
                Constants.Page.ReportForm,
                Constants.Analytics.ReportFlowBack,
                {
                    source = Constants.Page.ReportForm,
                    reason = reason,
                    descriptionTextChanged = descriptionTextChanged
                }
            )
        end,
        closeDialog = function(reason, descriptionTextChanged)
            callback(EndReportFlow())
            SendAnalytics(
                Constants.Page.ReportForm,
                Constants.Analytics.ReportFlowAbandoned,
                {
                    source = Constants.Page.ReportForm,
                    reason = reason,
                    descriptionTextChanged = descriptionTextChanged
                }
            )
            SessionUtility.endAbuseReportSession()
        end,
        sendReport = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
            callback(SendReport(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
        end
    }
end)(var1)
