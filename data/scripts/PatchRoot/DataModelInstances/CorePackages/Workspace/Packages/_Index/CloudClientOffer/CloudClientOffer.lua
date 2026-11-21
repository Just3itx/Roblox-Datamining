-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _createCloudClientOffer = require(script.createCloudClientOffer)
local CloudClientServiceAdapter = require(script.CloudClientServiceAdapter)

return {
    ["jest.config"] = script["jest.config"],
    CloudClientOfferSheet = require(script.Components.CloudClientOfferSheet),
    createCloudClientServiceAdapter = CloudClientServiceAdapter.createCloudClientServiceAdapter,
    getCloudClientServiceAdapter = CloudClientServiceAdapter.getCloudClientServiceAdapter,
    GetCloudClientOfferStore = require(script.Stores.GetCloudClientOfferStore),
    GetCloudClientSessionStore = require(script.Stores.GetCloudClientSessionStore),
    OpenCloudClientOfferSheet = require(script.Thunks.OpenCloudClientOfferSheet)
}
