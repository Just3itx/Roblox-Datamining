-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)
local LoadableImage = require(AppChatParent.UIBlox).App.Loading.LoadableImage

local function AvatarThumbnail(tbl1)
    return React.createElement(LoadableImage, {
        Size = UDim2.fromScale(1, 1),
        Image = tbl1.thumbnail,
        useShimmerAnimationWhileLoading = true,
        showFailedStateWhenLoadingFailed = true,
        cornerRadius = tbl1.cornerRadius
    })
end

return AvatarThumbnail
