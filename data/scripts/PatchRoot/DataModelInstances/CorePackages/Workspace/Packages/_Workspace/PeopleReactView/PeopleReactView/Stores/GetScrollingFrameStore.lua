-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Signals = require(PeopleReactViewParent.Signals)
local createScrollingFrameStore = require(script.createScrollingFrameStore)

return Signals.createComputed(createScrollingFrameStore)
