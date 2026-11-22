-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local CommentRowView = require(script.Parent.CommentRowView)
local useCommentRowViewModel = require(script.Parent.useCommentRowViewModel)

local function CommentRowContainer(arg1)
    local var1 = useCommentRowViewModel(arg1)
    return React.createElement(CommentRowView, var1)
end

return CommentRowContainer
