-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobuxPill = script:FindFirstAncestor("RobuxPill")
local RobuxPillParent = RobuxPill.Parent
local React = require(RobuxPillParent.React)
local Foundation = require(RobuxPillParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Button = Foundation.Button
local Skeleton = Foundation.Skeleton
local FillBehavior = Foundation.Enums.FillBehavior
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius

local FFlagRobuxPillSingleFocusTarget = require(RobuxPill.Flags.FFlagRobuxPillSingleFocusTarget)

local function numWithCommas(robuxBalance: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return tostring(robuxBalance):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

return React.memo(React.forwardRef(function(tbl1, ref) -- name: RobuxPill
    local var1 = useTokens()
    local var2 = tbl1.showBorder == nil or tbl1.showBorder
    local selectable = not FFlagRobuxPillSingleFocusTarget and nil
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = {
            ["size-full-1400 padding-medium"] = tbl1.isCompact == true,
            ["size-full-0 auto-y"] = tbl1.isCompact ~= true,
            ["padding-xlarge"] = not tbl1.isCompact and var2,
            ["padding-x-medium padding-y-xlarge"] = not (tbl1.isCompact or var2)
        },
        onActivated = tbl1.onBuyActivated,
        LayoutOrder = tbl1.layoutOrder,
        ref = ref,
        testId = "robux-pill",
        stroke = var2
            and {
                Color = var1.Color.Stroke.Default.Color3,
                Transparency = var1.Color.Stroke.Default.Transparency,
                Thickness = var1.Stroke.Standard
            }
            or nil,
        cornerRadius = if var2 then UDim.new(0, var1.Radius.Medium) else nil
    }
    local tbl3 = { RobuxContainer = 0, BuyRobuxButton = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = {
            ["row align-y-center position-center-left anchor-center-left auto-xy"] = true,
            ["gap-medium"] = tbl1.isCompact == true,
            ["gap-small"] = tbl1.isCompact ~= true
        },
        testId = "robux-container"
    }

    local tbl5 = {
        RobuxIcon = React.createElement(Icon, {
            name = IconName.Robux,
            size = if tbl1.isCompact then IconSize.Large else IconSize.Medium,
            LayoutOrder = 1,
            testId = "robux-icon"
        }),
        RobuxAmount = 0
    }
    local element

    if tbl1.robuxBalance == nil then
        element = React.createElement(
            Foundation.View,
            { tag = "size-2500-800", LayoutOrder = 2 },
            {
                Skeleton = React.createElement(Skeleton, { radius = Radius.Medium, testId = "robux-balance-skeleton" })
            }
        )
    else
        element = React.createElement(FoundationText, {
            Size = UDim2.new(0.5, 0, 0, 0),
            tag = {
                ["auto-y text-align-x-left text-truncate-end content-emphasis"] = true,
                ["text-heading-small"] = tbl1.isCompact == true,
                ["text-title-large"] = tbl1.isCompact ~= true
            },
            Text = numWithCommas(tbl1.robuxBalance),
            LayoutOrder = 2
        })
    end

    tbl5.RobuxAmount = element
    tbl3.RobuxContainer = createElement2(view2, tbl4, tbl5)
    local element2

    if tbl1.isCompact then
        element2 = React.createElement(Foundation.View, {
            Position = UDim2.new(1, 0, 0.5, 0),
            tag = "anchor-center-right auto-xy",
            sizeConstraint = {
                MinSize = Vector2.new(84, 0)
            },
            testId = "buy-robux-button-container"
        }, {
            Button = React.createElement(Button, {
                text = tbl1.buyButtonText,
                size = InputSize.Small,
                Selectable = selectable,
                onActivated = tbl1.onBuyActivated,
                fillBehavior = FillBehavior.Fill
            })
        })
    else
        element2 = React.createElement(Button, {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            text = tbl1.buyButtonText,
            size = InputSize.Small,
            Selectable = selectable,
            onActivated = tbl1.onBuyActivated
        })
    end

    tbl3.BuyRobuxButton = element2
    return createElement(view, tbl2, tbl3)
end))
