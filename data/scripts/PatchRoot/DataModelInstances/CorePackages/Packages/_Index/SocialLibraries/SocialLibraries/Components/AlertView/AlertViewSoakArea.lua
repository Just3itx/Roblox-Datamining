-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local bool1 = game:DefineFastFlag("SocialLibrariesSelectableAlertViewShim", false)

local var1 = Roact.PureComponent:extend("AlertViewSoakArea")
var1.defaultProps = {
    Visible = true,
    BackgroundTransparency = 0.75,
    BackgroundColor3 = Color3.fromRGB(255, 0, 255)
}

function var1.render(arg1)
    return Roact.createElement("ImageButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = arg1.props.BackgroundTransparency,
        BackgroundColor3 = arg1.props.BackgroundColor3,
        Active = true,
        AutoButtonColor = false,
        Selectable = not bool1 and nil,
        Visible = arg1.props.Visible
    }, arg1.props[Roact.Children])
end

return var1
