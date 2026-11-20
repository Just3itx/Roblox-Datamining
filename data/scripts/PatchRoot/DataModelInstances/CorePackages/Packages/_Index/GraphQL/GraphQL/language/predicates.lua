-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Kind = require(script.Parent.kinds).Kind

local isExecutableDefinitionNode = nil

local isTypeSystemDefinitionNode = nil
local isTypeDefinitionNode = nil
local isTypeSystemExtensionNode = nil
local isTypeExtensionNode = nil

local function isDefinitionNode(arg1)
    return isExecutableDefinitionNode(arg1) or isTypeSystemDefinitionNode(arg1) or isTypeSystemExtensionNode(arg1)
end

isExecutableDefinitionNode = function(arg1): boolean
    return arg1.kind == Kind.OPERATION_DEFINITION or arg1.kind == Kind.FRAGMENT_DEFINITION
end

isTypeSystemDefinitionNode = function(arg1)
    return arg1.kind == Kind.SCHEMA_DEFINITION or isTypeDefinitionNode(arg1) or arg1.kind == Kind.DIRECTIVE_DEFINITION
end

isTypeDefinitionNode = function(arg1): boolean
    return arg1.kind == Kind.SCALAR_TYPE_DEFINITION
        or arg1.kind == Kind.OBJECT_TYPE_DEFINITION
        or arg1.kind == Kind.INTERFACE_TYPE_DEFINITION
        or arg1.kind == Kind.UNION_TYPE_DEFINITION
        or arg1.kind == Kind.ENUM_TYPE_DEFINITION
        or arg1.kind == Kind.INPUT_OBJECT_TYPE_DEFINITION
end

isTypeSystemExtensionNode = function(arg1)
    return arg1.kind == Kind.SCHEMA_EXTENSION or isTypeExtensionNode(arg1)
end

isTypeExtensionNode = function(arg1): boolean
    return arg1.kind == Kind.SCALAR_TYPE_EXTENSION
        or arg1.kind == Kind.OBJECT_TYPE_EXTENSION
        or arg1.kind == Kind.INTERFACE_TYPE_EXTENSION
        or arg1.kind == Kind.UNION_TYPE_EXTENSION
        or arg1.kind == Kind.ENUM_TYPE_EXTENSION
        or arg1.kind == Kind.INPUT_OBJECT_TYPE_EXTENSION
end

return {
    isDefinitionNode = isDefinitionNode,
    isExecutableDefinitionNode = isExecutableDefinitionNode,
    isSelectionNode = function(arg1): boolean
        return arg1.kind == Kind.FIELD or arg1.kind == Kind.FRAGMENT_SPREAD or arg1.kind == Kind.INLINE_FRAGMENT
    end,
    isValueNode = function(arg1): boolean
        return arg1.kind == Kind.VARIABLE
            or arg1.kind == Kind.INT
            or arg1.kind == Kind.FLOAT
            or arg1.kind == Kind.STRING
            or arg1.kind == Kind.BOOLEAN
            or arg1.kind == Kind.NULL
            or arg1.kind == Kind.ENUM
            or arg1.kind == Kind.LIST
            or arg1.kind == Kind.OBJECT
    end,
    isTypeNode = function(arg1): boolean
        return arg1.kind == Kind.NAMED_TYPE or arg1.kind == Kind.LIST_TYPE or arg1.kind == Kind.NON_NULL_TYPE
    end,
    isTypeSystemDefinitionNode = isTypeSystemDefinitionNode,
    isTypeDefinitionNode = isTypeDefinitionNode,
    isTypeSystemExtensionNode = isTypeSystemExtensionNode,
    isTypeExtensionNode = isTypeExtensionNode
}
