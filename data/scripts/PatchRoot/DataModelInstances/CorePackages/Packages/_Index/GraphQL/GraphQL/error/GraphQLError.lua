-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local language = scriptParentParent.language
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Error = LuauPolyfill.Error
local Object = LuauPolyfill.Object

local HttpService = game:GetService("HttpService")

local isObjectLike = require(scriptParentParent.jsutils.isObjectLike).isObjectLike

local _ast = require(language.ast)

local _source = require(language.source)

local getLocation = require(language.location).getLocation
local printLocation = require(language.printLocation)
local printLocation2 = printLocation.printLocation
local printSourceLocation = printLocation.printSourceLocation

local printError = nil
local undefinedIfEmpty = nil

local GraphQLError = (setmetatable({}, { __index = Error }))

GraphQLError.__index = GraphQLError
function GraphQLError.__tostring(arg1)
    return printError(arg1)
end

function GraphQLError.new(str1: string, arg1, source, positions, path, originalError, extensions)
    local error = Error.new(str1)

    error.name = "GraphQLError"
    error.originalError = originalError

    local var2 = undefinedIfEmpty
    if not Array.isArray(arg1) then
        arg1 = arg1 and { arg1 } or nil
    end

    error.nodes = var2(arg1)

    local tbl1 = {}

    if error.nodes then
        for _, value in ipairs(error.nodes) do
            local loc = value.loc
            if loc ~= nil then
                table.insert(tbl1, loc)
            end
        end
    end
    local var3 = undefinedIfEmpty(tbl1)

    error.source = source or (if var3 == nil then nil else var3[1].source)

    error.positions = positions or (if var3 then Array.map(var3, function(arg2)
        return arg2.start
    end) else nil)

    error.locations = if positions and source then Array.map(positions, function(arg2)
        return getLocation(source, arg2)
    end) elseif var3 then Array.map(var3, function(arg2)
        return getLocation(arg2.source, arg2.start)
    end) else nil

    error.path = path or nil
    local extensions2 = if originalError then originalError.extensions else nil

    if extensions == nil and isObjectLike(extensions2) then
        error.extensions = Object.assign({}, extensions2)
    else
        error.extensions = extensions or nil
    end

    if originalError and originalError.stack then
        error.stack = originalError.stack
    end

    return (setmetatable(error, GraphQLError))
end

function GraphQLError.toString(arg1)
    return printError(arg1)
end

function GraphQLError:toJSON()
    local tbl1 = { "message" }

    if self.locations ~= nil then
        table.insert(tbl1, "locations")
    end
    if self.path ~= nil then
        table.insert(tbl1, "path")
    end
    if self.extensions ~= nil then
        table.insert(tbl1, "extensions")
    end

    return "{" .. Array.join(Array.map(tbl1, function(input): string
        return HttpService:JSONEncode(input) .. ":" .. HttpService:JSONEncode(self[input])
    end), ",") .. "}"
end

undefinedIfEmpty = function(arg1)
    return if arg1 == nil or #arg1 == 0 then nil else arg1
end

printError = function(tbl1)
    local message = tbl1.message

    if tbl1.nodes ~= nil then
        for i = 1, #tbl1.nodes do
            local var2 = tbl1.nodes[i]
            if var2.loc ~= nil then
                message ..= "\n\n" .. printLocation2(var2.loc)
            end
        end

        return message
    end

    if tbl1.source ~= nil and tbl1.locations ~= nil then
        for i = 1, #tbl1.locations do
            local location = tbl1.locations[i]
            message ..= "\n\n" .. printSourceLocation(tbl1.source, location)
        end
    end

    return message
end

return { printError = printError, GraphQLError = GraphQLError }
