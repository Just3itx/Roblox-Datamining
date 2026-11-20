-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:23Z
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

local null = require(scriptParentParent.luaUtils.null)

local var1 = Object.freeze({})
local luaUtils = scriptParentParent.luaUtils

local isNillish = require(luaUtils.isNillish).isNillish

local jsutils = scriptParentParent.jsutils
local _ObjMap = require(jsutils.ObjMap)

local inspect = require(jsutils.inspect).inspect
local keyMap = require(jsutils.keyMap).keyMap
local toObjMap = require(jsutils.toObjMap).toObjMap
local keyValMap = require(jsutils.keyValMap).keyValMap
local devAssert = require(jsutils.devAssert).devAssert
local instanceOf = require(jsutils.instanceOf)
local didYouMean = require(jsutils.didYouMean).didYouMean
local isObjectLike = require(jsutils.isObjectLike).isObjectLike
local identityFunc = require(jsutils.identityFunc).identityFunc
local suggestionList = require(jsutils.suggestionList).suggestionList
local _PromiseOrValue = require(jsutils.PromiseOrValue)

local _Path = require(jsutils.Path)

local mapValueOrdered = require(scriptParentParent.luaUtils.mapValueOrdered).mapValueOrdered

local GraphQLError = require(scriptParentParent.error.GraphQLError).GraphQLError

local language = scriptParentParent.language
local Kind = require(language.kinds).Kind
local print = require(language.printer).print

local _ast = require(scriptParentParent.language.ast)

local valueFromASTUntyped = require(scriptParentParent.utilities.valueFromASTUntyped).valueFromASTUntyped

local isScalarType = nil

local isObjectType = nil

local isInterfaceType = nil

local isUnionType = nil

local isEnumType = nil

local isInputObjectType = nil

local isListType = nil

local isNonNullType = nil

local isWrappingType = nil

local isNullableType = nil

local argsToArgsConfig = nil

local defineInputFieldMap = nil
local defineTypes = nil
local isPlainObj = nil
local didYouMeanEnumValue = nil
local defineEnumValues = nil
local fieldsToFieldsConfig = nil
local defineInterfaces = nil
local defineFieldMap = nil

local var2 = nil
local var3 = nil
local GraphQLScalarType = ({})
local GraphQLObjectType = ({})
local GraphQLInterfaceType = ({})
local GraphQLUnionType = ({})
local GraphQLEnumType = ({})
local GraphQLInputObjectType = ({})

local function isType(arg1)
    return isScalarType(arg1)
        or isObjectType(arg1)
        or isInterfaceType(arg1)
        or isUnionType(arg1)
        or isEnumType(arg1)
        or isInputObjectType(arg1)
        or isListType(arg1)
        or isNonNullType(arg1)
end

local function assertType<T>(arg1: T): T
    if not isType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL type."):format(inspect(arg1))))
    end

    return arg1
end

isScalarType = function(arg1)
    return instanceOf(arg1, GraphQLScalarType)
end

local function assertScalarType<T>(arg1: T): T
    if not isScalarType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Scalar type."):format(inspect(arg1))))
    end

    return arg1
end

isObjectType = function(arg1)
    return instanceOf(arg1, GraphQLObjectType)
end

local function assertObjectType<T>(arg1: T): T
    if not isObjectType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Object type."):format(inspect(arg1))))
    end

    return arg1
end

isInterfaceType = function(arg1)
    return instanceOf(arg1, GraphQLInterfaceType)
end

local function assertInterfaceType<T>(arg1: T): T
    if not isInterfaceType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Interface type."):format(inspect(arg1))))
    end

    return arg1
end

isUnionType = function(arg1)
    return instanceOf(arg1, GraphQLUnionType)
end

local function assertUnionType<T>(arg1: T): T
    if not isUnionType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Union type."):format(inspect(arg1))))
    end

    return arg1
end

isEnumType = function(arg1)
    return instanceOf(arg1, GraphQLEnumType)
end

local function assertEnumType<T>(arg1: T): T
    if not isEnumType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Enum type."):format(inspect(arg1))))
    end

    return arg1
