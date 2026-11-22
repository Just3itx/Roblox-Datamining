-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local createPostInsightsCoachmarkSessionStore = require(script.Parent.createPostInsightsCoachmarkSessionStore)

return Signals.createComputed(createPostInsightsCoachmarkSessionStore)
