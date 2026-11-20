-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local equal = require(scriptParentParentParent.jsutils.equal)
local DocumentType = require(script.Parent.Parent.parser).DocumentType
local ApolloError = require(scriptParentParentParent.errors).ApolloError

local _types = require(script.Parent.Parent.types.types)

local OperationData = require(script.Parent.OperationData).OperationData

local mergeOptions = require(scriptParentParentParent.core).mergeOptions

local _core = require(scriptParentParentParent.link.core)

local MutationData = setmetatable({}, { __index = OperationData })
MutationData.__index = MutationData

function MutationData.new(tbl2)
    local operationData = OperationData.new(tbl2.options, tbl2.context)
    function operationData.runMutation(tbl3)
        operationData:onMutationStart()
        local var2 = operationData:generateNewMutationId()

        return operationData:mutate(tbl3 == nil and {} or tbl3):andThen(function<T>(arg1: T): T
            operationData:onMutationCompleted(arg1, var2)
            return arg1
        end):catch(function(errors)
            local options = operationData:getOptions()
            local onError = options.onError
            operationData:onMutationError(errors, var2)
            if not Boolean.toJSBoolean(onError) then
                error(errors)
                return
            end

            onError(options, errors)
            return { data = nil, errors = errors }
        end)
    end

    operationData:verifyDocumentType(tbl2.options.mutation, DocumentType.Mutation)
    operationData.result = tbl2.result
    operationData.setResult = tbl2.setResult
    operationData.mostRecentMutationId = 0
    return (setmetatable(operationData, MutationData))
end

function MutationData:execute(arg1)
    self.isMounted = true
    self:verifyDocumentType(self:getOptions().mutation, DocumentType.Mutation)
    return { self.runMutation, Object.assign({}, arg1, { client = self:refreshClient().client }) }
end

function MutationData.afterExecute(arg1)
    arg1.isMounted = true
    return function(...)
        return arg1:unmount(...)
    end
end

function MutationData.cleanup(_) end

function MutationData.mutate(arg1, arg2)
    return arg1:refreshClient().client:mutate(mergeOptions(arg1:getOptions(), arg2))
end

function MutationData:onMutationStart()
    if self.result.loading or self:getOptions().ignoreResults then
        return
    end

    self:updateResult({ loading = true, error = nil, data = nil, called = true })
end

function MutationData.onMutationCompleted(tbl2, arg1, num1: number)
    local options = tbl2:getOptions()
    local onCompleted = options.onCompleted
    local ignoreResults = options.ignoreResults

    local data = arg1.data
    local errors = arg1.errors
    local apolloError = if errors and #errors > 0 then ApolloError.new({ graphQLErrors = errors }) else nil

    local function callOncomplete() -- Luacid: unused: defined but never referenced
        if Boolean.toJSBoolean(onCompleted) then
            return onCompleted(data)
        end
        return nil
    end

    if tbl2:isMostRecentMutation(num1) and not ignoreResults then
        tbl2:updateResult({ called = true, loading = false, data = data, error = apolloError })
    end

    if Boolean.toJSBoolean(onCompleted) then
        onCompleted(data)
    end
end

function MutationData.onMutationError(tbl2, error, num1: number)
    if not tbl2:isMostRecentMutation(num1) then
        return
    end

    tbl2:updateResult({ loading = false, error = error, data = nil, called = true })
end

function MutationData:generateNewMutationId()
    self.mostRecentMutationId += 1
    return self.mostRecentMutationId
end

function MutationData:isMostRecentMutation(mostRecentMutationId: number): boolean
    return self.mostRecentMutationId == mostRecentMutationId
end

function MutationData:updateResult(previousResult): {[any]: any}?
    if not self.isMounted or self.previousResult and equal(self.previousResult, previousResult) then
        return nil
    end

    self:setResult(previousResult)
    self.previousResult = previousResult
    return previousResult
end

tbl1.MutationData = MutationData

return tbl1
