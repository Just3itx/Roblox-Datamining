-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local ReactUtils = require(SduiSharedContentParent.ReactUtils)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local usePreferences = Foundation.Hooks.usePreferences
local usePulseBinding = Foundation.Hooks.usePulseBinding
local useTokens = Foundation.Hooks.useTokens
local useClock = ReactUtils.useClock

local white = Color3.new(1, 1, 1)

local function generateShimmerGradient(color3: Color3): ColorSequence
    local color3_2 = color3:Lerp(Color3.new(0, 0, 0), 0.2)
    local color3_3 = color3:Lerp(Color3.new(1, 1, 1), 0.8)

    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, color3),
        ColorSequenceKeypoint.new(0.25, color3_2),
        ColorSequenceKeypoint.new(0.5, color3_3),
        ColorSequenceKeypoint.new(0.75, color3_2),
        ColorSequenceKeypoint.new(1, color3)
    })
end

local function useShimmerText(tbl1)
    local var1 = usePreferences()
    local var2 = useTokens()
    local var3 = useClock()
    local var4 = usePulseBinding(0.75)
    local var5 = if tbl1.animationSpeed == nil then 0.75 else math.max(tbl1.animationSpeed, 0)
    local var6 = if tbl1.gradientOffset == nil or not (tbl1.gradientOffset > 0) then 1.05 else tbl1.gradientOffset

    local default = var2.Color.Content.Default
    local var7 = tbl1.textStyle or default
    local color3 = var7.Color3 or default.Color3
    local transparency = var7.Transparency or default.Transparency

    local var8 = React.useMemo(function(): ColorSequence
        return generateShimmerGradient(color3)
    end, { color3 })

    if tbl1.isShimmerEnabled == false then
        return {
            children = tbl1.children,
            textStyle = tbl1.textStyle
        }
    end

    if var1.reducedMotion then
        return {
            children = tbl1.children,
            textStyle = var4:map(function(num1: number)
                return {
                    Color3 = color3,
                    Transparency = math.min(transparency + num1 * 0.1, 1)
                }
            end)
        }
    end

    return {
        children = {
            Content = React.createElement(React.Fragment, nil, tbl1.children),
            ShimmerGradient = React.createElement("UIGradient", {
                Color = var8,
                Offset = var3:map(function(num1: number): Vector2
                    return Vector2.new(num1 * var5 % var6 - var6 / 2, 0)
                end),
                Rotation = 15
            })
        },
        textStyle = { Color3 = white, Transparency = transparency }
    }
end

return useShimmerText
