-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local PostStatusBadgeView = require(script.Parent.PostStatusBadgeView)
local usePostStatusBadgeViewModel = require(script.Parent.usePostStatusBadgeViewModel)

local function PostStatusBadgeContainer(arg1)
    local var1 = usePostStatusBadgeViewModel(arg1)
    if var1 == nil then
        return nil
    end
    return React.createElement(PostStatusBadgeView, var1)
end

return PostStatusBadgeContainer
