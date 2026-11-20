-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Boolean = require(scriptParentParent.LuauPolyfill).Boolean
local module = {}

local mapSchema = require(script.Parent.mapSchema).mapSchema

local _GraphQL = require(scriptParentParent.GraphQL)

local _types = require(script.Parent.types)

local MapperKind = require(script.Parent.Interfaces).MapperKind

function module.extractExtensionsFromSchema(arg1)
    local tbl1 = {
        schemaExtensions = not Boolean.toJSBoolean(arg1.extensions) and {} or arg1.extensions or {},
        types = {}
    }
    local var1 = mapSchema
    local tbl2 = {}
    local objectType = MapperKind.OBJECT_TYPE

    tbl2[tostring(objectType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            fields = {},
            type = "object",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }

        return arg2
    end
    local interfaceType = MapperKind.INTERFACE_TYPE

    tbl2[tostring(interfaceType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            fields = {},
            type = "interface",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions
        }

        return arg2
    end
    local field = MapperKind.FIELD

    tbl2[tostring(field)] = function(arg2, arg3, arg4)
        tbl1.types[arg4].fields[arg3] = {
            arguments = {},
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions
        }

        local args = arg2.args
        if args ~= nil then
            for _, arg in args do
                local var2 = table.unpack(arg)

                tbl1.types[arg4].fields[arg3].arguments[tostring(var2)] = not Boolean.toJSBoolean(args[tostring(var2)].extensions) and {} or args[tostring(var2)].extensions or {}
            end
        end
        return arg2
    end

    local enumType = MapperKind.ENUM_TYPE

    tbl2[tostring(enumType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            values = {},
            type = "enum",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }

        return arg2
    end
    local enumValue = MapperKind.ENUM_VALUE

    tbl2[tostring(enumValue)] = function(arg2, arg3, _, arg4)
        tbl1.types[arg3].values[arg4] = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}

        return arg2
    end

    local scalarType = MapperKind.SCALAR_TYPE

    tbl2[tostring(scalarType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            type = "scalar",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }

        return arg2
    end
    local unionType = MapperKind.UNION_TYPE

    tbl2[tostring(unionType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            type = "union",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }

        return arg2
    end
    local inputObjectType = MapperKind.INPUT_OBJECT_TYPE

    tbl2[tostring(inputObjectType)] = function(arg2)
        local types = tbl1.types
        local name = arg2.name
        types[tostring(name)] = {
            fields = {},
            type = "input",
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }

        return arg2
    end
    local inputObjectField = MapperKind.INPUT_OBJECT_FIELD

    tbl2[tostring(inputObjectField)] = function(arg2, arg3, arg4)
        tbl1.types[arg4].fields[arg3] = {
            extensions = not Boolean.toJSBoolean(arg2.extensions) and {} or arg2.extensions or {}
        }
        return arg2
    end

    var1(arg1, tbl2)

    return tbl1
end

return module
