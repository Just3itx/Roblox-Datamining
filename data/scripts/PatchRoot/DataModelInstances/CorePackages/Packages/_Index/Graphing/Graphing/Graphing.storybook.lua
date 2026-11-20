-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)
local ReactRoblox = require(GraphingParent.ReactRoblox)

return {
    name = "Graphing",
    storyRoots = { Graphing.Components },
    roact = React,
    reactRoblox = ReactRoblox
}
