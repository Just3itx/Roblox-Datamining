-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")

local _Recipient = require(ShareSheet.Recipients.Recipient)

local function getSelectableRecipients(tbl1, tbl2)
    local tbl3 = {}
    for _, value in tbl1 do
        tbl3[value.id] = true
    end
    local var1 = table.clone(tbl1)
    for _, value in tbl2 do
        if not tbl3[value.id] then
            table.insert(var1, value)
        end
    end
    return var1
end

return getSelectableRecipients
