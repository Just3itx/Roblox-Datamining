-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)

local function getFooterVisibilityFromItemFooters(tbl1)
    local tbl2 = { isCreatorNameVisible = false, isTitleVisible = false, isPriceVisible = false }

    if not tbl1 then
        return tbl2
    end
    for _, value in tbl1 do
        if value.contentType == "AgentName" then
            tbl2.isCreatorNameVisible = true
        elseif value.contentType == "Price" then
            tbl2.isPriceVisible = true
        elseif value.contentType == "ItemName" then
            tbl2.isTitleVisible = true
        end
    end
    return tbl2
end

return getFooterVisibilityFromItemFooters
