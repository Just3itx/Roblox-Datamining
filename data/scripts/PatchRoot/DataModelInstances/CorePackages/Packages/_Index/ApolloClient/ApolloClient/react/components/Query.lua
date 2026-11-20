-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local _core = require(scriptParentParentParent.core)

local _types = require(script.Parent.types)

local useQuery = require(script.Parent.Parent.hooks).useQuery

function module.Query(arg1)
    local children = arg1.children
    local query = arg1.query
    local var1 = Object.assign({}, arg1, { children = Object.None, query = Object.None })

    local var2 = useQuery(query, var1)

    if Boolean.toJSBoolean(var2) then
        return children(var2)
    end
    return nil
end

return module
