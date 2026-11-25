-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local StyleParent = script:FindFirstAncestor("Style").Parent

local _Foundation = require(StyleParent.Foundation)
local getAppFoundationThemeName, setAppFoundationThemeName = require(StyleParent.Signals).createSignal(nil)

return {
    getAppFoundationThemeName = getAppFoundationThemeName,
    setAppFoundationThemeName = setAppFoundationThemeName
}
