-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local module = {}
local buildClientSchema = require(scriptParentParent.GraphQL).buildClientSchema

local _loaders = require(script.Parent.loaders)

local _types = require(script.Parent.types)

local String = LuauPolyfill.String
local json = require(script.Parent.json)

local function stripBOM(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    str1 = tostring(str1)

    if String.charCodeAt(str1, 1) == 65279 then
        str1 = String.slice(str1, 2)
    end

    return str1
end

local function parseBOM(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return json.parse((stripBOM(str1)))
end

function module.parseGraphQLJSON(location: string, str1: string, arg1)
    local var1 = parseBOM(str1)

    if Boolean.toJSBoolean(var1.data) then
        var1 = var1.data
    end
    if var1.kind == "Document" then
        return { location = location, document = var1 }
    end

    if Boolean.toJSBoolean(var1.__schema) then
        return {
            location = location,
            schema = buildClientSchema(var1, arg1)
        }
    end

    if typeof(var1) == "string" then
        return { location = location, rawSDL = var1 }
    end
    error(Error.new("Not valid JSON content"))
end

return module
