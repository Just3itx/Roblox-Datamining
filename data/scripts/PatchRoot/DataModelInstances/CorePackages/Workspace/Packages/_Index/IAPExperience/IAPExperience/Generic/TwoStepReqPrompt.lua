-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)

local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            title = { key = "Authentication.TwoStepVerification.Title.VerificationRequired" },
            message = { key = "Authentication.TwoStepVerification.Label.TwoStepRequired" },
            cancel = { key = "Authentication.TwoStepVerification.Action.Cancel" },
            backToGame = { key = "IAPExperience.PurchaseSuccess.Action.BackToGame" },
            gotoSecurity = { key = "Authentication.TwoStepVerification.Action.GoToSecurity" }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    local props = tbl1.props

    local buttonStackInfo = props.openSecuritySettings
        and {
            buttons = {
                {
                    props = {
                        onActivated = props.closePrompt,
                        text = tbl2.cancel,
                        inputIcon = props.cancelControllerIcon
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = props.openSecuritySettings,
                        text = tbl2.gotoSecurity,
                        inputIcon = props.doneControllerIcon
                    }
                }
            }
        }
        or {
            buttons = {{
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = props.closePrompt,
                    text = tbl2.backToGame,
                    inputIcon = props.doneControllerIcon
                }
            }}
        }

    return Roact.createElement(InteractiveAlert, {
        anchorPoint = props.anchorPoint,
        position = props.position,
        screenSize = props.screenSize,
        title = tbl2.title,
        titleIcon = Images["icons/status/error_large"],
        bodyText = tbl2.message,
        buttonStackInfo = buttonStackInfo
    })
end

return var1
