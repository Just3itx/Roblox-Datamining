-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLibraries = require(AppChat.SocialLibraries)

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local TextInput = SocialLibraries.Components.AlertViews.TextInput
local usePositionOffsetForVirtualKeyboard = require(AppChat.Hooks.usePositionOffsetForVirtualKeyboard)

local tbl1 = {
    titleText = "Placeholder",
    cancelText = "CancelText",
    confirmText = "ConfirmText",
    warningText = nil,
    inputText = nil,
    placeholderText = nil,
    soakAreaColor3 = Color3.fromRGB(25, 25, 25),
    soakAreaTransparency = 0.8,
    onActivated = nil,
    onModalClose = nil
}

function EditChatGroupNameDialog(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local var2 = usePositionOffsetForVirtualKeyboard({ isNearBottomOfScreen = false })

    return React.createElement(TextInput, Cryo.Dictionary.join(var1, { shouldAdjustForKeyboard = var2 == nil }))
end

return EditChatGroupNameDialog
