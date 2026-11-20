-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local var1 = Roact.PureComponent:extend("MaskedIcon")
var1.defaultProps = { icon = "rbxasset://textures/ui/LuaChat/icons/share-game-thumbnail.png" }

function var1.render(arg1)
    local props = arg1.props

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0)
    }, {
        layout = Roact.createElement(
            "UIListLayout",
            {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        ),
        button = Roact.createElement(
            "ImageLabel",
            {
                BackgroundTransparency = 1,
                Image = props.icon,
                Size = UDim2.new(1, 0, 1, 0)
            },
            {
                layout = Roact.createElement(
                    "UIListLayout",
                    {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }
                ),
                mask = Roact.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    Image = "rbxasset://textures/ui/LuaChat/graphic/gr-mask-game-icon-48x48.png",
                    Size = UDim2.new(1, 0, 1, 0)
                })
            }
        )
    })
end
return var1
