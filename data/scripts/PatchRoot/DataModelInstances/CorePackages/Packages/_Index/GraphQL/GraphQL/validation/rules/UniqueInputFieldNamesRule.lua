-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local _visitor = require(scriptParentParentParent.language.visitor)

local _ValidationContext = require(script.Parent.Parent.ValidationContext)

local language = scriptParentParentParent.language

local _ast = require(language.ast)

local module = {}

function module.UniqueInputFieldNamesRule(arg1)
    local tbl1 = {}
    local tbl2 = ({})

    return {
        ObjectValue = {
            enter = function()
                table.insert(tbl1, tbl2)
                tbl2 = {}
            end,
            leave = function()
                tbl2 = table.remove(tbl1)
            end
        },
        ObjectField = function(_, arg2)
            local value = arg2.name.value
            if not tbl2[value] then
                tbl2[value] = arg2.name

                return
            end

            arg1:reportError(
                GraphQLError.new(("There can be only one input field named \"%s\"."):format(value), { tbl2[value], arg2.name })
            )
        end
    }
end

return module
