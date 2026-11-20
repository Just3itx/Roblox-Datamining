-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error

local devAssert = require(scriptParentParent.jsutils.devAssert).devAssert
local GraphQLError = require(scriptParentParent.error.GraphQLError).GraphQLError

local _ast = require(scriptParentParent.language.ast)

local _schema = require(scriptParentParent.type.schema)

local visitor = require(scriptParentParent.language.visitor)
local visit = visitor.visit
local visitInParallel = visitor.visitInParallel
local assertValidSchema = require(scriptParentParent.type.validate).assertValidSchema
local TypeInfo = require(scriptParentParent.utilities.TypeInfo)
local TypeInfo2 = TypeInfo.TypeInfo

local visitWithTypeInfo = TypeInfo.visitWithTypeInfo
local specifiedRules = require(scriptParent.specifiedRules)
local specifiedRules2 = specifiedRules.specifiedRules
local specifiedSDLRules = specifiedRules.specifiedSDLRules
local ValidationContext = require(scriptParent.ValidationContext)
local SDLValidationContext = ValidationContext.SDLValidationContext
local ValidationContext2 = ValidationContext.ValidationContext

local module = {}

function module.validate(arg1, arg2, arg3, tbl1, arg4)
    local var1 = arg3 or specifiedRules2
    local var2 = tbl1 or { maxErrors = nil }
    local var3 = arg4 or TypeInfo2.new(arg1)

    devAssert(arg2, "Must provide document.")

    assertValidSchema(arg1)

    local tbl2 = {}
    local result = {}
    local validationContext2 = ValidationContext2.new(arg1, arg2, var3, function(arg5)
        if var2.maxErrors ~= nil and #result >= var2.maxErrors then
            table.insert(result, GraphQLError.new("Too many validation errors, error limit reached. Validation aborted."))

            error(tbl2)
        end

        table.insert(result, arg5)
    end)

    local var4 = visitInParallel(Array.map(var1, function(arg5)
        return arg5(validationContext2)
    end))

    local success, result2 = pcall(function()
        visit(arg2, visitWithTypeInfo(var3, var4))
    end)

    if not success and result2 ~= tbl2 then
        error(result2)
    end

    return result
end

function module.validateSDL(arg1, arg2, arg3)
    local var1 = arg3 or specifiedSDLRules
    local result = {}
    local sdlValidationContext = SDLValidationContext.new(arg1, arg2, function(arg4)
        table.insert(result, arg4)
    end)
    local var2 = Array.map(var1, function(arg4)
        return arg4(sdlValidationContext)
    end)
    visit(arg1, visitInParallel(var2))
    return result
end

function module.assertValidSDL(arg1)
    local var1 = module.validateSDL(arg1)
    if #var1 ~= 0 then
        error(Error.new(table.concat(Array.map(var1, function(arg2)
            return arg2.message
        end), "\n\n")))
    end
end

function module.assertValidSDLExtension(arg1, arg2)
    local var1 = module.validateSDL(arg1, arg2)
    if #var1 ~= 0 then
        error(Error.new(table.concat(Array.map(var1, function(arg3)
            return if typeof(arg3) == "string" then arg3 else arg3.message
        end), "\n\n")))
    end
end

return module
