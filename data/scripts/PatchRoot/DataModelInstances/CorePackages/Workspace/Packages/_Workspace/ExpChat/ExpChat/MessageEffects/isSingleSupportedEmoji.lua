-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local EmojiList = require(ExpChatParent.EmojiList)

local str1 = game:DefineFastString("ExpChatLargerSingularEmojiBlacklist", "")

local str2 = utf8.char(65039)

local function stripPresentationSelectors(str3: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (string.gsub(str3, str2, ""))
end

local function getBlacklistedEmojiNames() -- Luacid: Inlined by compiler; 1 call site recovered
    local blacklistedEmojiNames = ({})
    for value in string.gmatch(str1, "[^,%s]+") do
        blacklistedEmojiNames[value] = true
    end
    return blacklistedEmojiNames
end

local var1 = nil

local function getSupportedEmojis()
    if not var1 then
        local blacklistedEmojiNames = getBlacklistedEmojiNames()
        local tbl1 = {}
        for value, value2 in EmojiList do
            if not blacklistedEmojiNames[value] then
                tbl1[stripPresentationSelectors(value2.base)] = true
            end
        end
        var1 = tbl1
    end
    return var1
end

local function isSingleSupportedEmoji(str3: string): boolean
    local var2 = string.match(str3, "^%s*(.-)%s*$")
    return getSupportedEmojis()[stripPresentationSelectors(var2)] == true
end

return isSingleSupportedEmoji
