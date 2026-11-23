-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Logger = require(AppChatParent.Loggers).Logger
return (Logger.new(Logger, "AppChat Analytics"))
