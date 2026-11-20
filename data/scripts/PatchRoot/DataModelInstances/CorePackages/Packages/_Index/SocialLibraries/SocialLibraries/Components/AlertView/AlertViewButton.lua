-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local var1 = Roact.PureComponent:extend("AlertViewButton")

var1.defaultProps = {
    LayoutOrder = 0,
    secondary = false,
    onActivated = function() end,
    Size = UDim2.new(1, 0, 1, 0),
    Text = ""
}

function var1.render(arg1)
    local primarySystem = ButtonType.PrimarySystem
    if arg1.props.secondary then
        primarySystem = ButtonType.Secondary
    end

    return Roact.createElement(Button, {
        buttonType = primarySystem,
        size = arg1.props.Size,
        layoutOrder = arg1.props.LayoutOrder,
        text = arg1.props.Text,
        onActivated = arg1.props.onActivated
    })
end

return var1
