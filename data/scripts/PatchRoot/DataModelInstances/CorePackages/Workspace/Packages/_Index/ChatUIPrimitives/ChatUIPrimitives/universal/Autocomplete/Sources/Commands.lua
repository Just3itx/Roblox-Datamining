-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Signals = require(ChatUIPrimitivesParent.Signals)

local _AutocompleteTypes = require(script.Parent.Parent.AutocompleteTypes)
local utf8Range = require(script.Parent.Parent.utf8Range)

local function isWordBoundary(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == " " or str1 == "\n"
end

local function matchCommandTrigger(str1: string, num1: number)
    local var1 = utf8.len(str1)
    if var1 == nil or num1 < 2 or var1 + 1 < num1 then
        return nil
    end

    local num2 = 1
    for i = num1 - 1, 1, -1 do
        local var2 = utf8Range.charAt(str1, i)
        if var2 == nil then
            return nil
        end

        if isWordBoundary(var2) then
            num2 = i + 1
            break
        end
    end

    if num2 ~= 1 or utf8Range.charAt(str1, 1) ~= "/" then
        return nil
    end

    local query = utf8Range.slice(str1, 1, num1 - 1)
    return if query == nil or query == "" then nil else {
        query = query,
        replaceStart = 1,
        replaceFinish = num1 - 1
    }
end

local function buildSortedAliases(getCommandSets, arg1)
    local tbl1 = ({})
    local sortedAliases = {}
    for _, getCommandSet in getCommandSets do
        for _, value in getCommandSet(arg1) do
            if value.autocompleteVisible == false then
                continue
            end

            for _, value2 in value.aliases do
                local str1 = string.lower(value2)
                if not tbl1[str1] then
                    tbl1[str1] = true
                    table.insert(sortedAliases, str1)
                end
            end
        end
    end

    table.sort(sortedAliases)
    return sortedAliases
end

local function searchSortedAliases<T>(tbl1, str1: string): {T}
    local str2 = string.lower(str1)
    local num1 = #str2

    local num2 = #tbl1 + 1
    local num3 = 1

    while num3 < num2 do
        local num4 = (num3 + num2) // 2
        if tbl1[num4] < str2 then
            num3 = num4 + 1
        else
            num2 = num4
        end
    end

    local result = {}
    for i = num3, #tbl1 do
        local var1 = tbl1[i]
        if string.sub(var1, 1, num1) ~= str2 then
            break
        end

        table.insert(result, var1)
    end
    return result
end

local function selectCommand(text: string)
    return { kind = "insert", text = text }
end

local function renderCommandEntry(text: string, _: boolean)
    return React.createElement(Foundation.View, { tag = "row align-y-center size-full" }, {
        alias = React.createElement(
            Foundation.Text,
            { tag = "auto-xy text-body-medium content-emphasis", Text = text, LayoutOrder = 1 }
        )
    })
end

local function commands(tbl1)
    assert(type(tbl1.id) == "string" and tbl1.id ~= "", "AutocompleteSources.commands requires an id")
    assert(type(tbl1.getCommandSets) == "table", "AutocompleteSources.commands requires getCommandSets")

    local getCommandSets = tbl1.getCommandSets
    local tbl2 = {}

    return {
        id = tbl1.id,
        matchTrigger = matchCommandTrigger,
        search = function(str1: string)
            return (searchSortedAliases(tbl2, str1))
        end,
        select = selectCommand,
        renderEntry = renderCommandEntry,
        maxResults = tbl1.maxResults,
        subscribe = function(callback: (...any) -> (...any))
            local bool1 = false
            local bool2 = false
            local effect = Signals.createEffect(function(arg1)
                tbl2 = buildSortedAliases(getCommandSets, arg1)
                if bool1 or not bool2 then
                    bool2 = true
                    return
                end
                callback()
            end)
            return function()
                bool1 = true
                effect()
            end
        end
    }
end

return commands
