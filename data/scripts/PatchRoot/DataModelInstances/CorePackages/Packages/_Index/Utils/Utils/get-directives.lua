-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local _GraphQL = require(scriptParentParent.GraphQL)

local getArgumentValues = require(script.Parent.getArgumentValues).getArgumentValues

local function getDirectivesInExtensions(arg1, arg2)
    local var1 = arg2 == nil and { "directives" } or arg2

    local reduce = Array.reduce

    local function func1(none, arg3)
        return if none == Object.None or none == nil then nil else none[arg3]
    end

    return (reduce(var1, func1, if typeof(arg1) == "table" and arg1.extensions then arg1.extensions else Object.None))
end

module.getDirectivesInExtensions = getDirectivesInExtensions
local function _getDirectiveInExtensions(arg1, name: string)
    local var1 = Array.filter(arg1, function(arg2): boolean
        return arg2.name == name
    end)

    if #var1 == 0 then
        return nil
    end
    return (Array.map(var1, function(arg2)
        return if arg2.args == nil then {} else arg2.args
    end))
end

local function getDirectiveInExtensions(arg1, name: string, arg2)
    local var1 = arg2 == nil and { "directives" } or arg2

    local var2 = Array.reduce(var1, function(none, arg3)
        return if none == Object.None or none == nil then nil else none[arg3]
    end, if typeof(arg1) == "table" and arg1.extensions then arg1.extensions else Object.None)

    if var2 == nil then
        return nil
    end
    if Boolean.toJSBoolean(Array.isArray(var2)) then
        return (_getDirectiveInExtensions(var2, name))
    end

    local tbl1 = {}

    for _, value in Object.entries(var2) do
        local var3, args = table.unpack(value, 1, 2)
        if Boolean.toJSBoolean(Array.isArray(args)) then
            for _, arg in args do
                table.insert(tbl1, { name = var3, args = arg })
            end
        else
            table.insert(tbl1, { name = var3, args = args })
        end
    end

    return (_getDirectiveInExtensions(tbl1, name))
end
module.getDirectiveInExtensions = getDirectiveInExtensions
function module.getDirectives(arg1, arg2, arg3)
    local directivesInExtensions = getDirectivesInExtensions(arg2, arg3 == nil and { "directives" } or arg3)
    if directivesInExtensions ~= nil and #directivesInExtensions > 0 then
        return directivesInExtensions
    end
    local var1 = not Boolean.toJSBoolean(if Boolean.toJSBoolean(arg1) then arg1.getDirectives else arg1) and {} or arg1:getDirectives()

    local var2 = Array.reduce(var1, function(arg4, arg5)
        local name = arg5.name
        arg4[tostring(name)] = arg5
        return arg4
    end, {})
    local tbl1 = {}
    if Boolean.toJSBoolean(arg2.astNode) then
        table.insert(tbl1, arg2.astNode)
    end

    if Array.indexOf(Object.keys(arg2), "extensionASTNodes") ~= -1 and Boolean.toJSBoolean(arg2.extensionASTNodes) then
        tbl1 = Array.concat({}, tbl1, arg2.extensionASTNodes)
    end

    local directives = {}
    for _, value in tbl1 do
        if not Boolean.toJSBoolean(value.directives) then
            continue
        end

        for _, value2 in value.directives do
            local var3 = var2[tostring(value2.name.value)]
            if Boolean.toJSBoolean(var3) then
                table.insert(directives, { name = value2.name.value, args = getArgumentValues(var3, value2) })
            end
        end
    end

    return directives
end

function module.getDirective(arg1, arg2, name: string, arg3)
    local directiveInExtensions = getDirectiveInExtensions(arg2, name, arg3 == nil and { "directives" } or arg3)
    if directiveInExtensions ~= nil then
        return directiveInExtensions
    end
    local directive = if Boolean.toJSBoolean(if Boolean.toJSBoolean(arg1) then arg1.getDirective else arg1) then arg1:getDirective(name) else nil

    if directive == nil then
        return nil
    end
    local tbl1 = {}
    if Boolean.toJSBoolean(arg2.astNode) then
        table.insert(tbl1, arg2.astNode)
    end

    if Array.indexOf(Object.keys(arg2), "extensionASTNodes") ~= -1 and Boolean.toJSBoolean(arg2.extensionASTNodes) then
        tbl1 = Array.concat({}, tbl1, arg2.extensionASTNodes)
    end

    local tbl2 = {}
    for _, value in tbl1 do
        if not Boolean.toJSBoolean(value.directives) then
            continue
        end

        for _, value2 in value.directives do
            if value2.name.value == name then
                table.insert(tbl2, getArgumentValues(directive, value2))
            end
        end
    end

    return if Boolean.toJSBoolean(#tbl2) then tbl2 else nil
end

return module
