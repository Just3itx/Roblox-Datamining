-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local insert = table.insert

local function tokenize(str1: string)
    local num1 = 0
    local tbl1 = {
        ["\n"] = {
            {
                "LINE_BREAK",
                "^\n",
                "^\n",
                1
            },
            { "HEADING", "^[#]+", "^([#]+)" },
            {
                "DIVIDER",
                "^[-]+[ \t]*\n",
                "^([-]+)[ \t]*\n",
                1
            },
            {
                "DIVIDER",
                "^[=]+[ \t]*\n",
                "^([=]+)[ \t]*\n",
                1
            },
            { "BULLET_LIST_ITEM", "^%s*%*", "^(%s*)(%*)" },
            { "BULLET_LIST_ITEM_2", "^%s*-", "^(%s*)(-)" },
            { "CODE_BLOCK", "^```[%w]*\n.-```", "^```([%w]*)\n(.-)```" },
            { "CODE_BLOCK", "^```[%w]*\n.+$", "^```([%w]*)\n(.+)$" },
            { "QUOTE", "^%s*>" },
            { "ORDERED_LIST_ITEM", "^%s*[0-9]+%.[ \t]+", "^(%s*)([0-9]+)%.[ \t]+" },
            { "ORDERED_LIST_ITEM", "^%s*[A-Za-z]%.[ \t]+", "^(%s*)([A-Za-z])%.[ \t]+" },
            { "TABLE_ROW", "^|" }
        },
        ["\\"] = {{ "ESCAPE", "^\\.", "^\\(.)" }},
        ["-"] = {{ "TABLE_HEADER", "^[-]+" }},
        ["="] = {{ "TABLE_HEADER_2", "^[=]+" }},
        ["!"] = {{ "IMAGE", "^!%[[^%]]+%]%([^%)]+%)", "^!%[([^%]]+)%]%(([^%)]+)%)" }},
        ["|"] = {{ "TABLE_DIVIDER", "^|" }},
        ["<"] = {
            { "OPEN_CLOSE", "^<[^>]*/>", "^<([%w-]+)%s?([^>]*)/>" },
            { "CLOSE", "^</[^>]*>", "^</([%w-]+)%s?([^>]*)>" },
            { "OPEN", "^<[^>]*>", "^<([%w-]+)%s?([^>]*)>" }
        },
        ["*"] = {
            { "BOLD_2", "^%*%*" },
            { "BOLD", "^%*" }
        },
        _ = {
            { "ITALIC_2", "^__" },
            { "ITALIC", "^_" }
        },
        ["~"] = {{ "STRIKE", "^~" }},
        ["["] = {
            { "LINK", "^%[[^%]]+%]%([^%)]+%)", "^%[([^%]]+)%]%(([^%)]+)%)" },
            { "ACTION", "^%[%[[^%]]+%]%]", "^%[%[([^%]]+)%]%]" }
        },
        ["`"] = {
            { "INLINE_CODE", "^`[^\n`]*`", "^`([^\n`]*)`" },
            { "INLINE_CODE", "^`[^\n`]+$", "^`([^\n`]+)$" }
        }
    }
    local num2 = 0
    local tbl2 = {}

    while true do
        if not (num1 <= #str1) then
            if num1 ~= num2 then
                insert(tbl2, { name = "TEXT", text = str1:sub(num2, num1 - 1), offset = num2 })
            end

            return tbl2
        end

        local str2 = if num1 == 0 then "\n" else str1:sub(num1, num1)

        local var1 = tbl1[str2]
        local bool1 = false
        if var1 then
            local num3 = if str2 == "\n" then 1 else 0
            local str3 = str1:sub(num1 + num3)
            for _, value in var1 do
                local text = str3:match(value[2])
                if not text then
                    continue
                end

                local name = value[1]

                local var4 = value[3]

                local var5 = value[4] or 0
                local var6 = #text - var5
                if num1 ~= num2 then
                    insert(tbl2, { name = "TEXT", text = str1:sub(num2, num1 - 1), offset = num2 })
                end

                insert(
                    tbl2,
                    {
                        name = name,
                        text = text,
                        capture = var4 and { str3:match(var4) } or nil,
                        isBlock = str2 == "\n",
                        offset = num1
                    }
                )
                num1 += num3 + var6
                num2 = num1
                bool1 = true
                break
            end
        end

        if not bool1 then
            num1 += 1
        end
    end
end

return tokenize
