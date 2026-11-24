-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperimentCacheManagerParent = script:FindFirstAncestor("ExperimentCacheManager").Parent
local Dash = require(ExperimentCacheManagerParent.Dash)
local getAllAppUserLayers = require(ExperimentCacheManagerParent.ExperimentLayers).getAllAppUserLayers

return function()
    local allAppUserLayers = getAllAppUserLayers()
    return Dash.values(allAppUserLayers)
end
