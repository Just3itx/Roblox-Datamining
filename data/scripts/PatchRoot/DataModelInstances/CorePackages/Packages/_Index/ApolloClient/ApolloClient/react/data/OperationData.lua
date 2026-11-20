-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local equal = require(scriptParentParentParent.jsutils.equal)
local invariant = require(scriptParentParentParent.jsutils.invariant).invariant
local _core = require(script.Parent.Parent.Parent.core)

local parser = require(script.Parent.Parent.parser)

local parser2 = parser.parser
local operationName = parser.operationName
local _types = require(script.Parent.Parent.types.types)

local OperationData = {}
OperationData.__index = OperationData

function OperationData.new(arg1, arg2)
    return (setmetatable(
        {
            options = Boolean.toJSBoolean(arg1) and arg1 or {},
            context = Boolean.toJSBoolean(arg2) and arg2 or {}
        },
        OperationData
    ))
end

function OperationData:getOptions()
    return self.options
end

function OperationData:setOptions(options, bool1: boolean?)
    if bool1 == nil then
        bool1 = false
    end

    if bool1 and not equal(self.options, options) then
        self.previousOptions = self.options
    end
    self.options = options
end

function OperationData.unmount(arg1)
    arg1.isMounted = false
end

function OperationData:refreshClient()
    local toJsBoolean = Boolean.toJSBoolean
    local var1 = if Boolean.toJSBoolean(self.options) then self.options.client else self.options
    local bool1 = false
    local var2

    if toJsBoolean(var1) then
        if Boolean.toJSBoolean(self.options) then
            var2 = self.options.client
        else
            var2 = self.options
        end

        bool1 = var2
    end
    if not bool1 then
        if Boolean.toJSBoolean(self.context) then
            var2 = self.context.client
        else
            var2 = self.context
        end
    end
    invariant(
        Boolean.toJSBoolean(var2),
        "Could not find \"client\" in the context or passed in as an option. Wrap the root component in an <ApolloProvider>, or pass an ApolloClient instance in via options."
    )
    local bool2

    if var2 == self.client then
        bool2 = false
    else
        self.client = var2
        self:cleanup()
        bool2 = true
    end
    return {
        client = self.client,
        isNew = bool2
    }
end

function OperationData.verifyDocumentType(_, arg1, type)
    local var1 = parser2(arg1)
    local var2 = operationName(type)
    local var3 = operationName(var1.type)
    invariant(
        var1.type == type,
        ("Running a %s requires a graphql "):format(var2) .. ("%s, but a %s was used instead."):format(var2, var3)
    )
end

tbl1.OperationData = OperationData

return tbl1
