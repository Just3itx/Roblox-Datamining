-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local var1 = require(AppChat.Logger):new(script.Name)

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local ButtonStack = UIBlox.App.Button.ButtonStack
local enum = UIBlox.App.Button.Enum
local Label = require(AppChat.Components.Label.Label)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Foundation = require(AppChatParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FFlagAppChatLandingModalThemedBackground = require(AppChat.Flags.FFlagAppChatLandingModalThemedBackground)

local iconsActionsFavoriteOn = UIBlox.App.ImageSet.Images["icons/actions/favoriteOn"]
local IconNameX = Foundation.Enums.IconName.X

local tbl1 = {}

tbl1[AppChatNetworking.Constants.ModalContentType.Link] = function(tbl2)
    local var2 = useStyle()
    return React.createElement("TextButton", {
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = tbl2.layoutOrder,
        FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
        BorderSizePixel = 0,
        Text = `<u>{tbl2.content.text}</u>`,
        RichText = true,
        TextColor3 = var2.Theme.TextDefault.Color,
        TextSize = var2.Font.CaptionBody.RelativeSize * var2.Font.BaseSize,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        [React.Event.Activated] = tbl2.content.onActivated
    })
end

tbl1[AppChatNetworking.Constants.ModalContentType.Text] = function(tbl2)
    local var2 = useStyle()
    return React.createElement("TextLabel", {
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = tbl2.layoutOrder,
        FontFace = normalizeFontFace(var2.Tokens.Typography.BodyLarge.Font),
        BorderSizePixel = 0,
        Text = tbl2.content.text,
        TextColor3 = var2.Theme.TextDefault.Color,
        TextSize = var2.Font.CaptionBody.RelativeSize * var2.Font.BaseSize,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    })
end

local tbl2 = {
    titleText = "",
    bodyText = "",
    actionText = "",
    additionalContent = {},
    buttonType = enum.ButtonType.PrimarySystem,
    paddingX = 12,
    hideActionButton = false,
    onActivated = function() end,
    onDismissed = function() end
}

return React.forwardRef(function(tbl3, ref)
    local var2 = Cryo.Dictionary.join(tbl2, tbl3)
    local var3 = useStyle()
    local var4 = var2.style or var3
    local var5 = useChatPagePadding()

    local size200 = var4.Tokens.Size.Size_200
    local size1000 = var4.Tokens.Size.Size_1000
    local var6 = Foundation.Hooks.useTokens()
    local size600 = var6.Size.Size_600

    local var7, var8 = React.useMemo(function()
        local var7 = Cryo.Dictionary.map(var2.additionalContent, function(content, num1: number)
            local var7 = tbl1[content.type]
            local layoutOrder = num1 + 2
            local element = if var7 then React.createElement(var7, { layoutOrder = layoutOrder, content = content }) else nil

            if element then
                return element, `additionalContent_{num1}`
            end
            var1:warning(`Unsupported additional content type: {content.type}`)

            return nil, nil
        end)
        return var7, not Cryo.isEmpty(var7)
    end, { var2.additionalContent })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        LayoutOrder = var2.LayoutOrder,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ref = ref
    }
    local tbl5 = {
        ContentPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, size200),
            PaddingBottom = UDim.new(0, size200),
            PaddingLeft = UDim.new(0, var5.left),
            PaddingRight = UDim.new(0, var5.right)
        }),
        Content = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        BackgroundTransparency = if FFlagAppChatLandingModalThemedBackground then var4.Theme.BackgroundUIDefault.Transparency else var4.Theme.SystemPrimaryContent.Transparency,
        BackgroundColor3 = if FFlagAppChatLandingModalThemedBackground then var4.Theme.BackgroundUIDefault.Color else var4.Theme.SystemPrimaryContent.Color,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, size200 * 2)
        }),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var4.Tokens.Radius.Medium) }),
        UIStroke = React.createElement("UIStroke", {
            Thickness = var4.Tokens.Stroke.Standard,
            Color = var4.Theme.Divider.Color,
            Transparency = var4.Theme.Divider.Transparency
        }),
        ContentPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, size200),
            PaddingBottom = UDim.new(0, size200),
            PaddingLeft = UDim.new(0, size200),
            PaddingRight = UDim.new(0, size200)
        }),
        IconAndTextFrame = 0,
        Buttons = 0
    }
    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl9 = {
        HorizontalLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, size200)
        }),
        TextFrame = 0,
        ImageIcon = 0
    }
    local createElement4 = React.createElement
    local str4 = "Frame"
    local tbl10 = {
        Size = UDim2.new(1, -size600 - size200, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl11 = {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, size200)
        }),
        LabelAndTextFrame = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, size200)
                }),
                TitleLabelWithIcon = if var2.titleLabelText then React.createElement(Label, { bodyText = var2.titleLabelText, iconImage = iconsActionsFavoriteOn, layoutOrder = 1 }) else nil,
                TitleTextLabel = React.createElement(
                    "TextLabel",
                    {
                        Size = UDim2.new(1, 0, 0, 0),
                        LayoutOrder = 2,
                        FontFace = normalizeFontFace(var6.Typography.HeadingLarge.Font),
                        BorderSizePixel = 0,
                        Text = var2.titleText,
                        TextColor3 = var4.Theme.TextEmphasis.Color,
                        TextSize = var4.Font.Header2.RelativeSize * var4.Font.BaseSize,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    {
                        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
                    }
                )
            }
        ),
        BodyTextLabel = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 0),
            LayoutOrder = 2,
            FontFace = normalizeFontFace(var6.Typography.BodyLarge.Font),
            BorderSizePixel = 0,
            Text = var2.bodyText,
            TextColor3 = var4.Theme.TextDefault.Color,
            TextSize = var4.Font.CaptionBody.RelativeSize * var4.Font.BaseSize,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        }),
        AdditionalContent = if var8 then React.createElement(React.Fragment, {}, var7) else nil
    }
    tbl9.TextFrame = createElement4(str4, tbl10, tbl11)

    tbl9.ImageIcon = React.createElement(
        Foundation.View,
        {
            onActivated = var2.onDismissed,
            LayoutOrder = 2,
            tag = "auto-xy x-default-transparent radius-xsmall"
        },
        {
            Icon = React.createElement(Foundation.Icon, { size = size600, name = IconNameX })
        }
    )
    tbl7.IconAndTextFrame = createElement3(str3, tbl8, tbl9)
    local element

    if var2.hideActionButton then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, size1000)
            },
            {
                ButtonStack = React.createElement(ButtonStack, {
                    forcedFillDirection = Enum.FillDirection.Horizontal,
                    buttons = {{
                        buttonType = var2.buttonType,
                        props = {
                            onActivated = var2.onActivated,
                            text = var2.actionText
                        }
                    }}
                })
            }
        )
    end

    tbl7.Buttons = element
    tbl5.Content = createElement2(str2, tbl6, tbl7)
    return createElement(str1, tbl4, tbl5)
end)
