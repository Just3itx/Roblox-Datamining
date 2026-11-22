-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)

return {
    Players = game:GetService("Players"),
    llama = LuaSocialLibrariesDeps.llama,
    Rodux = require(scriptParentParent.Rodux)
}
