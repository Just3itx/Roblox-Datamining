-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent
local FFlagSduiAlwaysCacheWithIdentifier = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAlwaysCacheWithIdentifier

local function resolveSduiCacheEntry(tbl1, str1: string, str2: string?)
    if not tbl1 then
        return nil
    end
    local var1 = tbl1[str2 or str1]
    if var1 then
        return var1
    end
    if str2 == nil then
        if FFlagSduiAlwaysCacheWithIdentifier then
            local var2 = nil
            for _, value in tbl1 do
                if var2 ~= nil then
                    return nil
                end

                var2 = value
            end

            return var2
        end
        for _, value in tbl1 do
            return value
        end
    end
    return nil
end

return resolveSduiCacheEntry
