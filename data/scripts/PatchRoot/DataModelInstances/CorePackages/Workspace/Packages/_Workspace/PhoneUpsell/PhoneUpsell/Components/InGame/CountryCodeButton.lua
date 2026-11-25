-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local React = require(PhoneUpsellParent.React)
local UIBlox = require(PhoneUpsellParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(PhoneUpsellParent.RobloxAppAssets).GetImageData
local Roact = require(PhoneUpsellParent.Roact)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace

local function CountryCodeButton(tbl1)
    local var1 = useStyle()
    local tokens = var1.Tokens
    local tbl2 = {
        Base = {
            Field = {
                Typography = tokens.Typography.BodyLarge
            },
            FieldValue = {
                ContentColor = tokens.Color.Content.Emphasis
            }
        }
    }
    local size = tbl1.size
    local layoutOrder = tbl1.layoutOrder
    local countryPrefix = tbl1.countryPrefix
    local imageColor3 = if tbl1.error then tokens.Color.System.Alert.Color3 else var1.Theme.UIDefault.Color
    local uiDefaultTransparency = var1.Theme.UIDefault.Transparency
    local var3 = tbl1.font or tbl2.Base.Field.Typography.Font
    local textSize = tbl1.textSize or tbl2.Base.Field.Typography.FontSize

    local createElement = React.createElement
    local var5 = ImageSetLabel
    local tbl3 = {
        ZIndex = 2,
        Size = size,
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(9, 9, 9, 9),
        Image = GetImageData("LuaApp/buttons/buttonStroke"),
        ImageColor3 = imageColor3,
        ImageTransparency = uiDefaultTransparency,
        LayoutOrder = layoutOrder
    }
    local tbl4 = {
        Button = React.createElement("TextButton", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = countryPrefix,
            FontFace = normalizeFontFace(var3),
            TextSize = textSize,
            TextColor3 = tbl2.Base.FieldValue.ContentColor.Color3,
            TextTransparency = tbl2.Base.FieldValue.ContentColor.Transparency,
            [Roact.Event.Activated] = tbl1.onButtonClick,
            [Roact.Ref] = tbl1.forwardRef
        })
    }
    return createElement(var5, tbl3, tbl4)
end

return CountryCodeButton
