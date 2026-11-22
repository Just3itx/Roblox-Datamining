-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local React = require(ReactionsParent.React)

local Reaction = require(Reactions.Components.Reaction)
local ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)
local reactionExplosionTicker = require(Reactions.Utils.reactionExplosionTicker)
local reactionExplosionMath = require(Reactions.Utils.reactionExplosionMath)

local Medium = ReactionSize.Medium

local white = Color3.new(1, 1, 1)

local var1 = React.memo(function(tbl1)
    local var1 = React.useMemo(function()
        local var1 = tbl1.progress:map(function(arg1)
            return reactionExplosionMath.solveParticle(arg1, tbl1.particle)
        end)
        return {
            position = var1:map(function(arg1): UDim2
                return UDim2.fromOffset(arg1.x, arg1.y)
            end),
            rotation = var1:map(function(arg1)
                return arg1.rotation
            end),
            scale = var1:map(function(arg1)
                return arg1.scale
            end),
            imageStyle = var1:map(function(arg1)
                return {
                    Color3 = white,
                    Transparency = arg1.transparency
                }
            end)
        }
    end, { tbl1.progress, tbl1.particle })

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = var1.position,
        Rotation = var1.rotation,
        Size = UDim2.fromOffset(32, 32)
    }, {
        Glyph = React.createElement(Reaction, {
            reactionType = tbl1.reactionType,
            size = Medium,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            scale = var1.scale,
            imageStyle = var1.imageStyle
        })
    })
end)

return React.memo(function(tbl1) -- name: ReactionExplosion
    local var2 = tbl1.ticker or reactionExplosionTicker.shared

    local var3 = React.useMemo(function()
        return tbl1.particleCount or math.random(reactionExplosionMath.MIN_PARTICLES, reactionExplosionMath.MAX_PARTICLES)
    end, { tbl1.particleCount })

    local var4 = React.useMemo(function()
        local result = ({})
        for i = 1, var3 do
            local angle = (i - 1) * (math.pi * 2 / var3) + (math.random() - 0.5) * reactionExplosionMath.ANGLE_JITTER
            local reach = reactionExplosionMath.MAX_REACH * (reactionExplosionMath.REACH_MIN_FACTOR + math.random() * reactionExplosionMath.REACH_RANGE)
            local num1 = if math.random() < 0.5 then -1 else 1
            result[i] = {
                angle = angle,
                reach = reach,
                spin = (reactionExplosionMath.SPIN_MIN + math.random() * reactionExplosionMath.SPIN_RANGE) * num1,
                sizeScale = reactionExplosionMath.SIZE_MIN + math.random() * reactionExplosionMath.SIZE_RANGE
            }
        end

        return result
    end, { var3 })

    local progress, var6 = React.useBinding(0)

    local var7 = React.useRef(tbl1.onComplete)
    var7.current = tbl1.onComplete

    React.useLayoutEffect(function()
        local var8 = nil
        local bool1 = false
        local var9 = nil
        var9 = var2.add(function(num1: number)
            if var8 == nil then
                var8 = num1
            end
            local num2 = math.clamp((num1 - var8) / reactionExplosionMath.DURATION, 0, 1)
            var6(num2)
            if not (num2 >= 1) or bool1 then
                return
            end

            bool1 = true
            var9()
            local current = var7.current
            if current ~= nil then
                current()
            end
        end)

        return var9
    end, { var2 })

    local tbl2 = ({})
    for value, particle in var4 do
        local str1 = `particle_{value}`
        tbl2[str1] = React.createElement(var1, { reactionType = tbl1.reactionType, progress = progress, particle = particle })
    end

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = tbl1.position,
        Size = UDim2.fromOffset(0, 0)
    }, tbl2)
end)
