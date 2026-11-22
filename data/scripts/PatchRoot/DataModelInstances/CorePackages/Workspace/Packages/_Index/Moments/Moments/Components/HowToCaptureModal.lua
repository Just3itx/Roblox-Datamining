-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local FormFactor = MomentsCommon.Enums.FormFactor
local Constants = require(Moments.Constants)
local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent

local tbl1 = {
    title = "Feature.Moments.Label.HowToUseCaptureTitle",
    step1 = "Feature.Moments.Description.HowToCaptureStep1",
    step2 = "Feature.Moments.Description.HowToCaptureStep2",
    step3 = "Feature.Moments.Description.HowToCaptureStep3",
    back = "Feature.Moments.Action.Back",
    done = "Feature.Moments.Action.Done",
    next = "Feature.Moments.Action.Continue"
}

local tbl2 = {
    {
        image = Constants.HowToCaptureModalSteps.image1,
        descriptionKey = "step1"
    },
    {
        image = Constants.HowToCaptureModalSteps.image2,
        descriptionKey = "step2"
    },
    {
        image = Constants.HowToCaptureModalSteps.image3,
        descriptionKey = "step3"
    }
}

local function HowToCaptureModal(tbl3)
    local var1 = useLocalization(tbl1)
    local var2 = useDeviceInsets()
    local var3 = useTokens()
    local var4 = useFormFactor()

    local var5, var6 = React.useState(1)

    local var7 = React.useRef({ true })

    React.useEffect(function()
        if not var7.current[var5] then
            var7.current[var5] = true
            fireAnalyticsEvent(EventNames.FTUXHowToCaptureCarouselImpression)
        end
    end, { var5 })

    local onActivated = React.useCallback(function()
        var6(function(arg1): number
            return math.max(1, arg1 - 1)
        end)
    end, {})

    local var9 = React.useCallback(function()
        var6(function(arg1): number
            return math.min(#tbl2, arg1 + 1)
        end)
    end, {})

    local var10 = tbl2[var5]

    local tbl4 = ({})
    for layoutOrder = 1, #tbl2 do
        local str1 = "dot_" .. layoutOrder
        tbl4[str1] = React.createElement(View, {
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(8, 8),
            tag = {
                ["radius-circle bg-system-contrast"] = layoutOrder == var5,
                ["radius-circle bg-system-emphasis"] = layoutOrder ~= var5
            }
        })
    end

    local createElement = React.createElement
    local var11 = View
    local tbl5 = {
        tag = "position-center-center anchor-center-center size-full-full radius-large bg-surface-0",
        sizeConstraint = {
            MaxSize = if var4 == FormFactor.Wide then Vector2.new(600, 700) else nil
        }
    }
    local tbl6 = {
        CloseButtonContainer = React.createElement(View, {
            padding = {
                top = UDim.new(0, var2.top + var3.Padding.Medium),
                right = UDim.new(0, var2.right + var3.Padding.Medium)
            },
            tag = "position-top-right anchor-top-right auto-xy"
        }, {
            CloseButton = React.createElement(
                View,
                {
                    onActivated = tbl3.onClose,
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
        }),
        Body = 0
    }

    local createElement2 = React.createElement
    local var12 = View
    local tbl7 = {
        padding = {
            top = UDim.new(0, var2.top + var3.Padding.XLarge),
            bottom = UDim.new(0, math.max(var2.bottom, var3.Padding.Medium)),
            left = UDim.new(0, math.max(var2.left, var3.Padding.Large)),
            right = UDim.new(0, math.max(var2.right, var3.Padding.Large))
        },
        tag = "col align-x-center align-y-center gap-large size-full"
    }

    local tbl8 = {
        Title = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var1.title,
            tag = "size-full-0 auto-y text-heading-large text-wrap text-align-x-center content-emphasis"
        }),
        StepImage = React.createElement(Image, {
            Image = var10.image,
            LayoutOrder = 2,
            ScaleType = Enum.ScaleType.Fit,
            Size = UDim2.fromScale(0.8, 0.45),
            SizeConstraint = Enum.SizeConstraint.RelativeXX
        }),
        Dots = React.createElement(View, { LayoutOrder = 3, tag = "row align-x-center align-y-center gap-small auto-xy" }, tbl4),
        Description = React.createElement(FoundationText, {
            LayoutOrder = 4,
            Text = var1[var10.descriptionKey],
            tag = "size-full-0 auto-y text-body-large text-wrap text-align-x-center content-muted"
        }),
        Nav = 0
    }

    local createElement3 = React.createElement
    local var13 = View
    local tbl9 = {
        LayoutOrder = 5,
        tag = "row align-x-center align-y-center gap-medium size-full-0 auto-y"
    }

    local tbl10 = { BackButton = 0, NextButton = 0 }
    local element

    if var5 > 1 then
        element = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 1,
            onActivated = onActivated,
            size = Foundation.Enums.InputSize.Large,
            text = var1.back,
            variant = Foundation.Enums.ButtonVariant.Standard,
            width = UDim.new(1, 0)
        })
    else
        element = nil
    end

    tbl10.BackButton = element

    local createElement4 = React.createElement
    local var14 = Button
    local tbl11 = {
        fillBehavior = Foundation.Enums.FillBehavior.Fill,
        LayoutOrder = 2,
        onActivated = 0,
        size = 0,
        text = 0,
        variant = 0,
        width = 0
    }
    if not (var5 < #tbl2) then
        var9 = tbl3.onClose
    end

    tbl11.onActivated = var9
    tbl11.size = Foundation.Enums.InputSize.Large
    tbl11.text = if var5 < #tbl2 then var1.next else var1.done
    tbl11.variant = Foundation.Enums.ButtonVariant.Emphasis
    tbl11.width = UDim.new(1, 0)
    tbl10.NextButton = createElement4(var14, tbl11)
    tbl8.Nav = createElement3(var13, tbl9, tbl10)
    tbl6.Body = createElement2(var12, tbl7, tbl8)
    return createElement(var11, tbl5, tbl6)
end

return HowToCaptureModal
