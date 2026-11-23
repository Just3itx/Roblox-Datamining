-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:55Z
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
    topPadding = 8,
    bottomPadding = 8,
    widthScale = 1,
    widthOffset = 0,
    onActivated = function()
        print("FlexIconWithTextCell onActivated")
    end,
    secondaryIcon = "",
    secondaryIconSize = 24,
    iconCellWidth = 60,
    LayoutOrder = 0,
    style = TestStyle,
    BackgroundTransparency = nil,
    showDivider = true
}

return memo(function(tbl2) -- name: FlexIconWithTextCell
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local style = var1.style
    local theme = style.Theme
    local font = style.Font
    local var2 = useTokens()
    local bool1 = var1.primaryIcon == nil

    local createElement = React.createElement
    local var3 = BaseCell
    local tbl3 = {
        Size = UDim2.new(1, var1.widthOffset, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = var1.BackgroundTransparency or theme.BackgroundDefault.Transparency,
        onPressedBackgroundColor3 = theme.BackgroundOnPress.Color,
        onPressedBackgroundTransparency = theme.BackgroundOnPress.Transparency,
        LayoutOrder = var1.LayoutOrder,
        onActivated = var1.onActivated,
        showDivider = var1.showDivider,
        dividerColor3 = theme.Divider.Color,
        dividerTransparency = theme.Divider.Transparency,
        isDisabled = var1.isDisabled,
        avatarCircleCellWidth = var1.iconCellWidth
    }
    local tbl4 = { leftFrame = 0, rightFrame = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, -var1.iconCellWidth, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl6 = {
        leftListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        leftFramePadding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, var1.topPadding),
                PaddingBottom = UDim.new(0, var1.bottomPadding)
            }
        ),
        imageFrame = 0,
        textFrame = 0
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

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl7 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl8 = {
        uiListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        titleText = React.createElement("TextLabel", {
            Size = UDim2.new(1, if bool1 then 0 else -var1.iconCellWidth, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = var1.Text,
            TextSize = font.Header2.RelativeSize * font.BaseSize,
            FontFace = normalizeFontFace(var2.Typography.TitleLarge.Font),
            TextColor3 = theme.TextEmphasis.Color,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = true,
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }),
        subTitleText = 0
    }
    local element2

    if var1.SubTitleText then
        element2 = React.createElement("TextLabel", {
            Size = UDim2.new(1, if bool1 then 0 else -var1.iconCellWidth, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = var1.SubTitleText,
            TextSize = font.BodySmall.RelativeSize * font.BaseSize,
            FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
            TextColor3 = theme.TextDefault.Color,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        })
    else
        element2 = nil
    end

    tbl8.subTitleText = element2
    tbl6.textFrame = createElement3(str2, tbl7, tbl8)
    tbl4.leftFrame = createElement2(str1, tbl5, tbl6)
    local element3

    if var1.secondaryIcon then
        element3 = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(var1.iconCellWidth, var1.iconCellWidth),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            {
                secondaryIcon = React.createElement("ImageLabel", {
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = var1.secondaryIcon,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(var1.secondaryIconSize, var1.secondaryIconSize)
                })
            }
        )
    else
        element3 = nil
    end

    tbl4.rightFrame = element3
    return createElement(var3, tbl3, tbl4)
end)
