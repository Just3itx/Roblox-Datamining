-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local t = require(scriptParentParentParentParentParent.t)

local validateFont = require(scriptParent.validateFont)
local validateSettings = require(scriptParent.validateSettings)
local validateTheme = require(scriptParent.validateTheme)

return (t.strictInterface({
    Theme = t.optional(validateTheme),
    Font = t.optional(validateFont),
    Tokens = t.optional(t.any),
    Settings = t.optional(validateSettings)
}))
