-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local UIBlox = require(AppChatParent.UIBlox)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local var1 = Roact.PureComponent:extend("Checkbox")
var1.defaultProps = { activated = false }

function var1.render(arg1)
    return UIBlox.Style.withStyle(function(arg2)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(0, 64, 1, 0),
            BackgroundTransparency = 1
        }
        local tbl2 = {
            layout = Roact.createElement(
                "UIListLayout",
                {
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }
            ),
            image = Roact.createElement(ImageSetLabel, {
                Size = UDim2.new(0, 20, 0, 20),
                BackgroundTransparency = 1,
                Image = if arg1.props.activated then Images["squircles/fill"] else Images["squircles/hollow"],
                ImageColor3 = if arg1.props.activated then arg2.Tokens.Color.System.Emphasis.Color3 else arg2.Theme.IconEmphasis.Color,
                ImageTransparency = if arg1.props.activated then 0 else arg2.Theme.IconEmphasis.Transparency
            }, {
                FillImage = if arg1.props.activated then Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.fromOffset(16, 16),
                    Image = Images["icons/status/success_small"]
                }) else nil
            })
        }
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
