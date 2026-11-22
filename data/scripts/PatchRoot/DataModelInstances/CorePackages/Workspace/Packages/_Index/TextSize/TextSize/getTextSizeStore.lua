-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local TextSize = script:FindFirstAncestor("TextSize")
local TextSizeParent = TextSize.Parent
local Signals = require(TextSizeParent.Signals)
local createTextSizeStore = require(TextSize.createTextSizeStore)

return Signals.createComputed(createTextSizeStore)
