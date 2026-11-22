-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local Context = React.createContext(nil)

return {
    Context = Context,
    useMomentPushedFeedSafeArea = function()
        return React.useContext(Context)
    end
}
