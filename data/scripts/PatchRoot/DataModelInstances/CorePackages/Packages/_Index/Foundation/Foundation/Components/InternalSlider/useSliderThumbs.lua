-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local calculateSliderStepValue = require(Foundation.Components.Slider.calculateSliderStepValue)
local calculateSliderValueFraction = require(Foundation.Components.Slider.calculateSliderValueFraction)
local getThumbOffset = require(script.Parent.ThumbLayout.getThumbOffset)
local toThumbFraction = require(script.Parent.ThumbLayout.toThumbFraction)
local toThumbTrackFraction = require(script.Parent.ThumbLayout.toThumbTrackFraction)

local function getKnobFraction(vector2: Vector2, bool1: boolean) -- Luacid: Inlined by compiler; 10 call sites recovered
    return if bool1 then vector2.Y else vector2.X
end

local function useSliderThumbs(tbl1)
    local toFraction = React.useCallback(function(num1: number)
        return calculateSliderValueFraction(num1, tbl1.range)
    end, { tbl1.range })

    local valueFromFraction = React.useCallback(function(num1: number)
        local var2 = tbl1.range.Min + num1 * (tbl1.range.Max - tbl1.range.Min)
        if tbl1.step then
            return (calculateSliderStepValue(var2, tbl1.step, tbl1.range))
        end

        return var2
    end, { tbl1.range, tbl1.step })

    local var3 = React.useCallback(function(num1: number, num2: number)
        if not tbl1.step or tbl1.step <= 0 then
            return num1
        end
        local var3 = (num1 - tbl1.range.Min) / tbl1.step
        local num3 = math.max(1, math.abs(var3)) * 1e-6
        local var4 = if num2 > 0 then math.ceil(var3 - num3) else math.floor(var3 + num3)
        return tbl1.range.Min + var4 * tbl1.step
    end, { tbl1.range.Min, tbl1.step })

    local clampToNeighbors = React.useCallback(function(num1: number, num2: number): number
        local var4 = if tbl1.step and tbl1.step > 0 then tbl1.step else 0.01 * (tbl1.range.Max - tbl1.range.Min)
        local value = tbl1.thumbs[num1].value:getValue()

        if num1 > 1 then
            local value2 = tbl1.thumbs[num1 - 1].value:getValue()
            num2 = math.max(num2, value2, math.min(var3(value2 + var4, 1), value))
        end
        if num1 < #tbl1.thumbs then
            local value2 = tbl1.thumbs[num1 + 1].value:getValue()
            num2 = math.min(num2, value2, math.max(var3(value2 - var4, -1), value))
        end
        return num2
    end, {
        tbl1.thumbs,
        tbl1.range.Min,
        tbl1.range.Max,
        tbl1.step,
        var3
    })
    local updateThumbValue = React.useCallback(function(num1: number, num2: number)
        if num2 ~= tbl1.thumbs[num1].value:getValue() then
            tbl1.onValueChanged(num1, num2)
        end
    end, { tbl1.thumbs, tbl1.onValueChanged })

    local seekThumb = React.useCallback(function(num1: number, num2: number)
        updateThumbValue(num1, clampToNeighbors(num1, valueFromFraction(math.clamp(num2, 0, 1))))
    end, { updateThumbValue, clampToNeighbors, valueFromFraction })

    local fractions = ({})
    for i = 1, #tbl1.thumbs do
        fractions[i] = tbl1.thumbs[i].value:map(toFraction)
    end

    local thumbsLen = #tbl1.thumbs
    local getThumbTrackFraction = React.useCallback(function(num1: number)
        local var7 = toThumbTrackFraction
        local var8 = toFraction(tbl1.thumbs[num1].value:getValue())

        local num2 = thumbsLen
        local knobScale = tbl1.getKnobScale()
        return var7(var8, num1, num2, if tbl1.isVertical then getKnobFraction(knobScale, true) else getKnobFraction(knobScale, false))
    end, {
        tbl1.thumbs,
        toFraction,
        thumbsLen,
        tbl1.getKnobScale,
        tbl1.isVertical
    })
    local seekThumbToTrackFraction = React.useCallback(function(num1: number, num2: number)
        local knobScale = tbl1.getKnobScale()
        local knobFraction = if tbl1.isVertical then getKnobFraction(knobScale, true) else getKnobFraction(knobScale, false)
        seekThumb(num1, toThumbFraction(num2, num1, thumbsLen, knobFraction))
    end, {
        seekThumb,
        thumbsLen,
        tbl1.getKnobScale,
        tbl1.isVertical
    })
    local trackFractions = ({})
    for i = 1, thumbsLen do
        local joinBindings = React.joinBindings
        local tbl4 = {
            fraction = fractions[i],
            knobScale = tbl1.knobScale
        }

        trackFractions[i] = joinBindings(tbl4):map(function(tbl5)
            local var9 = toThumbTrackFraction
            local fraction = tbl5.fraction
            local num1 = i
            local num2 = thumbsLen
            local knobScale = tbl5.knobScale
            return var9(
                fraction,
                num1,
                num2,
                if tbl1.isVertical then getKnobFraction(knobScale, true) else getKnobFraction(knobScale, false)
            )
        end)
    end

    local positions = ({})
    for i = 1, thumbsLen do
        local joinBindings = React.joinBindings
        local tbl5 = {
            fraction = fractions[i],
            knobScale = tbl1.knobScale
        }

        positions[i] = joinBindings(tbl5):map(function(tbl6): UDim2
            local fraction = tbl6.fraction
            local var9 = getThumbOffset
            local fraction2 = tbl6.fraction
            local num1 = i
            local num2 = thumbsLen
            local knobScale = tbl6.knobScale
            local xScale = fraction + var9(
                fraction2,
                num1,
                num2,
                if tbl1.isVertical then getKnobFraction(knobScale, true) else getKnobFraction(knobScale, false),
                tbl1.isContained
            )
            if tbl1.isVertical then
                return UDim2.fromScale(0.5, 1 - xScale)
            end

            return UDim2.fromScale(xScale, 0.5)
        end)
    end

    return {
        fractions = fractions,
        trackFractions = trackFractions,
        positions = positions,
        span = React.joinBindings({ first = fractions[1], last = fractions[thumbsLen], knobScale = tbl1.knobScale }):map(function(tbl5)
            local knobScale = tbl5.knobScale
            local knobFraction = if tbl1.isVertical then getKnobFraction(knobScale, true) else getKnobFraction(knobScale, false)
            local xScale = tbl5.first + getThumbOffset(tbl5.first, 1, thumbsLen, knobFraction, tbl1.isContained)
            local var9 = tbl5.last + getThumbOffset(tbl5.last, thumbsLen, thumbsLen, knobFraction, tbl1.isContained)
            local var10 = var9 - xScale

            if tbl1.isVertical then
                return {
                    Position = UDim2.fromScale(0, 1 - var9),
                    Size = UDim2.fromScale(1, var10)
                }
            end

            return {
                Position = UDim2.fromScale(xScale, 0),
                Size = UDim2.fromScale(var10, 1)
            }
        end),
        getThumbTrackFraction = getThumbTrackFraction,
        seekThumbToTrackFraction = seekThumbToTrackFraction,
        toFraction = toFraction,
        valueFromFraction = valueFromFraction,
        clampToNeighbors = clampToNeighbors,
        updateThumbValue = updateThumbValue,
        seekThumb = seekThumb
    }
end

return useSliderThumbs
