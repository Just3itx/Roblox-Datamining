-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Sheet = script:FindFirstAncestor("Sheet")
local SheetContext = require(Sheet.SheetContext)
local SheetType = require(Sheet.SheetType)

local CloseAffordance = require(Foundation.Components.CloseAffordance)
local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)
local View = require(Foundation.Components.View)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: SheetHeader
    local var1 = useTokens()
    local var2 = React.useContext(SheetContext)

    local innerScrollY = var2.innerScrollY
    local setHasHeader = var2.setHasHeader
    local hasFullBleed = var2.hasFullBleed
    local sheetType = var2.sheetType
    local closeSheet = var2.closeSheet
    local testId = var2.testId
    local closeAffordanceRef = var2.closeAffordanceRef
    local contentStartRef = var2.contentStartRef
    assert(innerScrollY and setHasHeader and closeSheet and testId, "SheetHeader must be used within a Sheet")

    local bool1 = sheetType == SheetType.Bottom

    React.useEffect(function()
        setHasHeader(true)
        return function()
            setHasHeader(false)
        end
    end, {})

    local var3 = if tbl1.hasCloseAffordance == nil then not bool1 else tbl1.hasCloseAffordance
    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        ZIndex = 2,
        tag = "col size-full-0 auto-y",
        testId = `{testId}--header`,
        ref = ref
    }
    local tbl3 = { Content = 0, BottomBorder = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl4 = {
        LayoutOrder = 1,
        tag = "row align-y-center items-center gap-small size-full-1400 auto-y margin-left-small padding-y-small padding-right-medium"
    }

    local tbl5 = {
        SubContent = React.createElement(
            View,
            { LayoutOrder = 1, tag = "row items-center shrink gap-small size-full-0 auto-y" },
            tbl1.children
        ),
        CloseAffordance = if var3 then React.createElement(CloseAffordance, {
            onActivated = closeSheet,
            ref = closeAffordanceRef,
            NextSelectionDown = contentStartRef,
            variant = if hasFullBleed then CloseAffordanceVariant.OverMedia else CloseAffordanceVariant.Utility,
            LayoutOrder = 2,
            testId = `{testId}--header--close-affordance`
        }) else nil
    }
    tbl3.Content = createElement2(var5, tbl4, tbl5)

    tbl3.BottomBorder = React.createElement(View, {
        LayoutOrder = 2,
        backgroundStyle = innerScrollY:map(function(num1: number)
            return {
                Color3 = var1.Color.Stroke.Default.Color3,
                Transparency = math.lerp(1, var1.Color.Stroke.Default.Transparency, math.clamp(num1 / var1.Size.Size_1200, 0, 1))
            }
        end),
        testId = `{testId}--header--bottom-border`,
        Size = UDim2.new(1, 0, 0, var1.Stroke.Standard)
    })

    return createElement(var4, tbl2, tbl3)
end))
