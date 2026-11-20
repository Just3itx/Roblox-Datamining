-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DragIntent = require(Foundation.Enums.DragIntent)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)

local function openSign(start): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if start == InternalDrawerSide.Start then 1 else -1
end

local function distanceAlong(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.max(0, (num3 - num2) * num1)
end

local function velocityAlong(num1: number, num2: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return num2 * num1
end

local function freshVelocity(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if num3 - num2 > 0.1 then 0 else num1
end

local function resolveThreshold(num1: number?, num2: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if num1 == nil then num2 else num1
end

return {
    DEFAULT_DISTANCE_FRACTION = 0.3,
    DEFAULT_VELOCITY_THRESHOLD = 400,
    classifyDrag = function(num1: number, num2: number, num3: number, num4: number?)
        local num5 = math.abs(num1)
        local num6 = math.abs(num2)

        if num3 < num6 and num5 <= num6 then
            return DragIntent.Ignore
        end

        if num5 <= num3 then
            return DragIntent.Pending
        end

        if num4 == nil or not (velocityAlong(num4, num1) <= 0) then
            return DragIntent.Claim
        end

        return DragIntent.Ignore
    end,
    closeSign = function(start): number
        return -openSign(start)
    end,
    distanceAlong = distanceAlong,
    freshVelocity = freshVelocity,
    openSign = openSign,
    passedThreshold = function(num1: number, num2: number, num3: number, num4: number, num5: number): boolean
        if num2 <= 0 then
            return false
        end
        if num5 <= num3 then
            return true
        end
        return num1 > 0 and num4 * num2 <= num1
    end,
    progress = function(num1: number, num2: number): number
        if num2 <= 0 then
            return 0
        end
        return math.clamp(num1 / num2, 0, 1)
    end,
    resolveThresholds = function(tbl1): (number, number)
        return resolveThreshold(tbl1.distanceFraction, 0.3), (resolveThreshold(tbl1.velocityThreshold, 400))
    end,
    shouldCommit = function(tbl1, num1: number, num2: number, num3: number, num4: number, num5: number): boolean
        local num6 = distanceAlong(num1, tbl1.startX, tbl1.lastX)
        local num7 = velocityAlong(num1, (freshVelocity(tbl1.velocityX, tbl1.lastTime, num5)))

        if num2 <= 0 then
            return false
        end
        if num4 <= num7 then
            return true
        end
        return num6 > 0 and num3 * num2 <= num6
    end,
    velocityAlong = velocityAlong
}
