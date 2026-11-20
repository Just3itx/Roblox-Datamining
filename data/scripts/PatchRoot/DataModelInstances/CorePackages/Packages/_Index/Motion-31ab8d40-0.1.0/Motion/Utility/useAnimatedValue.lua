-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local ReactOtter = require(scriptParentParentParent.ReactOtter)

local preset = require(scriptParent.TimingConfigs).presets[require(scriptParentParent.Enums.TransitionPreset).Default]

local _Types = require(scriptParentParent.Types)

local function validateNumber(arg1, num1: number?): number -- Luacid: unused: defined but never referenced
    return if type(arg1) == "number" then arg1 else num1 or 0
end

local function useAnimatedValue(arg1)
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(...)
        if var1.current == nil then
            return
        end

        if type(var1.current) == "function" then
            var1.current(...)
            return
        end

        if var1.current._isMockFunction then
            var1.current(...)
        end
    end, { var1 })

    if typeof(arg1) == "table" and arg1.Color3 and arg1.Transparency then
        local useAnimatedBinding = ReactOtter.useAnimatedBinding
        local tbl1 = { r = 0, g = 0, b = 0, Transparency = 0 }
        local r = arg1.Color3.R
        tbl1.r = if type(r) ~= "number" then 0 else r
        local g = arg1.Color3.G
        tbl1.g = if type(g) ~= "number" then 0 else g
        local b = arg1.Color3.B
        tbl1.b = if type(b) ~= "number" then 0 else b
        local transparency = arg1.Transparency
        tbl1.Transparency = if type(transparency) ~= "number" then 0 else transparency
        local var3, var4 = useAnimatedBinding(tbl1, var2)

        return var3:map(function(tbl2)
            return {
                Color3 = Color3.new(tbl2.r, tbl2.g, tbl2.b),
                Transparency = tbl2.Transparency
            }
        end), function(arg2, arg3)
            if typeof(arg2) ~= "table" or not arg2.Color3 or arg2.Transparency == nil then
                warn("Expected target to be a table with Color3 and Transparency fields")
                return
            end

            local var5 = var1
            var5.current = if arg3 then arg3.onComplete or nil else nil

            local var6 = arg3 and {
                duration = arg3.duration or preset.duration,
                easingStyle = arg3.easingStyle
            } or nil

            local var7 = var4
            local tbl2 = { r = 0, g = 0, b = 0, Transparency = 0 }
            local ease = ReactOtter.ease
            local r2 = arg2.Color3.R
            tbl2.r = ease(if type(r2) ~= "number" then 0 else r2, var6)
            local ease2 = ReactOtter.ease
            local g2 = arg2.Color3.G
            tbl2.g = ease2(if type(g2) ~= "number" then 0 else g2, var6)
            local ease3 = ReactOtter.ease
            local b2 = arg2.Color3.B
            tbl2.b = ease3(if type(b2) ~= "number" then 0 else b2, var6)
            local ease4 = ReactOtter.ease
            local transparency2 = arg2.Transparency
            tbl2.Transparency = ease4(if type(transparency2) ~= "number" then 0 else transparency2, var6)
            var7(tbl2)
        end
    elseif typeof(arg1) == "UDim" then
        local useAnimatedBinding = ReactOtter.useAnimatedBinding
        local tbl1 = { scale = 0, offset = 0 }
        local scale = arg1.Scale
        tbl1.scale = if type(scale) ~= "number" then 0 else scale
        local offset = arg1.Offset
        tbl1.offset = if type(offset) ~= "number" then 0 else offset
        local var3, var4 = useAnimatedBinding(tbl1, var2)

        return var3:map(function(tbl2): UDim
            return UDim.new(tbl2.scale, tbl2.offset)
        end), function(arg2, arg3)
            if not arg2 then
                return
            end

            if typeof(arg2) ~= "UDim" then
                warn("Expected UDim target but got", typeof(arg2))
                return
            end

            local var5 = var1
            var5.current = if arg3 then arg3.onComplete or nil else nil

            local var6 = arg3 and {
                duration = arg3.duration or preset.duration,
                easingStyle = arg3.easingStyle
            } or nil

            local var7 = var4
            local tbl2 = { scale = 0, offset = 0 }
            local ease = ReactOtter.ease
            local scale2 = arg2.Scale
            tbl2.scale = ease(if type(scale2) ~= "number" then 0 else scale2, var6)
            local ease2 = ReactOtter.ease
            local offset2 = arg2.Offset
            tbl2.offset = ease2(if type(offset2) ~= "number" then 0 else offset2, var6)
            var7(tbl2)
        end
    elseif typeof(arg1) == "UDim2" then
        local useAnimatedBinding = ReactOtter.useAnimatedBinding
        local tbl1 = { xScale = 0, xOffset = 0, yScale = 0, yOffset = 0 }
        local scale = arg1.X.Scale
        tbl1.xScale = if type(scale) ~= "number" then 0 else scale
        local offset = arg1.X.Offset
        tbl1.xOffset = if type(offset) ~= "number" then 0 else offset
        local scale2 = arg1.Y.Scale
        tbl1.yScale = if type(scale2) ~= "number" then 0 else scale2
        local offset2 = arg1.Y.Offset
        tbl1.yOffset = if type(offset2) ~= "number" then 0 else offset2
        local var3, var4 = useAnimatedBinding(tbl1, var2)

        return var3:map(function(tbl2): UDim2
            return UDim2.new(tbl2.xScale, tbl2.xOffset, tbl2.yScale, tbl2.yOffset)
        end), function(arg2, arg3)
            if not arg2 then
                return
            end

            if typeof(arg2) ~= "UDim2" then
                warn("Expected UDim2 target but got", typeof(arg2))
                return
            end

            local var5 = var1
            var5.current = if arg3 then arg3.onComplete or nil else nil

            local var6 = arg3 and {
                duration = arg3.duration or preset.duration,
                easingStyle = arg3.easingStyle
            } or nil

            local var7 = var4
            local tbl2 = { xScale = 0, xOffset = 0, yScale = 0, yOffset = 0 }
            local ease = ReactOtter.ease
            local scale3 = arg2.X.Scale
            tbl2.xScale = ease(if type(scale3) ~= "number" then 0 else scale3, var6)
            local ease2 = ReactOtter.ease
            local offset3 = arg2.X.Offset
            tbl2.xOffset = ease2(if type(offset3) ~= "number" then 0 else offset3, var6)
            local ease3 = ReactOtter.ease
            local scale4 = arg2.Y.Scale
            tbl2.yScale = ease3(if type(scale4) ~= "number" then 0 else scale4, var6)
            local ease4 = ReactOtter.ease
            local offset4 = arg2.Y.Offset
            tbl2.yOffset = ease4(if type(offset4) ~= "number" then 0 else offset4, var6)
            var7(tbl2)
        end
    elseif typeof(arg1) == "Vector2" then
        local useAnimatedBinding = ReactOtter.useAnimatedBinding
        local tbl1 = { x = 0, y = 0 }
        local x = arg1.X
        tbl1.x = if type(x) ~= "number" then 0 else x
        local y = arg1.Y
        tbl1.y = if type(y) ~= "number" then 0 else y
        local var3, var4 = useAnimatedBinding(tbl1, var2)

        return var3:map(function(tbl2): Vector2
            return Vector2.new(tbl2.x, tbl2.y)
        end), function(arg2, arg3)
            if not arg2 then
                return
            end

            if typeof(arg2) ~= "Vector2" then
                warn("Expected Vector2 target but got", typeof(arg2))
                return
            end

            local var5 = var1
            var5.current = if arg3 then arg3.onComplete or nil else nil

            local var6 = arg3 and {
                duration = arg3.duration or preset.duration,
                easingStyle = arg3.easingStyle
            } or nil

            local var7 = var4
            local tbl2 = { x = 0, y = 0 }
            local ease = ReactOtter.ease
            local x2 = arg2.X
            tbl2.x = ease(if type(x2) ~= "number" then 0 else x2, var6)
            local ease2 = ReactOtter.ease
            local y2 = arg2.Y
            tbl2.y = ease2(if type(y2) ~= "number" then 0 else y2, var6)
            var7(tbl2)
        end
    elseif typeof(arg1) == "Color3" then
        local useAnimatedBinding = ReactOtter.useAnimatedBinding
        local tbl1 = { r = 0, g = 0, b = 0 }
        local r = arg1.R
        tbl1.r = if type(r) ~= "number" then 0 else r
        local g = arg1.G
        tbl1.g = if type(g) ~= "number" then 0 else g
        local b = arg1.B
        tbl1.b = if type(b) ~= "number" then 0 else b
        local var3, var4 = useAnimatedBinding(tbl1, var2)

        return var3:map(function(tbl2): Color3
            return Color3.new(tbl2.r, tbl2.g, tbl2.b)
        end), function(color3, arg2)
            if not color3 then
                return
            end

            if typeof(color3) ~= "Color3" then
                warn("Expected Color3 target but got", typeof(color3))
                return
            end

            local var5 = var1
            var5.current = if arg2 then arg2.onComplete or nil else nil

            local var6 = arg2 and {
                duration = arg2.duration or preset.duration,
                easingStyle = arg2.easingStyle
            } or nil

            local var7 = var4
            local tbl2 = { r = 0, g = 0, b = 0 }
            local ease = ReactOtter.ease
            local r2 = color3.R
            tbl2.r = ease(if type(r2) ~= "number" then 0 else r2, var6)
            local ease2 = ReactOtter.ease
            local g2 = color3.G
            tbl2.g = ease2(if type(g2) ~= "number" then 0 else g2, var6)
            local ease3 = ReactOtter.ease
            local b2 = color3.B
            tbl2.b = ease3(if type(b2) ~= "number" then 0 else b2, var6)
            var7(tbl2)
        end
    elseif typeof(arg1) == "number" then
        local var3, var4 = ReactOtter.useAnimatedBinding(if type(arg1) ~= "number" then 0 else arg1, var2)

        return var3:map(function(num1: number): number
            return num1
        end), function(arg2, arg3)
            if typeof(arg2) ~= "number" then
                return
            end

            local var5 = var1
            var5.current = if arg3 then arg3.onComplete or nil else nil

            local var6 = arg3 and {
                duration = arg3.duration or preset.duration,
                easingStyle = arg3.easingStyle
            } or nil

            var4(ReactOtter.ease(arg2, var6))
        end
    else
        warn("Unsupported type for animated value:", typeof(arg1))
        return React.createBinding(arg1), function() end
    end
end

return useAnimatedValue
