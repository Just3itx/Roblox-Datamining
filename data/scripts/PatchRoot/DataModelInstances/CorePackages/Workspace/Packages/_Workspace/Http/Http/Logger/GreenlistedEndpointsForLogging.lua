-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["catalog/sponsored-items"] = "avatar_experience_sponsored_items",
    ["marketplace-widgets/v1/widgets?requestId"] = "avatar_experience_marketplace_widgets",
    ["v3/outfits"] = "avatar_experience_outfits",
    ["catalog/items/details"] = "avatar_experience_item_details",
    ["recommendations/user-inventory"] = "avatar_experience_recommended_user_inventory",
    ["v1/purchases/products"] = "avatar_experience_purchase_product",
    ["autocomplete-avatar/v2/suggest"] = "avatar_experience_auto_complete",
    ["topic/get-topics"] = "avatar_experience_get_topics",
    ["widgets/search"] = "avatar_experience_widget_search",
    ["widgets/hydrate"] = "avatar_experience_widget_hydrate",
    ["marketplace-widgets/v1/pills"] = "avatar_experience_catalog_categories"
}

local module = {}

function module.isSuccessStatusCode(_, num1: number): boolean
    return num1 >= 200 and num1 < 300
end

function module.getMatchingName(str1: string, num1: number)
    local var1 = nil
    local str2 = tostring(num1)
    local str3 = if module:isSuccessStatusCode(num1) then "api_success_" else "api_error_"

    for value, value2 in tbl1 do
        if string.find(str1, value, 1, true) then
            return str3 .. value2 .. "_" .. str2
        end
    end
    return var1
end

function module.sendStatusCodeCounter(str1: string, num1: number, arg1)
    arg1 = arg1 or game:GetService("RbxAnalyticsService")

    local matchingName = module.getMatchingName(str1, num1)
    if matchingName and arg1 then
        arg1:ReportCounter(matchingName, 1)
    end
end

return module
