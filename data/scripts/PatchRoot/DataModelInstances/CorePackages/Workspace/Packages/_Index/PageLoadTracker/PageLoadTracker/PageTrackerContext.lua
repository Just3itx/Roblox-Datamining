-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local PageLoadTrackerParent = script:FindFirstAncestor("PageLoadTracker").Parent
local React = require(PageLoadTrackerParent.React)

local _createPageTracker = require(script.Parent.createPageTracker)

return React.createContext(nil)
