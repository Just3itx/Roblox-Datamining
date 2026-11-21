-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local Signals = require(CloudClientOfferParent.Signals)
local createCloudClientOffer = require(CloudClientOffer.createCloudClientOffer)

local getDefaultCloudClientOfferDependencies = require(CloudClientOffer.getDefaultCloudClientOfferDependencies).getDefaultCloudClientOfferDependencies

return Signals.createComputed(function()
    return createCloudClientOffer(getDefaultCloudClientOfferDependencies())
end)
