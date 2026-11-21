-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function serializeFilterSelections(tbl1)
    if tbl1 == nil then
        return nil
    end
    local tbl2 = {}
    for value in tbl1 do
        table.insert(tbl2, value)
    end
    if #tbl2 == 0 then
        return nil
    end
    table.sort(tbl2)
    local tbl3 = {}
    for _, value in tbl2 do
        table.insert(tbl3, `{value}={tbl1[value]}`)
    end
    return table.concat(tbl3, "&")
end

local function getChartsSortDetailPageKey(str1: string?, str2: string?, tbl1): string
    local str3 = if str1 == nil or str1 == "" then "ChartsSortDetail-Unknown" elseif str2 and str2 ~= "" then `ChartsSortDetail-{str1}-{str2}` else `ChartsSortDetail-{str1}`
    local var1 = serializeFilterSelections(tbl1)
    if var1 then
        return `{str3}?{var1}`
    end
    return str3
end

return getChartsSortDetailPageKey
