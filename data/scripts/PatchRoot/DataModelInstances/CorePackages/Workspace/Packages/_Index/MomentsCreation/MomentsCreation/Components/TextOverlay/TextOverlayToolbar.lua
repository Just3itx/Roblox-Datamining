-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local View = Foundation.View
local useCallback = React.useCallback
local useState = React.useState
local useTokens = Foundation.Hooks.useTokens

local EventNames = MomentsCommon.Analytics.EventNames
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)

local FFlagMomentsTextOverlayV2Redesign = MomentsCommon.Flags.FFlagMomentsTextOverlayV2Redesign
local TextAlignmentButton = require(MomentsCreation.Components.TextOverlay.TextAlignmentButton)
local TextColorButton = require(MomentsCreation.Components.TextOverlay.TextColorButton)
local TextColorSwatchRow = require(MomentsCreation.Components.TextOverlay.TextColorSwatchRow)
local TextFontButton = require(MomentsCreation.Components.TextOverlay.TextFontButton)
local TextFontRow = require(MomentsCreation.Components.TextOverlay.TextFontRow)

local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)

local function TextOverlayToolbar(tbl1)
    local controller = tbl1.controller
    local var1 = useTokens()

    local var2, var3 = useState(nil)

    local onToggle = useCallback(function()
        local var4 = if var2 ~= "Color" then "Color" else nil
        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayColorPickerToggled,
                makeCreationEventFields.makeTextOverlayEventFields({ buttonToggled = if var4 == nil then "close" else "open" })
            )
        end

        var3(var4)
    end, { var2 })

    local var4 = useCallback(function()
        local var5 = if var2 ~= "Font" then "Font" else nil
        if FFlagMomentsTextOverlayV2Redesign then
            fireAnalyticsEvent(
                EventNames.EditingFlowTextOverlayFontToolbarToggled,
                makeCreationEventFields.makeTextOverlayEventFields({ buttonToggled = if var5 == nil then "close" else "open" })
            )
        end

        var3(var5)
    end, { var2 })

    if tbl1.isKeyboardVisible or not FFlagMomentsTextOverlayV2Redesign then
        return nil
    end

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = "col align-x-center gap-medium position-bottom-center anchor-bottom-center size-full-0 auto-y",
        ZIndex = 10,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        padding = {
            bottom = UDim.new(0, var1.Padding.Large)
        }
    }
    local tbl3 = {
        IconRow = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row gap-xsmall auto-xy",
            padding = {
                left = UDim.new(0, var1.Padding.Large),
                right = UDim.new(0, var1.Padding.Large)
            }
        }, {
            FontButton = if FFlagMomentsTextOverlayV2Redesign then React.createElement(TextFontButton, { LayoutOrder = 1, expanded = var2 == "Font", onToggle = var4 }) else nil,
            ColorButton = if FFlagMomentsTextOverlayV2Redesign then React.createElement(TextColorButton, { LayoutOrder = 2, expanded = var2 == "Color", onToggle = onToggle }) else nil,
            AlignmentButton = if FFlagMomentsTextOverlayV2Redesign then React.createElement(TextAlignmentButton, { LayoutOrder = 3, controller = controller }) else nil
        }),
        SwatchRow = if FFlagMomentsTextOverlayV2Redesign and var2 == "Color" then React.createElement(TextColorSwatchRow, { LayoutOrder = 2, controller = controller }) else nil,
        FontRow = if FFlagMomentsTextOverlayV2Redesign and var2 == "Font" then React.createElement(TextFontRow, { LayoutOrder = 3, controller = controller }) else nil
    }
    return createElement(var6, tbl2, tbl3)
end

return TextOverlayToolbar
