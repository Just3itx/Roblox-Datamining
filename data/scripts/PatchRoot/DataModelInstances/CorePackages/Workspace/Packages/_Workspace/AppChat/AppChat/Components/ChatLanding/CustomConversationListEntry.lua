-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local Foundation = require(AppChatParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local getBoldTextTheme = require(script.Parent.Utils.getBoldTextTheme)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)

local iconsNavigationPushRight = Images["icons/navigation/pushRight"]

function CustomConversationListEntry(tbl1)
    local var1 = useStyle()
    local boldTextTheme = getBoldTextTheme(var1)
    local var2 = useTextSizeOffset()
    local var3 = useChatPagePadding()

    local onActivated = tbl1.onActivated

    local titleText = tbl1.titleText
    local textEmphasisTransparency = boldTextTheme.Theme.TextEmphasis.Transparency
    local textEmphasisColor = boldTextTheme.Theme.TextEmphasis.Color
    local textSize = boldTextTheme.Font.Header2.RelativeSize * boldTextTheme.Font.BaseSize
    local yOffset = textSize + var2
    local subTitleText = tbl1.subTitleText
    local textDefaultTransparency = var1.Theme.TextDefault.Transparency
    local textDefaultColor = var1.Theme.TextDefault.Color
    local var4 = var1.Font.CaptionBody.RelativeSize * var1.Font.BaseSize
    local yOffset2 = var4 + var2

    local var6 = IconSize.Regular + 12
    local xOffset = 60 - (60 - IconSize.Regular) / 2

    local view = Foundation.View
    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, tbl1.entryHeight),
        BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
        BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
        onActivated = onActivated,
        testId = if FFlagDebugAppChatEnableDomLocators then tbl1.testId else nil
    }
    local tbl3 = {
        leftAlign = React.createElement("Frame", {
            Size = UDim2.new(1, -var6, 1, 0),
            BackgroundTransparency = 1
        }, {
            padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var3.left) }),
            layout = React.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            iconHolder = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, xOffset, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 0
                },
                {
                    layout = React.createElement(
                        "UIListLayout",
                        {
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Left
                        }
                    ),
                    icon = React.createElement(
                        ImageSetLabel,
                        {
                            BackgroundColor3 = boldTextTheme.Theme.BackgroundUIDefault.Color,
                            BackgroundTransparency = boldTextTheme.Theme.BackgroundUIDefault.Transparency,
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, IconSize.Regular, 0, IconSize.Regular),
                            ScaleType = Enum.ScaleType.Stretch,
                            Image = tbl1.entryIcon,
                            ImageColor3 = var1.Theme.IconEmphasis.Color,
                            ImageTransparency = var1.Theme.IconEmphasis.Transparency
                        },
                        {
                            corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                        }
                    )
                }
            ),
            centerContent = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, -60, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                },
                {
                    layout = React.createElement("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 2)
                    }),
                    title = React.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        TextSize = textSize,
                        TextColor3 = textEmphasisColor,
                        TextTransparency = textEmphasisTransparency,
                        FontFace = normalizeFontFace(var1.Tokens.Typography.TitleLarge.Font),
                        Text = titleText or "",
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        LayoutOrder = 1
                    }),
                    subTitle = React.createElement("TextLabel", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, yOffset2),
                        TextSize = var4,
                        TextColor3 = textDefaultColor,
                        TextTransparency = textDefaultTransparency,
                        FontFace = normalizeFontFace(var1.Tokens.Typography.BodySmall.Font),
                        Text = subTitleText,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        LayoutOrder = 2
                    })
                }
            )
        }),
        rightAlign = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            layout = React.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, var3.right) }),
            icon = React.createElement(ImageSetLabel, {
                LayoutOrder = 0,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, IconSize.Regular, 0, IconSize.Regular),
                ScaleType = Enum.ScaleType.Stretch,
                Image = iconsNavigationPushRight,
                ImageColor3 = var1.Theme.IconEmphasis.Color,
                ImageTransparency = var1.Theme.IconEmphasis.Transparency
            })
        }),
        divider = 0
    }
    local element

    if FFlagAppChatRemoveConversationListDivider then
        element = nil
    else
        element = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            layout = React.createElement(
                "UIListLayout",
                {
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                }
            ),
            divider = React.createElement("Frame", {
                BackgroundTransparency = var1.Theme.Divider.Transparency,
                BackgroundColor3 = var1.Theme.Divider.Color,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -xOffset, 0, 1)
            })
        })
    end

    tbl3.divider = element
    return createElement(view, tbl2, tbl3)
end

return CustomConversationListEntry
