-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

local _ReplyingToMessageContext = require(script.Parent.ReplyingToMessageContext)

return React.createContext(function(_) end)
