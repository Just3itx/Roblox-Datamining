-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local DialogSize = require(Foundation.Enums.DialogSize)
return require(FoundationParent.React).createContext({
    size = DialogSize.Small,
    responsiveSize = DialogSize.Small,
    setResponsiveSize = function(_) end,
    hasHeroMedia = false,
    setHasHeroMedia = function(_: boolean) end,
    testId = "",
    closeAffordanceRef = nil,
    contentStartRef = nil,
    setContentStartRef = function(_) end
})
