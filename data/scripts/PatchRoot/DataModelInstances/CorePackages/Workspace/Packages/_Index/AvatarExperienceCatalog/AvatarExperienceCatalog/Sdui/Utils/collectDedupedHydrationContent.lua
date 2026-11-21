-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local tbl1 = { Asset = true, Bundle = true, Look = true }

local function collectDedupedHydrationContent(tbl2, tbl3, tbl4, num1: number?)
    local num2 = if num1 then math.min(num1, #tbl2) else #tbl2

    for i = 1, num2 do
        local var1 = tbl2[i]
        local str1 = tostring(var1.type)
        local str2 = tostring(var1.id)
        if not tbl1[str1] then
            continue
        end

        local var2 = tbl4[str1] or {}
        if not var2[str2] then
            var2[str2] = true
            tbl4[str1] = var2

            table.insert(tbl3, var1)
        end
    end
end
return collectDedupedHydrationContent
