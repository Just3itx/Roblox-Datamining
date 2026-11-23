-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle

local Skeleton = require(AppChatParent.Foundation).Skeleton

local var1 = Roact.PureComponent:extend("TextPlaceholders")

var1.defaultProps = { LayoutOrder = 0, avatarSize = 60, avatarCellWidth = 60 }

function var1.render(arg1)
    return withStyle(function(_)
        return Roact.createElement("Frame", {
            Size = UDim2.new(1, -arg1.props.avatarCellWidth, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder
        }, {
            Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 0) }),
            UIList = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            ),
            topRectangle = Roact.createElement(Skeleton, { LayoutOrder = 1, Size = UDim2.new(0, 94, 0, 12) }),
            spacer = Roact.createElement("Frame", { LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 7), BackgroundTransparency = 1 }),
            bottomRectangle = Roact.createElement(Skeleton, { LayoutOrder = 3, Size = UDim2.new(0, 169, 0, 12) })
        })
    end)
end

return var1
