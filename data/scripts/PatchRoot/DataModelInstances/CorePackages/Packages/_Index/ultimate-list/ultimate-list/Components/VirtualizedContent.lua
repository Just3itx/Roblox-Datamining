-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:23Z
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

local function getScrollAxis(vector2: Vector2, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == "x" then
        return vector2.X
    elseif str1 == "y" then
        return vector2.Y
    end

    return (exhaustiveMatch(str1))
end

local function getPosition(num1: number, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == "x" then
        return UDim2.fromOffset(num1, 0)
    elseif str1 == "y" then
        return UDim2.fromOffset(0, num1)
    end

    return (exhaustiveMatch(str1))
end

local function getContentSize(uDim2: UDim2, direction: string)
    if direction == "x" then
        return UDim2.new(0, uDim2.X.Offset, 1, 0)
    elseif direction == "y" then
        return UDim2.new(1, 0, 0, uDim2.Y.Offset)
    end

    return (exhaustiveMatch(direction))
end

local function VirtualizedContent(tbl1)
    local var1 = useVirtualizedList(tbl1)
    local positionBinding, var3 = React.useBinding(UDim2.new())

    React.useEffect(function()
        local current = tbl1.scrollingFrameRef.current
        assert(current ~= nil, "VirtualizedContent requires scrollingFrameRef.current to point to its ancestor ScrollingFrame")

        local var4 = nil
        local var5 = nil

        local function syncMetrics()
            local absoluteWindowSize = current.AbsoluteWindowSize
            if absoluteWindowSize ~= var4 then
                var4 = absoluteWindowSize
                var1.setWindowSize(absoluteWindowSize)

                if tbl1.onAbsoluteWindowSizeChanged ~= nil then
                    tbl1.onAbsoluteWindowSizeChanged(absoluteWindowSize)
                end
            end

            local canvasPosition = current.CanvasPosition
            local direction = tbl1.direction
            local var6 = if direction == "x" then getScrollAxis(canvasPosition, "x") elseif direction == "y" then getScrollAxis(canvasPosition, "y") else exhaustiveMatch(direction)
            local var7 = var3
            local direction2 = tbl1.direction
            var7(
                if direction2 == "x" then getPosition(var6, "x") elseif direction2 == "y" then getPosition(var6, "y") else exhaustiveMatch(direction2)
            )
            var1.setScrollAxis(var6)

            if var6 == var5 then
                return
            end

            var5 = var6

            if tbl1.onScrollAxisChanged ~= nil then
                tbl1.onScrollAxisChanged(var6)
            end
        end

        local tbl2 = { current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(syncMetrics), current:GetPropertyChangedSignal("CanvasPosition"):Connect(syncMetrics), RunService.RenderStepped:Connect(syncMetrics) }

        syncMetrics()

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {
        tbl1.scrollingFrameRef,
        tbl1.direction,
        tbl1.onAbsoluteWindowSizeChanged,
        tbl1.onScrollAxisChanged,
        var1.setWindowSize,
        var1.setScrollAxis
    })

    return createElement("Frame", {
        BackgroundTransparency = 1,
        Size = var1.canvasSizeBinding:map(function(uDim2: UDim2)
            return (getContentSize(uDim2, tbl1.direction))
        end)
    }, {
        RendererOverlay = createElement(RendererOverlay, {
            dimensions = tbl1.dimensions,
            renderer = tbl1.renderer,
            getKey = tbl1.getKey,
            direction = tbl1.direction,
            virtualizedListController = var1.virtualizedListController,
            windowSizeBinding = var1.windowSizeBinding,
            scrollAxisBinding = var1.scrollAxisBinding,
            positionBinding = positionBinding,
            fillNonDominantAxis = true
        })
    })
end

return VirtualizedContent
