-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local _React = require(AppChatParent.React)

local _ButtonVariant = Foundation.Enums.ButtonVariant

local _MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)

local Status = table.freeze({ Loading = "Loading", Ready = "Ready", Error = "Error" })

return table.freeze({ Status = Status })
