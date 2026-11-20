-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)
local GraphQLEnumType = GraphQL.GraphQLEnumType
local GraphQLInputObjectType = GraphQL.GraphQLInputObjectType
local GraphQLInterfaceType = GraphQL.GraphQLInterfaceType
local GraphQLObjectType = GraphQL.GraphQLObjectType

local GraphQLScalarType = GraphQL.GraphQLScalarType
local GraphQLUnionType = GraphQL.GraphQLUnionType
local isEnumType = GraphQL.isEnumType
local isInterfaceType = GraphQL.isInterfaceType
local isInputObjectType = GraphQL.isInputObjectType
local isObjectType = GraphQL.isObjectType
local isScalarType = GraphQL.isScalarType
local isUnionType = GraphQL.isUnionType

function module.renameType(arg1, str1: string)
    if Boolean.toJSBoolean(isObjectType(arg1)) then
        local new = GraphQLObjectType.new

        return new(
            Object.assign({}, arg1:toConfig(), {
                name = str1,
                astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
                extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                    return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
                end)
            })
        )
    end

    if Boolean.toJSBoolean(isInterfaceType(arg1)) then
        local new = GraphQLInterfaceType.new

        return new(
            Object.assign({}, arg1:toConfig(), {
                name = str1,
                astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
                extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                    return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
                end)
            })
        )
    end

    if Boolean.toJSBoolean(isUnionType(arg1)) then
        local new = GraphQLUnionType.new

        return new(
            Object.assign({}, arg1:toConfig(), {
                name = str1,
                astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
                extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                    return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
                end)
            })
        )
    end

    if Boolean.toJSBoolean(isInputObjectType(arg1)) then
        local new = GraphQLInputObjectType.new

        return new(
            Object.assign({}, arg1:toConfig(), {
                name = str1,
                astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
                extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                    return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
                end)
            })
        )
    end

    if Boolean.toJSBoolean(isEnumType(arg1)) then
        local new = GraphQLEnumType.new

        return new(
            Object.assign({}, arg1:toConfig(), {
                name = str1,
                astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
                extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                    return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
                end)
            })
        )
    end

    if not Boolean.toJSBoolean(isScalarType(arg1)) then
        error(Error.new(("Unknown type %s."):format(tostring(arg1))))
        return
    end

    local new = GraphQLScalarType.new

    return new(
        Object.assign({}, arg1:toConfig(), {
            name = str1,
            astNode = if arg1.astNode == nil then arg1.astNode else Object.assign({}, arg1.astNode, { name = Object.assign({}, arg1.astNode.name, { value = str1 }) }),
            extensionASTNodes = if arg1.extensionASTNodes == nil then arg1.extensionASTNodes else Array.map(arg1.extensionASTNodes, function(arg2)
                return Object.assign({}, arg2, { name = Object.assign({}, arg2.name, { value = str1 }) })
            end)
        })
    )
end

return module
