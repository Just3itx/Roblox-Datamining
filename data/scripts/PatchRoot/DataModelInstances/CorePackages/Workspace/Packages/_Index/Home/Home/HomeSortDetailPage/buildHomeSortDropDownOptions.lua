-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")

local isHomeSortDetailSortIncluded = require(Home.HomeSortDetailPage.isHomeSortDetailSortIncluded)

local function isValidString(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return typeof(arg1) == "string" and arg1 ~= ""
end

local function buildHomeSortDropDownOptions(tbl1)
    local homeSortDropDownOptions = {}
    if typeof(tbl1) ~= "table" then
        return homeSortDropDownOptions
    end
    local entryOrder = tbl1.entry_order
    local entryMap = tbl1.entry_map
    if typeof(entryOrder) ~= "table" or typeof(entryMap) ~= "table" then
        return homeSortDropDownOptions
    end

    for storeIndex, entryIdentifier in entryOrder do
        local var1 = entryMap[entryIdentifier]
        local inputData = if typeof(var1) == "table" then var1.input_data else nil
        local kind = if typeof(inputData) == "table" then inputData.kind else nil
        local value3 = if typeof(kind) == "table" then kind.value else nil
        local sortId = if typeof(value3) == "table" then value3.sort_id else nil
        local title = if typeof(value3) == "table" then value3.title else nil
        local robloxComponent = if typeof(var1) == "table" then var1.roblox_component else nil

        if not (isValidString(entryIdentifier) and isValidString(sortId) and isValidString(title) and isValidString(robloxComponent)) then
            continue
        end

        local var2 = isHomeSortDetailSortIncluded

        if not var2(sortId, if typeof(kind) == "table" then kind.type else nil) then
            continue
        end
        table.insert(
            homeSortDropDownOptions,
            {
                topicId = tostring(sortId),
                displayName = title,
                entryIdentifier = entryIdentifier,
                storeIndex = storeIndex
            }
        )
    end

    return homeSortDropDownOptions
end

return buildHomeSortDropDownOptions
