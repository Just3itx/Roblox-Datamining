-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local _Types = require(InlineRichText.Types)

local TokenName = require(InlineRichText.Enums.TokenName)
local parseXmlAttributes = require(InlineRichText.Parser.parseXmlAttributes)
local escapeRichFormatting = require(InlineRichText.Utils.escapeRichFormatting)
local unescapeRichFormatting = require(InlineRichText.Utils.unescapeRichFormatting)

local FFlagInlineRichTextSkipPlaintextEscape = require(InlineRichTextParent.SharedFlags).FFlagInlineRichTextSkipPlaintextEscape

local tbl1 = {
    { name = "OPEN_CLOSE", pattern = "^<([%w-]+)%s?([^>]*)/>" },
    { name = "OPEN", pattern = "^<([%w-]+)%s?([^>]*)>" },
    { name = "CLOSE", pattern = "^</([%w-]+)%s?([^>]*)>" }
}

local tbl2 = {
    OPEN = function(tbl2, text: string, str1: string)
        local attributes = parseXmlAttributes(str1)
        table.insert(tbl2, { name = TokenName.Open, text = text, attributes = attributes })
    end,
    CLOSE = function(tbl2, text: string)
        table.insert(tbl2, { name = TokenName.Close, text = text, attributes = {} })
    end,
    OPEN_CLOSE = function(tbl2, text: string, str1: string)
        local attributes = parseXmlAttributes(str1)
        table.insert(tbl2, { name = TokenName.Open, text = text, attributes = attributes })

        table.insert(tbl2, { name = TokenName.Close, text = text, attributes = {} })
    end
}

local function tokenize(str1: string)
    local num1 = 0
    local num2 = 0
    local result = {}
    local var1 = string.gsub(str1, "\n+", " ")

    for value in string.gmatch(var1, "()<") do
        if value < num1 then
            continue
        end

        local bool1 = false
        for _, value2 in tbl1 do
            local name = value2.name
            local pattern = value2.pattern
            local var2, var3 = string.find(var1, pattern, value)
            if not (var2 and var3) then
                continue
            end

            local tbl3 = { string.match(var1, pattern, value) }
            local var4 = tbl3[1]
            local var5 = tbl3[2] or ""
            if not var4 then
                continue
            end

            if value ~= num2 then
                local str2 = string.sub(var1, num2, value - 1)
                table.insert(result, {
                    name = TokenName.Text,
                    text = if FFlagInlineRichTextSkipPlaintextEscape then unescapeRichFormatting(str2) else escapeRichFormatting(str2),
                    attributes = {}
                })
            end

            if var4 ~= "br" then
                tbl2[name](result, var4, var5)
            elseif name == "OPEN" or name == "OPEN_CLOSE" then
                table.insert(result, { name = TokenName.Break, text = "", attributes = {} })
            end

            value += var3 - var2 + 1
            num2 = value
            bool1 = true
            break
        end

        if bool1 then
            num1 = value
        else
            num1 = value + 1
        end
    end
    local num3 = #var1 + 1

    if num3 ~= num2 then
        local str2 = string.sub(var1, num2, num3 - 1)
        table.insert(result, {
            name = TokenName.Text,
            text = if FFlagInlineRichTextSkipPlaintextEscape then unescapeRichFormatting(str2) else escapeRichFormatting(str2),
            attributes = {}
        })
    end

    if result[1] and result[1].name == TokenName.Text and result[1].text == "" then
        table.remove(result, 1)
    end

    return result
end

return tokenize
