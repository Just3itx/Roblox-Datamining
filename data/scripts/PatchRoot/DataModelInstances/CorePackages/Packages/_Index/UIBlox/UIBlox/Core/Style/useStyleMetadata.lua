-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local StyleContext = require(scriptParent.StyleContext)
local React = require(scriptParentParentParentParent.React)

local function useStyleMetadata()
    local var1 = React.useContext(StyleContext)
    return if var1 then var1.styleMetadata else nil
end

return useStyleMetadata
