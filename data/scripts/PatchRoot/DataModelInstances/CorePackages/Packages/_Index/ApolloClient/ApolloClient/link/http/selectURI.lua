-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local module = {}

local _types = require(script.Parent.Parent.core.types)

function module.selectURI(arg1, arg2)
    local uri = arg1:getContext().uri

    if Boolean.toJSBoolean(uri) then
        return uri
    elseif typeof(arg2) == "function" then
        return arg2(arg1)
    end
    return Boolean.toJSBoolean(arg2) and arg2 or "/graphql"
end
return module