end

isInputObjectType = function(arg1)
    return instanceOf(arg1, GraphQLInputObjectType)
end

local function assertInputObjectType<T>(arg1: T): T
    if not isInputObjectType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Input Object type."):format(inspect(arg1))))
    end

    return arg1
end

isListType = function(arg1)
    return instanceOf(arg1, var2)
end

local function assertListType<T>(arg1: T): T
    if not isListType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL List type."):format(inspect(arg1))))
    end

    return arg1
end

isNonNullType = function(arg1)
    return instanceOf(arg1, var3)
end

local function assertNonNullType<T>(arg1: T): T
    if not isNonNullType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL Non-Null type."):format(inspect(arg1))))
    end

    return arg1
end

local function isInputType(arg1)
    return isScalarType(arg1) or isEnumType(arg1) or isInputObjectType(arg1) or isWrappingType(arg1) and isInputType(arg1.ofType)
end

local function assertInputType<T>(arg1: T): T
    if not isInputType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL input type."):format(inspect(arg1))))
    end

    return arg1
end

local function isOutputType(arg1)
    return isScalarType(arg1)
        or isObjectType(arg1)
        or isInterfaceType(arg1)
        or isUnionType(arg1)
        or isEnumType(arg1)
        or isWrappingType(arg1) and isOutputType(arg1.ofType)
end

local function assertOutputType<T>(arg1: T): T
    if not isOutputType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL output type."):format(inspect(arg1))))
    end

    return arg1
end

local function isLeafType(arg1)
    return isScalarType(arg1) or isEnumType(arg1)
end

local function assertLeafType<T>(arg1: T): T
    if not isLeafType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL leaf type."):format(inspect(arg1))))
    end

    return arg1
end

local function isCompositeType(arg1)
    return isObjectType(arg1) or isInterfaceType(arg1) or isUnionType(arg1)
end

local function assertCompositeType<T>(arg1: T): T
    if not isCompositeType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL composite type."):format(inspect(arg1))))
    end

    return arg1
end

local function isAbstractType(arg1)
    return isInterfaceType(arg1) or isUnionType(arg1)
end

local function assertAbstractType<T>(arg1: T): T
    if not isAbstractType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL abstract type."):format(inspect(arg1))))
    end

    return arg1
end

var2 = {}

var2.__index = var2

function var2.new(ofType)
    local tbl7 = {}

    devAssert(isType(ofType), ("Expected %s to be a GraphQL type."):format(inspect(ofType)))

    tbl7.ofType = ofType

    return (setmetatable(tbl7, var2))
end

function var2.__tostring(arg1)
    return arg1:toString()
end

function var2:toString(): string
    return "[" .. tostring(self.ofType) .. "]"
end

function var2.toJSON(arg1)
    return arg1:toString()
end

var3 = {}

var3.__index = var3

function var3.new(ofType)
    local tbl7 = {}
    devAssert(isNullableType(ofType), ("Expected %s to be a GraphQL nullable type."):format(inspect(ofType)))

    tbl7.ofType = ofType
    return (setmetatable(tbl7, var3))
end

function var3.__tostring(arg1)
    return arg1:toString()
end

function var3:toString(): string
    return tostring(self.ofType) .. "!"
end

function var3.toJSON(arg1)
    return arg1:toString()
end

isWrappingType = function(arg1)
    return isListType(arg1) or isNonNullType(arg1)
end

local function assertWrappingType<T>(arg1: T): T
    if not isWrappingType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL wrapping type."):format(inspect(arg1))))
    end

    return arg1
end

isNullableType = function(arg1)
    return isType(arg1) and not isNonNullType(arg1)
end

local function assertNullableType<T>(arg1: T): T
    if not isNullableType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL nullable type."):format(inspect(arg1))))
    end

    return arg1
end

local function getNullableType(arg1)
    return if arg1 then if isNonNullType(arg1) then arg1.ofType else arg1 else nil
end

local function isNamedType(arg1)
    return isScalarType(arg1)
        or isObjectType(arg1)
        or isInterfaceType(arg1)
        or isUnionType(arg1)
        or isEnumType(arg1)
        or isInputObjectType(arg1)
