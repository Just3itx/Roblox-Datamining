-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local CommentsPanelBodyView = require(script.Parent.CommentsPanelBodyView)
local useCommentsPanelBodyViewModel = require(script.Parent.useCommentsPanelBodyViewModel)

local function CommentsPanelBodyContainer(arg1)
    local var1 = useCommentsPanelBodyViewModel(arg1)
    return React.createElement(CommentsPanelBodyView, var1)
end

return CommentsPanelBodyContainer
