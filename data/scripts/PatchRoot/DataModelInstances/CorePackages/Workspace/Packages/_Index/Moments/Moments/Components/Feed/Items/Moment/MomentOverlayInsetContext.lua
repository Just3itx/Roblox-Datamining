-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local Context = React.createContext(0)

return {
    Context = Context,
    useMomentOverlayInset = function()
        return React.useContext(Context)
    end
}
