-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local createImmersiveChromeStore = require(script.createImmersiveChromeStore)

return Signals.createComputed(createImmersiveChromeStore)
