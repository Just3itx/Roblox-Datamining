-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)

local function extractShareInfo(arg1): {hasShared: boolean, shareCount: number}? -- Luacid: Inlined by compiler; 1 call site recovered
    local stats = arg1.stats
    if stats == nil or type(stats.shareCount) ~= "number" then
        return nil
    end

    return {
        shareCount = math.max(stats.shareCount, 0),
        hasShared = false
    }
end

local function extractShareInfoByMomentId(tbl1)
    local result = ({})

    if tbl1 == nil then
        return result
    end

    for _, value in tbl1 do
        local var1 = value.entityId or value.id
        if var1 == nil then
            continue
        end

        local var2 = extractShareInfo(value)

        if var2 ~= nil then
            result[var1] = var2
        end
    end

    return result
end

return extractShareInfoByMomentId
