-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Cryo = require(ChatUIPrimitivesParent.Cryo)
local EmojiList = require(ChatUIPrimitivesParent.EmojiList)

local Trie = require(script.Parent.Trie)

local function buildEmojiArray()
    local emojiArray = {}
    for _, value in Cryo.Dictionary.keys(EmojiList) do
        table.insert(emojiArray, ":" .. value)
    end
    table.sort(emojiArray)
    return emojiArray
end

local var1 = nil

local function search(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = arg1:autocomplete(str1:lower())
    table.sort(var2, function(str2: string, str3: string): boolean
        local bool1 = string.sub(str2, 1, 1) == ":"
        local bool2 = string.sub(str3, 1, 1) == ":"
        if not (bool1 and bool2) then
            return str2 < str3
        end

        local popularity = EmojiList[string.sub(str2, 2)].popularity
        local popularity2 = EmojiList[string.sub(str3, 2)].popularity
        return if popularity == popularity2 then str2 < str3 else popularity < popularity2
    end)
    return var2
end

local function searchSortedArray<T>(tbl1, str1: string, func1: ((...any) -> (...any))?): {T}
    local str2 = str1:lower()
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
        local var2 = tbl1[i]
        if string.sub(var2, 1, num1) ~= str2 then
            break
        end

        table.insert(result, var2)
    end

    if func1 then
        table.sort(result, func1)
    end
    return result
end

local function compareEmojiPopularity(str1: string, str2: string): boolean
    local popularity = EmojiList[string.sub(str1, 2)].popularity
    local popularity2 = EmojiList[string.sub(str2, 2)].popularity
    return if popularity == popularity2 then str1 < str2 else popularity < popularity2
end

return {
    buildTrie = function(tbl1, bool1: boolean?) -- name: buildUnifiedTrie
        local trie = Trie.new()
        if tbl1 then
            for _, value in tbl1 do
                trie:insert(value:lower())
            end
        end
        if bool1 then
            for _, value in Cryo.Dictionary.keys(EmojiList) do
                trie:insert(":" .. value)
            end
        end
        return trie
    end,
    buildEmojiArray = buildEmojiArray,
    buildCommandTrie = function(tbl1)
        local trie = Trie.new()
        for _, value in tbl1 do
            trie:insert(value:lower())
        end
        return trie
    end,
    getEmojiStructure = function()
        var1 = var1 or buildEmojiArray()

        return var1
    end,
    matchTrigger = function(str1: string, num1: number)
        if num1 < 2 then
            return nil
        end
        local num2 = 1
        for i = num1 - 1, 1, -1 do
            local str2 = string.sub(str1, i, i)
            if str2 == " " or str2 == "\n" then
                num2 = i + 1
                break
            end
        end

        local str2 = string.sub(str1, num2, num2)
        if str2 == "/" then
            if num2 ~= 1 then
                return nil
            end
        elseif str2 == ":" then
            if num1 - num2 < 3 then
                return nil
            end
        else
            local var2 = nil
            for i = num1 - 1, num2, -1 do
                if string.sub(str1, i, i) == ":" then
                    var2 = i
                    break
                end
            end

            if not var2 or num1 - var2 < 3 then
                return nil
            end

            num2 = var2
        end

        return {
            query = string.sub(str1, num2, num1 - 1),
            replaceStart = num2,
            replaceFinish = num1 - 1
        }
    end,
    matchColonCompletion = function(str1: string, num1: number)
        if num1 - 1 < 3 then
            return nil
        end
        if string.sub(str1, num1 - 1, num1 - 1) ~= ":" then
            return nil
        end
        local str2 = string.sub(str1, 1, num1 - 1)
        local replaceStart, _, var3 = string.find(str2, ":([^:%s]+):$")
        if not var3 then
            return nil
        end
        local var4 = EmojiList[string.lower(var3)]
        return if var4 then {
            replacement = var4.base,
            replaceStart = replaceStart,
            replaceFinish = num1 - 1
        } else nil
    end,
    search = search,
    searchSortedArray = searchSortedArray,
    searchStructures = function(tbl1, str1: string)
        if string.sub(str1, 1, 1) == ":" then
            if not tbl1.emoji then
                return {}
            end
            return (searchSortedArray(tbl1.emoji, str1, compareEmojiPopularity))
        elseif not tbl1.command then
            return {}
        else
            return search(tbl1.command, str1)
        end
    end,
    formatReplacement = function(str1: string)
        if string.sub(str1, 1, 1) == ":" then
            return EmojiList[string.sub(str1, 2)].base
        end

        return str1
    end,
    renderEntry = function(text: string, _: boolean)
        if string.sub(text, 1, 1) ~= ":" then
            return React.createElement(
                Foundation.Text,
                {
                    tag = "text-body-medium text-align-x-left content-emphasis",
                    Text = text,
                    Size = UDim2.fromScale(1, 1)
                }
            )
        end

        local str1 = string.sub(text, 2)
        local var2 = EmojiList[str1]
        return React.createElement(Foundation.View, {
            tag = "row align-y-center gap-large",
            Size = UDim2.fromScale(1, 1)
        }, {
            glyph = React.createElement(
                Foundation.Text,
                {
                    tag = "auto-xy text-body-medium content-emphasis",
                    Text = if var2 then var2.base else "",
                    LayoutOrder = 1
                }
            ),
            name = React.createElement(
                Foundation.Text,
                { tag = "auto-xy text-body-medium content-emphasis", Text = str1, LayoutOrder = 2 }
            )
        })
    end
}
