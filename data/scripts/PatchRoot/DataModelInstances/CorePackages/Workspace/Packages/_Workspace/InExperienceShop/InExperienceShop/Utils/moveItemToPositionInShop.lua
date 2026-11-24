-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function moveItemToPositionInShop(tbl1, num1: number, id: string, itemType, num2: number)
    local var1 = tbl1[num1]
    if var1 == nil then
        return tbl1
    end

    local var2 = nil
    for k, item in var1.items do
        if item.itemType == itemType and item.id == id then
            var2 = k
            break
        end
    end

    if var2 == nil then
        return tbl1
    end

    local num3 = math.clamp(num2, 1, #var1.items)
    if var2 == num3 then
        return tbl1
    end

    local item = var1.items[var2]
    local items = table.clone(var1.items)
    table.remove(items, var2)
    table.insert(items, num3, item)

    local var4 = table.clone(var1)
    var4.items = items
    local var5 = table.clone(tbl1)
    var5[num1] = var4
    return var5
end

return moveItemToPositionInShop
