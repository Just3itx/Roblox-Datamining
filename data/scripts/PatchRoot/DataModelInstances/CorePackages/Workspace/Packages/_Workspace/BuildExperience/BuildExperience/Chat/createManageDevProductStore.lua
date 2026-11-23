-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local DeveloperProduct = require(BuildExperienceParent.DataHydration.DeveloperProduct)
local HttpClient = require(BuildExperienceParent.HttpClient)
local createManageDevProductNetwork = require(script.Parent.createManageDevProductNetwork)

local function createManageDevProductStore()
    return DeveloperProduct.createDeveloperProductStore(
        {
            network = createManageDevProductNetwork(HttpClient.createRequestInternalNetwork())
        }
    )
end
return createManageDevProductStore
