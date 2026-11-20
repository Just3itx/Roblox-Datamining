-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local View = Foundation.View

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = React.useContext(CreationFlowContext)

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center auto-y size-full-0"
    }
    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var2.Padding.Large),
            PaddingBottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Large)),
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }),
        SizeConstraint = 0
    }

    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        sizeConstraint = {
            MaxSize = Constants.BottomBarSizeConstraint
        },
        tag = "align-x-center auto-y gap-small row size-full-0"
    }

    local tbl5 = {
        ContinueButton = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 1,
            onActivated = tbl1.onContinueCallback,
            size = InputSize.Medium,
            text = var3.getLocalization(CreationFlowLocalization.PublishingCtaContinue),
            variant = ButtonVariant.Emphasis,
            width = UDim.new(0.5, 0)
        }),
        ReturnToGalleryButton = 0
    }
    local element

    if tbl1.onReturnToGalleryCallback then
        element = React.createElement(Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 2,
            text = var3.getLocalization(CreationFlowLocalization.PublishingCtaReturn),
            variant = ButtonVariant.Standard,
            width = UDim.new(0.5, 0),
            onActivated = tbl1.onReturnToGalleryCallback,
            size = InputSize.Medium
        })
    else
        element = nil
    end

    tbl5.ReturnToGalleryButton = element
    tbl3.SizeConstraint = createElement2(var5, tbl4, tbl5)
    return createElement(var4, tbl2, tbl3)
end
