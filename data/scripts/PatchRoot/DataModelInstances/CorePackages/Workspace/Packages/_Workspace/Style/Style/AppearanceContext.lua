-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent
return require(StyleParent.React).createContext({
    theme = "dark",
    setTheme = function(_: string) end
})
