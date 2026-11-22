-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readInputValue(inputData) -- Luacid: Inlined by compiler; 2 call sites recovered
    local kind = if inputData == nil then nil else inputData.kind
    return if kind == nil then nil else kind.value
end

local function isFeed(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return type(arg1) == "table" and type(arg1.entry_map) == "table"
end

local tbl1 = {
    "universe_items",
    "game_items",
    "song_items",
    "event_items",
    "user_items",
    "items",
    "cards"
}
local function hasItemList(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in tbl1 do
        if type(tbl2[value]) == "table" then
            return true
        end
    end
    return false
end

local function hasSortId(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local sortId = arg1.sort_id
    return not (sortId == nil) and sortId ~= ""
end

local function readPoolId(arg1): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    local poolId = arg1.pool_id
    return if type(poolId) == "string" and poolId ~= "" then poolId else nil
end

local function readSortId(str1: string, tbl2): string -- Luacid: Inlined by compiler; 1 call site recovered
    local sortId = tbl2.sort_id
    if sortId ~= nil and sortId ~= "" then
        return tostring(sortId)
    end
    return str1
end

local function countSortItems(tbl2, arg1, tbl3, str1: string)
    local var1 = readPoolId(tbl2)

    if var1 == nil then
        local num1 = 0
        for _, value in tbl1 do
            local var2 = tbl2[value]
            if type(var2) == "table" then
                num1 += #var2
            end
        end
        return num1
    end

    local str2 = `{str1}/{var1}`
    if tbl3[str2] then
        return 0
    end
    tbl3[str2] = true
    local contentPools = arg1.content_pools
    local contentPool = if type(contentPools) == "table" then contentPools[var1] else nil
    local items = if type(contentPool) == "table" then contentPool.items else nil
    return if type(items) == "table" then #items else 0
end

local function buildHomeFeedStats(arg1)
    local homeFeedStats = ({})
    if type(arg1) ~= "table" then
        return homeFeedStats
    end
    local tbl2 = {}
    for _, value in arg1.page_entries or {} do
        local var1 = readInputValue(value.input_data)

        if not isFeed(var1) then
            continue
        end

        for position, value3 in var1.entry_order or {} do
            local var2 = var1.entry_map[value3]
            if var2 == nil then
                continue
            end

            local var3 = readInputValue(var2.input_data)
            if type(var3) ~= "table" then
                continue
            end

            local bool1 = readPoolId(var3) ~= nil or hasItemList(var3)

            if not (bool1 or hasSortId(var3)) then
                continue
            end

            local str1 = readSortId(value3, var3)
            local itemCount = if bool1 then countSortItems(var3, var1, tbl2, str1) else nil
            local homeFeedStat = homeFeedStats[str1]
            if homeFeedStat == nil then
                homeFeedStats[str1] = { itemCount = itemCount, position = position }
            elseif itemCount ~= nil then
                homeFeedStat.itemCount = (homeFeedStat.itemCount or 0) + itemCount
            end
        end
    end
    return homeFeedStats
end

return buildHomeFeedStats
