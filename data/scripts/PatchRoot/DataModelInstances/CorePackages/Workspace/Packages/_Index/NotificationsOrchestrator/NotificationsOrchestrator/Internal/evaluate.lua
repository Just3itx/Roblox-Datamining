-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local _Types = require(NotificationsOrchestrator.Types)

local function countWithin(shownAt, num1: number, seconds: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = num1 - seconds
    local num3 = 0
    for _, value in shownAt do
        if num2 <= value then
            num3 += 1
        end
    end
    return num3
end

local function evaluate(arg1, arg2, func1: (...any) -> (...any), num1: number): boolean
    if arg1 == nil then
        return true
    end

    local bool1 = arg1.cooldownSeconds ~= nil
    local bool2 = arg1.maxImpressions ~= nil
    if not (bool1 or bool2) then
        return true
    end

    local var1 = func1()
    local cooldownSeconds = arg1.cooldownSeconds
    if cooldownSeconds ~= nil and var1.lastShownAt > 0 and num1 - var1.lastShownAt < cooldownSeconds then
        return false
    end
    if arg1.maxImpressions == nil then
        return true
    end

    return (if typeof(arg2) == "table" and arg2.kind == "rolling" then countWithin(var1.shownAt, num1, arg2.seconds) else var1.count) < arg1.maxImpressions
end

return evaluate
