-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local InputMode = require(Foundation.Utility.Input.InputMode)
local getInputMode = require(Foundation.Utility.Input.getInputMode)

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local calculateSliderFraction = require(Foundation.Components.Slider.calculateSliderFraction)
local getGuiInputPosition = require(Foundation.Components.Slider.getGuiInputPosition)

local _useSliderThumbs = require(script.Parent.useSliderThumbs)

local function getNearestThumbIndex(num1: number, tbl1): number
    local num2 = 1
    local num3 = math.abs(tbl1[1] - num1)
    for i = 2, #tbl1 do
        local num4 = math.abs(tbl1[i] - num1)
        if num4 < num3 - 1e-9 then
            num2 = i
            num3 = num4
        end
    end

    return num2
end

local function useSliderPointerDrag(tbl1)
    local draggedIndex, var2 = React.useState(nil)
    local var3 = React.useRef(nil)

    local onThumbDragStarted = React.useCallback(function(num1: number)
        var2(num1)
        tbl1.setActiveIndex(num1)
        if tbl1.onDragStarted then
            tbl1.onDragStarted()
        end
    end, { tbl1.setActiveIndex, tbl1.onDragStarted })

    local onThumbDragEnded = React.useCallback(function()
        var2(nil)
        if tbl1.onDragEnded then
            tbl1.onDragEnded()
        end
    end, { tbl1.onDragEnded })

    local var6 = React.useCallback(function(vector2: Vector2)
        local current = tbl1.rootRef.current
        if not current then
            return nil
        end
        return calculateSliderFraction(getGuiInputPosition(vector2, current), current, tbl1.isVertical)
    end, { tbl1.isVertical, tbl1.rootRef })

    return {
        draggedIndex = draggedIndex,
        onThumbDragStarted = onThumbDragStarted,
        onThumbDragEnded = onThumbDragEnded,
        onTrackDragStarted = React.useCallback(function(_, vector2: Vector2)
            local var7 = var6(vector2)

            if getInputMode(UserInputService:GetLastInputType()) == InputMode.Directional or var7 == nil then
                return
            end

            local tbl2 = ({})
            for k in tbl1.thumbs do
                tbl2[k] = tbl1.getThumbTrackFraction(k)
            end
            local current = getNearestThumbIndex(var7, tbl2)
            var3.current = current
            onThumbDragStarted(current)
            tbl1.seekThumbToTrackFraction(current, var7)
        end, {
            var6,
            tbl1.thumbs,
            tbl1.getThumbTrackFraction,
            onThumbDragStarted,
            tbl1.seekThumbToTrackFraction
        }),
        onTrackDrag = React.useCallback(function(_, vector2: Vector2)
            local current = var3.current
            local var7 = var6(vector2)
            if current == nil or var7 == nil then
                return
            end
            tbl1.seekThumbToTrackFraction(current, var7)
        end, { var6, tbl1.seekThumbToTrackFraction }),
        onTrackDragEnded = React.useCallback(function()
            if var3.current == nil then
                return
            end
            var3.current = nil
            onThumbDragEnded()
        end, { onThumbDragEnded })
    }
end

return useSliderPointerDrag
