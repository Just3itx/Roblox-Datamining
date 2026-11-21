-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)

local VirtualizedFeedView = require(script.Parent.VirtualizedFeedView)
local useVirtualizedFeedViewModel = require(script.Parent.useVirtualizedFeedViewModel)

local function AssetPickerVirtualizedFeedContainer(arg1)
    local var1 = useVirtualizedFeedViewModel(arg1)
    return React.createElement(VirtualizedFeedView, var1)
end

return AssetPickerVirtualizedFeedContainer
