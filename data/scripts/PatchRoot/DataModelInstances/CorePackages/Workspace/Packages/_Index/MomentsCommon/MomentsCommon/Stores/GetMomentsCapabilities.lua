-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent
local Signals = require(MomentsCommonParent.Signals)
local createMomentsCapabilities = require(script.createMomentsCapabilities)

return Signals.createComputed(function(_)
    return createMomentsCapabilities()
end)
