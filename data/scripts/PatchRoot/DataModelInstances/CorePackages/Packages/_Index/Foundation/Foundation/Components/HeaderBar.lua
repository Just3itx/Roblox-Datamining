-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
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
