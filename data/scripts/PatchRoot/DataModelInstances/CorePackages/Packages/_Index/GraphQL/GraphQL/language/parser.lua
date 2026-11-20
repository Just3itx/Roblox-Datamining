-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local _error = require(scriptParentParent.error)

local tokenKind = require(scriptParent.tokenKind)

local Location = require(scriptParent.ast).Location

local Source = require(scriptParent.source).Source

local lexer = require(scriptParent.lexer)
local Lexer = lexer.Lexer

local isPunctuatorTokenKind = lexer.isPunctuatorTokenKind

local TokenKind = tokenKind.TokenKind
local DirectiveLocation = require(scriptParent.directiveLocation).DirectiveLocation
local Kind = require(scriptParent.kinds).Kind

local syntaxError = require(script.Parent.Parent.error.syntaxError).syntaxError

local getTokenDesc = nil
local getTokenKindDesc = nil

local Parser = ({})
Parser.__index = Parser

function Parser.new(arg1, _options)
    if typeof(arg1) == "string" then
        arg1 = Source.new(arg1)
    end

    return (setmetatable({ _lexer = Lexer.new(arg1), _options = _options }, Parser))
end

function Parser:parseName()
    local var1 = self:expectToken(TokenKind.NAME)
    return {
        kind = Kind.NAME,
        value = var1.value,
        loc = self:loc(var1)
    }
end

function Parser:parseDocument()
    local token = self._lexer.token
    return {
        kind = Kind.DOCUMENT,
        definitions = self:many(TokenKind.SOF, self.parseDefinition, TokenKind.EOF),
        loc = self:loc(token)
    }
end

function Parser:parseDefinition()
    if self:peek(TokenKind.NAME) then
        local value = self._lexer.token.value
        if value == "query" or value == "mutation" or value == "subscription" then
            return self:parseOperationDefinition()
        end

        if value == "fragment" then
            return self:parseFragmentDefinition()
        end

        if value == "schema"
            or value == "scalar"
            or value == "type"
            or value == "interface"
            or value == "union"
            or value == "enum"
            or value == "input"
            or value == "directive"
        then
            return self:parseTypeSystemDefinition()
        end

        if value == "extend" then
            return self:parseTypeSystemExtension()
        end
    else
        if self:peek(TokenKind.BRACE_L) then
            return self:parseOperationDefinition()
        end

        if self:peekDescription() then
            return self:parseTypeSystemDefinition()
        end
    end
    error(self:unexpected())
end

function Parser:parseOperationDefinition()
    local token = self._lexer.token
    if self:peek(TokenKind.BRACE_L) then
        return {
            kind = Kind.OPERATION_DEFINITION,
            operation = "query",
            name = nil,
            variableDefinitions = {},
            directives = {},
            selectionSet = self:parseSelectionSet(),
            loc = self:loc(token)
        }
    end

    local operation = self:parseOperationType()
    local name = if self:peek(TokenKind.NAME) then self:parseName() else nil
    return {
        kind = Kind.OPERATION_DEFINITION,
        operation = operation,
        name = name,
        variableDefinitions = self:parseVariableDefinitions(),
        directives = self:parseDirectives(false),
        selectionSet = self:parseSelectionSet(),
        loc = self:loc(token)
    }
end

function Parser:parseOperationType(): string
    local var1 = self:expectToken(TokenKind.NAME)

    if var1.value == "query" then
        return "query"
    elseif var1.value == "mutation" then
        return "mutation"
    elseif var1.value == "subscription" then
        return "subscription"
    end

    error(self:unexpected(var1))
end

function Parser:parseVariableDefinitions()
    return self:optionalMany(TokenKind.PAREN_L, self.parseVariableDefinition, TokenKind.PAREN_R)
end

function Parser:parseVariableDefinition()
    local token = self._lexer.token
    local variable = self:parseVariable()
    self:expectToken(TokenKind.COLON)
    local type = self:parseTypeReference()
    return {
        kind = Kind.VARIABLE_DEFINITION,
        variable = variable,
        type = type,
        defaultValue = if self:expectOptionalToken(TokenKind.EQUALS) then self:parseValueLiteral(true) else nil,
        directives = self:parseDirectives(true),
        loc = self:loc(token)
    }
end

function Parser:parseVariable()
    local token = self._lexer.token
    self:expectToken(TokenKind.DOLLAR)
    return {
        kind = Kind.VARIABLE,
        name = self:parseName(),
        loc = self:loc(token)
    }
