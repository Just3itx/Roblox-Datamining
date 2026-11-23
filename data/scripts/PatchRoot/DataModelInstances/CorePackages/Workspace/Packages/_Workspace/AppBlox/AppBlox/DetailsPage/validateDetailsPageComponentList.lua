-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local ContentPosition = require(script.Parent.ContentPosition)

local t = require(AppBloxParent.t)

return t.map(
    t.string,
    t.strictInterface({
        portraitLayoutOrder = t.integer,
        portraitZIndex = t.optional(t.integer),
        landscapeLayoutOrder = t.integer,
        landscapePosition = ContentPosition.isEnumValue,
        renderComponent = t.callback,
        showCornerGradient = t.optional(t.boolean),
        useSelectionBumper = t.optional(t.boolean),
        visible = t.optional(t.boolean)
    })
)
