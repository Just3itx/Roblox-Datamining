-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Roact = require(scriptParentParentParent.Roact)
local UIBlox = require(scriptParentParentParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)

local var1 = Roact.Component:extend(script.Name)

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.new(0.5, 0, 0.5, 0)
}

function var1.render(arg1)
    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            TitleText = { key = "IAPExperience.LeaveRoblox.Title.LeavingRoblox" },
            BodyText = { key = "IAPExperience.LeaveRoblox.Text.ExternalWebsiteWarning" },
            ButtonCancel = { key = "IAPExperience.LeaveRoblox.Action.Cancel" },
            ButtonContinue = { key = "IAPExperience.LeaveRoblox.Action.Continue" }
        },
        render = function(tbl1)
            return arg1:renderAlert(tbl1)
        end
    })
end

function var1.renderAlert(tbl1, tbl2)
    return (Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        Active = true,
        Selectable = false
    }, {
        AlertWindow = Roact.createElement(InteractiveAlert, {
            title = tbl2.TitleText,
            bodyText = tbl2.BodyText,
            buttonStackInfo = {
                buttons = {
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            onActivated = tbl1.props.cancelActivated,
                            text = tbl2.ButtonCancel
                        }
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = tbl1.props.continueActivated,
                            text = tbl2.ButtonContinue
                        }
                    }
                }
            },
            screenSize = tbl1.props.screenSize
        })
    }))
end

return var1