end

local function assertNamedType<T>(arg1: T): T
    if not isNamedType(arg1) then
        error(Error.new(("Expected %s to be a GraphQL named type."):format(inspect(arg1))))
    end

    return arg1
end

local function getNamedType(arg1)
    if not arg1 then
        return nil
    end

    while isWrappingType(arg1) do
        arg1 = arg1.ofType
    end

    return arg1
end

local function resolveThunk(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if typeof(arg1) == "function" then
        return (arg1())
    end

    return arg1
end

local function undefineIfEmpty(extensionAstNodes) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if extensionAstNodes and #extensionAstNodes > 0 then extensionAstNodes else nil
end

GraphQLScalarType.__index = GraphQLScalarType

function GraphQLScalarType.new(tbl7)
    local tbl8 = ({})
    local var4 = if tbl7.parseValue then tbl7.parseValue else identityFunc
    tbl8.name = tbl7.name
    tbl8.description = tbl7.description
    tbl8.specifiedByUrl = tbl7.specifiedByUrl
    local var5 = if tbl7.serialize then tbl7.serialize else identityFunc

    function tbl8.serialize(_, ...)
        return var5(...)
    end

    function tbl8.parseValue(_, ...)
        return var4(...)
    end
    local var6 = not tbl7.parseLiteral and function(arg1, arg2)
        return var4(valueFromASTUntyped(arg1, arg2))
    end or tbl7.parseLiteral

    function tbl8.parseLiteral(_, ...)
        return var6(...)
    end
    tbl8.extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil
    tbl8.astNode = tbl7.astNode
    tbl8.extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)

    devAssert(typeof(tbl7.name) == "string", "Must provide name.")

    local var7 = devAssert
    local bool1 = isNillish(tbl7.specifiedByUrl) or typeof(tbl7.specifiedByUrl) == "string"
    var7(
        bool1,
        ("%s must provide \"specifiedByUrl\" as a string, "):format(tbl8.name) .. ("but got: %s."):format(inspect(tbl7.specifiedByUrl))
    )

    local var8 = devAssert
    local bool2 = tbl7.serialize == nil or typeof(tbl7.serialize) == "function"
    var8(
        bool2,
        ("%s must provide \"serialize\" function. If this custom Scalar is also used as an input type, ensure \"parseValue\" and \"parseLiteral\" functions are also provided."):format(
            tbl8.name
        )
    )
    if tbl7.parseLiteral then
        local var9 = devAssert
        local parseValue = tbl7.parseValue
        local bool3 = typeof(parseValue) == "function" and typeof(tbl7.parseLiteral) == "function"
        var9(bool3, ("%s must provide both \"parseValue\" and \"parseLiteral\" functions."):format(tbl8.name))
    end

    return (setmetatable(tbl8, GraphQLScalarType))
end

function GraphQLScalarType:toConfig()
    return {
        name = self.name,
        description = self.description,
        specifiedByUrl = self.specifiedByUrl,
        serialize = self.serialize,
        parseValue = self.parseValue,
        parseLiteral = self.parseLiteral,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = not self.extensionASTNodes and {} or self.extensionASTNodes
    }
end

function GraphQLScalarType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLScalarType:toString()
    return self.name
end

function GraphQLScalarType.toJSON(arg1)
    return arg1:toString()
end

GraphQLObjectType.__index = GraphQLObjectType

function GraphQLObjectType.new(tbl7)
    local tbl8 = {
        name = tbl7.name,
        description = tbl7.description,
        isTypeOf = tbl7.isTypeOf,
        extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil,
        astNode = tbl7.astNode,
        extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)
    }
    function tbl8._fields()
        return defineFieldMap(tbl7)
    end
    function tbl8._interfaces()
        return defineInterfaces(tbl7)
    end
    devAssert(typeof(tbl7.name) == "string", "Must provide name.")
    local var4 = devAssert
    local bool1 = tbl7.isTypeOf == nil or typeof(tbl7.isTypeOf) == "function"
    var4(bool1, ("%s must provide \"isTypeOf\" as a function, but got: %s."):format(tbl8.name, inspect(tbl7.isTypeOf)))

    return (setmetatable(tbl8, GraphQLObjectType))
