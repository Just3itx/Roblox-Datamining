-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local isGlobalTabFirst = require(ExpChat.isGlobalTabFirst)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)

local function getDefaultTabName(tbl1): string?
    return if FFlagExpChatGlobalTabDefault and isGlobalTabFirst() and tbl1.RBXGlobal ~= nil then "RBXGlobal" elseif tbl1.RBXGeneral == nil then nil else "RBXGeneral"
end

return getDefaultTabName
