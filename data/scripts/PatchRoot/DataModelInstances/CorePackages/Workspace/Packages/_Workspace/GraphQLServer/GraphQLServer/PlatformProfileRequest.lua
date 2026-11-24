-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    hasPlatformFields = function(tbl1): boolean
        return table.find(tbl1, "names.platformName") ~= nil or table.find(tbl1, "platformProfileId") ~= nil
    end,
    normalizeProfiles = function(tbl1, tbl2)
        local bool1 = table.find(tbl2, "names.platformName") ~= nil
        local bool2 = table.find(tbl2, "platformProfileId") ~= nil
        if not (bool1 or bool2) then
            return tbl1
        end
        local result = {}
        for _, value in tbl1 do
            local var1 = table.clone(value)
            if bool1 then
                local names = type(value.names) ~= "table" and {} or table.clone(value.names)
                if type(names.platformName) ~= "string" then
                    names.platformName = ""
                end
                var1.names = names
            end
            if bool2 and type(var1.platformProfileId) ~= "string" then
                var1.platformProfileId = ""
            end
            table.insert(result, var1)
        end
        return result
    end
}
