-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local function decodeEmoji(arg1): {assetSource: number, id: any, name: any, unicode: number}?
    if type(arg1) ~= "table" then
        return nil
    end
    if type(arg1.id) ~= "string" or arg1.id == "" then
        return nil
    end
    if type(arg1.name) ~= "string" or arg1.name == "" then
        return nil
    end

    return {
        id = arg1.id,
        name = arg1.name,
        assetSource = if type(arg1.asset_source) == "string" then arg1.asset_source else nil,
        unicode = if type(arg1.unicode) == "string" then arg1.unicode else nil
    }
end

local function decodeEmojiSet(arg1): {emojiPage: {[any]: any}, emojiSetId: any, emojiSetName: any, nextCursor: number, previousCursor: number}?
    if type(arg1) ~= "table" then
        return nil
    end
    if type(arg1.emoji_set_id) ~= "string" or arg1.emoji_set_id == "" then
        return nil
    end
    if type(arg1.emoji_set_name) ~= "string" or arg1.emoji_set_name == "" then
        return nil
    end

    local emojiPage = {}
    if type(arg1.emoji_page) == "table" then
        for _, value in arg1.emoji_page do
            local var1 = decodeEmoji(value)
            if var1 ~= nil then
                table.insert(emojiPage, var1)
            end
        end
    end

    return {
        emojiSetId = arg1.emoji_set_id,
        emojiSetName = arg1.emoji_set_name,
        emojiPage = emojiPage,
        nextCursor = if type(arg1.next_cursor) == "string" then arg1.next_cursor else nil,
        previousCursor = if type(arg1.previous_cursor) == "string" then arg1.previous_cursor else nil
    }
end

return {
    decodeGetEmojiSetsResponse = function(arg1)
        local emojiSets = {}
        if type(arg1) == "table" and type(arg1.emoji_sets) == "table" then
            for _, emojiSet in arg1.emoji_sets do
                local var1 = decodeEmojiSet(emojiSet)
                if var1 ~= nil then
                    table.insert(emojiSets, var1)
                end
            end
        end

        return {
            emojiSets = emojiSets,
            nextCursor = if type(arg1) == "table" and type(arg1.next_cursor) == "string" then arg1.next_cursor else nil,
            previousCursor = if type(arg1) == "table" and type(arg1.previous_cursor) == "string" then arg1.previous_cursor else nil
        }
    end,
    flattenEmojis = function(arg1)
        if arg1 == nil then
            return {}
        end

        local result = {}
        for _, emojiSet in arg1.emojiSets do
            for _, value in emojiSet.emojiPage do
                table.insert(result, value)
            end
        end
        return result
    end
}
