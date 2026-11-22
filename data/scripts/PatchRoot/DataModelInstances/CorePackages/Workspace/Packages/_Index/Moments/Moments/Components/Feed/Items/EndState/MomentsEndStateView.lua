-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)

local Button = Foundation.Button
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize

local useFormFactor = MomentsCommon.Hooks.useFormFactor
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens
local FormFactor = MomentsCommon.Enums.FormFactor

local tbl1 = {
    title = "Feature.Moments.Label.NonInfiniteScrollEndTitle",
    description = "Feature.Moments.Description.NonInfiniteScrollEndBody",
    loadMore = "Feature.Moments.Action.Continue"
}

local tbl2 = {
    title = "Feature.Moments.Label.FeedEndTitle",
    description = "Feature.Moments.Label.FeedEndBody"
}

local function resolveLocalized(str1: string?, str2: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return if str1 == nil or str1 == "" then str2 else str1
end

local function MomentsEndStateView(tbl3)
    local var1 = useTokens()
    local bool1 = useFormFactor() == FormFactor.Wide
    local bool2 = tbl3.showLoadMore ~= false

    local var2 = useLocalization(if bool2 then tbl1 else tbl2)

    local str1 = resolveLocalized(var2.title, "There are more Moments to watch")
    local str2 = resolveLocalized(var2.description, "We've paused your feed. You can decide if you'd like to continue watching.")
    local text = resolveLocalized(var2.loadMore, "Continue")

    local createElement = React.createElement
    local var3 = View
    local tbl4 = {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "col align-x-center align-y-center gap-xxlarge size-full clip bg-surface-0"
    }
    local tbl5 = { Content = 0 }
    local createElement2 = React.createElement
    local var4 = View
    local tbl6 = {
        tag = "col align-x-center gap-xxlarge size-full-0 auto-y",
        sizeConstraint = {
            MaxSize = if bool1 then Vector2.new(420, math.huge) else nil
        }
    }
    local tbl7 = {
        TextBlock = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col align-x-center gap-medium size-full-0 auto-y"
        }, {
            Graphic = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    tag = "align-x-center align-y-center size-full-0 auto-y",
                    Size = UDim2.new(1, 0, 0, 180)
                },
                {
                    IconCluster = React.createElement(View, {
                        tag = "position-center-center anchor-center-center",
                        Size = UDim2.fromOffset(94, 94),
                        testId = "moments-end-state-icon-cluster"
                    }, {
                        TiltFrame = React.createElement(View, {
                            tag = "position-center-center anchor-center-center stroke-standard stroke-default radius-large",
                            Size = UDim2.fromOffset(115, 115),
                            Rotation = -15,
                            testId = "moments-end-state-tilt-frame",
                            ZIndex = 1
                        }),
                        Glyph = React.createElement(Icon, {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            name = "icons/brands/moments_large",
                            size = IconSize.Large,
                            style = var1.Color.Content.Emphasis,
                            testId = "moments-end-state-brand-icon",
                            ZIndex = 2
                        })
                    })
                }
            ),
            Title = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = str1,
                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
            }),
            Description = React.createElement(FoundationText, {
                LayoutOrder = 3,
                Text = str2,
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
            })
        }),
        ButtonGroup = 0
    }
    local element

    if bool2 then
        element = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col align-x-center gap-small auto-y",
                Size = UDim2.fromOffset(200, 0)
            },
            {
                LoadMore = React.createElement(Button, {
                    LayoutOrder = 1,
                    fillBehavior = FillBehavior.Fill,
                    onActivated = tbl3.onLoadMore,
                    size = InputSize.Medium,
                    text = text,
                    testId = "moments-end-state-load-more",
                    variant = ButtonVariant.Standard,
                    width = UDim.new(1, 0)
                })
            }
        )
    else
        element = nil
    end

    tbl7.ButtonGroup = element
    tbl5.Content = createElement2(var4, tbl6, tbl7)
    return createElement(var3, tbl4, tbl5)
end

return MomentsEndStateView
