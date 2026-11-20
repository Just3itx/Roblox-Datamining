-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local luaUtils = scriptParentParent.luaUtils

local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set

local isNillish = require(luaUtils.isNillish)
local isNillish2 = isNillish.isNillish
local isNotNillish = isNillish.isNotNillish
local _null = require(luaUtils.null)

local jsutils = scriptParentParent.jsutils
local inspect = require(jsutils.inspect).inspect
local toObjMap = require(jsutils.toObjMap).toObjMap
local devAssert = require(jsutils.devAssert).devAssert
local instanceOf = require(jsutils.instanceOf)
local isObjectLike = require(jsutils.isObjectLike).isObjectLike

local __Schema = require(script.Parent.introspection).__Schema

local _ast = require(scriptParentParent.language.ast)

local _GraphQLError = require(scriptParentParent.error.GraphQLError)

local directives = require(script.Parent.directives)

local isDirective = directives.isDirective
local specifiedDirectives = directives.specifiedDirectives

local _ObjMap = require(jsutils.ObjMap)

local definition = require(script.Parent.definition)

local isObjectType = definition.isObjectType
local isInterfaceType = definition.isInterfaceType
local isUnionType = definition.isUnionType
local isInputObjectType = definition.isInputObjectType
local getNamedType = definition.getNamedType

local var1 = nil
local collectReferencedTypes = nil

