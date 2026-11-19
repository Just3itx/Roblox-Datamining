-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:11:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Breakpoint = require(Foundation.Enums.Breakpoint)
local Dash = require(FoundationParent.Dash)
local _ResponsiveContext = require(Foundation.Providers.Responsive.ResponsiveContext)
local _Types = require(Foundation.Components.Types)

local function getColumnMetrics(arg1, arg2, arg3)
    local column = arg1.grid.columns[arg2]

    if arg3 then
        if type(arg3) == "table" then
            arg3 = arg3[arg1.breakpoint.shortNames[arg2]] or column
        end

        column = math.clamp(arg3, 0, column)
    end

    return {
        colCount = column,
        gutterCount = math.max(0, column - 1)
    }
end

local function getGridMetrics(arg1, arg2, num1: number, arg3)
    local columnMetrics = getColumnMetrics(arg1, arg2)
    local tbl1 = if arg3 then getColumnMetrics(arg1, arg2, arg3) else columnMetrics
    local grid = arg1.grid
    local gapHeight = grid.gaps[arg2]
    local gutterWidth = grid.gutters[arg2]
    local margin = grid.margins[arg2]

    local gridWidth = math.max(0, num1 - margin * 2)

    local var1 = columnMetrics.gutterCount * gutterWidth
    local var2 = tbl1.gutterCount * gutterWidth
    local colWidth = math.max(0, (gridWidth - var1) / columnMetrics.colCount)
    local xOffset = if var1 < gridWidth then math.floor(colWidth * tbl1.colCount + var2) else 0
    local uDim2 = UDim2.fromOffset(xOffset, 0)

    return Dash.assign({
        full = Dash.assign(columnMetrics, { margin = margin }),
        margin = margin,
        colWidth = colWidth,
        gapHeight = gapHeight,
        gutterWidth = gutterWidth,
        gridWidth = gridWidth,
        cellSize = uDim2,
        cellWidth = xOffset
    }, tbl1)
end

return getGridMetrics
