-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local FocusContext = require(script.Parent.FocusContext)

local function useFocusController()
    local var1 = React.useContext(FocusContext)
    return if var1 then var1.focusNode.focusController else nil
end

return useFocusController
