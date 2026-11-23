-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local buildValidMessages = require(script.Parent.buildValidMessages)
local ingestBatch = require(script.Parent.ingestBatch)
local IngestOperation = require(script.Parent.IngestOperation)

local function ingestMessagePage(str1: string, tbl1)
    local validMessages = buildValidMessages(str1, tbl1)
    return ingestBatch(str1, validMessages, IngestOperation.Append)
end

return ingestMessagePage
