-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Error = require(scriptParentParentParentParent.LuauPolyfill).Error

local _Response = require(scriptParentParentParent.luaUtils.Response)

local module = {}

function module.throwServerError(response, arg1, str1: string)
    local error2 = Error.new(str1)
    error2.name = "ServerError"
    error2.response = response
    error2.statusCode = response.status
    error2.result = arg1
    error(error2)
end
return module
