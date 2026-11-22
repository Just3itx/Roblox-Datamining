-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ScrollTelemetryParent = script:FindFirstAncestor("ScrollTelemetry").Parent
local ArgCheck = require(ScrollTelemetryParent.ArgCheck)
local Cryo = require(ScrollTelemetryParent.Cryo)
local t = require(ScrollTelemetryParent.t)
local mutedError = require(ScrollTelemetryParent.Loggers).mutedError

local var1 = t.strictInterface({
    distance = t.number,
    screenSizeX = t.number,
    screenSizeY = t.number,
    scrollAreaSize = t.number,
    scrollDepth = t.optional(t.number),
    startDepth = t.optional(t.number),
    startPos = t.number,
    scrollDuration = t.number
})

local var2 = t.strictInterface({
    distance = t.number,
    screenSizeX = t.number,
    screenSizeY = t.number,
    scrollAreaSize = t.number,
    scrollDepth = t.optional(t.number),
    startDepth = t.optional(t.number),
    startPos = t.number,
    scrollDuration = t.number,
    sortPos = t.number,
    gameSetTypeId = t.string,
    gameSetTargetId = t.optional(t.number)
})

return function(arg1, arg2, scrollingDirection, arg3)
    ArgCheck.isType(arg2, "string", "eventContext")

    local str1 = "unknown"

    local var3 = nil
    if scrollingDirection == Enum.ScrollingDirection.Y then
        var3 = var1
        str1 = "vertical"
    elseif scrollingDirection == Enum.ScrollingDirection.X then
        var3 = var2
        str1 = "horizontal"
    elseif scrollingDirection == Enum.ScrollingDirection.XY then
        mutedError(`Direction {scrollingDirection.Name} is an unsupported option for feedScroll event`)
    end

    if var3 then
        local var4, var5 = var3(arg3)

        if not var4 then
            mutedError(var5)
        end
    else
        mutedError(
            `Missing interface for unknown direction {scrollingDirection.Name} to type check feedScroll event parameters`
        )
    end
    arg1:sendEventDeferred(arg2, "feedScroll", (Cryo.Dictionary.join(arg3, { direction = str1 })))
end
