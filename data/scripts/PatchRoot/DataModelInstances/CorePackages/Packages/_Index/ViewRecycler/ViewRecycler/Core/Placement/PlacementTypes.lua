-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local IdentityKind = require(ViewRecycler.Core.Enums.IdentityKind)
local PinnedPosition = require(ViewRecycler.Core.Enums.PinnedPosition)

return table.freeze({
    IdentityKind = IdentityKind,
    ITEM_PLACEMENT_KEYS = table.freeze({ "mainAxisOffset", "mainAxisLength", "mainAxisEndLimit", "zIndex" }),
    PinnedPosition = PinnedPosition
})
