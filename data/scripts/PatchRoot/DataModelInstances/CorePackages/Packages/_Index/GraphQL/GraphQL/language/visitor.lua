-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.Parent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local inspect = require(scriptParentParent.jsutils.inspect).inspect

local _ast = require(scriptParentParent.language.ast)

local isNode = require(script.Parent.ast).isNode

local QueryDocumentKeys = {
    Name = {},
    Document = { "definitions" },
    OperationDefinition = {
        "name",
        "variableDefinitions",
        "directives",
        "selectionSet"
    },
    VariableDefinition = {
        "variable",
        "type",
        "defaultValue",
        "directives"
    },
    Variable = { "name" },
    SelectionSet = { "selections" },
    Field = {
        "alias",
        "name",
        "arguments",
        "directives",
        "selectionSet"
    },
    Argument = { "name", "value" },
    FragmentSpread = { "name", "directives" },
    InlineFragment = { "typeCondition", "directives", "selectionSet" },
    FragmentDefinition = {
        "name",
        "variableDefinitions",
        "typeCondition",
        "directives",
        "selectionSet"
    },
    IntValue = {},
    FloatValue = {},
    StringValue = {},
    BooleanValue = {},
    NullValue = {},
    EnumValue = {},
    ListValue = { "values" },
    ObjectValue = { "fields" },
    ObjectField = { "name", "value" },
    Directive = { "name", "arguments" },
    NamedType = { "name" },
    ListType = { "type" },
    NonNullType = { "type" },
    SchemaDefinition = { "description", "directives", "operationTypes" },
    OperationTypeDefinition = { "type" },
    ScalarTypeDefinition = { "description", "name", "directives" },
    ObjectTypeDefinition = {
        "description",
        "name",
        "interfaces",
        "directives",
        "fields"
    },
    FieldDefinition = {
        "description",
        "name",
        "arguments",
        "type",
        "directives"
    },
    InputValueDefinition = {
        "description",
        "name",
        "type",
        "defaultValue",
        "directives"
    },
    InterfaceTypeDefinition = {
        "description",
        "name",
        "interfaces",
        "directives",
        "fields"
    },
    UnionTypeDefinition = {
        "description",
        "name",
        "directives",
        "types"
    },
    EnumTypeDefinition = {
        "description",
        "name",
        "directives",
        "values"
    },
    EnumValueDefinition = { "description", "name", "directives" },
    InputObjectTypeDefinition = {
        "description",
        "name",
        "directives",
        "fields"
    },
    DirectiveDefinition = {
        "description",
        "name",
        "arguments",
        "locations"
    },
    SchemaExtension = { "directives", "operationTypes" },
    ScalarTypeExtension = { "name", "directives" },
    ObjectTypeExtension = {
        "name",
        "interfaces",
        "directives",
        "fields"
    },
    InterfaceTypeExtension = {
        "name",
        "interfaces",
        "directives",
        "fields"
    },
    UnionTypeExtension = { "name", "directives", "types" },
    EnumTypeExtension = { "name", "directives", "values" },
    InputObjectTypeExtension = { "name", "directives", "fields" }
}

local BREAK = Object.freeze({})

local null = require(scriptParentParent.luaUtils.null)

local getVisitFn = nil

