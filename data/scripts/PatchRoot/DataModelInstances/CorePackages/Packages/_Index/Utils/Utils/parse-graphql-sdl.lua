-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object
local module = {}
local GraphQL = require(scriptParentParent.GraphQL)

local Kind = GraphQL.Kind

local parse = GraphQL.parse
local Source = GraphQL.Source
local visit = GraphQL.visit
local isTypeSystemDefinitionNode = GraphQL.isTypeSystemDefinitionNode

local print = GraphQL.print

local comments = require(script.Parent.comments)

local dedentBlockStringValue = comments.dedentBlockStringValue
local getLeadingCommentBlock = comments.getLeadingCommentBlock

local _Interfaces = require(script.Parent.Interfaces)

local String = LuauPolyfill.String

local transformCommentsToDescriptions = nil
local isDescribable = nil

local function removeCommentsAndTrim(str1: string) -- Luacid: unused: defined but never referenced
    local var1 = string.gsub(str1, "(#[^*]*)", "")
    return String.trim(var1)
end

function module.parseGraphQLSDL(location: string?, str1: string, arg1)
    local var1 = arg1 == nil and {} or arg1
    local var2 = nil

    local success, result = pcall(function()
        if Boolean.toJSBoolean(var1.commentDescriptions) and String.includes(str1, "#") then
            var2 = transformCommentsToDescriptions(str1, var1)

            if Boolean.toJSBoolean(var1.noLocation) then
                var2 = parse(print(var2), var1)
            end
        else
            var2 = parse(Source.new(str1, location), var1)
        end
    end)

    if success then
        return { location = location, document = var2 }
    end

    if String.includes(result.message, "EOF") then
        local var3 = string.gsub(str1, "(#[^*]*)", "")
        if String.trim(var3) == "" then
            var2 = {
                kind = Kind.DOCUMENT,
                definitions = {}
            }

            return { location = location, document = var2 }
        end
    end

    error(result)

    return { location = location, document = var2 }
end

transformCommentsToDescriptions = function(str1: string, arg1)
    local var1 = parse(str1, Object.assign({}, arg1 == nil and {} or arg1, { noLocation = false }))
    return (visit(var1, {
        leave = function(_, arg2)
            if not Boolean.toJSBoolean(isDescribable(arg2)) then
                return
            end

            local leadingCommentBlock = getLeadingCommentBlock(arg2)
            if leadingCommentBlock == nil then
                return
            end

            local value = dedentBlockStringValue("\n" .. tostring(leadingCommentBlock))

            local block = String.includes(value, "\n")

            if not Boolean.toJSBoolean(arg2.description) then
                return Object.assign({}, arg2, { description = { kind = Kind.STRING, value = value, block = block } })
            end

            return Object.assign(
                {},
                arg2,
                {
                    description = Object.assign({}, arg2.description, { value = arg2.description.value .. "\n" .. value, block = true })
                }
            )
        end
    }))
end

module.transformCommentsToDescriptions = transformCommentsToDescriptions

isDescribable = function(arg1)
    return isTypeSystemDefinitionNode(arg1)
        or arg1.kind == Kind.FIELD_DEFINITION
        or arg1.kind == Kind.INPUT_VALUE_DEFINITION
        or arg1.kind == Kind.ENUM_VALUE_DEFINITION
end

module.isDescribable = isDescribable
return module
