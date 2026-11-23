-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local GamePassConfig = require(BuildExperienceParent.DataHydration.GamePassConfig)
local HttpClient = require(BuildExperienceParent.HttpClient)
local createManageDevProductNetwork = require(script.Parent.createManageDevProductNetwork)

local function createManageGamePassStore()
    return GamePassConfig.createGamePassConfigStore(
        {
            network = createManageDevProductNetwork(HttpClient.createRequestInternalNetwork(), { label = "GamePassConfig" })
        }
    )
end

return createManageGamePassStore
