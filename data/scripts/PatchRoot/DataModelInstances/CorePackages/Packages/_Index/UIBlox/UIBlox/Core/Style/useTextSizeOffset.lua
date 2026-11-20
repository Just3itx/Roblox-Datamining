-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local StyleContext = require(scriptParent.StyleContext)
local React = require(scriptParentParentParentParent.React)

local function useTextSizeOffset()
    return React.useContext(StyleContext).derivedValues.textSizeOffset
end

return useTextSizeOffset
