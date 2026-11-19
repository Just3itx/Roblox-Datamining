-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:51:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _BaseMenu = require(Foundation.Components.BaseMenu)
local _Types = require(Foundation.Components.Types)

local function markSelectedItem(arg1, id)
    if id == nil then
        return arg1, nil
    end
    local tbl1 = {}
    local var1 = nil
    for _, value in arg1 do
        if value.id then
            if value.id == id then
                value = table.clone(value)
                value.isChecked = true
                var1 = value
            end

            table.insert(tbl1, value)
        elseif value.items then
            local items, var3 = markSelectedItem(value.items, id)
            table.insert(tbl1, { title = value.title, items = items })
            var1 = var1 or var3
        end
    end

    return tbl1, var1
end

return markSelectedItem
