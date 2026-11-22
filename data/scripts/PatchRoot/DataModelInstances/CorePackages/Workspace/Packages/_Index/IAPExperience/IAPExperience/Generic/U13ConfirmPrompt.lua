-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local U13ConfirmType = require(scriptParent.U13ConfirmType)

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.getMessage(_, tbl1, arg1)
    if arg1 == U13ConfirmType.U13PaymentModal then
        return tbl1.u13PaymentModal
    end

    if arg1 == U13ConfirmType.U13MonthlyThreshold1Modal then
        return tbl1.u13MonthlyThreshold1Modal
    end

    if arg1 == U13ConfirmType.U13MonthlyThreshold2Modal then
        return tbl1.u13MonthlyThreshold2Modal
    end

    if arg1 == U13ConfirmType.ParentalConsentWarningPaymentModal13To17 then
        return tbl1.parentalConsentWarningPaymentModal13To17
    end
end

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            title = { key = "IAPExperience.U13Confirm.Title.Warning" },
            u13PaymentModal = { key = "IAPExperience.U13Confirm.Text.U13PaymentModal" },
            u13MonthlyThreshold1Modal = {
                key = "IAPExperience.U13Confirm.Text.U13MonthlyThreshold1Modal"
            },
            u13MonthlyThreshold2Modal = {
                key = "IAPExperience.U13Confirm.Text.U13MonthlyThreshold2Modal"
            },
            parentalConsentWarningPaymentModal13To17 = {
                key = "IAPExperience.U13Confirm.Text.ParentalConsentWarningPaymentModal13To17"
            },
            confirm = { key = "IAPExperience.U13Confirm.Action.Confirm" },
            cancel = { key = "IAPExperience.U13Confirm.Action.Cancel" }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    local props = tbl1.props

    return Roact.createElement(InteractiveAlert, {
        anchorPoint = props.anchorPoint,
        position = props.position,
        screenSize = props.screenSize,
        title = tbl2.title,
        bodyText = tbl1:getMessage(tbl2, props.modalType),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = props.cancelActivated,
                        text = tbl2.cancel,
                        inputIcon = props.cancelControllerIcon
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.doneActivated,
                        text = tbl2.confirm,
                        inputIcon = props.doneControllerIcon
                    }
                }
            }
        }
    })
end

return var1
