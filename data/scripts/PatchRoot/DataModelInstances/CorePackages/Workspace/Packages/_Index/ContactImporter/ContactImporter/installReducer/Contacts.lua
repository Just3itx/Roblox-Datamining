-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local RoduxContacts = dependencies.RoduxContacts
local llama = dependencies.llama

local var1 = RoduxContacts.installReducer()

return function(arg1, arg2)
    return llama.List.reduce({ arg2 }, var1, arg1)
end
