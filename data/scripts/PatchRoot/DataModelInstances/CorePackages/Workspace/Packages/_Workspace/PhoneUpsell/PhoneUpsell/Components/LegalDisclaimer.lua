-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent

local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local Foundation = require(PhoneUpsellParent.Foundation)
local Checkbox = Foundation.Checkbox
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local LinkButton = UIBlox.App.Button.LinkButton
local useStyle = UIBlox.Core.Style.useStyle

return function(arg1)
    local var1 = useStyle()

    local baseSize = var1.Font.BaseSize
    local relativeSize = var1.Font.CaptionHeader.RelativeSize
    local size150 = var1.Tokens.Size.Size_150

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = arg1.LayoutOrder
    }
    local tbl2 = {
        ListLayout = React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, var1.Tokens.Size.Size_150)
            }
        ),
        LegalTextContainer = 0,
        LegalButtonsContainer = 0
    }
    local element

    if arg1.showLegalText and arg1.showLegalTextCheckbox then
        element = React.createElement(
            "Frame",
            {
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, size150)
                }),
                LegalCheckbox = React.createElement(Checkbox, { onActivated = arg1.setLegalTextChecked, isChecked = arg1.legalTextChecked, label = "" }),
                LegalText = React.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = arg1.legalText,
                    TextSize = baseSize * relativeSize,
                    TextColor3 = var1.Theme.TextDefault.Color,
                    TextTransparency = var1.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2.new(1, -(26 + size150), 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y
                })
            }
        )
    else
        element = arg1.showLegalText
            and React.createElement("TextLabel", {
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                Text = arg1.legalText,
                TextSize = baseSize * relativeSize,
                TextColor3 = var1.Theme.TextDefault.Color,
                TextTransparency = var1.Theme.TextDefault.Transparency,
                FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            })
    end

    tbl2.LegalTextContainer = element

    tbl2.LegalButtonsContainer = arg1.showLegalButtons
        and React.createElement(
            "Frame",
            {
                LayoutOrder = 4,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 5)
                }),
                TermsOfUseButton = React.createElement(
                    LinkButton,
                    {
                        text = arg1.termsOfUse,
                        onActivated = arg1.onTermsOfUseClick,
                        layoutOrder = 5,
                        fontStyle = "CaptionBody"
                    }
                ),
                TextButtonDivider = React.createElement("TextLabel", {
                    LayoutOrder = 6,
                    BackgroundTransparency = 1,
                    Text = "-",
                    TextSize = baseSize * relativeSize,
                    TextColor3 = var1.Theme.TextDefault.Color,
                    TextTransparency = var1.Theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(var1.Tokens.Typography.BodyLarge.Font),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.XY
                }),
                PrivacyPolicyButton = React.createElement(
                    LinkButton,
                    {
                        text = arg1.privacyPolicy,
                        onActivated = arg1.onPrivacyPolicyClick,
                        layoutOrder = 7,
                        fontStyle = "CaptionBody"
                    }
                )
            }
        )
    return createElement(str1, tbl1, tbl2)
end
