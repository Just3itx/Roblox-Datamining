-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChat = script:FindFirstAncestor("ExpChat")
local FFlagExpChatScrollbarInset = require(ExpChat.Flags.FFlagExpChatScrollbarInset)

local num1 = game:DefineFastInt("ExpChatVisibleARButtonPadding", 42)

local num2 = game:DefineFastInt("ExpChatVisibleARButtonPaddingInset", 34)

return if FFlagExpChatScrollbarInset then num2 else num1