end

function GraphQLObjectType:getFields()
    if typeof(self._fields) == "function" then
        self._fields = self._fields()
    end
    return self._fields
end

function GraphQLObjectType:getInterfaces()
    if typeof(self._interfaces) == "function" then
        self._interfaces = self._interfaces()
    end
    return self._interfaces
end

function GraphQLObjectType:toConfig()
    return {
        name = self.name,
        description = self.description,
        interfaces = self:getInterfaces(),
        fields = fieldsToFieldsConfig(self:getFields()),
        isTypeOf = self.isTypeOf,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {}
    }
end

function GraphQLObjectType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLObjectType:toString()
    return self.name
end

function GraphQLObjectType.toJSON(arg1)
    return arg1:toString()
end

defineInterfaces = function(tbl7)
    local var4 = resolveThunk(tbl7.interfaces) or {}

    devAssert(
        Array.isArray(var4),
        ("%s interfaces must be an Array or a function which returns an Array."):format(tbl7.name)
    )

    return var4
end

defineFieldMap = function(tbl7)
    local var4 = resolveThunk(tbl7.fields)

    devAssert(
        isPlainObj(var4) or instanceOf(var4, Map),
        ("%s fields must be an object with field names as keys or a function which returns such an object."):format(tbl7.name)
    )

    local var5 = coerceToMap(var4)

    return mapValueOrdered(var5, function(arg1, name)
        devAssert(isPlainObj(arg1), ("%s.%s field config must be an object."):format(tbl7.name, name))

        local var6 = devAssert
        local bool1 = arg1.resolve == nil or typeof(arg1.resolve) == "function"
        var6(
            bool1,
            ("%s.%s field resolver must be a function if "):format(tbl7.name, name) .. ("provided, but got: %s."):format(inspect(arg1.resolve))
        )

        local var7 = not arg1.args and {} or arg1.args

        devAssert(
            isPlainObj(var7) or instanceOf(var7, Map),
            ("%s.%s args must be an object with argument names as keys."):format(tbl7.name, name)
        )

        local args = Array.map(coerceToMap(var7):entries(), function(arg3)
            local var8 = arg3[1]
            local var9 = arg3[2]

            return {
                name = var8,
                description = var9.description,
                type = var9.type,
                defaultValue = var9.defaultValue,
                deprecationReason = var9.deprecationReason,
                extensions = if var9.extensions then toObjMap(var9.extensions) else nil,
                astNode = var9.astNode
            }
        end)

        return {
            name = name,
            description = arg1.description,
            type = arg1.type,
            args = args,
            resolve = arg1.resolve,
            subscribe = arg1.subscribe,
            deprecationReason = arg1.deprecationReason,
            extensions = if arg1.extensions then toObjMap(arg1.extensions) else nil,
            astNode = arg1.astNode
        }
    end)
end

isPlainObj = function(arg1)
    return not (arg1 == null) and isObjectLike(arg1) and (not Array.isArray(arg1) or next(arg1) == nil)
end

fieldsToFieldsConfig = function(arg1)
    return mapValueOrdered(arg1, function(arg2)
        return {
            description = arg2.description,
            type = arg2.type,
            args = argsToArgsConfig(arg2.args),
            resolve = arg2.resolve,
            subscribe = arg2.subscribe,
            deprecationReason = arg2.deprecationReason,
            extensions = arg2.extensions,
            astNode = arg2.astNode
        }
    end)
end

argsToArgsConfig = function(arg1)
    return keyValMap(arg1, function(arg2)
        return arg2.name
    end, function(arg2)
        return {
            description = arg2.description,
            type = arg2.type,
            defaultValue = arg2.defaultValue,
            deprecationReason = arg2.deprecationReason,
            extensions = arg2.extensions,
            astNode = arg2.astNode
        }
    end)
end

local function isRequiredArgument(tbl7)
    return isNonNullType(tbl7.type) and tbl7.defaultValue == nil
