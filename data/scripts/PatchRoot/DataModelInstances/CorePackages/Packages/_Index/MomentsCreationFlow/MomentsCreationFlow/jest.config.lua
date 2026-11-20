-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent

return {
    projects = { require(scriptParent.Components.Tests)["jest.config"], require(scriptParent.Thunks.Tests)["jest.config"], require(scriptParent.Utils.Tests)["jest.config"] }
}
