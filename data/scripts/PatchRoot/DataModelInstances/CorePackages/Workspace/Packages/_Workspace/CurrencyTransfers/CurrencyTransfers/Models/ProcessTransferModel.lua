-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent
local t = require(CurrencyTransfersParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    return (module.new({ success = (arg1 or {}).success or true }))
end

function module.format(arg1)
    return (module.new({ success = arg1.success }))
end

module.isValid = t.strictInterface({ success = t.boolean })

return module
