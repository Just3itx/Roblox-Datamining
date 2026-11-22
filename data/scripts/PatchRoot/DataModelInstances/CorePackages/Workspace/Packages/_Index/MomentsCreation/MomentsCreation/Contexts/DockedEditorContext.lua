-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

return require(MomentsCreationParent.React).createContext({
    setDockedEditorHeight = function(_: number) end
})
