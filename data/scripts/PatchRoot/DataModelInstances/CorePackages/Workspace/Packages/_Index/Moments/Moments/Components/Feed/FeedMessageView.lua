-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local FoundationCloudAssets = require(MomentsParent.FoundationCloudAssets)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local FFlagMomentsParentTimeLimit = MomentsCommon.Flags.FFlagMomentsParentTimeLimit

local Button = Foundation.Button
local Icon = Foundation.Icon
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useTokens = Foundation.Hooks.useTokens
local FormFactor = MomentsCommon.Enums.FormFactor

local function renderGraphic(tbl1, emphasis)
    if tbl1.pictogram ~= nil then
        local asset = FoundationCloudAssets.Assets[tbl1.pictogram]
        return React.createElement(Image, {
            LayoutOrder = 1,
            Image = asset.assetId,
            aspectRatio = asset.size.X / asset.size.Y,
            imageStyle = emphasis,
            tag = "size-full-0",
            Size = UDim2.new(1, 0, 0, 199),
            testId = "--moments-feed-message--pictogram"
        })
    end

    local iconName = tbl1.iconName
    if iconName == nil then
        return nil
    end

    local element = React.createElement(Icon, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        name = iconName,
        size = tbl1.iconSize or IconSize.Large,
        style = emphasis,
        testId = "--moments-feed-message--icon",
        ZIndex = 2
    })

    local frameRadiusTag = FFlagMomentsParentTimeLimit and tbl1.frameRadiusTag or "radius-large"

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = 1,
        tag = "size-full-0",
        Size = UDim2.new(1, 0, 0, if tbl1.tilted then 180 else 140)
    }
    local tbl3 = { Cluster = 0 }
    if tbl1.tilted then
        element = React.createElement(
            View,
            {
                tag = "position-center-center anchor-center-center",
                Size = UDim2.fromOffset(94, 94)
            },
            {
                TiltFrame = React.createElement(View, {
                    tag = `position-center-center anchor-center-center stroke-standard stroke-default {frameRadiusTag}`,
                    Size = UDim2.fromOffset(115, 115),
                    Rotation = -15,
                    testId = "--moments-feed-message--tilt-frame",
                    ZIndex = 1
                }),
                Glyph = element
            }
        )
    end

    tbl3.Cluster = element
    return createElement(var1, tbl2, tbl3)
end

local function FeedMessageView(tbl1)
    local var1 = useTokens()
    local bool1 = useFormFactor() == FormFactor.Wide
    local primaryAction = tbl1.primaryAction

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col align-x-center gap-xxlarge size-full-0 auto-y",
        sizeConstraint = {
            MaxSize = if bool1 then Vector2.new(420, math.huge) else nil
        },
        testId = tbl1.testId or "--moments-feed-message"
    }
    local tbl3 = {
        TextBlock = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col align-x-center gap-medium size-full-0 auto-y"
        }, {
            Graphic = renderGraphic(tbl1, var1.Color.Content.Emphasis),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.title,
                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = tbl1.description,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
            })
        }),
        ButtonGroup = 0
    }
    local element

    if primaryAction == nil then
        element = nil
    else
        element = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-x-center gap-small auto-xy"
        }, {
            Primary = React.createElement(Button, {
                LayoutOrder = 1,
                onActivated = primaryAction.onActivated,
                size = InputSize.Medium,
                text = primaryAction.text,
                testId = primaryAction.testId or "--moments-feed-message--primary",
                variant = ButtonVariant.Emphasis
            })
        })
    end

    tbl3.ButtonGroup = element
    return createElement(var2, tbl2, tbl3)
end

return FeedMessageView
