-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)

local withStyle = require(AppChatParent.UIBlox).Style.withStyle

local LoadingAvatar = require(script.Parent.LoadingAvatar)
local TextPlaceholders = require(script.Parent.TextPlaceholders)

local var1 = Roact.PureComponent:extend("ChatLoadingIndicator")
var1.defaultProps = { cellHeight = 64, avatarCellWidth = 60 }

function var1.init(arg1)
    function arg1.singleConversationPlaceholder(layoutOrder, arg2)
        return withStyle(function(arg3)
            return Roact.createElement("Frame", {
                LayoutOrder = layoutOrder,
                Size = UDim2.new(1, 0, 0, arg1.props.cellHeight),
                BackgroundTransparency = arg3.Tokens.Color.None.Transparency,
                BackgroundColor3 = arg3.Theme.BackgroundDefault.Color,
                BorderSizePixel = 0
            }, {
                UIList = Roact.createElement(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical
                    }
                ),
                Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 0), PaddingTop = UDim.new(0, 4) }),
                Content = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 1, -1),
                        BackgroundTransparency = 1
                    },
                    {
                        UIList = Roact.createElement(
                            "UIListLayout",
                            {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Horizontal
                            }
                        ),
                        avatar = Roact.createElement(LoadingAvatar, {
                            avatarImage = arg1.props.avatarImage,
                            cellWidth = arg1.props.avatarCellWidth,
                            cellHeight = arg1.props.cellHeight,
                            LayoutOrder = 1
                        }),
                        textPlaceholders = Roact.createElement(TextPlaceholders, { avatarCellWidth = arg1.props.avatarCellWidth, LayoutOrder = 2 })
                    }
                ),
                bottomLineContainer = not arg2
                    and Roact.createElement(
                        "Frame",
                        {
                            LayoutOrder = 2,
                            Size = UDim2.new(1, 0, 0, 1),
                            BackgroundTransparency = 1,
                            ZIndex = 2,
                            ClipsDescendants = true
                        },
                        {
                            Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, arg1.props.avatarCellWidth) }),
                            bottomLine = Roact.createElement("Frame", {
                                BackgroundColor3 = arg3.Theme.Divider.Color,
                                Transparency = arg3.Theme.Divider.Transparency,
                                Size = UDim2.new(1, 0, 1, 0),
                                BorderSizePixel = 0
                            })
                        }
                    )
            })
        end)
    end

    function arg1.allConversationPlaceholdersList()
        local tbl1 = {
            UIList = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            )
        }
        table.insert(tbl1, arg1.singleConversationPlaceholder(1, false))
        table.insert(tbl1, arg1.singleConversationPlaceholder(2, false))
        table.insert(tbl1, arg1.singleConversationPlaceholder(3, true))

        return tbl1
    end
end

function var1.render(arg1)
    local pageBackgroundTransparency = arg1.props.pageBackgroundTransparency
    return withStyle(function(arg2)
        return Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = arg2.Theme.BackgroundDefault.Color,
            BackgroundTransparency = if pageBackgroundTransparency ~= nil then pageBackgroundTransparency else arg2.Tokens.Color.None.Transparency,
            BorderSizePixel = 0
        }, arg1.allConversationPlaceholdersList())
    end)
end

return var1