local function visit(arg1, tbl2, tbl3)
    local var2 = tbl3 or QueryDocumentKeys

    local var3 = Array.isArray(arg1)
    local num1 = 0
    local tbl4 = { arg1 }
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = {}
    local var4 = nil
    local prev = nil
    local visitFn
    local var5

    repeat
        local bool1 = false
        local bool2 = false
        num1 += 1
        local bool3 = num1 == #tbl4 + 1
        local bool4 = bool3 and #tbl5 ~= 0
        local var6, tbl8

        if bool3 then
            if #tbl6 == 0 then
                var6 = nil
            else
                var6 = tbl7[#tbl7]
            end

            local var7 = table.remove(tbl6)
            if bool4 then
                if var3 then
                    tbl8 = Array.slice(var4)
                else
                    tbl8 = {}
                    for k in pairs(var4) do
                        tbl8[k] = var4[k]
                    end
                end

                local num2 = 0
                for i = 1, #tbl5 do
                    local var8 = tbl5[i][1]
                    local var9 = tbl5[i][2]
                    if var3 then
                        var8 -= num2
                    end
                    if var3 and var9 == nil then
                        Array.splice(tbl8, var8, 1)
                        num2 += 1
                    else
                        tbl8[var8] = var9
                    end
                end
            else
                tbl8 = var4
            end

            num1 = prev.index
            tbl4 = prev.keys
            tbl5 = prev.edits
            var3 = prev.inArray
            prev = prev.prev
            var4 = var7
            bool1 = true
        else
            if var4 then
                if var3 then
                    var6 = num1
                else
                    var6 = tbl4[num1]
                end
            else
                var6 = nil
            end

            if var4 then
                tbl8 = var4[var6]
            else
                tbl8 = arg1
            end

            if tbl8 ~= nil and tbl8 ~= null then
                if var4 then
                    table.insert(tbl7, var6)
                end

                bool1 = true
            end
        end
        if bool1 then
            var5 = nil
            local bool5 = false

            if not Array.isArray(tbl8) then
                if not isNode(tbl8) then
                    error("Invalid AST Node: " .. inspect(tbl8) .. ".")
                end
                visitFn = getVisitFn(tbl2, tbl8.kind, bool3)
                bool5 = visitFn
            end

            if bool5 then
                var5 = visitFn(tbl2, tbl8, var6, var4, tbl7, tbl6)

                if var5 == BREAK then
                    break
                end

                if var5 ~= false then
                    local bool6 = false

                    if var5 ~= nil or var5 == null then
                        if var5 == null then
                            var5 = nil
                        end

                        table.insert(tbl5, { var6, var5 })
                        bool6 = not bool3
                    end

                    if bool6 then
                        if isNode(var5) then
                            tbl8 = var5
                            bool2 = true
                        else
                            table.remove(tbl7)
                        end
                    else
                        bool2 = true
                    end
                elseif not bool3 then
                    table.remove(tbl7)
                else
                    bool2 = true
                end
            else
                bool2 = true
            end
        end

        if bool2 then
            if var5 == nil and bool4 then
                table.insert(tbl5, { var6, tbl8 })
            end

            if bool3 then
                table.remove(tbl7)
            else
                prev = { inArray = var3, index = num1, keys = tbl4, edits = tbl5, prev = prev }

                var3 = Array.isArray(tbl8)
                if var3 then
                    tbl4 = tbl8
                else
                    tbl4 = var2[tbl8.kind] or {}
                end
                num1 = 0
                tbl5 = {}
                if var4 then
                    table.insert(tbl6, var4)
                    var4 = tbl8
                else
                    var4 = tbl8
                end
            end
        end
    until prev == nil

    if #tbl5 ~= 0 then
        arg1 = tbl5[#tbl5][2]
    end

    return arg1
end

local function visitInParallel(arg1)
    local tbl2 = ({})

    return {
        enter = function(_, arg2, ...)
            for i = 1, #arg1 do
                if tbl2[i] ~= nil then
                    continue
                end

                local visitFn = getVisitFn(arg1[i], arg2.kind, false)

                if not visitFn then
                    continue
                end

                local var2 = visitFn(arg1[i], arg2, ...)
                if var2 == false then
                    tbl2[i] = arg2
                elseif var2 == BREAK then
                    tbl2[i] = BREAK
                elseif var2 ~= nil then
                    return var2
                end
            end
        end,
        leave = function(_, ...)
            local var2 = ...
            for i = 1, #arg1 do
                if tbl2[i] == nil then
                    local visitFn = getVisitFn(arg1[i], var2.kind, true)

                    if visitFn then
                        local var3 = visitFn(arg1[i], ...)
                        if var3 == BREAK then
                            tbl2[i] = BREAK
                        elseif var3 ~= nil and var3 ~= false then
                            return var3
                        end
                    end
                elseif tbl2[i] == var2 then
                    tbl2[i] = nil
                end
            end
        end
    }
end

getVisitFn = function(tbl2, str1: string, bool1: boolean)
    local var2 = tbl2[str1]
    if var2 then
        if not bool1 and type(var2) == "function" then
            return var2
        end

        local var3 = if typeof(var2) == "function" then nil elseif bool1 then var2.leave else var2.enter

        if type(var3) == "function" then
            return var3
        end

        return
    end

    local var3 = if bool1 then tbl2.leave else tbl2.enter

    if not var3 then
        return
    end

    if type(var3) == "function" then
        return var3
    end

    local var4 = var3[str1]
    if type(var4) == "function" then
        return var4
    end
end

return {
    BREAK = BREAK,
    REMOVE = null,
    visit = visit,
    visitInParallel = visitInParallel,
    getVisitFn = getVisitFn,
    QueryDocumentKeys = QueryDocumentKeys
}
