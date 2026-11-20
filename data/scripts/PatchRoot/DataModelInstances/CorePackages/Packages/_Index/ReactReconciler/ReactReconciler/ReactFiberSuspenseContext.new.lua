-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactFiberStackNew = require(script.Parent["ReactFiberStack.new"])

local createCursor = ReactFiberStackNew.createCursor
local push = ReactFiberStackNew.push
local pop = ReactFiberStackNew.pop

local module = { InvisibleParentSuspenseContext = 1, ForceSuspenseFallback = 2 }

local suspenseStackCursor = createCursor(0)
module.suspenseStackCursor = suspenseStackCursor

function module.hasSuspenseContext(num1: number, num2: number): boolean
    return bit32.band(num1, num2) ~= 0
end

function module.setDefaultShallowSuspenseContext(num1: number): number
    return bit32.band(num1, 1)
end

function module.setShallowSuspenseContext(num1: number, num2: number): number
    return bit32.bor(bit32.band(num1, 1), num2)
end

function module.addSubtreeSuspenseContext(num1: number, num2: number): number
    return bit32.bor(num1, num2)
end

function module.pushSuspenseContext(arg1, num1: number)
    push(suspenseStackCursor, num1, arg1)
end

function module.popSuspenseContext(arg1)
    pop(suspenseStackCursor, arg1)
end

return module
