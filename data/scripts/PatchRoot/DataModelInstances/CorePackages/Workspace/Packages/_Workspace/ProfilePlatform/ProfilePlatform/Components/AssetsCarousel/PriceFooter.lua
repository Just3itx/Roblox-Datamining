-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local normalizeFontFace = require(ProfilePlatformParent.Foundation).Utility.normalizeFontFace

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle
local Images = UIBlox.App.ImageSet.Images

local Localization = require(ProfilePlatformParent.Localization)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useLocalization = Localization.Hooks.useLocalization

local FFlagProfilePlatformFixResaleLimitedPrice = require(ProfilePlatform.Flags.FFlagProfilePlatformFixResaleLimitedPrice)

local iconsCommonRobux = Images["icons/common/robux"]

local function PriceFooter(tbl1)
    local var1 = useStyle()
    local font = var1.Font
    local theme = var1.Theme
    local textSize = font.BaseSize * font.SubHeader1.RelativeSize
    local vector2 = Vector2.new(textSize, textSize)

    local var3 = useLocalization({ freeText = TextKeys.CatalogLabelFree, offSaleText = TextKeys.CatalogLabelOffSale })

    local var4 = nil
    local bool1 = false

    if tbl1.isOffSale then
        if FFlagProfilePlatformFixResaleLimitedPrice and tbl1.lowestResalePrice and tbl1.lowestResalePrice > 0 then
            var4 = tostring(tbl1.lowestResalePrice)
            bool1 = true
        else
            var4 = var3.offSaleText
        end
    elseif tbl1.price == 0 then
        var4 = var3.freeText
    elseif tbl1.price then
        var4 = tostring(tbl1.price)
        bool1 = true
    end

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.fromOffset(0, -4)
        },
        {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 4)
            }),
            Icon = if bool1 then React.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Image = iconsCommonRobux,
                ImageColor3 = theme.IconEmphasis.Color,
                ImageTransparency = theme.IconEmphasis.Transparency,
                Size = UDim2.fromOffset(vector2.X, vector2.Y)
            }) else nil,
            Text = React.createElement("TextLabel", {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, if bool1 then -(vector2.X + 4) else 0, 1, 0),
                FontFace = normalizeFontFace(var1.Tokens.Typography.TitleLarge.Font),
                TextColor3 = theme.SecondaryContent.Color,
                TextTransparency = theme.SecondaryContent.Transparency,
                TextSize = textSize,
                Text = var4,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        }
    )
end
return PriceFooter
