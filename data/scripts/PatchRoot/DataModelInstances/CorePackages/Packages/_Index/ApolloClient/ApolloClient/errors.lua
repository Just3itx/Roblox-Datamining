-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Boolean = LuauPolyfill.Boolean
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local toJSBoolean = require(script.Parent.utilities.globals.null).toJSBoolean

local invariant = require(scriptParent.jsutils.invariant).invariant
local DEV = require(scriptParent.utilities).DEV
invariant(typeof(DEV) == "boolean", tostring(DEV))

local _GraphQL = require(scriptParentParent.GraphQL)

local isNonEmptyArray = require(scriptParent.utilities).isNonEmptyArray

local hasOwnProperty = require(scriptParent.luaUtils.hasOwnProperty)

local ApolloError = setmetatable({}, { __index = Error })
ApolloError.__index = ApolloError

function module.isApolloError(arg1)
    return hasOwnProperty(arg1, "graphQLErrors")
end

local function generateErrorMessage(arg1)
    local str1 = ""

    if isNonEmptyArray(arg1.graphQLErrors) and isNonEmptyArray(arg1.graphQLErrors) or isNonEmptyArray(arg1.clientErrors) then
        local var2 = Array.concat(
            not Boolean.toJSBoolean(arg1.graphQLErrors) and {} or arg1.graphQLErrors or {},
            not Boolean.toJSBoolean(arg1.clientErrors) and {} or arg1.clientErrors or {}
        )
        for _, value in pairs(var2) do
            str1 ..= ("%s\n"):format(if toJSBoolean(value) then value.message else "Error message not found.")
        end
    end
    if arg1.networkError ~= nil then
        local networkError = arg1.networkError
        if typeof(networkError) ~= "string" then
            if networkError.message then
                networkError = networkError.message
            else
                networkError = networkError.error
            end
        end

        str1 ..= ("%s\n"):format(networkError)
    end

    return (string.gsub(str1, "\n$", ""))
end

function ApolloError.new(tbl1)
    local graphQlErrors = tbl1.graphQLErrors
    local clientErrors = tbl1.clientErrors
    local networkError = tbl1.networkError
    local errorMessage = tbl1.errorMessage
    local extraInfo = tbl1.extraInfo

    local error = Error.new(errorMessage)
    error.graphQLErrors = Boolean.toJSBoolean(graphQlErrors) and graphQlErrors or {}
    error.clientErrors = Boolean.toJSBoolean(clientErrors) and clientErrors or {}
    error.networkError = Boolean.toJSBoolean(networkError) and networkError or nil
    error.message = Boolean.toJSBoolean(errorMessage) and errorMessage or generateErrorMessage(error)
    error.extraInfo = extraInfo

    return (setmetatable(error, ApolloError))
end

module.ApolloError = ApolloError

return module
