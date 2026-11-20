-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _DataSources = require(ultimateList.DataSources)
local _Dimensions = require(ultimateList.Dimensions)
local React = require(ultimateList.Parent.React)
local createVirtualizedListController = require(ultimateList.createVirtualizedListController)

local function useVirtualizedList(tbl1)
    local virtualizedListController = React.useState(function()
        return createVirtualizedListController(tbl1.dataSource, tbl1.dimensions, tbl1.direction)
    end)

    React.useEffect(function()
        return function()
            virtualizedListController.destroy()
        end
    end, {})

    local canvasSizeBinding, var3 = React.useBinding(virtualizedListController.getCanvasSize())
    local windowSizeBinding, var5 = React.useBinding(Vector2.zero)
    local scrollAxisBinding, var7 = React.useBinding(0)

    React.useEffect(function()
        return virtualizedListController.bindToUpdate(function()
            var3(virtualizedListController.getCanvasSize())
        end)
    end, { virtualizedListController })

    local setWindowSize = React.useCallback(function(vector2: Vector2)
        var5(vector2)
        virtualizedListController.setWindowSize(vector2)
    end, { virtualizedListController })

    local setScrollAxis = React.useCallback(function(num1: number)
        virtualizedListController.setScrollAxis(num1)
        var7(num1)
    end, { virtualizedListController })

    React.useEffect(function()
        virtualizedListController.setDataSource(tbl1.dataSource)
    end, { tbl1.dataSource })

    React.useEffect(function()
        virtualizedListController.setDimensions(tbl1.dimensions)
    end, { tbl1.dimensions })

    React.useEffect(function()
        virtualizedListController.setOverscan(tbl1.overscan or 0)
    end, { tbl1.overscan })

    return {
        virtualizedListController = virtualizedListController,
        canvasSizeBinding = canvasSizeBinding,
        windowSizeBinding = windowSizeBinding,
        scrollAxisBinding = scrollAxisBinding,
        setWindowSize = setWindowSize,
        setScrollAxis = setScrollAxis
    }
end

return useVirtualizedList
