-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Promise = require(AppChatParent.Promise)

local module = {}
module.__index = module

function module.onBeforeSendingMessage(_, _) end

function module.sendMessage(_, _)
    return Promise.reject("Not implemented")
end

function module.onSuccess<T>(_, _, arg1: T): T
    return arg1
end

function module.onFailure<T>(_, _, arg1: T): T
    return arg1
end

return module
