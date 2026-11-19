-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:30:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local InputSize = require(Foundation.Enums.InputSize)

local IconButton = require(Foundation.Components.IconButton)
local View = require(Foundation.Components.View)
local _useCardVariants = require(script.Parent.Parent.useCardVariants)

local Icon = BuilderIcons.Icon
local Small = InputSize.Small

local function CardActions(tbl1)
    local variantProps = tbl1.variantProps

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = variantProps.actions.tag,
        AnchorPoint = if tbl1.isInline then nil else Vector2.new(1, 0),
        Position = if tbl1.isInline then nil else UDim2.fromScale(1, 0),
        LayoutOrder = if tbl1.isInline then 2 else nil,
        ZIndex = 2,
        testId = `{tbl1.testId}--actions`
    }
    local tbl3 = { Overflow = 0, Close = 0 }
    local element

    if tbl1.onOverflow then
        element = React.createElement(IconButton, {
            onActivated = tbl1.onOverflow,
            icon = Icon.ThreeDotsHorizontal,
            variant = if tbl1.isOverMedia then ButtonVariant.OverMedia else ButtonVariant.Utility,
            size = Small,
            isCircular = true,
            ref = tbl1.overflowRef,
            LayoutOrder = 1,
            testId = `{tbl1.testId}--overflow`
        })
    else
        element = nil
    end

    tbl3.Overflow = element
    local element2 = if tbl1.onClose then React.createElement(IconButton, {
        onActivated = tbl1.onClose,
        icon = Icon.X,
        variant = if tbl1.isOverMedia then ButtonVariant.OverMedia else ButtonVariant.Utility,
        size = Small,
        isCircular = true,
        LayoutOrder = 2,
        testId = `{tbl1.testId}--close`
    }) else nil
    tbl3.Close = element2
    return createElement(var1, tbl2, tbl3)
end

return CardActions
