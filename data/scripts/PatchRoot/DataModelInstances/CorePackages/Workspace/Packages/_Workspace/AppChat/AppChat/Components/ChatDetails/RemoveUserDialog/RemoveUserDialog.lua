-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local SocialLibraries = require(AppChat.SocialLibraries)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)

local Warning = SocialLibraries.Components.AlertViews.Warning

local tbl1 = {
    titleText = "Placeholder title",
    bodyText = "Placeholder body",
    cancelText = "TempCancel",
    confirmText = "TempConfirm",
    failureTitleText = "FailureTitle",
    failureBodyText = "FailureBody",
    failureButtonText = "FailureButton",
    soakAreaColor3 = Color3.fromRGB(25, 25, 25),
    soakAreaTransparency = 0.8,
    width = UDim.new(0.8, 0),
    displayFailed = false,
    onActivated = nil,
    onModalClose = nil
}

function RemoveUserDialog(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    return React.createElement(Warning, var1)
end

return RemoveUserDialog
