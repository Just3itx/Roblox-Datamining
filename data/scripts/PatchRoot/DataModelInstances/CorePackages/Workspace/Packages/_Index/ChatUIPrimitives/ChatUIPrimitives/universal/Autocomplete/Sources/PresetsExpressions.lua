-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Signals = require(ChatUIPrimitivesParent.Signals)

local _AutocompleteTypes = require(script.Parent.Parent.AutocompleteTypes)
local _Types = require(ChatUIPrimitives.UniversalMessage.Types)
local _createExpressionCatalogResource = require(ChatUIPrimitives.createExpressionCatalogResource)
local escapeRichText = require(ChatUIPrimitives.Utils.escapeRichText)
local getPresetIconRichText = require(ChatUIPrimitives.universal.ContentKinds.Preset.getPresetIconRichText)
local messageDraftFromExpressionContent = require(ChatUIPrimitives.universal.messageDraftFromExpressionContent)

local function resolveMinQueryLength(searchVariant): number -- Luacid: Inlined by compiler; 1 call site recovered
    local minQueryLength = if searchVariant == nil then nil else searchVariant.minQueryLength
    return if type(minQueryLength) == "number" and minQueryLength > 0 then minQueryLength else 2
end

local function getWordStartRank(lowerText: string, str1: string)
    local var1 = string.find(lowerText, str1, 1, true)
    while var1 ~= nil do
        if var1 == 1 then
            return 1
        end
        local match = string.match

        if match(string.sub(lowerText, var1 - 1, var1 - 1), "%w") == nil then
            return 2
        end
        var1 = string.find(lowerText, str1, var1 + 1, true)
    end
    return nil
end

local function presetText(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local content = arg1.content
    return if content.kind == "preset" then content.text else nil
end

local function buildIndex(catalog)
    if catalog == nil or catalog.status ~= "enabled" then
        return {}
    end

    local tbl1 = ({})
    local index = {}
    local num1 = 0
    for _, categoryGroup in catalog.categoryGroups do
        for _, value in categoryGroup.categories do
            for _, expressionItem in value.items do
                num1 += 1
                local var1 = presetText(expressionItem)

                if var1 == nil or var1 == "" or tbl1[var1] == true then
                    continue
                end

                tbl1[var1] = true
                table.insert(index, { expressionItem = expressionItem, catalogIndex = num1, lowerText = string.lower(var1) })
            end
        end
    end

    return index
end

local function presetDisplayText(tbl1) -- Luacid: unused: defined but never referenced
    local var1 = presetText(tbl1.expressionItem)
    return if var1 == nil then "" else var1
end

local function selectPreset(tbl1): {draft: any, kind: string}?
    local draft = messageDraftFromExpressionContent(tbl1.expressionItem.content)
    return if draft == nil then nil else { kind = "sendDraft", draft = draft }
end

local function PresetAutocompleteEntry(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local presetIconRichText = getPresetIconRichText(var1.Typography.BodyMedium.FontSize)
    return React.createElement(Foundation.View, { tag = "row align-y-center size-full" }, {
        label = React.createElement(Foundation.Text, {
            tag = "auto-xy text-body-medium content-emphasis",
            Text = `{escapeRichText(tbl1.text)} {presetIconRichText}`,
            RichText = true,
            LayoutOrder = 1
        })
    })
end

local function renderPresetEntry(tbl1, _: boolean)
    local createElement = React.createElement
    local func1 = PresetAutocompleteEntry
    local tbl2 = { text = 0 }
    local var1 = presetText(tbl1.expressionItem)
    tbl2.text = if var1 == nil then "" else var1
    return createElement(func1, tbl2)
end

local function presetChat(tbl1)
    assert(type(tbl1.id) == "string" and tbl1.id ~= "", "AutocompleteSources.presetChat requires an id")
    assert(type(tbl1.catalogResource) == "table", "AutocompleteSources.presetChat requires a catalogResource")
    assert(type(tbl1.getIsAvailable) == "function", "AutocompleteSources.presetChat requires getIsAvailable")

    local catalogResource = tbl1.catalogResource
    local getIsAvailable = tbl1.getIsAvailable
    local num1 = resolveMinQueryLength(tbl1.searchVariant)

    local bool1 = false
    local bool2 = false
    local currentCatalog = nil
    local tbl2 = {}

    local function updateIndex(catalog) -- Luacid: Inlined by compiler; 1 call site recovered
        if bool2 and currentCatalog == catalog then
            return
        end
        bool2 = true
        currentCatalog = catalog
        tbl2 = buildIndex(catalog)
    end

    return {
        id = tbl1.id,
        matchTrigger = function(query: string, num2: number): {query: string, replaceFinish: number, replaceStart: number}?
            local replaceFinish = utf8.len(query)
            return if replaceFinish == nil or num2 ~= replaceFinish + 1 or replaceFinish < num1 then nil else {
                query = query,
                replaceStart = 1,
                replaceFinish = replaceFinish
            }
        end,
        search = function(str1: string)
            if not bool1 then
                return {}
            end

            local str2 = string.lower(str1)
            local tbl3 = {}
            for _, entry in tbl2 do
                local rank = getWordStartRank(entry.lowerText, str2)
                if rank ~= nil then
                    table.insert(tbl3, { rank = rank, entry = entry })
                end
            end

            table.sort(tbl3, function(arg1, arg2): boolean
                if arg1.rank == arg2.rank then
                    return arg1.entry.catalogIndex < arg2.entry.catalogIndex
                end

                return arg1.rank < arg2.rank
            end)

            local var1 = table.create(#tbl3)
            for _, value in tbl3 do
                table.insert(var1, { expressionItem = value.entry.expressionItem, catalogIndex = value.entry.catalogIndex })
            end

            return var1
        end,
        select = selectPreset,
        renderEntry = renderPresetEntry,
        maxResults = tbl1.maxResults,
        subscribe = function(callback: (...any) -> (...any))
            catalogResource.acquire()
            local bool3 = false
            local bool4 = false
            local effect = Signals.createEffect(function(arg1)
                bool1 = getIsAvailable(arg1) == true
                updateIndex((catalogResource.getCatalog(arg1)))
                if bool3 or not bool4 then
                    bool4 = true
                    return
                end
                callback()
            end)
            return function()
                bool3 = true
                effect()
                catalogResource.release()
            end
        end
    }
end

return presetChat
