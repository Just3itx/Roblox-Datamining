-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local View = Foundation.View

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local Constants = require(MomentsCreation.Constants)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()

    local publishingCtaReturn = var3.PublishingCtaReturn

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center size-full-0 auto-y",
        padding = {
            top = UDim.new(0, var2.Padding.Large),
            bottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Large)),
            left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }
    }
    local tbl3 = {
        SizeConstraint = React.createElement(View, {
            sizeConstraint = {
                MaxSize = Constants.BottomBarSizeConstraint
            },
            tag = "row align-x-center gap-small size-full-0 auto-y"
        }, {
            ContinueButton = React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                LayoutOrder = 1,
                onActivated = tbl1.onContinueCallback,
                size = InputSize.Medium,
                text = var3.PublishingCtaContinue,
                variant = ButtonVariant.Emphasis,
                width = UDim.new(0.5, 0)
            }),
            ReturnToGalleryButton = if tbl1.onReturnToGalleryCallback then React.createElement(Button, {
                fillBehavior = Foundation.Enums.FillBehavior.Fill,
                LayoutOrder = 2,
                text = publishingCtaReturn,
                variant = ButtonVariant.Standard,
                width = UDim.new(0.5, 0),
                onActivated = tbl1.onReturnToGalleryCallback,
                size = InputSize.Medium
            }) else nil
        })
    }
    return createElement(var4, tbl2, tbl3)
end
