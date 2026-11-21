-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function getOrderedWidgets(tbl1)
    local tbl2 = {}
    for value in tbl1 do
        local var1 = tonumber(value)
        if var1 then
            table.insert(tbl2, var1)
        end
    end
    table.sort(tbl2)

    local orderedWidgets = {}
    for _, position in tbl2 do
        local widget = tbl1[tostring(position)]
        if widget.content and #widget.content > 0 then
            table.insert(orderedWidgets, { position = position, widget = widget })
        end
    end
    return orderedWidgets
end

return getOrderedWidgets
