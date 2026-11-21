-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)

local getRemainingTime = require(script.Parent.getRemainingTime)

local tbl1 = { days = 86400, hours = 3600, minutes = 60, seconds = 1 }

local function getNextTickInterval(arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl1[arg1.unit]
    return math.max(arg1.secondsRemaining - arg1.value * var1 + 1, 0.05)
end

local function useRemainingTime(str1: string?)
    local var1, var2 = React.useState(function()
        return getRemainingTime(str1)
    end)

    React.useEffect(function()
        if not str1 then
            var2(nil)
            return
        end

        local bool1 = false
        local var3 = nil

        local function tick()
            if bool1 then
                return
            end

            local remainingTime = getRemainingTime(str1)
            var2(remainingTime)
            if not remainingTime or remainingTime.value < 0 then
                return
            end
            var3 = task.delay(getNextTickInterval(remainingTime), tick)
        end

        if not bool1 then
            local remainingTime = getRemainingTime(str1)
            var2(remainingTime)
            if remainingTime and not (remainingTime.value < 0) then
                var3 = task.delay(getNextTickInterval(remainingTime), tick)
            end
        end

        return function()
            bool1 = true
            if var3 then
                task.cancel(var3)
                var3 = nil
            end
        end
    end, { str1 })

    return var1
end

return useRemainingTime
