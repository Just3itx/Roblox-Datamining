-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local _useMomentProgress = require(script.Parent.Parent.Hooks.useMomentProgress)
local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)

local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function formatTime(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    num1 = math.max(0, num1)
    local num2 = math.floor(num1 / 60)
    local num3 = math.floor(num1 % 60)
    return string.format("%d:%02d", num2, num3)
end

return React.memo(function(tbl1) -- name: TimeLabel
    local var1 = useTokens()

    local var2 = tbl1.progress:map(function(arg1): string
        return string.format("%s / %s", formatTime(arg1.time), formatTime(arg1.duration))
    end)

    local textStyle = tbl1.animationRatio:map(function(num1: number)
        return getColorStyleWithTransparency(var1.Color.Content.Emphasis, 1 - num1)
    end)

    return React.createElement(FoundationText, {
        tag = "auto-xy text-label-medium content-emphasis",
        Text = var2,
        textStyle = textStyle,
        LayoutOrder = tbl1.LayoutOrder
    })
end)
