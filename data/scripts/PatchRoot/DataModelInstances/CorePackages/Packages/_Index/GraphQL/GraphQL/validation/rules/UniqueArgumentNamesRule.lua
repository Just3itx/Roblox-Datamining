-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueArgumentNamesRule(arg1)
    local tbl1 = ({})

    return {
        Field = function()
            tbl1 = {}
        end,
        Directive = function()
            tbl1 = {}
        end,
        Argument = function(_, arg2): boolean
            local value = arg2.name.value
            if tbl1[value] then
                arg1:reportError(
                    GraphQLError.new(("There can be only one argument named \"%s\"."):format(value), { tbl1[value], arg2.name })
                )
            else
                tbl1[value] = arg2.name
            end
            return false
        end
    }
end

return module
