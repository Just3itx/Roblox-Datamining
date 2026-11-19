-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local visit = require(scriptParentParentParentParent.GraphQL).visit

local invariant = require(scriptParentParentParent.jsutils.invariant).invariant

local getInclusionDirectives = nil

function module.shouldInclude(arg1, tbl1)
    local directives = arg1.directives

    if not directives or #directives == 0 then
        return true
    end
    return Array.every(getInclusionDirectives(directives), function(arg2)
        local directive = arg2.directive
        local ifArgument = arg2.ifArgument
        local value

        if ifArgument.value.kind == "Variable" then
            if tbl1 == nil then
                value = false
            else
                value = tbl1[ifArgument.value.name.value]
            end

            invariant(value ~= nil, ("Invalid variable referenced in @%s directive."):format(directive.name.value))
        else
            value = ifArgument.value.value
        end
        return if directive.name.value == "skip" then not value else value
    end)
end

local function getDirectiveNames(arg1)
    local directiveNames = {}

    visit(arg1, {
        Directive = function(_, arg2)
            table.insert(directiveNames, arg2.name.value)
        end
    })

    return directiveNames
end
module.getDirectiveNames = getDirectiveNames

local function hasDirectives(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Array.some(getDirectiveNames(arg2), function(str1: string): boolean
        return Array.indexOf(arg1, str1) > -1
    end)
end
module.hasDirectives = hasDirectives

function module.hasClientExports(arg1)
    return not (arg1 == nil) and hasDirectives({ "client" }, arg1) and hasDirectives({ "export" }, arg1)
end

local function isInclusionDirective(directive): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local value = directive.name.value
    return value == "skip" or value == "include"
end

getInclusionDirectives = function(arg1)
    local inclusionDirectives = {}

    if arg1 and #arg1 > 0 then
        Array.forEach(arg1, function(directive)
            if not isInclusionDirective(directive) then
                return
            end

            local arguments = directive.arguments
            local value = directive.name.value

            if not arguments or #arguments ~= 1 then
                invariant(false, ("Incorrect number of arguments for the @%s directive."):format(value))
            end

            local ifArgument = arguments[1]

            if not ifArgument.name or ifArgument.name.value ~= "if" then
                invariant(false, ("Invalid argument for the @%s directive."):format(value))
            end

            local value2 = ifArgument.value

            if not value2 or value2.kind ~= "Variable" and value2.kind ~= "BooleanValue" then
                invariant(false, ("Argument for the @%s directive must be a variable or a boolean value."):format(value))
            end

            table.insert(inclusionDirectives, { directive = directive, ifArgument = ifArgument })
        end)
    end
    return inclusionDirectives
end
module.getInclusionDirectives = getInclusionDirectives

return module