end

GraphQLInterfaceType.__index = GraphQLInterfaceType

function GraphQLInterfaceType.new(tbl7)
    local tbl8 = {
        name = tbl7.name,
        description = tbl7.description,
        resolveType = tbl7.resolveType,
        extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil,
        astNode = tbl7.astNode,
        extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)
    }
    function tbl8._fields()
        return defineFieldMap(tbl7)
    end
    function tbl8._interfaces()
        return defineInterfaces(tbl7)
    end
    devAssert(typeof(tbl7.name) == "string", "Must provide name.")
    local var4 = devAssert
    local bool1 = tbl7.resolveType == nil or typeof(tbl7.resolveType) == "function"
    var4(
        bool1,
        ("%s must provide \"resolveType\" as a function, but got: %s."):format(tbl8.name, inspect(tbl7.resolveType))
    )

    return (setmetatable(tbl8, GraphQLInterfaceType))
end

function GraphQLInterfaceType:getFields()
    if typeof(self._fields) == "function" then
        self._fields = self._fields()
    end
    return self._fields
end

function GraphQLInterfaceType:getInterfaces()
    if typeof(self._interfaces) == "function" then
        self._interfaces = self._interfaces()
    end
    return self._interfaces
end

function GraphQLInterfaceType:toConfig()
    return {
        name = self.name,
        description = self.description,
        interfaces = self:getInterfaces(),
        fields = fieldsToFieldsConfig(self:getFields()),
        resolveType = self.resolveType,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {}
    }
end

function GraphQLInterfaceType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLInterfaceType:toString()
    return self.name
end

function GraphQLInterfaceType.toJSON(arg1)
    return arg1:toString()
end

GraphQLUnionType.__index = GraphQLUnionType

function GraphQLUnionType.new(tbl7)
    local tbl8 = {
        name = tbl7.name,
        description = tbl7.description,
        resolveType = tbl7.resolveType,
        extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil,
        astNode = tbl7.astNode,
        extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)
    }
    function tbl8._types()
        return defineTypes(tbl7)
    end
    devAssert(typeof(tbl7.name) == "string", "Must provide name.")
    local var4 = devAssert
    local bool1 = tbl7.resolveType == nil or typeof(tbl7.resolveType) == "function"
    var4(
        bool1,
        ("%s must provide \"resolveType\" as a function, but got: %s."):format(tbl8.name, inspect(tbl7.resolveType))
    )

    return (setmetatable(tbl8, GraphQLUnionType))
end

function GraphQLUnionType:getTypes()
    if typeof(self._types) == "function" then
        self._types = self._types()
    end
    return self._types
end

function GraphQLUnionType:toConfig()
    return {
        name = self.name,
        description = self.description,
        types = self:getTypes(),
        resolveType = self.resolveType,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {}
    }
end

function GraphQLUnionType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLUnionType:toString()
    return self.name
end

function GraphQLUnionType.toJSON(arg1)
    return arg1:toString()
end

defineTypes = function(tbl7)
    local var4 = resolveThunk(tbl7.types)

    devAssert(
        Array.isArray(var4),
        ("Must provide Array of types or a function which returns such an array for Union %s."):format(tbl7.name)
    )

    return var4
end

GraphQLEnumType.__index = GraphQLEnumType

function GraphQLEnumType.new(tbl7)
    local tbl8 = {
        name = tbl7.name,
        description = tbl7.description,
        extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil,
        astNode = tbl7.astNode,
        extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)
    }
    tbl8._values = defineEnumValues(tbl8.name, tbl7.values)
    tbl8._valueLookup = {}

    Array.forEach(tbl8._values, function(arg1)
        if arg1.value == arg1.value then
            tbl8._valueLookup[arg1.value] = arg1
            return
        end
        tbl8._valueLookup[var1] = arg1
    end)

    tbl8._nameLookup = keyMap(tbl8._values, function(arg1)
        return arg1.name
    end)

    devAssert(typeof(tbl7.name) == "string", "Must provide name.")

    return (setmetatable(tbl8, GraphQLEnumType))
end

