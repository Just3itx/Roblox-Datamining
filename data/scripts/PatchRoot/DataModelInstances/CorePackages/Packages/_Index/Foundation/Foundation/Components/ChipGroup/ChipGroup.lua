-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local ChipGroupVariant = require(Foundation.Enums.ChipGroupVariant)

local Flags = require(Foundation.Utility.Flags)

local ChipSize = require(Foundation.Enums.ChipSize)

local _ChipVariant = require(Foundation.Enums.ChipVariant)

local _Accessory = require(Foundation.Components.Chip.Accessory)

local Visibility = require(Foundation.Enums.Visibility)

local useBackgroundStyle = require(Foundation.Providers.Style.BackgroundStyleContext).useBackgroundStyle

local Chip = require(Foundation.Components.Chip)
local OverflowScrollContainer = require(Foundation.Components.OverflowScrollContainer)
local ScrollView = require(Foundation.Components.ScrollView)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useChipGroupVariants = require(Foundation.Components.ChipGroup.useChipGroupVariants)
local useClippingRect = require(Foundation.Components.ChipGroup.useClippingRect)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local numberSequence = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) }
)

local numberSequence2 = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0) }
)

local tbl1 = {
    size = ChipSize.Medium,
    variant = ChipGroupVariant.Row,
    testId = "--foundation-chip-group"
}

local function Scrim(tbl2)
    local backgroundStyle = useBackgroundStyle()

    return React.createElement(
        View,
        {
            LayoutOrder = tbl2.LayoutOrder,
            Size = UDim2.new(0, tbl2.width, 1, 0),
            backgroundStyle = backgroundStyle,
            testId = tbl2.testId
        },
        {
            UIGradient = React.createElement("UIGradient", { Transparency = tbl2.gradient })
        }
    )
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: ChipGroup
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local var3 = useChipGroupVariants(var2, var1.variant, var1.size)

    if Flags.FoundationUnifiedScrimScrolling then
        local size = var1.size
        local tbl2 = ({})
        for layoutOrder, chip in var1.chips do
            local str1 = `Chip{layoutOrder}`
            tbl2[str1] = React.createElement(Chip, {
                text = chip.text,
                leading = chip.leading,
                trailing = chip.trailing,
                onActivated = chip.onActivated,
                isChecked = chip.isChecked,
                variant = chip.variant,
                size = size,
                LayoutOrder = layoutOrder,
                testId = `{var1.testId}--chip-{layoutOrder}`
            })
        end

        local chipContainer = React.createElement(View, {
            tag = "auto-xy",
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var3.gap),
                Wraps = var3.isWrapped
            }
        }, tbl2)

        if var3.isWrapped then
            return React.createElement(
                View,
                withCommonProps(var1, { tag = "size-full-0 auto-y", ref = ref }),
                { ChipContainer = chipContainer }
            )
        end

        return React.createElement(
            OverflowScrollContainer,
            withCommonProps(var1, { size = var1.size, ref = ref }),
            { ChipContainer = chipContainer }
        )
    end
    local var4, var5 = React.useBinding(false)
    local var6, var7 = React.useBinding(false)
    local scrollingFrameRef = React.useRef(nil)
    local var9 = useClippingRect(scrollingFrameRef)

    local var10 = React.useCallback(function(arg2)
        if not var3.hasScrim or arg2.AbsoluteWindowSize.X == 0 then
            return
        end

        var5(arg2.CanvasPosition.X ~= 0)
        var7(arg2.AbsoluteWindowSize.X + arg2.CanvasPosition.X < arg2.AbsoluteCanvasSize.X - 1)
    end, { var3.hasScrim })

    local onAbsoluteSizeChanged = React.useCallback(function()
        if scrollingFrameRef.current then
            var10(scrollingFrameRef.current)
        end
    end, { var1.onAbsoluteSizeChanged, var10 })

    local onAbsolutePositionChanged = React.useCallback(function()
        if scrollingFrameRef.current then
            var10(scrollingFrameRef.current)
        end
    end, { var1.onAbsolutePositionChanged, var10 })

    local size = var1.size
    local scrimWidth = var3.scrimWidth
    local tbl2 = ({})
    for layoutOrder, chip in var1.chips do
        local str1 = `Chip{layoutOrder}`
        tbl2[str1] = React.createElement(Chip, {
            text = chip.text,
            leading = chip.leading,
            trailing = chip.trailing,
            onActivated = chip.onActivated,
            isChecked = chip.isChecked,
            variant = chip.variant,
            size = size,
            LayoutOrder = layoutOrder,
            testId = `{var1.testId}--chip-{layoutOrder}`
        })
    end

    local var13 = withCommonProps(var1, { ref = ref, tag = "size-full-0 auto-y" })

    var13.onAbsoluteSizeChanged = onAbsoluteSizeChanged
    var13.onAbsolutePositionChanged = onAbsolutePositionChanged

    local createElement = React.createElement
    local var14 = View
    local tbl3 = {
        ScrollView = React.createElement(ScrollView, {
            tag = "size-full-0 auto-y",
            scroll = {
                AutomaticSize = Enum.AutomaticSize.Y,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.fromScale(0, 1),
                ScrollingDirection = Enum.ScrollingDirection.X,
                ScrollingEnabled = not var3.isWrapped,
                scrollBarVisibility = Visibility.None
            },
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var3.gap),
                Wraps = var3.isWrapped
            },
            ClipsDescendants = var3.isWrapped,
            scrollingFrameRef = scrollingFrameRef,
            onCanvasPositionChanged = if var3.hasScrim then var10 else nil,
            onAbsoluteCanvasSizeChanged = if var3.hasScrim then var10 else nil,
            onAbsoluteWindowSizeChanged = if var3.hasScrim then var10 else nil
        }, tbl2),
        ScrimWrapper = 0
    }
    local element

    if var3.hasScrim then
        element = React.createElement(View, {
            tag = "row flex-between",
            Size = var9:map(function(rect: Rect): UDim2
                return UDim2.fromOffset(rect.Max.X - rect.Min.X, scrimWidth)
            end),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0),
            ZIndex = 2
        }, {
            ScrimStart = var4
                and React.createElement(
                    Scrim,
                    {
                        LayoutOrder = 1,
                        gradient = numberSequence,
                        width = scrimWidth,
                        testId = `{var1.testId}--scrim-start`
                    }
                ),
            ScrimEnd = var6
                and React.createElement(
                    Scrim,
                    {
                        LayoutOrder = 2,
                        gradient = numberSequence2,
                        width = scrimWidth,
                        testId = `{var1.testId}--scrim-end`
                    }
                )
        })
    else
        element = nil
    end

    tbl3.ScrimWrapper = element
    return createElement(var14, var13, tbl3)
end))
