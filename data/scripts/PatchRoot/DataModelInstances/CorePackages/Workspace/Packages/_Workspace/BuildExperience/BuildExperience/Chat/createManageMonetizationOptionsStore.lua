-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local HttpClient = require(BuildExperienceParent.HttpClient)
local MonetizationOptions = require(BuildExperienceParent.DataHydration.MonetizationOptions)
local createManageDevProductNetwork = require(script.Parent.createManageDevProductNetwork)

local function createManageMonetizationOptionsStore()
    return MonetizationOptions.createMonetizationOptionsStore({
        network = createManageDevProductNetwork(HttpClient.createRequestInternalNetwork(), { label = "MonetizationOptions" })
    })
end

return createManageMonetizationOptionsStore
