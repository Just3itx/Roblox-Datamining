-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local CloudClientOfferParent = script:FindFirstAncestor("CloudClientOffer").Parent

local Signals = require(CloudClientOfferParent.Signals)
local createCloudClientSessionStore = require(script.createCloudClientSessionStore)

return Signals.createComputed(createCloudClientSessionStore)
