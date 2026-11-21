-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)

local Context = React.createContext(nil)

return {
    Context = Context,
    useObservingUserId = function()
        return React.useContext(Context)
    end
}
