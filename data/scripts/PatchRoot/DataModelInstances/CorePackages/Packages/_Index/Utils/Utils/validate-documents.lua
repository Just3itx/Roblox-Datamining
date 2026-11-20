-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array

local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map

local Promise = require(scriptParentParent.Promise)

local module = {}

local GraphQL = require(scriptParentParent.GraphQL)
local Kind = GraphQL.Kind
local validate = GraphQL.validate

local specifiedRules = GraphQL.specifiedRules

local concatAST = GraphQL.concatAST

local versionInfo = GraphQL.versionInfo

local _loaders = require(script.Parent.loaders)

local AggregateError = require(script.Parent.AggregateError).AggregateError

local createDefaultRules = nil

function module.validateGraphQlDocuments(arg1, arg2, arg3)
    if arg3 == nil then
        arg3 = createDefaultRules()
    end

    return Promise.resolve():andThen(function()
        local map = Map.new()
        local tbl1 = {}
        for _, value in arg2 do
            if not value.document then
                continue
            end
            local definitions = {}
            for _, definition in value.document.definitions do
                if definition.kind == Kind.FRAGMENT_DEFINITION then
                    map:set(definition.name.value, definition)
                else
                    table.insert(definitions, definition)
                end
            end
            table.insert(tbl1, { location = value.location, document = { kind = Kind.DOCUMENT, definitions = definitions } })
        end

        local result = {}
        local tbl2 = {
            kind = Kind.DOCUMENT,
            definitions = Array.concat({}, map:values())
        }

        Promise.all(Array.map(tbl1, function(arg4)
            return Promise.resolve():andThen(function()
                local var1 = concatAST({ tbl2, arg4.document })
                local errors = validate(arg1, var1, arg3)

                if #errors > 0 then
                    table.insert(result, { filePath = arg4.location, errors = errors })
                end
            end)
        end)):expect()
        return result
    end)
end

function module.checkValidationErrors(arg1)
    if not (#arg1 > 0) then
        return
    end
    local tbl1 = {}
    for _, value in arg1 do
        for _, error in value.errors do
            local error2 = Error.new()
            error2.name = "GraphQLDocumentError"
            local str1 = tostring(error2.name)
            local message = error.message
            error2.message = ("%s: %s"):format(str1, tostring(message))
            error2.stack = error2.message

            if error.locations then
                for _, location in error.locations do
                    local str2 = tostring(error2.stack)

                    local str3 = tostring(value.filePath)
                    local str4 = tostring(location.line)
                    local column = location.column
                    error2.stack = str2 .. ("\n    at %s:%s:%s"):format(str3, str4, tostring(column))
                end
            end

            table.insert(tbl1, error2)
        end
    end
    local error = error
    local new = AggregateError.new

    local str1 = tostring(#tbl1)

    local join = Array.join
    local var1 = Array.map(tbl1, function(arg2, arg3): string
        local str2 = tostring(arg3)
        local stack = arg2.stack
        return ("Error %s: %s"):format(str2, tostring(stack))
    end)

    error(
        new(tbl1, ("GraphQL Document Validation failed with %s errors;\n  %s"):format(str1, tostring(join(var1, "\n\n"))))
    )
end

createDefaultRules = function()
    local tbl1 = { "NoUnusedFragmentsRule", "NoUnusedVariablesRule", "KnownDirectivesRule" }

    if versionInfo.major < 15 then
        tbl1 = Array.map(tbl1, function(arg1)
            return (arg1:gsub("Rule$", "", 1))
        end)
    end

    return Array.filter(specifiedRules, function(func1: (...any) -> (...any)): boolean
        local var1 = debug.info(func1, "n")
        return not Array.includes(tbl1, var1)
    end)
end

module.createDefaultRules = createDefaultRules
return module
