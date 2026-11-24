-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function getItemSlotCost(arg1, num1: number, func1: (...any) -> (...any)): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if func1(arg1, num1) then 2 else 1
end

local function buildUniformRows(tbl1, num1: number)
    local uniformRows = {}
    for i = 1, #tbl1, num1 do
        local tbl2 = {}
        local move = table.move
        local num2 = i + num1 - 1
        local num3 = #tbl1
        move(tbl1, i, math.min(num2, num3), 1, tbl2)
        table.insert(uniformRows, tbl2)
    end
    return uniformRows
end

return {
    buildItemGridRows = function(tbl1, num1: number, func1: ((...any) -> (...any))?)
        if func1 == nil then
            return (buildUniformRows(tbl1, num1))
        end

        local num2 = 1
        local tbl2 = {}

        while true do
            if not (num2 <= #tbl1) then
                return tbl2
            end

            local num3 = 1
            local tbl3 = {}
            local num4 = 0

            while num2 <= #tbl1 do
                local var1 = tbl1[num2]
                local itemSlotCost = getItemSlotCost(var1, num3, func1)

                if num1 < num4 + itemSlotCost and #tbl3 > 0 then
                    break
                end

                table.insert(tbl3, var1)
                num4 += itemSlotCost
                num2 += 1
                num3 += 1

                if num1 <= num4 then
                    break
                end
            end

            table.insert(tbl2, tbl3)
        end
    end,
    ROBUX_TILE_SLOT_COST = 2
}
