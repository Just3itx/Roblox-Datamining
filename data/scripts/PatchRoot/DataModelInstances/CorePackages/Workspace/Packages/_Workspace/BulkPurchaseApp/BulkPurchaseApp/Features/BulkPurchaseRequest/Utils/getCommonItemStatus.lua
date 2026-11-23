-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCommonItemStatus(tbl1)
    local var1 = nil
    for _, value in tbl1 do
        if var1 ~= nil and value ~= var1 then
            return nil
        end
        if var1 == nil then
            var1 = value
        end
    end

    return var1
end

return getCommonItemStatus
