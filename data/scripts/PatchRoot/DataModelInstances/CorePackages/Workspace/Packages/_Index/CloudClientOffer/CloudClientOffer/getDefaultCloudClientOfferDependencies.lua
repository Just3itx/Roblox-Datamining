-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")

local CloudClientServiceAdapter = require(CloudClientOffer.CloudClientServiceAdapter)
local CloudClientExperiment = require(CloudClientOffer.CloudClientExperiment)
local _createCloudClientOffer = require(CloudClientOffer.createCloudClientOffer)
local GetCloudClientSessionStore = require(CloudClientOffer.Stores.GetCloudClientSessionStore)

local FStringLuaAppCloudClientPlayButtonIxpLayer = require(CloudClientOffer.Flags.FStringLuaAppCloudClientPlayButtonIxpLayer)

local tbl1 = {
    { kind = "RobloxReality" },
    { kind = "CloudPlay" }
}

return {
    getDefaultCloudClientOfferDependencies = function()
        return {
            service = CloudClientServiceAdapter.getCloudClientServiceAdapter(),
            experiment = CloudClientExperiment(game:GetService("IXPService"), FStringLuaAppCloudClientPlayButtonIxpLayer),
            session = GetCloudClientSessionStore(false),
            candidates = tbl1
        }
    end,
    OFFER_CANDIDATES = tbl1
}
