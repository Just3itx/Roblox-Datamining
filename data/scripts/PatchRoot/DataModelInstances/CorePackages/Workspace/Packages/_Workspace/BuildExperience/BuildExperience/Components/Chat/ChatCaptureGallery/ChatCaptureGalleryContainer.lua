-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local React = require(BuildExperienceParent.React)

local ChatCaptureGalleryView = require(script.Parent.ChatCaptureGalleryView)
local useChatCaptureGalleryViewModel = require(script.Parent.useChatCaptureGalleryViewModel)

local function ChatCaptureGalleryContainer(arg1)
    local var1 = useChatCaptureGalleryViewModel(arg1)
    return React.createElement(ChatCaptureGalleryView, var1)
end

return ChatCaptureGalleryContainer
