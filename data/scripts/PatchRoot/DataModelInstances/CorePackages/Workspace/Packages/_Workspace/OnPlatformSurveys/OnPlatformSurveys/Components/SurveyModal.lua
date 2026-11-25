-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local FocusNavigationUtils = require(OnPlatformSurveysParent.FocusNavigationUtils)
local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local DialogSize = Foundation.Enums.DialogSize
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View
local useScaledValue = Foundation.Hooks.useScaledValue

local useSurveyFocusRefs = require(OnPlatformSurveys.Hooks.useSurveyFocusRefs)

return React.memo(function(tbl1) -- name: SurveyModal
    local isOpen = tbl1.isOpen ~= false
    local onClose = tbl1.onClose

    local var1, var2 = React.useState(0)
    local var3, var4 = React.useState(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize.Y)
    end, {})
    local var5 = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.Y)
    end, {})

    local var7 = useScaledValue(116)
    local centerSheetHeight = (if tbl1.children then var1 else 0) + var7 + (if tbl1.footer then var3 else 0)
    local snapPoints = React.useMemo(function()
        return { centerSheetHeight }
    end, { centerSheetHeight })

    local ref = useSurveyFocusRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, onClose)

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl2 = {
        isOpen = isOpen,
        onClose = onClose,
        preferCenterSheet = true,
        size = DialogSize.Large,
        centerSheetHeight = centerSheetHeight,
        snapPoints = snapPoints,
        ref = ref
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = if tbl1.title then React.createElement(
                FoundationText,
                {
                    Text = tbl1.title,
                    tag = "fill auto-y text-heading-small text-wrap text-align-x-left content-emphasis"
                }
            )
                or nil else nil
        }),
        Content = React.createElement(Sheet.Content, {}, {
            Body = React.createElement(
                View,
                {
                    tag = "col size-full-0 auto-y padding-bottom-small",
                    onAbsoluteSizeChanged = onAbsoluteSizeChanged
                },
                tbl1.children
            )
        }),
        Actions = tbl1.footer
            and React.createElement(
                Sheet.Actions,
                {},
                {
                    Footer = React.createElement(View, { tag = "row size-full-0 auto-y", onAbsoluteSizeChanged = var5 }, tbl1.footer)
                }
            )
            or nil
    }
    return createElement(root, tbl2, tbl3)
end)
