-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local Signals = require(CollectionViewsParent.Signals)

local createMainCollectionLayoutStore = require(script.Parent.createMainCollectionLayoutStore)

return Signals.createComputed(createMainCollectionLayoutStore)
