-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local MomentsHeaderContainer = require(Moments.Components.MomentsHeader.MomentsHeaderContainer)
local FFlagMomentsCreateAvatarPosts = require(MomentsParent.SharedFlags).FFlagMomentsCreateAvatarPosts

local function MomentsBackHeader(tbl1)
    return React.createElement(MomentsHeaderContainer, {
        layoutOrder = tbl1.layoutOrder,
        variant = "back",
        showTopScrim = true,
        onBack = tbl1.onBack,
        onCreatePressed = tbl1.onCreatePressed,
        onCreateAvatarMomentPressed = if FFlagMomentsCreateAvatarPosts then tbl1.onCreateAvatarMomentPressed else nil,
        onNavigateToTrending = tbl1.onNavigateToTrending,
        onNavigateToMyMoments = tbl1.onNavigateToMyMoments
    })
end

return MomentsBackHeader
