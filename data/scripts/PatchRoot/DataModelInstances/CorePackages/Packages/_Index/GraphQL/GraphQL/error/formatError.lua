-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local devAssert = require(scriptParentParent.jsutils.devAssert).devAssert
local _location = require(scriptParentParent.language.location)

local _GraphQLError = require(script.Parent.GraphQLError)

local module = {}

function module.formatError(arg1)
    devAssert(arg1, "Received nil error.")

    local message = if arg1.message and string.len(arg1.message) > 0 then arg1.message else "An unknown error occurred."

    local locations = arg1.locations
    local path = arg1.path
    local extensions = arg1.extensions

    return extensions
        and ({ message = message, locations = locations, path = path, extensions = extensions }
            or { message = message, locations = locations, path = path })
        or { message = message, locations = locations, path = path }
end

return module
