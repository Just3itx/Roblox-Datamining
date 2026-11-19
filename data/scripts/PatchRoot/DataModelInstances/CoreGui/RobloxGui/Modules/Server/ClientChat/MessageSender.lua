-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local _scriptParent = script.Parent

local tbl2 = {}
tbl2.__index = tbl2

function tbl2:SendMessage(arg1, arg2)
    self.SayMessageRequest:FireServer(arg1, arg2)
end

function tbl2:RegisterSayMessageFunction(sayMessageRequest)
    self.SayMessageRequest = sayMessageRequest
end

function tbl1.new()
    local self = setmetatable({}, tbl2)
    self.SayMessageRequest = nil

    return self
end

return tbl1.new()
