-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:00:53Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagMarketplaceOffersOptOutRootLowSpender = require(script.Parent.FFlagMarketplaceOffersOptOutRootLowSpender)
local FFlagMarketplaceOffersOptOutRootNoSpender = require(script.Parent.FFlagMarketplaceOffersOptOutRootNoSpender)
local FFlagMarketplaceOffersOptOutRootRandom = require(script.Parent.FFlagMarketplaceOffersOptOutRootRandom)

return FFlagMarketplaceOffersOptOutRootLowSpender
    or FFlagMarketplaceOffersOptOutRootNoSpender
    or FFlagMarketplaceOffersOptOutRootRandom