end

function Parser:parseSelectionSet()
    local token = self._lexer.token
    return {
        kind = Kind.SELECTION_SET,
        selections = self:many(TokenKind.BRACE_L, self.parseSelection, TokenKind.BRACE_R),
        loc = self:loc(token)
    }
end

function Parser.parseSelection(arg1)
    if arg1:peek(TokenKind.SPREAD) then
        return arg1:parseFragment()
    end
    return arg1:parseField()
end

function Parser:parseField()
    local token = self._lexer.token

    local var1 = self:parseName()
    local var2

    if self:expectOptionalToken(TokenKind.COLON) then
        var2 = self:parseName()
    else
        var2 = var1
        var1 = nil
    end

    return {
        kind = Kind.FIELD,
        alias = var1,
        name = var2,
        arguments = self:parseArguments(false),
        directives = self:parseDirectives(false),
        selectionSet = if self:peek(TokenKind.BRACE_L) then self:parseSelectionSet() or nil else nil,
        loc = self:loc(token)
    }
end

function Parser:parseArguments(bool1: boolean)
    local var1 = if bool1 then self.parseConstArgument else self.parseArgument
    return self:optionalMany(TokenKind.PAREN_L, var1, TokenKind.PAREN_R)
end

function Parser:parseArgument()
    local token = self._lexer.token
    local name = self:parseName()

    self:expectToken(TokenKind.COLON)
    return {
        kind = Kind.ARGUMENT,
        name = name,
        value = self:parseValueLiteral(false),
        loc = self:loc(token)
    }
end

function Parser:parseConstArgument()
    local token = self._lexer.token
    local name = self:parseName()
    self:expectToken(TokenKind.COLON)
    local value = self:parseValueLiteral(true)
    return {
        kind = Kind.ARGUMENT,
        name = name,
        value = value,
        loc = self:loc(token)
    }
end

function Parser:parseFragment()
    local token = self._lexer.token
    self:expectToken(TokenKind.SPREAD)

    local var1 = self:expectOptionalKeyword("on")
    if not var1 and self:peek(TokenKind.NAME) then
        return {
            kind = Kind.FRAGMENT_SPREAD,
            name = self:parseFragmentName(),
            directives = self:parseDirectives(false),
            loc = self:loc(token)
        }
    end
    return {
        kind = Kind.INLINE_FRAGMENT,
        typeCondition = if var1 then self:parseNamedType() else nil,
        directives = self:parseDirectives(false),
        selectionSet = self:parseSelectionSet(),
        loc = self:loc(token)
    }
end

function Parser:parseFragmentDefinition()
    local token = self._lexer.token
    self:expectKeyword("fragment")

    if (self._options and self._options.experimentalFragmentVariables) ~= true then
        local name = self:parseFragmentName()
        self:expectKeyword("on")
        local typeCondition = self:parseNamedType()
        local directives = self:parseDirectives(false)
        local selectionSet = self:parseSelectionSet()
        local loc = self:loc(token)
        return {
            kind = Kind.FRAGMENT_DEFINITION,
            name = name,
            typeCondition = typeCondition,
            directives = directives,
            selectionSet = selectionSet,
            loc = loc
        }
    end

    local name = self:parseFragmentName()
    local variableDefinitions = self:parseVariableDefinitions()
    self:expectKeyword("on")
    local typeCondition = self:parseNamedType()
    local directives = self:parseDirectives(false)
    local selectionSet = self:parseSelectionSet()
    local loc = self:loc(token)
    return {
        kind = Kind.FRAGMENT_DEFINITION,
        name = name,
        variableDefinitions = variableDefinitions,
        typeCondition = typeCondition,
        directives = directives,
        selectionSet = selectionSet,
        loc = loc
    }
end

function Parser:parseFragmentName()
    if self._lexer.token.value == "on" then
        error(self:unexpected())
    end
    return self:parseName()
end

