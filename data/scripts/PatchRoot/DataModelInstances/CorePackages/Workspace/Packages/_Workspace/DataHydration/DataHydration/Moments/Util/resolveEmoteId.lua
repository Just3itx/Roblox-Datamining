-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local isCanonicalNonzeroUuid = require(script.Parent.isCanonicalNonzeroUuid)

local function normalizeName(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = string.gsub(string.lower(str1), "%-", "")
    return if var1 == "crying" then "cry" else var1
end

return {
    resolveEmoteIdForReaction = function(tbl1, id)
        local var1 = normalizeName(id)

        for _, value in tbl1 do
            if value.id == id then
                return value.id
            end

            if normalizeName(value.name) == var1 then
                return value.id
            end
        end

        return id
    end,
    resolveOptionalEmoteIdForReaction = function(tbl1, arg1)
        local var1 = normalizeName(arg1)

        for _, value in tbl1 do
            if normalizeName(value.name) == var1 and isCanonicalNonzeroUuid(value.id) then
                return value.id
            end
        end
        return nil
    end,
    reactionTypeForEmoteId = function(tbl1, id: string)
        for _, value in tbl1 do
            if value.id == id then
                return normalizeName(value.name)
            end
        end

        return id
    end,
    normalizeName = normalizeName
}
