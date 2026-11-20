-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local Components = SocialLibraries.Components
local ButtonType = dependencies.UIBlox.App.Button.Enum.ButtonType
local AlertViewBuilder = require(Components.AlertViewBuilder.AlertViewBuilder)

local var1 = Roact.Component:extend("InfoAlertView")
var1.defaultProps = {
    titleText = "TestTitle",
    bodyText = "TestBody",
    confirmText = "TestConfirm",
    width = UDim.new(0.5, 0),
    screenSize = Vector2.new(0, 0),
    onModalClose = function() end,
    soakAreaColor3 = Color3.fromRGB(0, 0, 255),
    soakAreaTransparency = 0.9
}

function var1.render(arg1)
    local props = arg1.props

    return Roact.createElement(AlertViewBuilder, {
        title = props.titleText,
        bodyText = props.bodyText,
        width = props.width,
        screenSize = props.screenSize,
        onModalClose = props.onModalClose,
        buttons = {{
            buttonType = ButtonType.PrimarySystem,
            props = {
                text = props.confirmText,
                onActivated = props.onModalClose
            }
        }},
        soakAreaColor3 = props.soakAreaColor3,
        soakAreaTransparency = props.soakAreaTransparency
    })
end

return var1
