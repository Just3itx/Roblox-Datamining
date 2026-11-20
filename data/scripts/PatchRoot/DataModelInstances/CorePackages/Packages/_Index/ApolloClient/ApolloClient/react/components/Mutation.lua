-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local _core = require(scriptParentParentParent.core)

local _types = require(script.Parent.types)

local useMutation = require(script.Parent.Parent.hooks).useMutation

function module.Mutation(arg1)
    local var1, var2 = table.unpack(useMutation(arg1.mutation, arg1), 1, 2)
    if Boolean.toJSBoolean(arg1.children) then
        return arg1.children(var1, var2)
    end
    return nil
end

return module
