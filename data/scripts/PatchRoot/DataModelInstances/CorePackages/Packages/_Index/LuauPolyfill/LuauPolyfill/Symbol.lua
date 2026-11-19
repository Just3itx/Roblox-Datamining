-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Symbol = require(script.Symbol)

local GlobalRegistry = require(script.GlobalRegistry)

local var1 = setmetatable({}, {
    __call = function(_, str1: string?)
        return Symbol.new(str1)
    end
})

var1.for_ = GlobalRegistry.getOrInit

return var1
