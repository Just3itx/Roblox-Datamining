-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.networkRequests
local createGetConnectionsByEntityId = require(networkRequests.createGetConnectionsByEntityId)
local types = require(script.types)

local module = {}

function module.config(arg1)
    return {
        GetConnectionsByEntityId = createGetConnectionsByEntityId(arg1)
    }
end

module.Types = types
module["jest.config"] = script["jest.config"]
return module
