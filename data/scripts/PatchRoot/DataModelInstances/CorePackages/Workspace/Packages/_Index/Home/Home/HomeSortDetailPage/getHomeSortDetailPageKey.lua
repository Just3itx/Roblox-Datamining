-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")

local HomeSortDetailConstants = require(Home.HomeSortDetailPage.HomeSortDetailConstants)

local function getHomeSortDetailPageKey(str1: string?, num1: number?): string
    local var1 = if str1 == nil or str1 == "" then "Unknown" else str1
    if num1 ~= nil then
        return `{HomeSortDetailConstants.ConfigKeyPrefix}-{var1}-{num1}`
    end
    return `{HomeSortDetailConstants.ConfigKeyPrefix}-{var1}`
end

return getHomeSortDetailPageKey
