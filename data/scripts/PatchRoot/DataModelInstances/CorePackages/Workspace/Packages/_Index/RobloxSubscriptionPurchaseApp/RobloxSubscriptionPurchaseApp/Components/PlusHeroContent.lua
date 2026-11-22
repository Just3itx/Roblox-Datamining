-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local React = require(RobloxSubscriptionPurchaseAppParent.React)

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local GuiService = game:GetService("GuiService")
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)

local uDim2 = UDim2.fromScale(0.344, 0.574)

local uDim2_2 = UDim2.fromScale(0.626, 0.405)

local vector2 = Vector2.new(280, 158)

local function PlusHeroContent(tbl1)
    local var1 = useTokens()
    local bool1 = GuiService.ViewportDisplaySize ~= Enum.DisplaySize.Small

    local uDim2_3 = UDim2.fromOffset(
        (if bool1 then 160 else 280) * var1.Config.UI.Scale,
        (if bool1 then 90 else 158) * var1.Config.UI.Scale
    )
    local accentPictogram = if FFlagTTOnboardingSheet then tbl1.accentPictogram else nil
    local zero = Vector2.zero

    local uDim2_4 = UDim2.fromOffset(0, 0)
    local uDim = UDim.new(0, 0)
    local var2, num1

    if accentPictogram then
        zero = vector2 * var1.Config.UI.Scale
        var2 = zero.Y * 0.55
        uDim2_4 = UDim2.fromOffset(var2, var2)
        uDim = UDim.new(0, var2 * 0.044)
        num1 = 0.859375
    else
        var2 = 0
        num1 = 0
    end

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-xsmall size-full-0 auto-y"
    }
    local tbl3 = { HeroPictogram = 0, HeroTitle = 0, HeroSubtitle = 0 }
    local var4

    if tbl1.pictogram then
        local createElement2 = React.createElement
        local var5 = View
        local tbl4 = { LayoutOrder = 1, tag = "align-x-center size-full-0 auto-y" }

        local tbl5 = { PictogramImage = 0 }
        local element

        if accentPictogram then
            element = React.createElement(View, {
                Size = UDim2.fromOffset(zero.X, zero.Y)
            }, {
                AccentCard = React.createElement(View, {
                    tag = "anchor-center-center",
                    Position = uDim2_2,
                    Size = uDim2_4,
                    Rotation = 15,
                    cornerRadius = uDim,
                    stroke = {
                        Color = var1.Color.Content.Emphasis.Color3,
                        Transparency = 0.835,
                        Thickness = var2 * 0.012
                    },
                    ZIndex = 1
                }, {
                    Accent = React.createElement(Image, {
                        Image = accentPictogram.assetId,
                        imageStyle = var1.Color.Content.Emphasis,
                        ScaleType = Enum.ScaleType.Fit,
                        tag = "position-center-center anchor-center-center",
                        Size = UDim2.fromScale(0.8, 0.8)
                    })
                }),
                PrimaryFill = React.createElement(View, {
                    tag = "anchor-center-center bg-surface-100",
                    Position = uDim2,
                    Size = uDim2_4,
                    Rotation = -15,
                    cornerRadius = uDim,
                    ZIndex = 2
                }),
                Primary = React.createElement(Image, {
                    Image = tbl1.pictogram.assetId,
                    imageStyle = var1.Color.Content.Emphasis,
                    ScaleType = Enum.ScaleType.Fit,
                    tag = "anchor-center-center",
                    Position = uDim2,
                    Size = UDim2.fromScale(num1, num1),
                    ZIndex = 3
                })
            })
        else
            element = React.createElement(Image, {
                Image = tbl1.pictogram.assetId,
                imageStyle = var1.Color.Content.Emphasis,
                ScaleType = Enum.ScaleType.Fit,
                Size = uDim2_3
            })
        end

        tbl5.PictogramImage = element
        var4 = createElement2(var5, tbl4, tbl5)
    else
        var4 = nil
    end

    tbl3.HeroPictogram = var4

    tbl3.HeroTitle = React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = tbl1.title,
        tag = {
            ["size-full-0 auto-y text-heading-medium text-wrap text-align-x-left content-emphasis"] = bool1,
            ["size-full-0 auto-y text-heading-large text-wrap text-align-x-left content-emphasis"] = not bool1
        },
        RichText = tbl1.titleRichText
    })
    tbl3.HeroSubtitle = if tbl1.subtitle then React.createElement(FoundationText, {
        LayoutOrder = 3,
        Text = tbl1.subtitle,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default"
    }) else nil
    return createElement(var3, tbl2, tbl3)
end

return PlusHeroContent
