-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Array = require(script.Parent.Parent.Parent.LuauPolyfill).Array
local devAssert = require(script.Parent.Parent.jsutils.devAssert).devAssert
local _source = require(script.Parent.Parent.language.source)

local _ast = require(script.Parent.Parent.language.ast)

local parser = require(script.Parent.Parent.language.parser)

local Kind = require(script.Parent.Parent.language.kinds).Kind
local parse = parser.parse

local assertValidSDL = require(script.Parent.Parent.validation.validate).assertValidSDL

local GraphQLSchema = require(script.Parent.Parent.type.schema).GraphQLSchema
local specifiedDirectives = require(script.Parent.Parent.type.directives).specifiedDirectives

local extendSchemaImpl = require(script.Parent.extendSchema).extendSchemaImpl

local function buildASTSchema(arg1, arg2)
    devAssert(not (arg1 == nil) and arg1.kind == Kind.DOCUMENT, "Must provide valid Document AST.")

    if arg2 ~= nil and not (arg2.assumeValid or arg2.assumeValidSDL) then
        assertValidSDL(arg1)
    end

    local var1 = extendSchemaImpl(
        {
            description = nil,
            types = {},
            directives = {},
            extensions = nil,
            extensionASTNodes = {},
            assumeValid = false
        },
        arg1,
        arg2
    )
    if var1.astNode == nil then
        for _, value in ipairs(var1.types) do
            if value.name == "Query" then
                var1.query = value
            elseif value.name == "Mutation" then
                var1.mutation = value
            elseif value.name == "Subscription" then
                var1.subscription = value
            end
        end
    end

    local directives = var1.directives

    for _, value in ipairs(specifiedDirectives) do
        if Array.every(directives, function(arg3): boolean
            return arg3.name ~= value.name
        end) then
            table.insert(directives, value)
        end
    end

    return GraphQLSchema.new(var1)
end

return {
    buildASTSchema = buildASTSchema,
    buildSchema = function(arg1, arg2)
        local var1 = parse(arg1, {
            noLocation = if arg2 then arg2.noLocation else nil,
            experimentalFragmentVariables = if arg2 then arg2.experimentalFragmentVariables else nil
        })

        return buildASTSchema(
            var1,
            {
                assumeValidSDL = if arg2 then arg2.assumeValidSDL else nil,
                assumeValid = if arg2 then arg2.assumeValid else nil
            }
        )
    end,
    parse = parse
}
