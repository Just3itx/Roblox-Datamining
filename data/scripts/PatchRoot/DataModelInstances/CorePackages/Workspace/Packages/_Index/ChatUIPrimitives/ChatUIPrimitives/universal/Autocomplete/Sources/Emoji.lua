-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local EmojiList = require(ChatUIPrimitivesParent.EmojiList)

local _AutocompleteTypes = require(script.Parent.Parent.AutocompleteTypes)
local internalProviders = require(ChatUIPrimitives.Components.ChatInputBar.Autocomplete.internalProviders)
local utf8Range = require(script.Parent.Parent.utf8Range)

local function isWordBoundary(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == " " or str1 == "\n"
end

local function matchEmojiTrigger(str1: string, num1: number)
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

    local function matchFrom(replaceStart: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if num1 - replaceStart < 3 then
            return nil
        end
        local query = utf8Range.slice(str1, replaceStart, num1 - 1)
        return if query == nil then nil else {
            query = query,
            replaceStart = replaceStart,
            replaceFinish = num1 - 1
        }
    end

    local var2 = utf8Range.charAt(str1, num2)
    if var2 == nil then
        return nil
    elseif var2 == ":" then
        return matchFrom(num2)
    end

    local var3 = nil
    for i = num1 - 1, num2, -1 do
        if utf8Range.charAt(str1, i) == ":" then
            var3 = i
            break
        end
    end

    if var3 == nil then
        return nil
    end

    return matchFrom(var3)
end

local function matchEmojiCompletion(str1: string, num1: number)
    local var1 = utf8.len(str1)
    if var1 == nil or num1 - 1 < 3 or var1 < num1 - 1 then
        return nil
    end
    if utf8Range.charAt(str1, num1 - 1) ~= ":" then
        return nil
    end
    local var2 = utf8Range.slice(str1, 1, num1 - 1)
    if var2 == nil then
        return nil
    end
    local var3, _, var4 = string.find(var2, ":([^:%s]+):$")
    if var4 == nil or var3 == nil then
        return nil
    end
    local var5 = EmojiList[string.lower(var4)]
    if var5 == nil then
        return nil
    end
    local var6 = utf8.len(string.sub(var2, 1, var3 - 1))

    if var6 == nil then
        return nil
    end

    return {
        replacement = var5.base,
        replaceStart = var6 + 1,
        replaceFinish = num1 - 1
    }
end

local function compareEmojiPopularity(str1: string, str2: string): boolean
    local popularity = EmojiList[string.sub(str1, 2)].popularity
    local popularity2 = EmojiList[string.sub(str2, 2)].popularity
    return if popularity == popularity2 then str1 < str2 else popularity < popularity2
end

local function searchEmojis(str1: string)
    return internalProviders.searchSortedArray(internalProviders.getEmojiStructure(), str1, compareEmojiPopularity)
end

local function selectEmoji(text: string)
    local var1 = EmojiList[string.sub(text, 2)]
    local tbl1 = { kind = "insert", text = 0 }

    if var1 ~= nil then
        text = var1.base
    end

    tbl1.text = text
    return tbl1
end

local function renderEmojiEntry(str1: string, _: boolean)
    local str2 = string.sub(str1, 2)
    local var1 = EmojiList[str2]
    return React.createElement(Foundation.View, { tag = "row align-y-center gap-large size-full" }, {
        glyph = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-body-medium content-emphasis",
                Text = if var1 then var1.base else "",
                LayoutOrder = 1
            }
        ),
        name = React.createElement(
            Foundation.Text,
            { tag = "auto-xy text-body-medium content-emphasis", Text = str2, LayoutOrder = 2 }
        )
    })
end

local function emoji(tbl1)
    assert(type(tbl1.id) == "string" and tbl1.id ~= "", "AutocompleteSources.emoji requires an id")
    return {
        id = tbl1.id,
        matchTrigger = matchEmojiTrigger,
        search = searchEmojis,
        select = selectEmoji,
        renderEntry = renderEmojiEntry,
        matchCompletion = matchEmojiCompletion
    }
end

return emoji
