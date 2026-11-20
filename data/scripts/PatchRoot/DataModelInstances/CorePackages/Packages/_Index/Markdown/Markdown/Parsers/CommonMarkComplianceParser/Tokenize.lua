-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local Constants = require(script.Parent.Parent.Constants)
local PostProcessTokens = require(script.Parent.PostProcessTokens)
local Utils = require(script.Parent.Utils)
local Flags = require(Markdown.Parent.MarkdownCore).Flags

local insert = table.insert

local tbl1 = { ACTION = true, OPEN = true, CLOSE = true, OPEN_CLOSE = true }

local function createInlineCodeTracker(str1: string)
    local num1 = -1
    local var1 = nil
    local num2 = 0
    local num3 = -1
    local var2 = nil

    local function finishRun() -- Luacid: Inlined by compiler; 3 call sites recovered
        if num2 == 0 then
            return
        end

        if var1 == nil then
            var1 = num2
        elseif var1 == num2 then
            var1 = nil
        end

        num2 = 0
        var2 = nil
    end

    local function startLine(num4: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        if num4 == num1 then
            return
        end

        num1 = num4
        var1 = nil
        num2 = 0
        num3 = -1
        var2 = nil
    end

    return {
        addBacktick = function(num4: number, num5: number)
            startLine(num4)

            if num5 ~= num3 + 1 then
                finishRun()
            end

            num2 += 1
            num3 = num5
        end,
        isInside = function(num4: number): boolean
            startLine(num4)
            finishRun()
            return var1 ~= nil
        end,
        isInsideClosed = function(num4: number, num5: number)
            startLine(num4)
            finishRun()

            if var1 == nil then
                return false
            end

            if var2 == nil then
                var2 = false
                local var3 = string.find(str1, "\n", num5, true) or #str1 + 1
                local gmatch = string.gmatch
                local str2 = str1
                local var4 = var3 - 1

                for value in gmatch(string.sub(str2, num5, var4), "`+") do
                    if #value == var1 then
                        var2 = true
                        break
                    end
                end
            end

            return var2
        end
    }
end

local tbl2 = {{ "TABLE_ROW", "^[ \t]*|?" }}

local function getTableRowCells(str1: string)
    local var1 = string.match(str1, "^%s*(.-)%s*$") or ""
    local var2 = string.gsub(var1, "^|", "")
    local var3 = string.gsub(var2, "|$", "")
    local var4 = string.gsub(var3, "\\|", "")

    local tableRowCells = {}
    for value in string.gmatch(var4 .. "|", "([^|]*)|") do
        insert(tableRowCells, value)
    end

    return tableRowCells
end

local function isDelimiterRow(str1: string)
    if not string.find(str1, "|", 1, true) then
        return false
    end

    for _, value in getTableRowCells(str1) do
        if not string.match(value, "^%s*:?%-+:?%s*$") then
            return false
        end
    end

    return true
end

local tbl3 = {
    "^ ? ? ?##?#?#?#?#?[ \t]",
    "^ ? ? ?##?#?#?#?#?$",
    "^ ? ? ?%-[ \t]*%-[ \t]*%-[ \t]*[%- \t]*$",
    "^ ? ? ?%*[ \t]*%*[ \t]*%*[ \t]*[%* \t]*$",
    "^ ? ? ?_[ \t]*_[ \t]*_[ \t]*[_ \t]*$",
    "^%s*[%*%-] ",
    "^%s*```",
    "^%s*~~~",
    "^%s*>",
    "^%s*[0-9]+%.[ \t]",
    "^%s*[A-Za-z]%.[ \t]"
}

local function startsOtherBlock(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in tbl3 do
        if string.find(str1, value) then
            return true
        end
    end

    return false
end

local function couldBecomeDelimiterRow(str1: string, num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (string.find(str1, "^[%s|:%-]*$") == nil) and #getTableRowCells(str1) <= num1
end

local function isTableRow(str1: string, num1: number, bool1: boolean, bool2: boolean)
    local var1 = string.find(str1, "\n", num1, true)
    local str2 = string.sub(str1, num1, not var1 and #str1 or var1 - 1)

    if bool1 then
        local var2

        if string.find(str2, "%S") == nil then
            var2 = false
        else
            var2 = isDelimiterRow(str2)
            var2 = var2 or not startsOtherBlock(str2)
        end

        return var2
    end

    if not string.find(str2, "|", 1, true) or startsOtherBlock(str2) then
        return false
    end

    local bool3 = bool2 and string.sub(str2, 1, 1) == "|"
    if not var1 then
        return bool3
    end

    local var2 = string.find(str1, "\n", var1 + 1, true)
    local str3 = string.sub(str1, var1 + 1, not var2 and #str1 or var2 - 1)
    local num2 = #getTableRowCells(str2)
    return if isDelimiterRow(str3) and #getTableRowCells(str3) == num2 then true else bool3 and not var2 and couldBecomeDelimiterRow(str3, num2)
end

local tbl4 = {
    { "BREAK", "^\\\n" },
    { "ESCAPE", "^\\(%p)" }
}

local tbl5 = {{ "IMAGE", "^!%[([^%]]+)%]%(([^%)]+)%)" }}

local tbl6 = {
    { "OPEN_CLOSE", "^<([%w-]+)%s?([^>]*)/>" },
    { "CLOSE", "^</([%w-]+)%s?([^>]*)>" },
    { "OPEN", "^<([%w-]+)%s?([^>]*)>" }
}

local tbl7 = {
    { "BOLD_2", "^%*%*" },
    { "BOLD", "^%*" }
}

local tbl8 = {
    { "ITALIC_2", "^__" },
    { "ITALIC", "^_" }
}

local tbl9 = {{ "STRIKE", "^~" }}

local tbl10 = {{ "INLINE_CODE", "^`" }}

local tbl11 = {
    ["\\"] = tbl4,
    ["!"] = tbl5,
    ["<"] = tbl6,
    ["*"] = tbl7,
    _ = tbl8,
    ["~"] = tbl9,
    ["`"] = tbl10
}

local tbl12 = {
    ["\n"] = {
        { "LINE_BREAK", "^\n", 1 },
        { "HEADING", "^ ? ? ?(##?#?#?#?#?)[ \t]+", 1 },
        { "HEADING", "^ ? ? ?(##?#?#?#?#?)\n", 1 },
        { "DIVIDER", "^ ? ? ?%-[ \t]*%-[ \t]*%-[ \t]*[%- \t]*\n", 1 },
        { "DIVIDER", "^ ? ? ?%*[ \t]*%*[ \t]*%*[ \t]*[%* \t]*\n", 1 },
        { "DIVIDER", "^ ? ? ?_[ \t]*_[ \t]*_[ \t]*[_ \t]*\n", 1 },
        { "BULLET_LIST_ITEM", "^(%s*)(%* )" },
        { "BULLET_LIST_ITEM_2", "^(%s*)(- )" },
        { "CODE_BLOCK", "^```[ \t]*([^\n]*)[ \t]*\n(.-)```" },
        { "CODE_BLOCK", "^```[ \t]*([^\n]*)[ \t]*\n(.+)$" },
        { "CODE_BLOCK", "^~~~[ \t]*([^\n]*)[ \t]*\n(.-)~~~" },
        { "CODE_BLOCK", "^~~~[ \t]*([^\n]*)[ \t]*\n(.+)$" },
        { "QUOTE", "^%s*>" },
        { "ORDERED_LIST_ITEM", "^(%s*)([0-9]+)%.[ \t]+" },
        { "ORDERED_LIST_ITEM", "^(%s*)([A-Za-z])%.[ \t]+" },
        { "TABLE_ROW", "^|" }
    },
    ["\\"] = tbl4,
    ["-"] = {{ "TABLE_HEADER", "^[-]+" }},
    ["="] = {{ "TABLE_HEADER_2", "^[=]+" }},
    ["!"] = tbl5,
    ["|"] = {{ "TABLE_DIVIDER", "^|" }},
    ["<"] = tbl6,
    ["*"] = tbl7,
    _ = tbl8,
    ["~"] = tbl9,
    ["["] = {
        { "LINK", "^%[([^%]]*)%]%([ \t]*([^\n\t ]+)[ \t]\"([^\n]+)\"[ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*([^\n\t ]+)[ \t]'([^\n]+)'[ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*([^\n\t ]+)[ \t]%(([^\n]+)%)[ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*<>[ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*<([^\n\t]+)>[ \t]*%)" },
        { "LINK", "^%[([^%]]*)%]%([ \t]*([^\n\t ]+)[ \t]*%)" },
        { "ACTION", "^%[%[([^%]]+)%]%]" }
    },
    ["`"] = tbl10
}

local tbl13 = {{ "LINE_BREAK", "^[ \t\r]+\n", 1 }}
table.move(tbl12["\n"], 1, #tbl12["\n"], #tbl13 + 1, tbl13)

local function withoutTableRow(tbl14)
    local result = {}
    for _, value in tbl14 do
        if value[1] ~= "TABLE_ROW" then
            insert(result, value)
        end
    end

    return result
end

local tbl14 = withoutTableRow(tbl12["\n"])
local tbl15 = withoutTableRow(tbl13)

local tbl16 = {
    LINK = {
        mapToText = function(arg1)
            return arg1.capture and arg1.capture[1] or ""
        end,
        startToken = "LINK_START",
        endToken = "LINK_END",
        textStartOffset = 1
    }
}

local tbl17 = {{ "HEADING", "^  ? ?(#+)%s*\n", 1 }}

local function tokenizeTextSpan(str1: string, num1: number, bool1: boolean, arg1)
    local num2 = 0
    local num3 = 0
    local num4 = 0
    local tbl18 = {}

    local var1 = nil
    local bool2 = false
    local var2 = Flags.FFlagMarkdownTables and arg1.isStreaming == true
    local inlineCodeTracker = if Flags.FFlagMarkdownTagFallbacks then createInlineCodeTracker(str1) else nil

    while true do
        if not (num2 <= #str1) then
            if num2 ~= num3 then
                insert(tbl18, { name = "TEXT", text = string.sub(str1, num3, num2 - 1), offset = num3 + num1 })
            end

            return PostProcessTokens(tbl18)
        end

        local str2 = if num2 == 0 and not bool1 then "\n" else string.sub(str1, num2, num2)
        local bool3 = str2 == "\n" and not bool1
        local fFlagMarkdownTables = Flags.FFlagMarkdownTables

        if fFlagMarkdownTables then
            if bool3 then
                local func1 = isTableRow

                local num5 = num2 + 1
                local bool4 = var2 and (num2 <= 1 or string.sub(str1, num2 - 1, num2 - 1) == "\n")
                fFlagMarkdownTables = func1(str1, num5, bool2, bool4)
            else
                fFlagMarkdownTables = bool3
            end
        end

        local var3 = Flags.FFlagMarkdownTables and bool3 and not fFlagMarkdownTables
        local var4

        if bool1 then
            var4 = tbl11[str2] or {}
        elseif str2 == "\n" and var1 == "QUOTE" then
            if var3 then
                var4 = tbl15
            else
                var4 = tbl13
            end
        elseif fFlagMarkdownTables then
            var4 = tbl2
        elseif var3 then
            var4 = tbl14
        else
            var4 = tbl12[str2] or tbl17
        end

        local bool4 = false
        local var5 = nil
        local num5

        if str2 == "\n" and not bool1 then
            num4 = num2
            num5 = 1
        else
            num5 = 0
        end

        for _, value in var4 do
            local var6 = value[2]
            local var7, var8 = string.find(str1, var6, num2 + num5)
            if not (var7 and var8) then
                continue
            end

            local text = string.sub(str1, var7, var8)
            local name = value[1]

            local var10 = value[3] or 0
            local var11 = #text - var10
            local characterContext = nil

            if not bool1 then
                local _, var12 = string.find(text, "\n[^\n]*$")
                if var12 then
                    num4 = var12 + var7
                end
            end

            local fFlagMarkdownTables2 = Flags.FFlagMarkdownTables

            if fFlagMarkdownTables2 then
                if var1 == "TABLE_ROW" then
                    fFlagMarkdownTables2 = text == "\\|"
                else
                    fFlagMarkdownTables2 = false
                end
            end

            if name == "ESCAPE"
                and not fFlagMarkdownTables2
                and (if inlineCodeTracker then inlineCodeTracker.isInside(num4) else Utils.isInsideInlineCode(tbl18, num4))
            then
                continue
            end

            if inlineCodeTracker and tbl1[name] and inlineCodeTracker.isInsideClosed(num4, num2) then
                continue
            end
            if Constants.STYLED_TEXT[name] then
                characterContext = Utils.getCharacterContext(str1, num2, num5 + var11)
            end

            local tbl19 = { string.match(str1, var6, num2 + num5) }

            if bool1 and str2 == "<" and #tbl19 > 0 and not arg1.inlineTags[tbl19[1]] then
                continue
            end

            if num2 ~= num3 then
                insert(tbl18, { name = "TEXT", text = string.sub(str1, num3, num2 - 1), offset = num3 + num1 })
            end

            local isBlock = not bool1 and str2 == "\n"
            if isBlock then
                var1 = name
            end

            local tbl20 = {
                name = name,
                text = text,
                capture = 0,
                isBlock = 0,
                offset = 0,
                context = 0
            }

            if not (#tbl19 > 0) then
                tbl19 = nil
            end

            tbl20.capture = tbl19
            tbl20.isBlock = isBlock
            tbl20.offset = num2 + num1
            tbl20.context = characterContext
            insert(tbl18, tbl20)

            if inlineCodeTracker and name == "INLINE_CODE" then
                inlineCodeTracker.addBacktick(num4, num2)
            end

            num2 += num5 + var11
            num3 = num2
            var5 = name
            bool4 = true
            break
        end

        if not bool4 then
            num2 += 1
        end

        if Flags.FFlagMarkdownTables and bool3 then
            bool2 = var5 == "TABLE_ROW"
        end
    end
end

local function tokenize(str1: string, arg1)
    local result = {}

    for _, value in (tokenizeTextSpan(str1, 0, false, arg1)) do
        local var1 = tbl16[value.name]
        if var1 then
            local tbl18 = {{
                name = var1.startToken,
                offset = value.offset,
                text = string.sub(str1, value.offset, value.offset + var1.textStartOffset - 1),
                capture = value.capture
            }}

            local var2 = var1.mapToText(value)

            local var3 = tokenizeTextSpan(var2, value.offset + var1.textStartOffset, true, arg1)
            table.move(var3, 1, #var3, 2, tbl18)

            local offset = value.offset + var1.textStartOffset + #var2
            insert(
                tbl18,
                {
                    name = var1.endToken,
                    offset = offset,
                    text = string.sub(str1, offset, value.offset + #value.text - 1)
                }
            )
            table.move(tbl18, 1, #tbl18, #result + 1, result)
        else
            insert(result, value)
        end
    end

    return result
end

return tokenize
