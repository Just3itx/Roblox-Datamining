-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:50:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local CursorContext = require(script.Parent.CursorContext)

local function withCursor(render)
    return React.createElement(CursorContext.Consumer, { render = render })
end

return withCursor
