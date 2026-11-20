-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)
local StyleContext = require(scriptParent.StyleContext)
local React = require(scriptParentParentParentParent.React)

local function useStyle()
    return React.useContext(StyleContext).style
end

return useStyle
