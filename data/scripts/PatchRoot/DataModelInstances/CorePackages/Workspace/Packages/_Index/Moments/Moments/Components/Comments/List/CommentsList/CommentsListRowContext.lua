-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _Foundation = require(MomentsParent.Foundation)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)

local CommentsListRowContext = React.createContext(nil)

return {
    CommentsListRowContext = CommentsListRowContext,
    useCommentsListRow = function()
        local var1 = React.useContext(CommentsListRowContext)
        assert(var1 ~= nil, "Comments list rows must render inside CommentsListRowContext")
        return var1
    end
}
