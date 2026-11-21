-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local SearchTypes = require(DiscoveryUtilsParent.RobloxAppEnums).SearchTypes

local function isSearchTypeInOmniSearch(arg1): boolean
    return arg1 == SearchTypes.Games or arg1 == SearchTypes.Players or arg1 == SearchTypes.Auto or arg1 == SearchTypes.TopResults
end

return isSearchTypeInOmniSearch
