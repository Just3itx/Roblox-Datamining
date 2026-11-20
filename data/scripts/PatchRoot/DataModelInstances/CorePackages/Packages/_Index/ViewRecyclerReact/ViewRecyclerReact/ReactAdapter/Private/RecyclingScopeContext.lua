-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local React = require(ViewRecyclerReact.Parent.React)

local _RecyclingRoot = require(script.Parent.RecyclingRoot)

return React.createContext(nil)
