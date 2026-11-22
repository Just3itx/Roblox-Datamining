-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local CommentsComposerView = require(script.Parent.CommentsComposerView)
local useCommentsComposerViewModel = require(script.Parent.useCommentsComposerViewModel)

local function CommentsComposerContainer(arg1)
    local var1 = useCommentsComposerViewModel(arg1)
    return React.createElement(CommentsComposerView, var1)
end

return CommentsComposerContainer