function Parser:parseValueLiteral(bool1: boolean)
    local token = self._lexer.token

    local kind = token.kind
    if kind == TokenKind.BRACKET_L then
        return self:parseList(bool1)
    end

    if kind == TokenKind.BRACE_L then
        return self:parseObject(bool1)
    end

    if kind == TokenKind.INT then
        self._lexer:advance()
        return {
            kind = Kind.INT,
            value = token.value,
            loc = self:loc(token)
        }
    end

    if kind == TokenKind.FLOAT then
        self._lexer:advance()
        return {
            kind = Kind.FLOAT,
            value = token.value,
            loc = self:loc(token)
        }
    end

    if kind == TokenKind.STRING or kind == TokenKind.BLOCK_STRING then
        return self:parseStringLiteral()
    end

    if kind ~= TokenKind.NAME then
        if kind == TokenKind.DOLLAR and not bool1 then
            return self:parseVariable()
        end

        error(self:unexpected())
        return
    end

    self._lexer:advance()
    local value = token.value

    if value == "true" then
        return {
            kind = Kind.BOOLEAN,
            value = true,
            loc = self:loc(token)
        }
    elseif value == "false" then
        return {
            kind = Kind.BOOLEAN,
            value = false,
            loc = self:loc(token)
        }
    elseif value == "null" then
        return {
            kind = Kind.NULL,
            loc = self:loc(token)
        }
    end

    return {
        kind = Kind.ENUM,
        value = value,
        loc = self:loc(token)
    }
end

function Parser:parseStringLiteral()
    local token = self._lexer.token
    self._lexer:advance()
    return {
        kind = Kind.STRING,
        value = token.value,
        block = token.kind == TokenKind.BLOCK_STRING,
        loc = self:loc(token)
    }
end

function Parser:parseList(bool1: boolean)
    local token = self._lexer.token
    return {
        kind = Kind.LIST,
        values = self:any(TokenKind.BRACKET_L, function()
            return self:parseValueLiteral(bool1)
        end, TokenKind.BRACKET_R),
        loc = self:loc(token)
    }
end

function Parser:parseObject(bool1: boolean)
    local token = self._lexer.token
    return {
        kind = Kind.OBJECT,
        fields = self:any(TokenKind.BRACE_L, function()
            return self:parseObjectField(bool1)
        end, TokenKind.BRACE_R),
        loc = self:loc(token)
    }
end

function Parser:parseObjectField(bool1: boolean)
    local token = self._lexer.token
    local name = self:parseName()
    self:expectToken(TokenKind.COLON)

    return {
        kind = Kind.OBJECT_FIELD,
        name = name,
        value = self:parseValueLiteral(bool1),
        loc = self:loc(token)
    }
end

function Parser:parseDirectives(arg1)
    local result = {}

    while self:peek(TokenKind.AT) do
        table.insert(result, self:parseDirective(arg1))
    end
    return result
end

function Parser:parseDirective(arg1)
    local token = self._lexer.token
    self:expectToken(TokenKind.AT)
    return {
        kind = Kind.DIRECTIVE,
        name = self:parseName(),
        arguments = self:parseArguments(arg1),
        loc = self:loc(token)
    }
end

function Parser:parseTypeReference()
    local token = self._lexer.token
    local tbl2

    if self:expectOptionalToken(TokenKind.BRACKET_L) then
        local type = self:parseTypeReference()
        self:expectToken(TokenKind.BRACKET_R)
        tbl2 = {
            kind = Kind.LIST_TYPE,
            type = type,
            loc = self:loc(token)
        }
    else
        tbl2 = self:parseNamedType()
    end

    return if self:expectOptionalToken(TokenKind.BANG) then {
        kind = Kind.NON_NULL_TYPE,
        type = tbl2,
        loc = self:loc(token)
    } else tbl2
end

function Parser:parseNamedType()
    local token = self._lexer.token
    return {
        kind = Kind.NAMED_TYPE,
        name = self:parseName(),
        loc = self:loc(token)
    }
end

function Parser:parseTypeSystemDefinition()
    local var1 = if self:peekDescription() then self._lexer:lookahead() else self._lexer.token

    if var1.kind == TokenKind.NAME then
        local value = var1.value
        if value == "schema" then
            return self:parseSchemaDefinition()
        elseif value == "scalar" then
            return self:parseScalarTypeDefinition()
        elseif value == "type" then
            return self:parseObjectTypeDefinition()
        elseif value == "interface" then
            return self:parseInterfaceTypeDefinition()
        elseif value == "union" then
            return self:parseUnionTypeDefinition()
        elseif value == "enum" then
            return self:parseEnumTypeDefinition()
        elseif value == "input" then
            return self:parseInputObjectTypeDefinition()
        elseif value == "directive" then
            return self:parseDirectiveDefinition()
        end
    end

    error(self:unexpected(var1))
