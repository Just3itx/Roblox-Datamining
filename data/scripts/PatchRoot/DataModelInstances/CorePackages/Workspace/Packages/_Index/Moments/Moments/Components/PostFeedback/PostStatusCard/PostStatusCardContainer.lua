-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)

local PostStatusCardView = require(script.Parent.PostStatusCardView)
local usePostStatusCardViewModel = require(script.Parent.usePostStatusCardViewModel)
local useHidePostStatusToast = require(Moments.Components.PostFeedback.PostStatusToast.useHidePostStatusToast)

local FFlagMomentsHidePostStatusToast = SharedFlags.FFlagMomentsHidePostStatusToast

local function PostStatusCardContainer()
    if FFlagMomentsHidePostStatusToast then
        useHidePostStatusToast()
    end
    local var1 = usePostStatusCardViewModel()
    if var1 == nil then
        return nil
    end
    return React.createElement(PostStatusCardView, var1)
end

return PostStatusCardContainer
