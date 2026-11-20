-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local coerceToMap = LuauPolyfill.coerceToMap

local _ObjMap = require(scriptParentParent.jsutils.ObjMap)

local _ObjMap2 = require(script.Parent.Parent.jsutils.ObjMap)

local inspect = require(script.Parent.Parent.jsutils.inspect).inspect
local toObjMap = require(script.Parent.Parent.jsutils.toObjMap).toObjMap
local devAssert = require(script.Parent.Parent.jsutils.devAssert).devAssert
local instanceOf = require(script.Parent.Parent.jsutils.instanceOf)
local isObjectLike = require(script.Parent.Parent.jsutils.isObjectLike).isObjectLike

local _ast = require(script.Parent.Parent.language.ast)

local DirectiveLocation = require(script.Parent.Parent.language.directiveLocation).DirectiveLocation

local definition = require(script.Parent.definition)

local scalars = require(script.Parent.scalars)
local GraphQLString = scalars.GraphQLString
local GraphQLBoolean = scalars.GraphQLBoolean
local argsToArgsConfig = definition.argsToArgsConfig
local GraphQLNonNull = definition.GraphQLNonNull

local var1 = nil

function isDirective(arg1)
    return instanceOf(arg1, var1)
end

function assertDirective<T>(arg1: T): T
    if not isDirective(arg1) then
        error(Error.new(("Expected %s to be a GraphQL directive."):format(inspect(arg1))))
    end

    return arg1
end

var1 = {}
var1.__index = var1

function var1.new(tbl1)
    local tbl2 = {
        name = tbl1.name,
        description = tbl1.description,
        locations = tbl1.locations,
        isRepeatable = not not tbl1.isRepeatable,
        extensions = tbl1.extensions and toObjMap(tbl1.extensions),
        astNode = tbl1.astNode
    }
    devAssert(tbl1.name, "Directive must be named.")
    devAssert(Array.isArray(tbl1.locations), ("@%s locations must be an Array."):format(tbl1.name))

    local var2 = not tbl1.args and {} or tbl1.args

    devAssert(
        isObjectLike(var2) and (not Array.isArray(var2) or next(var2) == nil) or instanceOf(var2, Map),
        ("@%s args must be an object with argument names as keys."):format(tbl1.name)
    )

    tbl2.args = Array.map(coerceToMap(var2):entries(), function(arg1)
        local name = arg1[1]
        local var4 = arg1[2]

        return {
            name = name,
            description = var4.description,
            type = var4.type,
            defaultValue = var4.defaultValue,
            deprecationReason = var4.deprecationReason,
            extensions = var4.extensions and toObjMap(var4.extensions),
            astNode = var4.astNode
        }
    end)

    return (setmetatable(tbl2, var1))
end

function var1:toConfig()
    return {
        name = self.name,
        description = self.description,
        locations = self.locations,
        args = argsToArgsConfig(self.args),
        isRepeatable = self.isRepeatable,
        extensions = self.extensions,
        astNode = self.astNode
    }
end

function var1.__tostring(arg1)
    return arg1:toString()
end

function var1:toString()
    return "@" .. self.name
end

function var1.toJSON(arg1)
    return arg1:toString()
end

local GraphQLIncludeDirective = var1.new({
    name = "include",
    description = "Directs the executor to include this field or fragment only when the `if` argument is true.",
    locations = { DirectiveLocation.FIELD, DirectiveLocation.FRAGMENT_SPREAD, DirectiveLocation.INLINE_FRAGMENT },
    args = Map.new({{ "if", { type = GraphQLNonNull.new(GraphQLBoolean), description = "Included when true." } }})
})

local GraphQLSkipDirective = var1.new({
    name = "skip",
    description = "Directs the executor to skip this field or fragment when the `if` argument is true.",
    locations = { DirectiveLocation.FIELD, DirectiveLocation.FRAGMENT_SPREAD, DirectiveLocation.INLINE_FRAGMENT },
    args = Map.new({{ "if", { type = GraphQLNonNull.new(GraphQLBoolean), description = "Skipped when true." } }})
})

local GraphQLDeprecatedDirective = var1.new({
    name = "deprecated",
    description = "Marks an element of a GraphQL schema as no longer supported.",
    locations = {
        DirectiveLocation.FIELD_DEFINITION,
        DirectiveLocation.ARGUMENT_DEFINITION,
        DirectiveLocation.INPUT_FIELD_DEFINITION,
        DirectiveLocation.ENUM_VALUE
    },
    args = Map.new({{
        "reason",
        {
            type = GraphQLString,
            description = "Explains why this element was deprecated, usually also including a suggestion for how to access supported similar data. Formatted using the Markdown syntax, as specified by [CommonMark](https://commonmark.org/).",
            defaultValue = "No longer supported"
        }
    }})
})

local GraphQLSpecifiedByDirective = var1.new({
    name = "specifiedBy",
    description = "Exposes a URL that specifies the behaviour of this scalar.",
    locations = { DirectiveLocation.SCALAR },
    args = Map.new({{
        "url",
        {
            type = GraphQLNonNull.new(GraphQLString),
            description = "The URL that specifies the behaviour of this scalar."
        }
    }})
})

local specifiedDirectives = Object.freeze(
    {
        GraphQLIncludeDirective,
        GraphQLSkipDirective,
        GraphQLDeprecatedDirective,
        GraphQLSpecifiedByDirective
    }
)

return {
    isDirective = isDirective,
    assertDirective = assertDirective,
    GraphQLDirective = var1,
    GraphQLIncludeDirective = GraphQLIncludeDirective,
    GraphQLSkipDirective = GraphQLSkipDirective,
    DEFAULT_DEPRECATION_REASON = "No longer supported",
    GraphQLDeprecatedDirective = GraphQLDeprecatedDirective,
    GraphQLSpecifiedByDirective = GraphQLSpecifiedByDirective,
    specifiedDirectives = specifiedDirectives,
    isSpecifiedDirective = function(tbl1)
        return Array.some(specifiedDirectives, function(arg1): boolean
            return arg1.name == tbl1.name
        end)
    end
}