end

function Parser:peekDescription()
    return self:peek(TokenKind.STRING) or self:peek(TokenKind.BLOCK_STRING)
end

function Parser:parseDescription()
    if self:peekDescription() then
        return self:parseStringLiteral()
    end
end

function Parser:parseSchemaDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("schema")
    local directives = self:parseDirectives(true)
    local operationTypes = self:many(TokenKind.BRACE_L, self.parseOperationTypeDefinition, TokenKind.BRACE_R)

    return {
        kind = Kind.SCHEMA_DEFINITION,
        description = description,
        directives = directives,
        operationTypes = operationTypes,
        loc = self:loc(token)
    }
end

function Parser:parseOperationTypeDefinition()
    local token = self._lexer.token

    local operation = self:parseOperationType()
    self:expectToken(TokenKind.COLON)
    local type = self:parseNamedType()
    return {
        kind = Kind.OPERATION_TYPE_DEFINITION,
        operation = operation,
        type = type,
        loc = self:loc(token)
    }
end

function Parser:parseScalarTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("scalar")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    return {
        kind = Kind.SCALAR_TYPE_DEFINITION,
        description = description,
        name = name,
        directives = directives,
        loc = self:loc(token)
    }
end

function Parser:parseObjectTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("type")
    local name = self:parseName()
    local interfaces = self:parseImplementsInterfaces()
    local directives = self:parseDirectives(true)
    local fields = self:parseFieldsDefinition()
    return {
        kind = Kind.OBJECT_TYPE_DEFINITION,
        description = description,
        name = name,
        interfaces = interfaces,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseImplementsInterfaces()
    if self:expectOptionalKeyword("implements") then
        return self:delimitedMany(TokenKind.AMP, self.parseNamedType)
    end
    return {}
end

function Parser:parseFieldsDefinition()
    return self:optionalMany(TokenKind.BRACE_L, self.parseFieldDefinition, TokenKind.BRACE_R)
end

function Parser:parseFieldDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    local name = self:parseName()
    local var3 = self:parseArgumentDefs()
    self:expectToken(TokenKind.COLON)
    local type = self:parseTypeReference()
    local directives = self:parseDirectives(true)
    return {
        kind = Kind.FIELD_DEFINITION,
        description = description,
        name = name,
        arguments = var3,
        type = type,
        directives = directives,
        loc = self:loc(token)
    }
end

function Parser:parseArgumentDefs()
    return self:optionalMany(TokenKind.PAREN_L, self.parseInputValueDef, TokenKind.PAREN_R)
end

function Parser:parseInputValueDef()
    local token = self._lexer.token
    local description = self:parseDescription()
    local name = self:parseName()
    self:expectToken(TokenKind.COLON)
    local type = self:parseTypeReference()
    local defaultValue = if self:expectOptionalToken(TokenKind.EQUALS) then self:parseValueLiteral(true) else nil
    local directives = self:parseDirectives(true)
    return {
        kind = Kind.INPUT_VALUE_DEFINITION,
        description = description,
        name = name,
        type = type,
        defaultValue = defaultValue,
        directives = directives,
        loc = self:loc(token)
    }
end

function Parser:parseInterfaceTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("interface")
    local name = self:parseName()
    local interfaces = self:parseImplementsInterfaces()
    local directives = self:parseDirectives(true)
    local fields = self:parseFieldsDefinition()
    return {
        kind = Kind.INTERFACE_TYPE_DEFINITION,
        description = description,
        name = name,
        interfaces = interfaces,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseUnionTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("union")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local types = self:parseUnionMemberTypes()
    return {
        kind = Kind.UNION_TYPE_DEFINITION,
        description = description,
        name = name,
        directives = directives,
        types = types,
        loc = self:loc(token)
    }
end

function Parser:parseUnionMemberTypes()
    local result = {}
    if self:expectOptionalToken(TokenKind.EQUALS) then
        self:expectOptionalToken(TokenKind.PIPE)
        repeat
            table.insert(result, self:parseNamedType())
        until not self:expectOptionalToken(TokenKind.PIPE)
    end

    return result
end

function Parser:parseEnumTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("enum")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local values = self:parseEnumValuesDefinition()
    return {
        kind = Kind.ENUM_TYPE_DEFINITION,
        description = description,
        name = name,
        directives = directives,
        values = values,
        loc = self:loc(token)
    }
end

function Parser:parseEnumValuesDefinition()
    return self:optionalMany(TokenKind.BRACE_L, self.parseEnumValueDefinition, TokenKind.BRACE_R)
end

function Parser:parseEnumValueDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    return {
        kind = Kind.ENUM_VALUE_DEFINITION,
        description = description,
        name = name,
        directives = directives,
        loc = self:loc(token)
    }
end

function Parser:parseInputObjectTypeDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("input")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local fields = self:parseInputFieldsDefinition()
    return {
        kind = Kind.INPUT_OBJECT_TYPE_DEFINITION,
        description = description,
        name = name,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseInputFieldsDefinition()
    return self:optionalMany(TokenKind.BRACE_L, self.parseInputValueDef, TokenKind.BRACE_R)
end

function Parser:parseTypeSystemExtension()
    local var1 = self._lexer:lookahead()

    if var1.kind == TokenKind.NAME then
        local value = var1.value
        if value == "schema" then
            return self:parseSchemaExtension()
        elseif value == "scalar" then
            return self:parseScalarTypeExtension()
        elseif value == "type" then
            return self:parseObjectTypeExtension()
        elseif value == "interface" then
            return self:parseInterfaceTypeExtension()
        elseif value == "union" then
            return self:parseUnionTypeExtension()
        elseif value == "enum" then
            return self:parseEnumTypeExtension()
        elseif value == "input" then
            return self:parseInputObjectTypeExtension()
        end
    end

    error(self:unexpected(var1))
end

function Parser:parseSchemaExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("schema")
    local directives = self:parseDirectives(true)
    local operationTypes = self:optionalMany(TokenKind.BRACE_L, self.parseOperationTypeDefinition, TokenKind.BRACE_R)

    if #directives == 0 and #operationTypes == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.SCHEMA_EXTENSION,
        directives = directives,
        operationTypes = operationTypes,
        loc = self:loc(token)
    }
end

function Parser:parseScalarTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("scalar")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    if #directives == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.SCALAR_TYPE_EXTENSION,
        name = name,
        directives = directives,
        loc = self:loc(token)
    }
end

function Parser:parseObjectTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("type")
    local name = self:parseName()
    local interfaces = self:parseImplementsInterfaces()
    local directives = self:parseDirectives(true)
    local fields = self:parseFieldsDefinition()
    if #interfaces == 0 and #directives == 0 and #fields == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.OBJECT_TYPE_EXTENSION,
        name = name,
        interfaces = interfaces,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseInterfaceTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("interface")
    local name = self:parseName()
    local interfaces = self:parseImplementsInterfaces()
    local directives = self:parseDirectives(true)
    local fields = self:parseFieldsDefinition()
    if #interfaces == 0 and #directives == 0 and #fields == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.INTERFACE_TYPE_EXTENSION,
        name = name,
        interfaces = interfaces,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseUnionTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("union")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local types = self:parseUnionMemberTypes()
    if #directives == 0 and #types == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.UNION_TYPE_EXTENSION,
        name = name,
        directives = directives,
        types = types,
        loc = self:loc(token)
    }
