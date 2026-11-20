-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local View = Foundation.View

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = React.useContext(CreationFlowContext)

    local onActivated = useCallback(function()
        if tbl1.onTextOverlayDiscard then
            tbl1.onTextOverlayDiscard()
        end
    end, { tbl1.onTextOverlayDiscard })

    local var4 = useCallback(function()
        if tbl1.onTextOverlaySave then
            tbl1.onTextOverlaySave()
        end
    end, { tbl1.onTextOverlaySave })

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center auto-y align-y-bottom anchor-bottom-center col gap-large position-bottom-center size-full-0"
    }
    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, var2.Padding.Small),
            PaddingBottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Small)),
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }),
        Nav = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "align-x-center align-y-center auto-y gap-small row size-full-0 flex-x-between"
            },
            {
                BackButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 1,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaBack),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = onActivated,
                    size = Foundation.Enums.InputSize.Medium
                }),
                DoneButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fit,
                    LayoutOrder = 2,
                    text = var3.getLocalization(CreationFlowLocalization.GeneralCtaDone),
                    variant = Foundation.Enums.ButtonVariant.Text,
                    onActivated = var4,
                    size = Foundation.Enums.InputSize.Medium
                })
            }
        )
    }
    return createElement(var6, tbl2, tbl3)
end
