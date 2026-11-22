-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local createSignal = Signals.createSignal

local function createToastStore()
    local num1 = 0
    local getToasts, var2 = createSignal({})

    local function triggerToast(tbl1): number
        num1 += 1
        local tbl2 = { id = num1, data = tbl1 }
        local var3 = getToasts(false)

        if #var3 >= 4 then
            local tbl3 = {}
            for i = #var3 - 4 + 2, #var3 do
                table.insert(tbl3, var3[i])
            end
            table.insert(tbl3, tbl2)
            var2(tbl3)
        else
            local var4 = table.clone(var3)
            table.insert(var4, tbl2)
            var2(var4)
        end

        return tbl2.id
    end

    return {
        getToasts = getToasts,
        getToast = Signals.createComputed(function(arg1)
            local var3 = getToasts(arg1)

            if #var3 == 0 then
                return nil
            end

            return var3[#var3].data
        end),
        triggerToast = triggerToast,
        dismissToast = function(id: number)
            local tbl1 = {}

            for _, value in (getToasts(false)) do
                if value.id ~= id then
                    table.insert(tbl1, value)
                end
            end
            var2(tbl1)
        end
    }
end
return createToastStore
