-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local Components = SocialLibraries.Components
local ButtonType = dependencies.UIBlox.App.Button.Enum.ButtonType
local AlertViewBuilder = require(Components.AlertViewBuilder.AlertViewBuilder)

local var1 = Roact.Component:extend("WarningAlertView")
var1.defaultProps = {
    titleText = "TestTitle",
    bodyText = "TestBody",
    cancelText = "TestCancel",
    confirmText = "TestConfirm",
    failureTitleText = "failure title!",
    failureBodyText = "Thing failure!",
    failureButtonText = "failure Placeholder!",
    screenSize = Vector2.new(0, 0),
    width = UDim.new(0.5, 0),
    displayFailed = false,
    onActivated = function() end,
    onModalClose = function() end,
    soakAreaColor3 = Color3.fromRGB(0, 0, 255),
    soakAreaTransparency = 0.9
}

local function No_Op() end

function var1.render(arg1)
    local props = arg1.props
    local var2, var3, tbl1

    if props.displayFailed then
        var2 = arg1.props.failureTitleText
        var3 = arg1.props.failureBodyText

        tbl1 = {{
            buttonType = ButtonType.Alert,
            props = {
                text = props.failureButtonText,
                onActivated = No_Op
            }
        }}
    else
        var2 = arg1.props.titleText
        var3 = arg1.props.bodyText

        tbl1 = {
            {
                buttonType = ButtonType.Secondary,
                props = {
                    text = props.cancelText,
                    onActivated = No_Op
                }
            },
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    text = props.confirmText,
                    onActivated = props.onActivated
                }
            }
        }
    end

    return Roact.createElement(AlertViewBuilder, {
        title = var2,
        bodyText = var3,
        screenSize = arg1.props.screenSize,
        width = arg1.props.width,
        onModalClose = arg1.props.onModalClose,
        buttons = tbl1,
        soakAreaColor3 = props.soakAreaColor3,
        soakAreaTransparency = props.soakAreaTransparency
    })
end

return var1
