-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServiceLocator = require(script.ServiceLocator)

local module = { ServiceLocator = ServiceLocator }

function module.getService(arg1)
    return ServiceLocator.get(arg1)
end

function module.setupMockServices(arg1)
    ServiceLocator.clear()
    for k, value in pairs(arg1) do
        ServiceLocator.register(k, value)
    end
end

module["jest.config"] = script["jest.config"]
return module