function GraphQLEnumType:getValues()
    return self._values
end

function GraphQLEnumType:getValue(str1: string)
    return self._nameLookup[str1]
end

function GraphQLEnumType:serialize(arg1)
    local var4 = if arg1 == arg1 then self._valueLookup[arg1] else self._valueLookup[var1]

    if var4 == nil then
        error(GraphQLError.new(("Enum \"%s\" cannot represent value: %s"):format(self.name, inspect(arg1))))
    end

    return var4.name
end

function GraphQLEnumType:parseValue(arg1)
    if typeof(arg1) ~= "string" then
        local var4 = inspect(arg1)
        error(
            GraphQLError.new(
                ("Enum \"%s\" cannot represent non-string value: %s." .. didYouMeanEnumValue(self, var4)):format(self.name, var4)
            )
        )
    end

    local value = self:getValue(arg1)
    if value == nil then
        error(
            GraphQLError.new(
                ("Value \"%s\" does not exist in \"%s\" enum."):format(arg1, self.name) .. didYouMeanEnumValue(self, arg1)
            )
        )
    end
    return value.value
end

function GraphQLEnumType:parseLiteral(arg1, _)
    if arg1.kind ~= Kind.ENUM then
        local var4 = print(arg1)
        error(
            GraphQLError.new(
                ("Enum \"%s\" cannot represent non-enum value: %s."):format(self.name, var4) .. didYouMeanEnumValue(self, var4),
                arg1
            )
        )
    end

    local value = self:getValue(arg1.value)
    if value == nil then
        local var4 = print(arg1)
        error(
            GraphQLError.new(
                ("Value \"%s\" does not exist in \"%s\" enum."):format(var4, self.name) .. didYouMeanEnumValue(self, var4),
                arg1
            )
        )
    end

    return value.value
end

function GraphQLEnumType:toConfig()
    local values = keyValMap(self:getValues(), function(arg1)
        return arg1.name
    end, function(arg1)
        return {
            description = arg1.description,
            value = arg1.value,
            deprecationReason = arg1.deprecationReason,
            extensions = arg1.extensions,
            astNode = arg1.astNode
        }
    end)

    return {
        name = self.name,
        description = self.description,
        values = values,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {}
    }
end

function GraphQLEnumType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLEnumType:toString()
    return self.name
end

function GraphQLEnumType.toJSON(arg1)
    return arg1:toString()
end

didYouMeanEnumValue = function(tbl7, str1: string)
    local var4 = Array.map(tbl7:getValues(), function(arg1)
        return arg1.name
    end)
    local var5 = suggestionList(str1, var4)

    return didYouMean("the enum value", var5)
end

defineEnumValues = function(str1: string, arg1)
    devAssert(
        isPlainObj(arg1) or instanceOf(arg1, Map),
        ("%s values must be an object with value names as keys."):format(tostring(str1))
    )

    local var4 = coerceToMap(arg1):entries()

    return Array.map(var4, function(arg2)
        local var5 = arg2[1]
        local var6 = arg2[2]

        devAssert(
            isPlainObj(var6),
            ("%s.%s must refer to an object with a \"value\" key "):format(tostring(str1), tostring(var5)) .. ("representing an internal value but got: %s."):format(inspect(var6))
        )

        local tbl7 = {
            name = tostring(var5),
            description = var6.description,
            value = 0,
            deprecationReason = 0,
            extensions = 0,
            astNode = 0
        }

        if var6.value ~= nil then
            var5 = var6.value
        end

        tbl7.value = var5
        tbl7.deprecationReason = var6.deprecationReason
        tbl7.extensions = if var6.extensions then toObjMap(var6.extensions) else nil
        tbl7.astNode = var6.astNode
        return tbl7
    end)
end

GraphQLInputObjectType.__index = GraphQLInputObjectType

function GraphQLInputObjectType.new(tbl7)
    local tbl8 = {
        name = tbl7.name,
        description = tbl7.description,
        extensions = if tbl7.extensions then toObjMap(tbl7.extensions) else nil,
        astNode = tbl7.astNode,
        extensionASTNodes = undefineIfEmpty(tbl7.extensionASTNodes)
    }
    function tbl8._fields()
        return defineInputFieldMap(tbl7)
    end
    devAssert(typeof(tbl7.name) == "string", "Must provide name.")
    return (setmetatable(tbl8, GraphQLInputObjectType))
