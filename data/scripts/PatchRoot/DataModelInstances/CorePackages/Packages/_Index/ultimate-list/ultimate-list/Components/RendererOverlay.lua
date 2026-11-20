-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _Dimensions = require(ultimateList.Dimensions)
local React = require(ultimateList.Parent.React)
local ReactBindingsRenderer = require(ultimateList.Renderers.ReactBindingsRenderer)
local ReactStateRenderer = require(ultimateList.Renderers.ReactStateRenderer)
local _Renderers = require(ultimateList.Renderers)
local _createVirtualizedListController = require(ultimateList.createVirtualizedListController)
local exhaustiveMatch = require(ultimateList.Util.exhaustiveMatch)

local createElement = React.createElement

local function RendererOverlay(tbl1)
    local var1 = createElement
    local str1 = "Frame"

    local tbl2 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Position = tbl1.positionBinding,
        Size = tbl1.windowSizeBinding:map(function(vector2: Vector2)
            if tbl1.fillNonDominantAxis ~= true then
                return UDim2.fromOffset(vector2.X, vector2.Y)
            elseif tbl1.direction == "x" then
                return UDim2.new(0, vector2.X, 1, 0)
            elseif tbl1.direction == "y" then
                return UDim2.new(1, 0, 0, vector2.Y)
            end

            return (exhaustiveMatch(tbl1.direction))
        end),
        ZIndex = 2
    }

    local tbl3 = { Renderer = 0 }
    local element

    if tbl1.renderer.type == "byState" then
        element = createElement(ReactStateRenderer, {
            virtualizedListController = tbl1.virtualizedListController,
            config = tbl1.renderer.config,
            dimensions = tbl1.dimensions,
            direction = tbl1.direction,
            callback = tbl1.renderer.callback,
            getKey = tbl1.getKey,
            scrollAxisBinding = tbl1.scrollAxisBinding
        })
    elseif tbl1.renderer.type == "byBinding" then
        element = createElement(ReactBindingsRenderer, {
            virtualizedListController = tbl1.virtualizedListController,
            scrollAxisBinding = tbl1.scrollAxisBinding,
            dimensions = tbl1.dimensions,
            direction = tbl1.direction,
            callback = tbl1.renderer.callback,
            getKey = tbl1.getKey
        })
    else
        element = exhaustiveMatch(tbl1.renderer.type)
    end

    tbl3.Renderer = element
    return var1(str1, tbl2, tbl3)
end

return RendererOverlay
