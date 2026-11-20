-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _DataSources = require(ultimateList.DataSources)
local _Dimensions = require(ultimateList.Dimensions)
local React = require(ultimateList.Parent.React)
local RendererOverlay = require(script.Parent.RendererOverlay)
local _Renderers = require(ultimateList.Renderers)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)
local useVirtualizedList = require(script.Parent.useVirtualizedList)

local createElement = React.createElement

local function ScrollingFrame(tbl1)
    local var1 = useVirtualizedList(tbl1)

    local var2 = React.useCallback(function(arg1)
        var1.setWindowSize(arg1.AbsoluteWindowSize)

        if tbl1.onAbsoluteWindowSizeChanged ~= nil then
            tbl1.onAbsoluteWindowSizeChanged(arg1.AbsoluteWindowSize)
        end
    end, { tbl1.direction, tbl1.onAbsoluteWindowSizeChanged })

    local var3 = React.useCallback(function(arg1)
        local var3 = if tbl1.direction == "x" then arg1.CanvasPosition.X elseif tbl1.direction == "y" then arg1.CanvasPosition.Y else exhaustiveMatch(tbl1.direction)

        RunService.Heartbeat:Once(function()
            var1.setScrollAxis(var3)

            if tbl1.onScrollAxisChanged ~= nil then
                tbl1.onScrollAxisChanged(var3)
            end
        end)
    end, { tbl1.direction, tbl1.onScrollAxisChanged })

    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        CanvasSize = var1.canvasSizeBinding,
        [React.Change.AbsoluteWindowSize] = var2,
        [React.Change.CanvasPosition] = var3,
        [React.Tag] = tbl1.tag,
        ref = tbl1.scrollingFrameRef
    }

    if tbl1.native ~= nil then
        for value, value2 in tbl1.native do
            if tbl2[value] ~= nil then
                error(`{value} is already used by UltimateList`)
            end

            tbl2[value] = value2
        end
    end

    return createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }, {
        ScrollingFrame = createElement("ScrollingFrame", tbl2),
        RendererOverlay = createElement(RendererOverlay, {
            dimensions = tbl1.dimensions,
            renderer = tbl1.renderer,
            getKey = tbl1.getKey,
            direction = tbl1.direction,
            virtualizedListController = var1.virtualizedListController,
            windowSizeBinding = var1.windowSizeBinding,
            scrollAxisBinding = var1.scrollAxisBinding
        })
    })
end

return ScrollingFrame
