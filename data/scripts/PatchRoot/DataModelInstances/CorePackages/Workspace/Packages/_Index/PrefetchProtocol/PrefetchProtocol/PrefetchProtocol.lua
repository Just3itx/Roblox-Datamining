-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)

local _PrefetchProtocolTypes = require(script.Parent.PrefetchProtocolTypes)

local module = {
    POP_GUID_DESCRIPTOR = {
        fid = MessageBus.getMessageId("Prefetch", "popPendingPrefetchGuid"),
        validateParams = t.table
    }
}

module.__index = module

function module.new(messageBus)
    local tbl1 = {
        messageBus = messageBus or MessageBus
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:popPendingPrefetchGuid()
    return self.messageBus.call(self.POP_GUID_DESCRIPTOR, {})
end

module.default = module.new()

return module
