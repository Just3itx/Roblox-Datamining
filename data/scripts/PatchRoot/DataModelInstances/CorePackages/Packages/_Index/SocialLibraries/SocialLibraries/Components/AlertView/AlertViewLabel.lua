-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace

local var1 = Roact.PureComponent:extend("AlertViewLabel")
var1.defaultProps = {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 40),
    Text = "",
    TextXAlignment = Enum.TextXAlignment.Center
}

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        local backgroundTransparency = arg1.props.BackgroundTransparency
        local font = arg1.props.Font or arg2.Font.Body.Font
        local propsText = arg1.props.Text
        local textColor3 = arg1.props.TextColor3 or arg2.Theme.TextDefault.Color
        local textSize = arg1.props.TextSize or arg2.Font.Body.RelativeSize * arg2.Font.BaseSize
        local textXAlignment = arg1.props.TextXAlignment

        return Roact.createElement("TextLabel", {
            BackgroundTransparency = backgroundTransparency,
            FontFace = normalizeFontFace(font),
            LayoutOrder = arg1.props.LayoutOrder,
            Size = arg1.props.Size,
            Text = propsText,
            TextColor3 = textColor3,
            TextSize = textSize,
            TextWrapped = true,
            TextXAlignment = textXAlignment
        })
    end)
end

return var1
