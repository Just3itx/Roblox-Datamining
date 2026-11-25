-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local RequestType = require(PurchasePrompt.Enums.RequestType)

local str1 = game:DefineFastString("BlackbirdUpsellHiddenRequestTypes2", "")

local function trim(str2: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (str2:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function matchesHiddenRequestTypeList(none, str2: string)
    if none == nil or none == RequestType.None then
        return false
    end

    if str2 == "" then
        return false
    end

    local str3 = string.lower(tostring(none))

    for value in string.gmatch(str2, "[^,]+") do
        local str4 = string.lower((trim(value)))
        if str4 ~= "" and str3 == "requesttype." .. str4 then
            return true
        end
    end

    return false
end

return {
    isRequestTypeHiddenFromBlackbirdUpsell = function(none): boolean
        return (matchesHiddenRequestTypeList(none, str1))
    end,
    matchesHiddenRequestTypeList = matchesHiddenRequestTypeList
}
