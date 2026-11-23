-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local DeveloperSubscription = require(BuildExperienceParent.DataHydration.DeveloperSubscription)
local HttpClient = require(BuildExperienceParent.HttpClient)
local createManageDevProductNetwork = require(script.Parent.createManageDevProductNetwork)

local function createManageSubscriptionStore()
    return DeveloperSubscription.createDeveloperSubscriptionStore({
        network = createManageDevProductNetwork(HttpClient.createRequestInternalNetwork(), { label = "DeveloperSubscription" })
    })
end

return createManageSubscriptionStore
