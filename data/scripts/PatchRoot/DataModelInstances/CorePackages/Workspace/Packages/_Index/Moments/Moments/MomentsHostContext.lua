-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local MomentsHostContext = React.createContext(nil)

return {
    MomentsHostContext = MomentsHostContext,
    useMomentsHost = function()
        local var1 = React.useContext(MomentsHostContext)
        return if var1 == nil then {} else var1
    end
}
