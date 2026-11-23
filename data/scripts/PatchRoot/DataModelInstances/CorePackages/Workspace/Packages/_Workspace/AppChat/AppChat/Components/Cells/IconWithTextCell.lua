-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local ImageSetLabel = require(AppChatParent.UIBlox).Core.ImageSet.ImageSetLabel
local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local BaseCell = require(script.Parent.BaseCell)

local TestStyle = require(AppChat.SocialLibraries).Components.TestStyle

local _types = require(AppChat.types)

local tbl1 = {
    Text = "titleText",
    primaryIconSize = 32,
    isDisabled = false,
    Size = UDim2.new(1, 0, 1, 0),
    onActivated = function()
        print("IconWithTextCell onActivated")
    end,
    secondaryIcon = "",
    secondaryIconSize = 24,
    iconCellWidth = 60,
    LayoutOrder = 0,
    style = Cryo.Dictionary.join(TestStyle, { Tokens = { Color = { None = {} } } }),
    showDivider = true
}

return memo(function(tbl2) -- name: IconWithTextCell
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local style = var1.style
    local theme = style.Theme
    local font = style.Font
    local var2 = useTokens()
    local bool1 = var1.primaryIcon == nil

    local createElement = React.createElement
    local var3 = BaseCell
    local tbl3 = {
        Size = var1.Size,
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = style.Tokens.Color.None.Transparency,
        onPressedBackgroundColor3 = theme.BackgroundOnPress.Color,
        onPressedBackgroundTransparency = theme.BackgroundOnPress.Transparency,
        LayoutOrder = var1.LayoutOrder,
        onActivated = var1.onActivated,
        showDivider = var1.showDivider,
        dividerColor3 = theme.Divider.Color,
        dividerTransparency = theme.Divider.Transparency,
        isDisabled = var1.isDisabled,
        avatarCircleCellWidth = var1.iconCellWidth,
        testId = tbl2.testId
    }
    local tbl4 = { leftFrame = 0, rightFrame = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.new(1, -var1.iconCellWidth, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl6 = {
        leftListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        imageFrame = 0,
        text = 0
    }
    local element

    if bool1 then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.new(0, var1.iconCellWidth, 0, var1.primaryIconSize),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            {
                primaryIcon = React.createElement(ImageSetLabel, {
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = var1.primaryIcon,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, var1.primaryIconSize, 0, var1.primaryIconSize),
                    ImageColor3 = theme.IconEmphasis.Color,
                    BackgroundTransparency = 1
                })
            }
        )
    end

    tbl6.imageFrame = element

    tbl6.text = React.createElement("TextLabel", {
        Size = UDim2.new(1, if bool1 then 0 else -var1.iconCellWidth, 1, 0),
        Text = var1.Text,
        TextSize = font.Header2.RelativeSize * font.BaseSize,
        FontFace = normalizeFontFace(var2.Typography.TitleLarge.Font),
        TextColor3 = theme.TextEmphasis.Color,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        LayoutOrder = 2
    })
    tbl4.leftFrame = createElement2(str1, tbl5, tbl6)

    tbl4.rightFrame = React.createElement("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(var1.iconCellWidth, var1.iconCellWidth),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }, {
        secondaryIcon = var1.secondaryIcon
            and React.createElement("ImageLabel", {
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Image = var1.secondaryIcon,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(var1.secondaryIconSize, var1.secondaryIconSize)
            })
    })
    return createElement(var3, tbl3, tbl4)
end)
