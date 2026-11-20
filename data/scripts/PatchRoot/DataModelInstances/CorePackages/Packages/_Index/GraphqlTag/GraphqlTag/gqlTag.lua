-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local parse = require(scriptParentParent.GraphQL).parse

local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Map = LuauPolyfill.Map
local Set = LuauPolyfill.Set
local String = LuauPolyfill.String
local Object = LuauPolyfill.Object
local Array = LuauPolyfill.Array
local console = LuauPolyfill.console

local map = Map.new(nil)
local map2 = Map.new(nil)
local bool1 = true
local bool2 = false
local function normalize(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = str1:gsub(",+%s+", " ")
    return String.trim(var1)
end

local function cacheKeyFromLoc(tbl1) -- Luacid: unused: defined but never referenced
    return normalize(tbl1.source.body:sub(tbl1.start, tbl1._end))
end

local function processFragments(arg1)
    local set = Set.new(nil)
    local definitions = {}

    for i = 1, #arg1.definitions do
        local definition = arg1.definitions[i]
        if definition.kind == "FragmentDefinition" then
            local value = definition.name.value
            local loc = definition.loc
            local var1 = normalize((loc.source.body:sub(loc.start, loc._end)))

            local var2 = map2:get(value)
            if var2 and not var2:has(var1) then
                if bool1 then
                    console.warn(
                        "Warning: fragment with name " .. value .. " already exists.\ngraphql-tag enforces all fragment names across your application to be unique; read more about\nthis in the docs: http://dev.apollodata.com/core/fragments.html#unique-names"
                    )
                end
            elseif not var2 then
                var2 = Set.new()

                map2:set(value, var2)
            end
            var2:add(var1)
            if not set:has(var1) then
                set:add(var1)
                table.insert(definitions, definition)
            end
        else
            table.insert(definitions, definition)
        end
    end
    return Object.assign({}, arg1, { definitions = definitions })
end

local function stripLoc(arg1)
    local set = Set.new(nil)
    for i = 1, #set do
        local var1 = set[i]
        if var1.loc then
            set:delete(var1.loc)
        end
        for j = 1, #Object.keys(var1) do
            local var2 = var1[tostring(Object.keys(var1)[j])]
            if var2 and typeof(var2) == "table" and not Array.isArray(var2) then
                set:add(var2)
            end
        end
    end

    local loc = arg1.loc
    if loc then
        loc.startToken = nil
        loc.endToken = nil
    end
    return arg1
end

local function parseDocument(str1: string)
    local var1 = normalize(str1)

    if not map:has(var1) then
        local var2 = parse(str1, { experimentalFragmentVariables = bool2 })

        if not var2 or var2.kind ~= "Document" then
            error("Not a valid GraphQL document.")
        end

        map:set(var1, (stripLoc(processFragments(var2))))
    end

    return (map:get(var1))
end

local function gql(arg1)
    if typeof(arg1) == "string" then
        return (parseDocument(arg1))
    end

    if typeof(arg1) == "table" and arg1.kind == "Document" then
        return arg1
    end
    error(
        "graphql-tag-lua does not currently support non-strings or Fragments. Please file an issue or PR if you need this feature added."
    )
end

function resetCaches()
    map:clear()
    map2:clear()
end

function disableFragmentWarnings()
    bool1 = false
end

function enableExperimentalFragmentVariables()
    bool2 = true
end

function disableExperimentalFragmentVariables()
    bool2 = false
end

local tbl1 = {
    gql = gql,
    resetCaches = resetCaches,
    disableFragmentWarnings = disableFragmentWarnings,
    enableExperimentalFragmentVariables = enableExperimentalFragmentVariables,
    disableExperimentalFragmentVariables = disableExperimentalFragmentVariables
}
return {
    default = gql,
    gql = gql,
    resetCaches = tbl1.resetCaches,
    disableFragmentWarnings = tbl1.disableFragmentWarnings,
    enableExperimentalFragmentVariables = tbl1.enableExperimentalFragmentVariables,
    disableExperimentalFragmentVariables = tbl1.disableExperimentalFragmentVariables
}
