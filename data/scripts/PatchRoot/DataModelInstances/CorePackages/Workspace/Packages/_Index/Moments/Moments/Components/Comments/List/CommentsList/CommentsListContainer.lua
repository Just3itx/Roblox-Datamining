-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local CommentsListView = require(script.Parent.CommentsListView)
local useCommentsListViewModel = require(script.Parent.useCommentsListViewModel)

local function CommentsListContainer(arg1)
    local var1 = useCommentsListViewModel(arg1)
    return React.createElement(CommentsListView, var1)
end

return CommentsListContainer
