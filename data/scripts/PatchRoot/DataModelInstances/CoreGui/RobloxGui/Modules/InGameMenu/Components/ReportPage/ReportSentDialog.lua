-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent
local Assets = require(scriptParentParentParent.Resources.Assets)
local CloseReportSentDialog = require(scriptParentParentParent.Actions.CloseReportSentDialog)
local Constants = require(scriptParentParentParent.Resources.Constants)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local InfoDialog = require(scriptParentParentParent.Components.InfoDialog)

local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)

local validateProps = t.strictInterface({ isReportSentOpen = t.boolean, onDismiss = t.callback, inputType = t.optional(t.string) })

local var2 = Roact.PureComponent:extend("ReportSentDialog")

var2.validateProps = validateProps

function var2.init(arg1)
    arg1.buttonRef = Roact.createRef()
end

function var2.renderFocusHandler(arg1)
    local createElement = Roact.createElement
    local var3 = FocusHandler
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

    return createElement(var3, tbl1)
end

function var2.render(arg1)
    return withLocalization({
        titleText = "CoreScripts.InGameMenu.Report.ThanksForReport",
        bodyText = "CoreScripts.InGameMenu.Report.WillReviewBody",
        dismissText = "CoreScripts.InGameMenu.Ok"
    })(
        function(arg2)
            return Roact.createFragment({
                Dialog = Roact.createElement(InfoDialog, {
                    titleText = arg2.titleText,
                    bodyText = arg2.bodyText,
                    dismissText = arg2.dismissText,
                    iconImage = Assets.Images.SuccessTick,
                    buttonRef = arg1.buttonRef,
                    onDismiss = arg1.props.onDismiss,
                    visible = arg1.props.isReportSentOpen
                }),
                FocusHandler = arg1:renderFocusHandler()
            })
        end
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isReportSentOpen = arg1.report.reportSentOpen,
        inputType = arg1.displayOptions.inputType
    }
end, function(callback)
    return {
        onDismiss = function()
            callback(CloseReportSentDialog())
        end
    }
end)(var2)