end

function Parser:parseEnumTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("enum")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local values = self:parseEnumValuesDefinition()
    if #directives == 0 and #values == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.ENUM_TYPE_EXTENSION,
        name = name,
        directives = directives,
        values = values,
        loc = self:loc(token)
    }
end

function Parser:parseInputObjectTypeExtension()
    local token = self._lexer.token
    self:expectKeyword("extend")
    self:expectKeyword("input")
    local name = self:parseName()
    local directives = self:parseDirectives(true)
    local fields = self:parseInputFieldsDefinition()
    if #directives == 0 and #fields == 0 then
        error(self:unexpected())
    end
    return {
        kind = Kind.INPUT_OBJECT_TYPE_EXTENSION,
        name = name,
        directives = directives,
        fields = fields,
        loc = self:loc(token)
    }
end

function Parser:parseDirectiveDefinition()
    local token = self._lexer.token
    local description = self:parseDescription()
    self:expectKeyword("directive")
    self:expectToken(TokenKind.AT)
    local name = self:parseName()
    local var3 = self:parseArgumentDefs()
    local repeatable = self:expectOptionalKeyword("repeatable")
    self:expectKeyword("on")
    local locations = self:parseDirectiveLocations()
    return {
        kind = Kind.DIRECTIVE_DEFINITION,
        description = description,
        name = name,
        arguments = var3,
        repeatable = repeatable,
        locations = locations,
        loc = self:loc(token)
    }
