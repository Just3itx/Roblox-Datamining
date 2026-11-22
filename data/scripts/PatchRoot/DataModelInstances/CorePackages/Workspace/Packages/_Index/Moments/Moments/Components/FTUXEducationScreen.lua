-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local FoundationCloudAssets = require(MomentsParent.FoundationCloudAssets)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local IconButton = Foundation.IconButton
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local FormFactor = MomentsCommon.Enums.FormFactor

local Constants = require(Moments.Constants)
local HowToCaptureModal = require(Moments.Components.HowToCaptureModal)
local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local FFlagMomentsFtuxEducationScreenRefresh = require(Moments.Flags.FFlagMomentsFtuxEducationScreenRefresh)

local tbl1 = {
    title = "Feature.Moments.Label.CaptureLibrary",
    description = "Feature.Moments.Description.EmptyCapturesLibrary",
    howToCapture = "Feature.Moments.Action.HowToCapture",
    back = "Feature.Moments.Action.Back"
}

if FFlagMomentsFtuxEducationScreenRefresh then
    FoundationCloudAssets.preloadAsset("pictograms/captures")
end

local function FTUXEducationScreen(tbl2)
    local var1 = useLocalization(tbl1)
    local var2 = useDeviceInsets()
    local var3 = useTokens()
    local var4 = useFormFactor()

    local var5, var6 = React.useState(false)

    React.useEffect(function()
        fireAnalyticsEvent(EventNames.FTUXEducationScreenImpression)
    end, {})

    local onActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.FTUXHowToCaptureButtonPressed)
        var6(true)
    end, {})

    local onClose = React.useCallback(function()
        var6(false)
    end, {})

    local createElement = React.createElement
    local var9 = View
    local tbl3 = {
        backgroundStyle = var3.Color.Common.Scrim,
        tag = "position-center-center anchor-center-center size-full-full"
    }
    local tbl4 = { EducationCard = 0, HowToCard = 0 }
    local var10

    if var5 then
        var10 = nil
    else
        local createElement2 = React.createElement
        local var11 = View
        local tbl5 = {
            tag = "position-center-center anchor-center-center size-full-full radius-large bg-surface-0",
            sizeConstraint = {
                MaxSize = if var4 == FormFactor.Wide then Vector2.new(600, 700) else nil
            }
        }
        local tbl6 = { CloseButtonContainer = 0, Body = 0 }
        local createElement3 = React.createElement
        local var12 = View
        local tbl7 = {
            padding = {
                top = UDim.new(0, var2.top + var3.Padding.Medium),
                right = UDim.new(0, var2.right + var3.Padding.Medium)
            },
            tag = "position-top-right anchor-top-right auto-xy"
        }

        local tbl8 = { CloseButton = 0 }
        local element

        if FFlagMomentsFtuxEducationScreenRefresh then
            element = React.createElement(IconButton, {
                icon = BuilderIcons.Icon.X,
                isCircular = true,
                onActivated = tbl2.onClose,
                size = Foundation.Enums.InputSize.Large,
                variant = Foundation.Enums.ButtonVariant.Utility
            })
        else
            element = React.createElement(
                View,
                {
                    onActivated = tbl2.onClose,
                    tag = "size-1100-1100 padding-medium radius-circle bg-over-media-0"
                },
                {
                    CloseIcon = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        name = "icons/navigation/close_small",
                        size = Foundation.Enums.IconSize.Small,
                        style = var3.Color.ActionEmphasis.Foreground,
                        ZIndex = 2
                    })
                }
            )
        end

        tbl8.CloseButton = element
        tbl6.CloseButtonContainer = createElement3(var12, tbl7, tbl8)

        local createElement4 = React.createElement
        local var13 = View
        local tbl9 = {
            padding = {
                top = UDim.new(0, var2.top + var3.Padding.XLarge),
                bottom = UDim.new(0, math.max(var2.bottom, var3.Padding.Medium)),
                left = UDim.new(0, math.max(var2.left, var3.Padding.Large)),
                right = UDim.new(0, math.max(var2.right, var3.Padding.Large))
            },
            tag = if var4 == FormFactor.Wide then "col align-x-center align-y-center gap-large size-full" else "col align-x-center align-y-center gap-medium size-full"
        }

        local tbl10 = {
            Graphic = React.createElement(Image, {
                Image = if FFlagMomentsFtuxEducationScreenRefresh then FoundationCloudAssets.Assets["pictograms/captures"].assetId else Constants.CapturesAssetId,
                imageStyle = if FFlagMomentsFtuxEducationScreenRefresh then var3.Color.Content.Emphasis else nil,
                LayoutOrder = 1,
                ScaleType = Enum.ScaleType.Fit,
                Size = if var4 == FormFactor.Wide then UDim2.fromScale(0.7, 0.39375) else UDim2.fromScale(0.6, 0.33749999999999997),
                SizeConstraint = Enum.SizeConstraint.RelativeXX
            }),
            Title = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = var1.title,
                    tag = "auto-xy text-heading-large text-align-x-center content-emphasis"
                }
            ),
            Description = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 3,
                    Text = var1.description,
                    tag = "auto-xy text-body-large text-align-x-center content-muted"
                }
            ),
            ButtonArea = 0
        }

        local createElement5 = React.createElement
        local var14 = View
        local tbl11 = { LayoutOrder = 4, tag = "col align-x-center gap-medium size-full-0 auto-y" }

        local tbl12 = {
            HowToCaptureButton = React.createElement(Button, {
                fillBehavior = if FFlagMomentsFtuxEducationScreenRefresh then nil else Foundation.Enums.FillBehavior.Fill,
                LayoutOrder = 1,
                onActivated = onActivated,
                size = Foundation.Enums.InputSize.Large,
                text = var1.howToCapture,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                width = if FFlagMomentsFtuxEducationScreenRefresh then nil else UDim.new(1, 0)
            }),
            BackButton = 0
        }
        local element2

        if FFlagMomentsFtuxEducationScreenRefresh then
            element2 = nil
        else
            element2 = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                LayoutOrder = 2,
                onActivated = tbl2.onClose,
                size = Foundation.Enums.InputSize.Large,
                text = var1.back,
                variant = Foundation.Enums.ButtonVariant.Standard,
                width = UDim.new(1, 0)
            })
        end

        tbl12.BackButton = element2
        tbl10.ButtonArea = createElement5(var14, tbl11, tbl12)
        tbl6.Body = createElement4(var13, tbl9, tbl10)
        var10 = createElement2(var11, tbl5, tbl6)
    end

    tbl4.EducationCard = var10

    tbl4.HowToCard = if var5 then React.createElement(HowToCaptureModal, { onClose = onClose }) else nil
    return createElement(var9, tbl3, tbl4)
end

return FTUXEducationScreen
