-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local Cryo = require(SduiSharedUtilitiesParent.Cryo)

local function accumulateSduiCacheSubEntries(tbl1, tbl2)
    local var1 = Cryo.Dictionary.join(tbl2 or {}, {})
    for value, value2 in tbl1 do
        local var2 = var1[value]
        if var2 then
            value2 = Cryo.Dictionary.join(var2, value2)
        end

        var1[value] = value2
    end
    return var1
end

return accumulateSduiCacheSubEntries
