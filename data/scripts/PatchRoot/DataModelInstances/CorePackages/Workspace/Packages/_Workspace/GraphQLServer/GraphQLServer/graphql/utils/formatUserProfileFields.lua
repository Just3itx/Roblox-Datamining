-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")
local GraphQLServerParent = GraphQLServer.Parent
local GraphqlToolsUtils = require(GraphQLServerParent.GraphqlToolsUtils)
local LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local collectSubFields = GraphqlToolsUtils.collectSubFields
local UserProfileNestedFields = require(GraphQLServer.graphql.enums.UserProfileNestedFields)

return function(arg1, arg2)
    local var1 = arg2 or collectSubFields
    local var2 = var1(arg1.schema, arg1.fragments, arg1.variableValues, arg1.returnType, arg1.fieldNodes)

    local result = {}
    local function func1(arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        return arg3 == nil or arg3 == "id" or LuauPolyfill.String.endsWith(arg3, "__typename")
    end

    for _, value in var2 do
        local var3 = value[1]

        if UserProfileNestedFields[var3] then
            for _, value2 in (var1(arg1.schema, arg1.fragments, arg1.variableValues, arg1.returnType, var2[var3])) do
                local str1 = `{var3}.{value2[1]}`

                if not func1(str1) then
                    table.insert(result, str1)
                end
            end
        elseif not func1(var3) then
            table.insert(result, var3)
        end
    end

    return result
end
