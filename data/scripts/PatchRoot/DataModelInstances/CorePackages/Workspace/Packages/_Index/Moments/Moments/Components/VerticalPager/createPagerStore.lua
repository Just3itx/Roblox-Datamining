-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Cryo = require(MomentsParent.Cryo)
local Signals = require(MomentsParent.Signals)
local SignalsExperimental = require(MomentsParent.SignalsExperimental)

local snapMath = require(script.Parent.snapMath)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createPagerStore()
    local getItems, var2 = createSignal({})
    local getCurrentIndex, var4 = createSignal(1)

    local getCount = createComputed(function(arg1): number
        return #getItems(arg1)
    end)

    local getCurrentItem = createComputed(function(arg1)
        return getItems(arg1)[getCurrentIndex(arg1)]
    end)

    local function goToItem(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        var4(snapMath.clampIndex(num1, #getItems(false)))
    end

    return {
        getItems = getItems,
        getCount = getCount,
        getCurrentIndex = getCurrentIndex,
        getCurrentItem = getCurrentItem,
        addItems = function(tbl1)
            if #tbl1 == 0 then
                return
            end
            var2((Cryo.List.join(getItems(false), tbl1)))
        end,
        addItemAt = function(num1: number, arg1)
            local var5 = getItems(false)
            local num2 = #var5
            local num3 = math.clamp(num1, 1, num2 + 1)

            local var6 = table.clone(var5)
            table.insert(var6, num3, arg1)

            SignalsExperimental.batch(function()
                var2(var6)
                if not (num2 > 0) then
                    return
                end

                local var7 = getCurrentIndex(false)
                if num3 <= var7 then
                    var4(snapMath.clampIndex(var7 + 1, #var6))
                end
            end)
        end,
        removeItem = function(num1: number)
            local var5 = getItems(false)
            if num1 < 1 or #var5 < num1 then
                return
            end

            local var6 = table.clone(var5)
            table.remove(var6, num1)

            SignalsExperimental.batch(function()
                var2(var6)
                var4(snapMath.reindexAfterRemoval(getCurrentIndex(false), num1, #var6))
            end)
        end,
        setItems = function(tbl1)
            SignalsExperimental.batch(function()
                var2(table.clone(tbl1))
                var4(snapMath.clampIndex(getCurrentIndex(false), #tbl1))
            end)
        end,
        reset = function()
            SignalsExperimental.batch(function()
                var2({})
                var4(1)
            end)
        end,
        nextItem = function()
            goToItem(getCurrentIndex(false) + 1)
        end,
        previousItem = function()
            goToItem(getCurrentIndex(false) - 1)
        end,
        goToItem = goToItem,
        dispose = function() end
    }
end

return createPagerStore