local function isSchema(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return instanceOf(arg1, var1)
end

local function assertSchema<T>(arg1: T): T
    if not isSchema(arg1) then
        error(Error.new(("Expected %s to be a GraphQL schema."):format(inspect(arg1))))
    end
    return arg1
end

var1 = {}
var1.__index = var1

function var1.new(arg1)
    local self = (setmetatable({}, var1))

    self.__validationErrors = nil
    if arg1.assumeValid == true then
        self.__validationErrors = {}
    end

    devAssert(isObjectLike(arg1), "Must provide configuration object.")
    devAssert(
        not arg1.types or Array.isArray(arg1.types),
        ("\"types\" must be Array if provided but got: %s."):format(inspect(arg1.types))
    )
    devAssert(
        not arg1.directives or Array.isArray(arg1.directives),
        "\"directives\" must be Array if provided but got: " .. ("%s."):format(inspect(arg1.directives))
    )

    self.description = arg1.description
    self.extensions = if arg1.extensions then toObjMap(arg1.extensions) else nil
    self.astNode = arg1.astNode
    self.extensionASTNodes = arg1.extensionASTNodes

    self._queryType = arg1.query
    self._mutationType = arg1.mutation
    self._subscriptionType = arg1.subscription

    self._directives = arg1.directives or specifiedDirectives

    local set = Set.new()
    for _, value in ipairs(arg1.types or {}) do
        set:add(value)
    end
    if arg1.types ~= nil then
        for _, value in ipairs(arg1.types) do
            set:delete(value)
            collectReferencedTypes(value, set)
        end
    end

    if isNotNillish(self._queryType) then
        collectReferencedTypes(self._queryType, set)
    end
    if isNotNillish(self._mutationType) then
        collectReferencedTypes(self._mutationType, set)
    end
    if isNotNillish(self._subscriptionType) then
        collectReferencedTypes(self._subscriptionType, set)
    end

    for _, value in ipairs(self._directives) do
        if not isDirective(value) then
            continue
        end

        for _, arg in ipairs(value.args) do
            collectReferencedTypes(arg.type, set)
        end
    end

    collectReferencedTypes(__Schema, set)

    self._typeMap = Map.new()
    self._subTypeMap = Map.new()

    self._implementationsMap = Map.new()

    for _, value in set do
        if isNillish2(value) then
            continue
        end

        local var2 = if typeof(value) == "table" then value.name else tostring(value)
        devAssert(var2 and var2 ~= "", "One of the provided types for building the Schema is missing a name.")

        if self._typeMap:has(var2) then
            error(Error.new(("Schema must contain uniquely named types but contains multiple types named \"%s\"."):format(var2)))
        end

        self._typeMap:set(var2, value)

        if isInterfaceType(value) then
            for _, value2 in ipairs(value:getInterfaces()) do
                if not isInterfaceType(value2) then
                    continue
                end
                local tbl1 = self._implementationsMap:get(value2.name)

                if tbl1 == nil then
                    tbl1 = {
                        objects = {},
                        interfaces = {}
                    }
                    self._implementationsMap:set(value2.name, tbl1)
                end

                table.insert(tbl1.interfaces, value)
            end
        elseif isObjectType(value) then
            for _, value2 in ipairs(value:getInterfaces()) do
                if not isInterfaceType(value2) then
                    continue
                end
                local tbl1 = self._implementationsMap:get(value2.name)

                if tbl1 == nil then
                    tbl1 = {
                        objects = {},
                        interfaces = {}
                    }
                    self._implementationsMap:set(value2.name, tbl1)
                end

                table.insert(tbl1.objects, value)
            end
        end
    end

    return self
end

function var1:getQueryType()
    return self._queryType
end

function var1:getMutationType()
    return self._mutationType
end

function var1:getSubscriptionType()
    return self._subscriptionType
end

function var1:getTypeMap()
    return self._typeMap
end

function var1.getType(tbl1, str1: string)
    return tbl1:getTypeMap()[str1]
end

function var1.getPossibleTypes(arg1, arg2)
    if isUnionType(arg2) then
        return arg2:getTypes()
    end
    return arg1:getImplementations(arg2).objects
end

function var1:getImplementations(arg1)
    return self._implementationsMap:get(arg1.name) or {
        objects = {},
        interfaces = {}
    }
end

function var1:isSubType(arg1, arg2): boolean
    local tbl1 = self._subTypeMap[arg1.name]
    if tbl1 == nil then
        tbl1 = {}

        if isUnionType(arg1) then
            for _, value in ipairs(arg1:getTypes()) do
                tbl1[value.name] = true
            end
        else
            local implementations = self:getImplementations(arg1)
            for _, object in ipairs(implementations.objects) do
                tbl1[object.name] = true
            end
            for _, value in ipairs(implementations.interfaces) do
                tbl1[value.name] = true
            end
        end

        self._subTypeMap:set(arg1.name, tbl1)
    end

    return tbl1[arg2.name] ~= nil
end

function var1:getDirectives()
    return self._directives
end

function var1.getDirective(arg1, name)
    return Array.find(arg1:getDirectives(), function(arg2): boolean
        return arg2.name == name
    end)
end

function var1:toConfig()
    return {
        description = self.description,
        query = self:getQueryType(),
        mutation = self:getMutationType(),
        subscription = self:getSubscriptionType(),
        types = self:getTypeMap():values(),
        directives = Array.slice(self:getDirectives()),
        extensions = self.extensions,
        astNode = self.astNode,
        extensionASTNodes = self.extensionASTNodes or {},
        assumeValid = self.__validationErrors ~= nil
    }
end

function var1.__tostring(_): string
    return "GraphQLSchema"
end

collectReferencedTypes = function(arg1, arg2)
    local namedType = getNamedType(arg1)

    if not arg2:has(namedType) then
        arg2:add(namedType)
        if isUnionType(namedType) then
            for _, value in ipairs(namedType:getTypes()) do
                collectReferencedTypes(value, arg2)
            end

            return arg2
        end
        if isObjectType(namedType) or isInterfaceType(namedType) then
            for _, value in ipairs(namedType:getInterfaces()) do
                collectReferencedTypes(value, arg2)
            end

            for _, value in ipairs(namedType:getFields():values()) do
                collectReferencedTypes(value.type, arg2)
                for _, arg in ipairs(value.args) do
                    collectReferencedTypes(arg.type, arg2)
                end
            end

            return arg2
        end

        if isInputObjectType(namedType) then
            for _, value in ipairs(namedType:getFields():values()) do
                collectReferencedTypes(value.type, arg2)
            end
        end
    end

    return arg2
end

return { isSchema = isSchema, assertSchema = assertSchema, GraphQLSchema = var1 }
