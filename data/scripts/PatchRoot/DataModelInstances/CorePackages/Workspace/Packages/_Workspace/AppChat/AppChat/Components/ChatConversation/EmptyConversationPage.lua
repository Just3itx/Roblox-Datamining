-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)

local loadFoundationCloudAsset = require(AppChat.Utils.loadFoundationCloudAsset)
local var1, _ = loadFoundationCloudAsset("pictograms/chat")
local var2, _ = loadFoundationCloudAsset("pictograms/voice_chat")

return React.memo(function() -- name: EmptyConversationPage
    local var3 = useTokens()
    local var4 = useIsChatUserMessagesEnabled()

    local createElement = React.createElement
    local view = Foundation.View
    local tbl1 = { tag = "size-full" }

    local tbl2 = {
        ChatIcon = React.createElement(Foundation.Image, {
            Image = if var4 then var2 else var1,
            imageStyle = var3.Color.Content.Emphasis,
            ScaleType = Enum.ScaleType.Fit,
            Size = UDim2.new(0, 320, 0, 320),
            tag = "position-center-center anchor-center-center"
        })
    }
    return createElement(view, tbl1, tbl2)
end)
