-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local Signals = require(GiftingParent.Signals)

local createCanGiftStore = require(Gifting.Stores.createCanGiftStore)

return Signals.createComputed(function()
    return createCanGiftStore()
end)
