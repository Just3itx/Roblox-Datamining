-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function getWidgetItemIdsFromWidgetInfo(arg1, num1: number)
    local widgetItemIdsFromWidgetInfo = {}
    if not (arg1 and arg1.content) then
        return widgetItemIdsFromWidgetInfo
    end
    local content = arg1.content
    local contentLen = #content

    for i = 1, math.min(contentLen, num1) do
        local var1 = content[i]
        if var1 ~= nil and var1.id ~= nil then
            table.insert(widgetItemIdsFromWidgetInfo, tostring(var1.id))
        end
    end
    return widgetItemIdsFromWidgetInfo
end

return getWidgetItemIdsFromWidgetInfo
