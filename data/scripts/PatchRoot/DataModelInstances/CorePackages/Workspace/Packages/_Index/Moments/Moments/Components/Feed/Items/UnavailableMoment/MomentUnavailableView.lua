-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconSize = Foundation.Enums.IconSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    title = "Feature.Moments.Label.MomentRemovedTitle",
    body = "Feature.Moments.Label.MomentRemovedBody"
}

local tbl2 = {
    title = "Feature.Moments.Label.MomentUnavailable",
    body = "Feature.Moments.Label.MomentUnavailableDefault"
}

local tbl3 = {
    duration = 0.75,
    easingStyle = {
        0.37,
        0,
        0.63,
        1
    }
}

local function MomentUnavailableView(tbl4)
    local var1 = useTokens()
    local var2 = useLocalization(if tbl4.isModerated then tbl1 else tbl2)
    local animate = tbl4.animate

    local var3 = React.useRef(animate)
    local var4 = React.useRef(nil)
    local var5 = React.useCallback(function(num1: number)
        local current = var4.current
        if var3.current and current ~= nil then
            current(ReactOtter.ease(if num1 >= 0.5 then 0 else 1, tbl3))
        end
    end, {})
    local var6, current = ReactOtter.useAnimatedBinding(0, var5)

    React.useEffect(function()
        var3.current = animate
        var4.current = current
        if animate then
            current(ReactOtter.ease(1, tbl3))
            return
        end
        current(ReactOtter.instant(0))
    end, { animate, current })

    local var8 = 8 / var1.Size.Size_1200
    local var9 = var6:map(function(num1: number): UDim2
        return UDim2.fromScale(0.5, 0.5 + num1 * var8)
    end)

    return React.createElement(
        View,
        {
            LayoutOrder = tbl4.LayoutOrder,
            tag = "size-full bg-surface-0",
            testId = "moments-unavailable-moment"
        },
        {
            Content = React.createElement(
                View,
                { tag = "col align-x-center align-y-center size-full padding-x-xlarge", ZIndex = 1 },
                {
                    TextBlock = React.createElement(
                        View,
                        {
                            tag = "col align-x-center gap-small size-full-0 auto-y",
                            sizeConstraint = {
                                MaxSize = Vector2.new(420, math.huge)
                            }
                        },
                        {
                            Title = React.createElement(FoundationText, {
                                LayoutOrder = 1,
                                Text = var2.title,
                                tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-emphasis"
                            }),
                            Body = React.createElement(FoundationText, {
                                LayoutOrder = 2,
                                Text = var2.body,
                                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-center content-default"
                            })
                        }
                    )
                }
            ),
            NextAffordance = React.createElement(View, {
                tag = "position-bottom-center anchor-bottom-center auto-xy",
                padding = {
                    bottom = UDim.new(0, (tbl4.bottomInset or 0) + var1.Padding.Small)
                },
                ZIndex = 2
            }, {
                NextButton = React.createElement(View, {
                    tag = "size-1200 radius-circle",
                    onActivated = tbl4.onNext,
                    stateLayer = {
                        affordance = StateLayerAffordance.None
                    },
                    testId = "moments-unavailable-next"
                }, {
                    Arrow = React.createElement(Icon, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = var9,
                        name = BuilderIcons.Icon.DoubleChevronLargeDown,
                        size = IconSize.Large,
                        style = var1.Color.Content.Emphasis,
                        testId = "moments-unavailable-next-arrow"
                    })
                })
            })
        }
    )
end

return MomentUnavailableView