end

function Parser:parseDirectiveLocations()
    self:expectOptionalToken(TokenKind.PIPE)
    local result = {}

    repeat
        table.insert(result, self:parseDirectiveLocation())
    until not self:expectOptionalToken(TokenKind.PIPE)

    return result
end

function Parser:parseDirectiveLocation()
    local token = self._lexer.token
    local var1 = self:parseName()
    if DirectiveLocation[var1.value] ~= nil then
        return var1
    end
    error(self:unexpected(token))
end

function Parser:loc(arg1)
    if (self._options and self._options.noLocation) ~= true then
        return Location.new(arg1, self._lexer.lastToken, self._lexer.source)
    end
    return nil
end

function Parser:peek(kind): boolean
    return self._lexer.token.kind == kind
end

function Parser:expectToken(kind)
    local token = self._lexer.token
    if token.kind == kind then
        self._lexer:advance()
        return token
    end

    error(
        syntaxError(
            self._lexer.source,
            token.start,
            "Expected " .. getTokenKindDesc(kind) .. ", found " .. getTokenDesc(token) .. "."
        )
    )
end

function Parser:expectOptionalToken(kind)
    local token = self._lexer.token
    if token.kind ~= kind then
        return nil
    end

    self._lexer:advance()
    return token
end

function Parser:expectKeyword(str1: string)
    local token = self._lexer.token
    if token.kind == TokenKind.NAME and token.value == str1 then
        self._lexer:advance()
        return
    end
    error(syntaxError(self._lexer.source, token.start, "Expected \"" .. str1 .. "\", found " .. getTokenDesc(token) .. "."))
end

function Parser:expectOptionalKeyword(str1: string): boolean
    local token = self._lexer.token
    if token.kind ~= TokenKind.NAME or token.value ~= str1 then
        return false
    end

    self._lexer:advance()
    return true
end

function Parser:unexpected(arg1)
    local var1 = arg1 ~= nil and arg1 or self._lexer.token
    return syntaxError(self._lexer.source, var1.start, "Unexpected " .. getTokenDesc(var1) .. ".")
end

function Parser:any(arg1, func1: (...any) -> (...any), arg2)
    self:expectToken(arg1)
    local result = {}

    while not self:expectOptionalToken(arg2) do
        table.insert(result, func1(self))
    end
    return result
end

function Parser:optionalMany(arg1, func1: (...any) -> (...any), arg2)
    if not self:expectOptionalToken(arg1) then
        return {}
    end

    local result = {}

    repeat
        table.insert(result, func1(self))
    until self:expectOptionalToken(arg2)
    return result
end

function Parser:many(arg1, func1: (...any) -> (...any), arg2)
    self:expectToken(arg1)
    local result = {}

    repeat
        table.insert(result, func1(self))
    until self:expectOptionalToken(arg2)
    return result
end

function Parser:delimitedMany(arg1, func1: (...any) -> (...any))
    self:expectOptionalToken(arg1)
    local result = {}

    repeat
        table.insert(result, func1(self))
    until not self:expectOptionalToken(arg1)
    return result
end

getTokenDesc = function(arg1)
    local value = arg1.value
    return getTokenKindDesc(arg1.kind) .. (if value == nil then "" else " \"" .. value .. "\"" or "")
end

getTokenKindDesc = function(arg1)
    if isPunctuatorTokenKind(arg1) then
        arg1 = "\"" .. arg1 .. "\"" or arg1
    end

    return arg1
end

return {
    Parser = Parser,
    parse = function(arg1, tbl2)
        return Parser.new(arg1, tbl2):parseDocument()
    end,
    parseValue = function(arg1, tbl2)
        local var1 = Parser.new(arg1, tbl2)
        var1:expectToken(TokenKind.SOF)
        local var2 = var1:parseValueLiteral(false)
        var1:expectToken(TokenKind.EOF)
        return var2
    end,
    parseType = function(arg1, tbl2)
        local var1 = Parser.new(arg1, tbl2)
        var1:expectToken(TokenKind.SOF)
        local var2 = var1:parseTypeReference()
        var1:expectToken(TokenKind.EOF)
        return var2
    end
}
