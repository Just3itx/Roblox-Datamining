-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent

local t = require(RoduxSquadsParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({
        canSeeRegroupPromptToast = arg1.canSeeRegroupPromptToast or false,
        canSeeRegroupJoinButton = arg1.canSeeRegroupJoinButton or false
    }))
end

function module.format(arg1)
    return (module.new(
        {
            canSeeRegroupPromptToast = arg1.canSeeRegroupPromptToast,
            canSeeRegroupJoinButton = arg1.canSeeRegroupJoinButton
        }
    ))
end

module.isValid = t.interface({ canSeeRegroupPromptToast = t.boolean, canSeeRegroupJoinButton = t.boolean })

return module
