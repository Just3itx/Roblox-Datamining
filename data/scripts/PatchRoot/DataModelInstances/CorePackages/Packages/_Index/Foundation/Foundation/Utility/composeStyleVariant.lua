-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)

local _Types = require(Foundation.Components.Types)

local function tagToTable(tag) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if type(tag) == "string" then {
        [tag] = true
    } else tag
end

local function mergeTags(tag, tag2)
    if not tag then
        return tag2
    end
    if not tag2 then
        return tag
    end

    if type(tag) ~= "table" and type(tag2) ~= "table" then
        return `{tag} {tag2}`
    end

    local var1 = tagToTable(tag)
    local var2 = tagToTable(tag2)
    return Dash.join(var1, var2)
end

local function mergeProps(tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Dash.join(tbl1, tbl2)
    var1.tag = mergeTags(tbl1.tag, tbl2.tag)
    return var1
end

function composeStyleVariant(tbl1, ...)
    local var1 = Dash.copy(tbl1)
    Dash.forEachArgs(function(arg1)
        if arg1 == nil then
            return
        end
        for value, value2 in arg1 do
            var1[value] = mergeProps(var1[value] or {}, value2)
        end
    end, ...)

    return var1
end

return composeStyleVariant
