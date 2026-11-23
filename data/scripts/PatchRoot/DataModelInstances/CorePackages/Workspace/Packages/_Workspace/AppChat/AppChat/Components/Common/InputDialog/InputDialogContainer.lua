-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local InputDialogView = require(script.Parent.InputDialogView)
local useInputDialogViewModel = require(script.Parent.useInputDialogViewModel)

local function InputDialogContainer(arg1)
    local var1 = useInputDialogViewModel(arg1)
    return React.createElement(InputDialogView, var1)
end

return InputDialogContainer
