-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:19:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local TransientUIOverlayParent = script:FindFirstAncestor("TransientUIOverlay").Parent

local Signals = require(TransientUIOverlayParent.Signals)
local createTransientUIOverlayStore = require(script.createTransientUIOverlayStore)

return Signals.createComputed(createTransientUIOverlayStore)
