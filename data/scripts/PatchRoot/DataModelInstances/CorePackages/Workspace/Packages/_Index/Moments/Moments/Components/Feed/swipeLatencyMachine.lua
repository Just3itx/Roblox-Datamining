-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local _MomentsCommon = require(MomentsParent.MomentsCommon)

local function swipeLatencyMachine(tbl1)
    local now = tbl1.now
    local var1 = nil

    local num1 = 0

    local function tryComplete() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var2 = var1
        if var2 == nil then
            return
        end
        local settledAt = var2.settledAt
        local frameAt = var2.frameAt
        if settledAt == nil or frameAt == nil then
            return
        end

        var1 = nil
        tbl1.onMeasurement(
            math.round(math.max(0, frameAt - settledAt)),
            math.round(math.max(frameAt, settledAt) - var2.committedAt),
            var2.dimensions
        )
    end

    local var2 = tbl1.schedule or task.delay

    local function armCap(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
        if tbl1.capMs <= 0 then
            return
        end
        var2(tbl1.capMs / 1000, function()
            if num2 ~= num1 then
                return
            end

            var1 = nil
        end)
    end

    return {
        start = function(bool1: boolean, bool2: boolean, dimensions)
            num1 += 1
            local var3 = now()
            local tbl2 = {
                committedAt = var3,
                settledAt = if bool1 then var3 else nil,
                frameAt = 0,
                dimensions = 0
            }

            if not bool2 then
                var3 = nil
            end

            tbl2.frameAt = var3
            tbl2.dimensions = dimensions
            var1 = tbl2

            armCap(num1)
            tryComplete()
        end,
        update = function(bool1: boolean, bool2: boolean)
            local var3 = var1
            if var3 == nil then
                return
            end
            if var3.settledAt == nil and bool1 then
                var3.settledAt = now()
            end
            if var3.frameAt == nil and bool2 then
                var3.frameAt = now()
            end

            tryComplete()
        end
    }
end
return swipeLatencyMachine
