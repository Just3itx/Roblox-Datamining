-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local SlideTransitionContext = require(GenericAbuseReporting.BeduiV2.Components.SlideTransitionContext)
local Subtitle = require(GenericAbuseReporting.BeduiV2.Components.Subtitle)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)

local Sheet = Foundation.Sheet
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local useIsSlideAnimating = SlideTransitionContext.useIsSlideAnimating

local context = React.createContext(false)

local function useShouldUseOverlaidControls() -- Luacid: Inlined by compiler; 1 call site recovered
    return React.useContext(context)
end

local Title = React.forwardRef(function(tbl1, _)
    return React.createElement(
        TextWithTranslation,
        {
            input = tbl1.input,
            tag = "size-full-0 auto-y text-heading-medium",
            layoutOrder = tbl1.layoutOrder
        }
    )
end)
local var1 = React.forwardRef(function(tbl1, _)
    return React.createElement(View, {
        tag = "col gap-xsmall size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder
    }, {
        Title = React.createElement(
            TextWithTranslation,
            {
                input = tbl1.input,
                tag = "size-full-0 auto-y text-title-large",
                layoutOrder = tbl1.layoutOrder
            }
        ),
        Subtitle = tbl1.subtitle
            and React.createElement(
                Subtitle,
                {
                    subtitle = tbl1.subtitle,
                    layoutOrder = if tbl1.layoutOrder then tbl1.layoutOrder + 1 else 2
                }
            )
    })
end)

local sheetSlots = {
    Title = Title,
    Layout = React.forwardRef(function(tbl1, ref)
        return React.createElement(React.Fragment, nil, {
            Content = React.createElement(Sheet.Content, { ref = ref, isContentFullBleed = tbl1.isContentFullBleed }, tbl1.body),
            Actions = if tbl1.actions == nil then nil else React.createElement(Sheet.Actions, nil, tbl1.actions)
        })
    end),
    ContentInset = React.forwardRef(function(tbl1, _)
        return React.createElement(
            View,
            {
                tag = "col gap-medium size-full-0 auto-y padding-x-xlarge",
                LayoutOrder = tbl1.layoutOrder
            },
            tbl1.children
        )
    end)
}

local inlineSlots = {
    Title = var1,
    Layout = React.forwardRef(function(tbl2, ref)
        local var3 = useShouldUseOverlaidControls()

        local var4 = useTokens()
        local scrollBarImageTransparency = useIsSlideAnimating():map(function(bool1: boolean): number
            return if bool1 then 1 else 0
        end)

        local createElement = React.createElement
        local var6 = View
        local tbl3 = { tag = "col size-full", ref = ref }
        local tbl4 = {
            BodyWrapper = React.createElement(
                View,
                { tag = "fill size-full-0", LayoutOrder = 1 },
                React.createElement(
                    "ScrollingFrame",
                    {
                        Size = UDim2.new(1, 0, 1, 0),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.new(1, 0, 0, 0),
                        ZIndex = 2,
                        ScrollingDirection = Enum.ScrollingDirection.Y,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Selectable = false,
                        ScrollBarThickness = 1,
                        ScrollBarImageTransparency = scrollBarImageTransparency
                    },
                    React.createElement(
                        View,
                        {
                            tag = {
                                ["align-x-center size-full-0 auto-y margin-bottom-medium"] = true,
                                ["padding-top-large"] = var3
                            }
                        },
                        React.createElement(View, {
                            Size = if var3 then UDim2.new(0, 468 * var4.Config.UI.Scale, 0, 0) else nil,
                            tag = {
                                ["col gap-medium auto-y"] = true,
                                ["size-full-0"] = not var3
                            }
                        }, {
                            Body = tbl2.body,
                            LandscapeActions = if var3 and tbl2.actions ~= nil then React.createElement(View, { tag = "auto-xy padding-bottom-small padding-top-small", LayoutOrder = 1000 }, tbl2.actions) else nil
                        })
                    )
                )
            ),
            PortraitActionsWrapper = if var3 or tbl2.actions == nil then nil else React.createElement(
                View,
                { tag = "align-x-center size-full-0 auto-y padding-bottom-small", LayoutOrder = 2 },
                React.createElement(
                    View,
                    { tag = "row gap-medium position-bottom-center size-full-0 auto-y", ZIndex = 2 },
                    tbl2.actions
                )
            )
        }
        return createElement(var6, tbl3, tbl4)
    end),
    ContentInset = React.forwardRef(function(tbl2, _)
        return React.createElement(View, { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = tbl2.layoutOrder }, tbl2.children)
    end)
}

local context2 = React.createContext(sheetSlots)

return {
    sheetSlots = sheetSlots,
    inlineSlots = inlineSlots,
    LayoutSlotsProvider = function(tbl3)
        return React.createElement(context2.Provider, { value = tbl3.slots }, tbl3.children)
    end,
    useLayoutSlots = function()
        return React.useContext(context2)
    end,
    OverlaidControlsProvider = function(tbl3)
        return React.createElement(context.Provider, { value = tbl3.value }, tbl3.children)
    end,
    useShouldUseOverlaidControls = useShouldUseOverlaidControls,
    INLINE_LANDSCAPE_WIDTH = 468
}
