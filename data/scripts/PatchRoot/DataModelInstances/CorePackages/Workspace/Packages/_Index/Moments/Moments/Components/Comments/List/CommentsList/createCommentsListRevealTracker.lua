-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _ViewRecycler = require(MomentsParent.ViewRecycler)

local function createCommentsListRevealTracker(tbl1)
    local var1 = tbl1.schedule or function(arg1)
        task.defer(arg1)
    end
    local tbl2 = {}
    local var2 = nil
    local bool1 = false
    local bool2 = false

    local function reveal() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        bool1 = true
        tbl1.onReady()
    end

    local function isVisibleRangeMeasured()
        local var3 = var2
        if var3 == nil or var3.lastIndex < var3.firstIndex then
            return false
        end
        for i = var3.firstIndex, var3.lastIndex do
            local itemKey = tbl1.getItemKey(i)
            if itemKey == nil or not tbl2[itemKey] then
                return false
            end
        end
        return true
    end

    local function check()
        bool2 = false
        if not bool1 and isVisibleRangeMeasured() then
            reveal()
        end
    end

    local function scheduleCheck() -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 or bool2 then
            return
        end
        bool2 = true
        var1(check)
    end

    local layout = tbl1.layout
    local updateItemMeasurement = layout.updateItemMeasurement
    function layout.updateItemMeasurement(arg1)
        local var3 = updateItemMeasurement(arg1)
        if var3.accepted and not bool1 then
            tbl2[arg1.itemKey] = true
            scheduleCheck()
        end

        return var3
    end

    return {
        onVisibleRangeChanged = function(arg1)
            var2 = arg1
            scheduleCheck()
        end,
        reveal = reveal,
        destroy = function()
            bool1 = true
        end
    }
end

return createCommentsListRevealTracker
