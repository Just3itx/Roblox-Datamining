-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local _Types = require(scriptParent.Types)
local ValueChangedSignal = require(scriptParent.ValueChangedSignal)

local module = {}
module.__index = module

function module.new(bool1: boolean)
    return ValueChangedSignal.new(bool1)
end

return module