end

function GraphQLInputObjectType:getFields()
    if typeof(self._fields) == "function" then
        self._fields = self._fields()
    end
    return self._fields
end

function GraphQLInputObjectType:toConfig()
    local fields = mapValueOrdered(self:getFields(), function(arg1)
        return {
            description = arg1.description,
            type = arg1.type,
            defaultValue = arg1.defaultValue,
            extensions = arg1.extensions,
            astNode = arg1.astNode
        }
    end)

    return {
        name = self.name,
        description = self.description,
        fields = fields,
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {}
    }
end

function GraphQLInputObjectType.__tostring(arg1)
    return arg1:toString()
end

function GraphQLInputObjectType:toString()
    return self.name
end

function GraphQLInputObjectType.toJSON(arg1)
    return arg1:toString()
end

defineInputFieldMap = function(tbl7)
    local var4 = resolveThunk(tbl7.fields)

    devAssert(
        isPlainObj(var4) or instanceOf(var4, Map),
        ("%s fields must be an object with field names as keys or a function which returns such an object."):format(tbl7.name)
    )

    local var5 = coerceToMap(var4)

    return mapValueOrdered(var5, function(arg1, name)
        devAssert(
            arg1.resolve == nil,
            ("%s.%s field has a resolve property, but Input Types cannot define resolvers."):format(tbl7.name, name)
        )

        return {
            name = name,
            description = arg1.description,
            type = arg1.type,
            defaultValue = arg1.defaultValue,
            deprecationReason = arg1.deprecationReason,
            extensions = if arg1.extensions then toObjMap(arg1.extensions) else nil,
            astNode = arg1.astNode
        }
    end)
end

local function isRequiredInputField(tbl7)
    return isNonNullType(tbl7.type) and tbl7.defaultValue == nil
end

({}).new = function()
    return {}
end

return {
    GraphQLList = var2,
    GraphQLNonNull = var3,
    GraphQLScalarType = GraphQLScalarType,
    GraphQLObjectType = GraphQLObjectType,
    GraphQLInterfaceType = GraphQLInterfaceType,
    GraphQLUnionType = GraphQLUnionType,
    GraphQLEnumType = GraphQLEnumType,
    GraphQLInputObjectType = GraphQLInputObjectType,
    isType = isType,
    assertType = assertType,
    isScalarType = isScalarType,
    assertScalarType = assertScalarType,
    isObjectType = isObjectType,
    assertObjectType = assertObjectType,
    isInterfaceType = isInterfaceType,
    assertInterfaceType = assertInterfaceType,
    isUnionType = isUnionType,
    assertUnionType = assertUnionType,
    isEnumType = isEnumType,
    assertEnumType = assertEnumType,
    isInputObjectType = isInputObjectType,
    assertInputObjectType = assertInputObjectType,
    isListType = isListType,
    assertListType = assertListType,
    isNonNullType = isNonNullType,
    assertNonNullType = assertNonNullType,
    isInputType = isInputType,
    assertInputType = assertInputType,
    isOutputType = isOutputType,
    assertOutputType = assertOutputType,
    isLeafType = isLeafType,
    assertLeafType = assertLeafType,
    isCompositeType = isCompositeType,
    assertCompositeType = assertCompositeType,
    isAbstractType = isAbstractType,
    assertAbstractType = assertAbstractType,
    isWrappingType = isWrappingType,
    assertWrappingType = assertWrappingType,
    isNullableType = isNullableType,
    assertNullableType = assertNullableType,
    getNullableType = getNullableType,
    isNamedType = isNamedType,
    assertNamedType = assertNamedType,
    getNamedType = getNamedType,
    argsToArgsConfig = argsToArgsConfig,
    isRequiredArgument = isRequiredArgument,
    isRequiredInputField = isRequiredInputField,
    NULL = null
}
