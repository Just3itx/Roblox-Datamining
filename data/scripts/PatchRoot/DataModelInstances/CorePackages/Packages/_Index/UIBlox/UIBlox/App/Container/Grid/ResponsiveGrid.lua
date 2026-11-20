-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)

local ReactUtils = require(scriptParentParentParentParentParent.ReactUtils)
local useProperties = ReactUtils.useProperties
local usePropertiesDeferred = ReactUtils.usePropertiesDeferred

local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local ResponsiveRow = require(scriptParentParentParentParent.Core.Layout.Responsive.ResponsiveRow)
local useResponsiveLayout = require(scriptParentParentParentParent.Core.Layout.Responsive.useResponsiveLayout)

local function useCellAbsoluteHeight(uDim: UDim?, kind: string?)
    local var1 = useResponsiveLayout("columns", kind) or 1
    local var2 = useResponsiveLayout("gutter", kind) or 0
    local var3 = useResponsiveLayout("verticalGutter", kind) or var2
    local var4 = useResponsiveLayout("margin", kind) or 0
    local var5 = useResponsiveLayout("relativeHeight", kind)

    local var6 = uDim or var5

    return React.useCallback(function(num1: number)
        if not var6 then
            return nil
        end

        return math.max(((num1 - 2 * var4 + var2) / var1 - var2) * var6.Scale + var6.Offset, 0) + var3
    end, {
        var1,
        var2,
        var3,
        var4,
        var6
    })
end
local numberRange = NumberRange.new(0, 0)
if not UIBloxConfig.responsiveGridDisplayLinesNonNil then
    numberRange = nil
end
return React.forwardRef(function(tbl1, arg1) -- name: ResponsiveGrid
    local var1, var2 = React.useState(numberRange)
    local var3 = useCellAbsoluteHeight(tbl1.relativeHeight, tbl1.kind)

    local var4 = React.useCallback(function(arg2, arg3)
        if tbl1.absoluteWindowTop and tbl1.absoluteWindowHeight then
            local var4 = var3(arg3.X)
            if var4 and var4 > 0 then
                local min = math.floor(math.max(tbl1.absoluteWindowTop - arg2.Y, 0) / var4) + 1
                local num1 = math.ceil(math.max(tbl1.absoluteWindowHeight, 0) / var4) + 1
                return var2(NumberRange.new(min, min + num1 - 1))
            end
        end
        return var2(numberRange)
    end, {
        var3,
        tbl1.absoluteWindowTop,
        tbl1.absoluteWindowHeight,
        var2
    })

    local ref = (if tbl1.enableDeferredRefPropEvents then usePropertiesDeferred else useProperties)(
        arg1,
        var4,
        { "AbsolutePosition", "AbsoluteSize" }
    )
    local createElement = React.createElement
    local var6 = ResponsiveRow
    local tbl2 = {
        kind = tbl1.kind,
        layoutOrder = tbl1.layoutOrder,
        scrollable = false,
        multiLine = true,
        displayLines = 0,
        relativeHeight = 0,
        data = 0,
        getItem = 0,
        getItemCount = 0,
        renderItem = 0,
        keyExtractor = 0,
        getCellColspan = 0,
        getCellRowspan = 0,
        getCellOrder = 0,
        ref = 0
    }

    if not (tbl1.absoluteWindowTop and tbl1.absoluteWindowHeight) then
        var1 = nil
    end

    tbl2.displayLines = var1
    tbl2.relativeHeight = tbl1.relativeHeight
    tbl2.data = tbl1.data
    tbl2.getItem = tbl1.getItem
    tbl2.getItemCount = tbl1.getItemCount
    tbl2.renderItem = tbl1.renderItem
    tbl2.keyExtractor = tbl1.keyExtractor
    tbl2.getCellColspan = tbl1.getCellColspan
    tbl2.getCellRowspan = tbl1.getCellRowspan
    tbl2.getCellOrder = tbl1.getCellOrder
    tbl2.ref = ref
    return createElement(var6, tbl2)
end)
