-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(script.Parent.AdapterTypes)
local Children = require(script.Parent.Children)
local _CommonMark = require(MarkdownParent.CommonMark)
local _Engine = require(script.Parent.Engine)
local ListMarkers = require(script.Parent.ListMarkers)
local _Types = require(Markdown.Types)

local function optionalAttributes(url: string?, title: string?): {title: string?, url: string?}? -- Luacid: unused: defined but never referenced
    return if url == nil and title == nil then nil else { url = url, title = title }
end

local function appendListItems(tbl1, tbl2, arg1)
    local list = tbl1.list
    local out = tbl1.out
    local bool1 = not list.tight
    if bool1 and tbl1.splitParent == nil then
        arg1:gap("LooseList", list)
    end

    local splitParent = if bool1 then tbl1.splitParent else nil
    local var1 = ListMarkers.bulletPrefix(list)
    local var2 = ListMarkers.startNumber(list)
    local var3 = nil
    local function appendItem()
        if splitParent ~= nil and var3 ~= nil then
            out = arg1:append(splitParent, "LIST")
        end

        local prefix = if var2 == nil then var1 else ListMarkers.orderedPrefix(var2)

        if var2 ~= nil then
            var2 += 1
        end
        local var5 = arg1:append(out, "LIST_ITEM", { prefix = prefix })
        var3 = var5
        return var5
    end

    for _, value in arg1:_units(list, true) do
        local block = value.block
        if block ~= nil and block.kind == "ListItem" then
            local var4 = appendItem()
            local var5 = arg1:_units(block, false)
            local block2 = nil
            for _, value2 in var5 do
                if Children.isList(value2) then
                    block2 = value2.block
                    break
                end
            end

            arg1:_flattenUnits(var5, var4, { except = block2, gap = "ListItemBlocks" }, block)
            if block2 ~= nil then
                table.insert(tbl2, { list = block2, out = arg1:append(out, "LIST") })
            end
        else
            arg1:_flattenUnits({ value }, var3 or appendItem())
        end
    end
end

local module = {}

function module.list(tbl1)
    local bool1 = tbl1 == nil or tbl1.splitLooseTopLevel ~= false
    return function(list, arg1)
        local tbl2 = {{
            list = list,
            out = arg1:block("LIST"),
            splitParent = if bool1 and arg1.depth == 0 then arg1.parent else nil
        }}

        while #tbl2 > 0 do
            appendListItems(table.remove(tbl2), tbl2, arg1)
        end
    end
end

function module.quote(tbl1)
    local var1 = if tbl1 == nil then "flatten" else tbl1.nested or "flatten"
    if var1 ~= "flatten" and var1 ~= "drop" then
        error(`Rules.quote's nested must be "flatten" or "drop", not {var1}`)
    end

    local drop = if var1 == "drop" then table.freeze({ BlockQuote = true }) else nil

    return function(arg1, arg2)
        arg2:flatten(arg1, arg2:block("QUOTE"), { gap = "QuoteBlocks", drop = drop })
    end
end

function module.codeBlock()
    return function(arg1, arg2)
        local info = if arg1.kind == "FencedCodeBlock" then arg1.info else nil
        local tbl1

        if info == nil or info == "" then
            tbl1 = nil
        else
            local var1 = string.find(info, " ", 1, true)
            tbl1 = { language = 0 }

            if var1 then
                info = string.sub(info, 1, var1 - 1)
            end

            tbl1.language = info
        end
        local var1 = arg2:block("CODE_BLOCK", tbl1)
        local literal = arg1.literal or ""
        if string.sub(literal, -1) == "\n" then
            literal = string.sub(literal, 1, -2)
        end
        var1.text = literal
    end
end

function module.divider()
    return function(_, arg1)
        arg1:block("DIVIDER")
    end
end

function module.htmlBlock()
    return function(arg1, arg2)
        local var1 = arg2:block("PARAGRAPH")
        local literal = arg1.literal
        if literal ~= nil and literal ~= "" then
            arg2:append(var1, "TEXT").text = literal
        end
    end
end

function module.code()
    return function(arg1, arg2)
        local var1 = arg2:append(arg2.parent, "STYLED_TEXT", { style = "INLINE_CODE" })
        local literal = arg1.literal
        if literal ~= nil and literal ~= "" then
            arg2:append(var1, "TEXT").text = literal
        end
    end
end

function module.hardLineBreak()
    return function(_, arg1)
        arg1:append(arg1.parent, "BREAK")
    end
end

function module.link()
    return function(arg1, arg2)
        local parent = arg2.parent
        local destination = arg1.destination
        local title = arg1.title
        arg2:adaptInlinesOf(
            arg1,
            (arg2:append(
                parent,
                "LINK",
                destination ~= nil and { url = destination, title = title }
                    or title ~= nil and { url = destination, title = title }
                    or nil
            ))
        )
    end
end

function module.image()
    return function(arg1, arg2)
        local parent = arg2.parent
        local destination = arg1.destination
        local title = arg1.title
        arg2:append(
            parent,
            "IMAGE",
            destination ~= nil and { url = destination, title = title }
                or title ~= nil and { url = destination, title = title }
                or nil
        ).text = arg2:plainText(arg1)
    end
end

return module
