-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:00:46Z
-- Luau bytecode version: 9 | Luau type version: 3
local Actions = require(script.Actions)
local Content = require(script.Content)
local Leading = require(script.Leading)
return {
    Root = require(script.HeaderBar),
    Leading = Leading,
    Trailing = require(script.Trailing),
    Content = Content,
    Actions = Actions
}
