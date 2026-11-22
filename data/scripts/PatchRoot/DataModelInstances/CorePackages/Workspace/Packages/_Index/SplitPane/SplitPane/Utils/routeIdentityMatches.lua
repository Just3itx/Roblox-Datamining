-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local AppPage = require(SplitPaneParent.RobloxAppEnums).AppPage

local function getProfileType(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local extraProps = if tbl1 == nil then nil else tbl1.extraProps
    local profileType = if extraProps == nil then nil else extraProps.profileType
    return if profileType == nil then "User" else profileType
end

local function routeIdentityMatches(tbl1, str1: string, tbl2): boolean
    if tbl1.routeName ~= str1 then
        return false
    end
    local params = tbl1.params
    local detail = if tbl2 == nil then nil else tbl2.detail
    local detail2 = if params == nil then nil else params.detail
    return tostring(detail) == tostring(detail2)
        and (str1 ~= AppPage.ProfilePlatform or getProfileType(tbl2) == getProfileType(params))
end

return routeIdentityMatches
