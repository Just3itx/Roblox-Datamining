-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local Dash = require(scriptParentParentParent.Dash)

return React.createContext({ fireEvent = Dash.noop })
