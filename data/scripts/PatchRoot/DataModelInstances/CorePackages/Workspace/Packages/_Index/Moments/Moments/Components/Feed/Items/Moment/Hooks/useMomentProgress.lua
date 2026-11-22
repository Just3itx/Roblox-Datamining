-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local MomentContext = require(script.Parent.Parent.MomentContext)

local tbl1 = { time = 0, duration = 0, ratio = 0 }

local function useMomentProgress()
    local var1 = MomentContext.useMoment()

    return (Signals.createComputed(function(arg1)
        local controller = var1.controller
        if controller == nil then
            return tbl1
        end

        local time = controller.getPosition(arg1)
        local duration = controller.getState(arg1).duration

        return if duration <= 0 then tbl1 else {
            time = time,
            duration = duration,
            ratio = time / duration
        }
    end))
end

return useMomentProgress
