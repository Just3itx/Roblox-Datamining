-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)

local Sheet = script:FindFirstAncestor("Sheet")
local SheetContext = require(Sheet.SheetContext)
local SheetType = require(Sheet.SheetType)

local Flags = require(Foundation.Utility.Flags)
local useTokens = require(Foundation.Providers.Style.useTokens)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local View = require(Foundation.Components.View)

return React.memo(React.forwardRef(function(tbl1, ref) -- name: SheetActions
    local var1 = useTokens()

    local var2 = React.useContext(SheetContext)
    local sheetHeightAvailable = var2.sheetHeightAvailable
    local actionsHeight = var2.actionsHeight
    local setActionsHeight = var2.setActionsHeight
    local hasActionsDivider = var2.hasActionsDivider
    local safeAreaPadding = var2.safeAreaPadding
    local bottomPadding = var2.bottomPadding
    local sheetType = var2.sheetType
    local testId = var2.testId
    assert(
        sheetHeightAvailable
            and actionsHeight
            and setActionsHeight
            and hasActionsDivider
            and safeAreaPadding
            and bottomPadding
            and testId,
        "SheetActions must be used within a Sheet"
    )

    local innerSurface = var2.innerSurface

    if Flags.FoundationBottomSheetClearsActionsHeight then
        React.useLayoutEffect(function()
            return function()
                setActionsHeight(0)
            end
        end, { setActionsHeight })
    end

    local bool1 = sheetType == SheetType.Bottom

    local createElement = React.createElement
    local var3 = View

    local tbl2 = {
        tag = { ["row gap-small size-full-0 auto-y"] = true, ["bg-surface-100"] = bool1 },
        padding = {
            top = UDim.new(0, var1.Margin.Small),
            left = UDim.new(0, var1.Margin.Small),
            right = UDim.new(0, var1.Margin.Small),
            bottom = UDim.new(0, bottomPadding + var1.Margin.Small)
        },
        stroke = {
            Color = var1.Color.Stroke.Default.Color3,
            Transparency = var1.Color.Stroke.Default.Transparency,
            Thickness = hasActionsDivider:map(function(bool2: boolean)
                return if bool2 then var1.Stroke.Standard else 0
            end)
        },
        onAbsoluteSizeChanged = bool1 and function(arg1)
            setActionsHeight(arg1.AbsoluteSize.Y - bottomPadding)
        end or nil,
        ZIndex = 1,
        testId = `{testId}--actions`,
        Position = if bool1 then React.joinBindings({ sheetHeightAvailable = sheetHeightAvailable, actionsHeight = actionsHeight }):map(function(tbl2)
            return UDim2.new(0, 0, 1, -math.min(tbl2.sheetHeightAvailable, tbl2.actionsHeight))
        end) else nil,
        LayoutOrder = 3,
        ref = ref,
        onActivated = 0,
        selection = 0,
        stateLayer = 0
    }
    function tbl2.onActivated() end
    tbl2.selection = { Selectable = false }
    tbl2.stateLayer = {
        affordance = StateLayerAffordance.None
    }
    local element = createElement(var3, tbl2, tbl1.children)

    if bool1 then
        return innerSurface and ReactRoblox.createPortal(element, innerSurface)
    end

    return element
end))
