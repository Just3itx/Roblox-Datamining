-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local Portal = require(scriptParentParentParentParentParent.Roact).Portal
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local _Types = require(scriptParent.Types)
local Constants = require(scriptParent.Constants)
local withAnimation = require(scriptParentParentParentParent.Core.Animation.withAnimation)
local TooltipCallout = require(scriptParent.TooltipCallout)

local TooltipOrientation = require(scriptParentParent.Tooltip.Enum.TooltipOrientation)

local function argmax(distances, tbl1)
    local var1 = nil
    for k, value in pairs(distances) do
        if not tbl1[k] and (var1 == nil or distances[var1] < value) then
            var1 = k
        end
    end

    return var1
end

local function getDistances(vector2: Vector2, vector2_2: Vector2)
    return {
        [TooltipOrientation.Top] = vector2.Y - Constants.SCREEN_MARGIN,
        [TooltipOrientation.Bottom] = vector2_2.Y - vector2.Y - Constants.SCREEN_MARGIN,
        [TooltipOrientation.Left] = vector2.X - Constants.SCREEN_MARGIN,
        [TooltipOrientation.Right] = vector2_2.X - vector2.X - Constants.SCREEN_MARGIN
    }
end

function getOrientationAndContentOffset(arg1, distances, vector2: Vector2, vector2_2: Vector2)
    local zero = Vector2.zero
    local tbl1 = ({})

    while true do
        local var1

        if arg1 and not tbl1[arg1] then
            var1 = arg1
        else
            var1 = argmax(distances, tbl1)
            if not var1 then
                break
            end
        end

        arg1 = var1

        if arg1 == TooltipOrientation.Top or arg1 == TooltipOrientation.Bottom then
            if vector2.Y + Constants.DISTANCE_TO_CONTENT + vector2_2.Y <= distances[arg1] then
                local left = TooltipOrientation.Left
                if distances[TooltipOrientation.Right] < distances[TooltipOrientation.Left] then
                    left = TooltipOrientation.Right
                end
                local var2 = distances[left]
                if Constants.MIN_DISTANCE_TO_CARET_MIDDLE <= var2 then
                    zero = math.max(0, vector2_2.X / 2 - var2) * -1 * Constants.ORIENTATION_VECTOR[left]
                    break
                end

                tbl1[Constants.OPPOSITE_ORIENTATION[arg1]] = true
            end
        elseif vector2.X + Constants.DISTANCE_TO_CONTENT + vector2_2.X <= distances[arg1] then
            local top = TooltipOrientation.Top
            if distances[TooltipOrientation.Bottom] < distances[TooltipOrientation.Top] then
                top = TooltipOrientation.Bottom
            end
            local var2 = distances[top]
            if Constants.MIN_DISTANCE_TO_CARET_MIDDLE <= var2 then
                zero = math.max(0, vector2_2.Y / 2 - var2) * -1 * Constants.ORIENTATION_VECTOR[top]
                break
            end

            tbl1[Constants.OPPOSITE_ORIENTATION[arg1]] = true
        end

        tbl1[arg1] = true

        arg1 = Constants.OPPOSITE_ORIENTATION[arg1]
    end
    return arg1, zero
end

local function TooltipController(arg1)
    local var1, var2 = React.useState(Vector2.zero)
    local var3, var4 = React.useState(Vector2.zero)
    local var5, var6 = React.useState(Vector2.zero)
    local var7, var8 = React.useState(Vector2.zero)
    local var9, onContentSizeChanged = React.useState(Vector2.zero)

    local var11 = React.useCallback(function(arg2)
        var2(arg2.AbsolutePosition)
        var4(arg2.AbsoluteSize)
    end)

    local function ref(arg2)
        if arg2 then
            var8(arg2.AbsolutePosition)
            var6(arg2.AbsoluteSize)
        end
    end

    local triggerPointRadius = var3 / 2
    local triggerPointCenter = var1 + triggerPointRadius - var7

    local var14 = arg1.preferredOrientation or TooltipOrientation.Top

    local orientation, contentOffsetVector = React.useMemo(function()
        local distances = getDistances(triggerPointCenter, var5)

        return getOrientationAndContentOffset(var14, distances, triggerPointRadius, var9)
    end, {
        var14,
        var5,
        triggerPointCenter,
        triggerPointRadius,
        var9
    })

    local var17 = if not arg1.disabled and arg1.active then Constants.ACTIVE_ANIMATION_TARGETS else Constants.INACTIVE_ANIMATION_TARGETS

    local portal = withAnimation(var17, function(arg2) -- name: renderWithAnimation
        if arg2.transparency == 1 then
            return nil
        end

        local tbl1 = {
            orientation = orientation,
            triggerPointCenter = triggerPointCenter,
            triggerPointRadius = triggerPointRadius,
            contentOffsetVector = contentOffsetVector,
            onContentSizeChanged = onContentSizeChanged,
            distanceOffset = arg2.distanceOffset,
            transparency = arg2.transparency
        }

        local var18 = LuauPolyfill.Object.assign({}, arg1.tooltipProps, tbl1)

        local tbl2 = {
            Tooltip = React.createElement(TooltipCallout, var18)
        }
        local element

        if arg1.DEBUG_useTargetDirectly then
            element = React.createElement("Frame", {
                ZIndex = arg1.DisplayOrder,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = ref,
                [React.Change.AbsolutePosition] = ref,
                ref = ref
            }, tbl2)
        else
            element = React.createElement("ScreenGui", {
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                IgnoreGuiInset = true,
                DisplayOrder = arg1.DisplayOrder,
                [React.Change.AbsoluteSize] = ref,
                [React.Change.AbsolutePosition] = ref,
                ref = ref
            }, tbl2)
        end

        return React.createElement(Portal, { target = arg1.guiTarget }, { TooltipLayer = element })
    end, Constants.ANIMATION_OPTIONS)

    local triggerPointName = arg1.triggerPointName or "TriggerPoint"

    return React.createElement(React.Fragment, nil, { Portal = portal, [triggerPointName] = arg1.renderTriggerPoint(var11) })
end

return TooltipController
