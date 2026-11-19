-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:36Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local module = {}
local _GraphQL = require(scriptParentParentParentParent.GraphQL)

local invariant = require(scriptParentParentParent.jsutils.invariant).invariant
local Error = LuauPolyfill.Error

function module.getFragmentQueryDocument(arg1, value: string?)
    local tbl1 = {}
    Array.forEach(arg1.definitions, function(arg2)
        if arg2.kind == "OperationDefinition" then
            local error = error
            local new = Error.new
            local str2 = "Found a %s operation%s. "
            local str3 = tostring(arg2.operation)
            local var1

            if Boolean.toJSBoolean(arg2.name) then
                local value = arg2.name.value
                var1 = (" named '%s'"):format(tostring(value))
            else
                var1 = ""
            end

            error(
                new(
                    str2:format(str3, var1) .. "No operations are allowed when using a fragment as a query. Only fragments are allowed."
                )
            )
        end

        if arg2.kind == "FragmentDefinition" then
            table.insert(tbl1, arg2)
        end
    end)

    if typeof(value) == "nil" then
        invariant(
            #tbl1 == 1,
            string.format(
                "Found %s fragments. `fragmentName` must be provided when there is not exactly 1 fragment.",
                tostring(#tbl1)
            )
        )
        value = tbl1[1].name.value
    end

    return (Object.assign({}, arg1, {
        definitions = Array.concat({}, {{
            kind = "OperationDefinition",
            operation = "query",
            selectionSet = {
                kind = "SelectionSet",
                selections = {{
                    kind = "FragmentSpread",
                    name = { kind = "Name", value = value }
                }}
            }
        }}, arg1.definitions)
    }))
end

function module.createFragmentMap(arg1)
    local fragmentMap = {}

    Array.forEach(arg1 == nil and {} or arg1, function(arg2)
        fragmentMap[arg2.name.value] = arg2
    end)
    return fragmentMap
end

function module.getFragmentFromSelection(arg1, tbl1)
    local kind = arg1.kind
    if kind == "InlineFragment" then
        return arg1
    end

    if kind ~= "FragmentSpread" then
        return nil
    end

    local var1 = tbl1 and tbl1[arg1.name.value]

    invariant(var1, ("No fragment named %s."):format(arg1.name.value))
    return var1
end
return module
