-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local PostStatusRowView = require(script.Parent.PostStatusRowView)
local usePostStatusRowViewModel = require(script.Parent.usePostStatusRowViewModel)

local function PostStatusRowContainer(arg1)
    local var1 = usePostStatusRowViewModel(arg1)
    if var1 == nil then
        return nil
    end
    return React.createElement(PostStatusRowView, var1)
end

return PostStatusRowContainer
