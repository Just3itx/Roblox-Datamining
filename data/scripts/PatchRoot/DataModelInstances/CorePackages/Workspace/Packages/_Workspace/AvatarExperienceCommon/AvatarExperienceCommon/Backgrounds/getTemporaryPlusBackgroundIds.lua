-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local FStringAXPlusExclusiveBackgroundIds = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FStringAXPlusExclusiveBackgroundIds

local var1 = nil
local var2 = table.freeze({})
local bool1 = false

local function isNumericId(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(str1, "^%d+$") ~= nil
end

local function getTemporaryPlusBackgroundIds()
    local var3 = FStringAXPlusExclusiveBackgroundIds()
    if var3 == var1 then
        return var2, bool1
    end

    var1 = var3
    if string.gsub(var3, "^%s*(.-)%s*$", "%1") == "" then
        bool1 = false
        var2 = table.freeze({})
        return var2, bool1
    end

    if string.find(var3, "[;|]") ~= nil then
        bool1 = true
        var2 = table.freeze({})
        return var2, bool1
    end

    local tbl1 = ({})
    for _, value in string.split(var3, ",") do
        local var4 = string.gsub(value, "^%s*(.-)%s*$", "%1")
        if var4 == "" then
            continue
        end

        if not isNumericId(var4) then
            bool1 = true
            var2 = table.freeze({})
            return var2, bool1
        end
        tbl1[var4] = true
    end

    bool1 = false
    var2 = table.freeze(tbl1)
    return var2, bool1
end

return getTemporaryPlusBackgroundIds
