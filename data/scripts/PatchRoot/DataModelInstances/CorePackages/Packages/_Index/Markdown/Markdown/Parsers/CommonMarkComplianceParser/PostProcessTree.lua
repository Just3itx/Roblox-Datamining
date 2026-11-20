-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)
local Flags = require(Markdown.Parent.MarkdownCore).Flags
local NodeType = require(Markdown.Enums.NodeType)
local TableAlignment = require(Markdown.Enums.TableAlignment)

local insert = table.insert

local Constants = require(script.Parent.Parent.Constants)
local CONTAINERS = Constants.CONTAINERS
local INLINE_TEXT = Constants.INLINE_TEXT
local PLAIN_TEXT = Constants.PLAIN_TEXT
local STYLED_TEXT = Constants.STYLED_TEXT

local getNodeType = require(script.Parent.Parent.getNodeType)
local isNodeBlock = require(script.Parent.Parent.isNodeBlock)

local tbl1 = {}

local function trimLeadingWhitespace(tbl2, bool1: boolean)
    local result = {}

    for _, value in tbl2 do
        local bool2 = false

        if bool1 and value.name == "TEXT" and value.text then
            value.text = value.text:gsub("^[ \t]+", "")
            bool2 = #value.text == 0
        end

        if bool2 then
            continue
        end

        if value.name == "BREAK" and value.text ~= nil then
            bool1 = string.sub(value.text, -1) == "\n"
        else
            bool1 = false
        end

        insert(result, value)
    end
    return result
end

local function makeContentInline(arg1, arg2)
    if arg1.name == "TAG" then
        arg1.type = NodeType.InlineSpan
    elseif arg1.name == "DIVIDER" then
        arg1.name = "BREAK"
        arg1.type = getNodeType("BREAK", arg2)
    end

    for _, child in arg1.children do
        makeContentInline(child, arg2)
    end
end

function tbl1.postProcessTree(arg1, arg2)
    local result = {}
    local num1 = 1
    local children = arg1.children
    local var1 = arg1.name == "TAG"
        and (arg2.inlineTags[arg1.text] or Flags.FFlagMarkdownTagFallbacks and arg1.type == NodeType.InlineSpan)
    local var2 = CONTAINERS[arg1.name] and not var1
    local fFlagMarkdownTagFallbacks = Flags.FFlagMarkdownTagFallbacks

    if fFlagMarkdownTagFallbacks then
        if arg1.type == NodeType.TextBlock or arg1.type == NodeType.InlineSpan then
            fFlagMarkdownTagFallbacks = true
        else
            fFlagMarkdownTagFallbacks = false
        end
    end

    while num1 <= #children do
        local child = children[num1]
        if fFlagMarkdownTagFallbacks and child.name == "TAG" then
            makeContentInline(child, arg2)
        end

        local inlineTag = child.name == "TAG" and child.text and arg2.inlineTags[child.text]

        if (INLINE_TEXT[child.name] or inlineTag) and var2 then
            local var3, var4 = tbl1.buildParagraph(children, num1, arg2)
            assert(var3 > 0, "Did not find an inline node when expected")

            if #var4.children > 0 then
                insert(result, var4)
            end
            num1 += var3
        elseif PLAIN_TEXT[child.name] then
            local var3, var4 = tbl1.mergeTextNodes(children, num1, nil, arg2)
            assert(var3 > 0, "Did not find a text node when expected")

            if var4.text and #var4.text > 0 then
                insert(result, var4)
            end
            num1 += var3
        elseif child.name == "LIST_ITEM" then
            local var3, var4 = tbl1.buildList(children, num1, arg2)
            insert(result, var4)
            assert(var3 > 0, "Did not find a list node when expected")
            num1 += var3
        elseif child.name == "TABLE_ROW" then
            local var3, var4 = tbl1.buildTable(children, num1, arg2)
            insert(result, var4)
            assert(var3 > 0, "Did not find a table row node when expected")
            num1 += var3
        elseif child.name == "QUOTE" then
            local var3, var4 = tbl1.buildQuote(children, num1, arg2)
            insert(result, var4)
            assert(var3 > 0, "Did not find a quote node when expected")
            num1 += var3
        elseif child.name == "LINE_BREAK" then
            num1 += 1
        else
            child.children = tbl1.postProcessTree(child, arg2)
            insert(result, child)
            num1 += 1
        end
    end
    if isNodeBlock(arg1) then
        result = trimLeadingWhitespace(result, false)

        local var3 = result[1]
        if var3 and var3.text then
            var3.text = var3.text:gsub("^%s+", "")
        end
        local var4 = result[#result]
        if var4 and var4.text then
            var4.text = var4.text:gsub("%s+$", "")
        end
    end

    return result
end

function tbl1.buildParagraph(children, num1: number, arg1, bool1: boolean?)
    local num2 = num1
    local tbl2 = {}
    local num3 = 0

    while num1 <= #children do
        local child = children[num1]
        local inlineTag = child.name == "TAG" and child.text and arg1.inlineTags[child.text]
        local var1 = INLINE_TEXT[child.name] or inlineTag

        if PLAIN_TEXT[child.name] then
            local var2, var3 = tbl1.mergeTextNodes(children, num1, bool1, arg1)

            if var3.text and #var3.text > 0 then
                insert(tbl2, var3)
            end
            assert(var2 > 0, "Did not find a rich text node when expected")
            num3 += var2
            num1 += var2
        elseif child.name == "STYLED_TEXT" then
            local _, var2 = tbl1.buildParagraph(child.children, 1, arg1, true)
            if child.attributes and child.attributes.style == "INLINE_CODE" then
                child.children = tbl1.applyCodeSpanRules(var2.children)
            else
                child.children = trimLeadingWhitespace(var2.children, false)
            end
            insert(tbl2, child)
            num3 += 1
            num1 += 1
        else
            if not var1 then
                break
            end

            if Flags.FFlagMarkdownTagFallbacks and child.name == "TAG" then
                makeContentInline(child, arg1)
            end

            insert(tbl2, child)
            num3 += 1
            num1 += 1
        end
    end

    if not bool1 then
        local child = children[num2 - 1]
        tbl2 = trimLeadingWhitespace(tbl2, not (child and child.name == "TAG"))
    end

    return num3, {
        name = "PARAGRAPH",
        children = tbl2,
        offset = children[num2].offset,
        type = getNodeType("PARAGRAPH", arg1)
    }
end

function tbl1.outputRichText(arg1, arg2)
    local var1 = if arg1.attributes then STYLED_TEXT[arg1.attributes.style] else nil

    if var1 then
        local var2, var3 = tbl1.mergeTextNodes(arg1.children, 1, nil, arg2)
        assert(var2 == #arg1.children, `Found non-inline content inside inline element at {arg1.offset}`)
        return `<{var1}>{var3.text}</{var1}>`
    end

    if arg1.text then
        return arg1.text
    end
    assert(false, `No text for node at {arg1.offset}`)
end

function tbl1.buildList(children, num1: number, arg1)
    local depth = children[num1].attributes.depth
    local num2 = num1
    local tbl2 = {}
    local num3 = 0

    while num1 <= #children do
        local child = children[num1]
        if child.name ~= "LIST_ITEM" then
            break
        end

        if child.attributes.depth == depth then
            child.children = tbl1.postProcessTree(child, arg1)
            insert(tbl2, child)
            num3 += 1
            num1 += 1
        else
            if not (depth < child.attributes.depth) then
                break
            end
            local var1, var2 = tbl1.buildList(children, num1, arg1)
            insert(tbl2, var2)
            assert(var1 > 0, "Did not find a list node when expected")
            num1 += var1
            num3 += var1
        end
    end

    return num3, {
        name = "LIST",
        attributes = { depth = depth },
        children = tbl2,
        offset = children[num2].offset,
        type = getNodeType("LIST", arg1)
    }
end

local function isEmptyQuoteLine(children)
    for _, child in children do
        if child.name ~= "TEXT" or child.text and #child.text > 0 then
            return false
        end
    end
    return true
end

function tbl1.buildQuote(children, num1: number, arg1)
    local num2 = num1
    local tbl2 = {}
    local num3 = 0

    while num1 <= #children and children[num1].name == "QUOTE" do
        local node = children[num1]
        insert(tbl2, { node = node, children = tbl1.postProcessTree(node, arg1) })
        num3 += 1
        num1 += 1
    end

    local num4 = #tbl2
    local num5 = 1

    while num5 <= num4 and isEmptyQuoteLine(tbl2[num5].children) do
        num5 += 1
    end
    while num5 <= num4 and isEmptyQuoteLine(tbl2[num4].children) do
        num4 -= 1
    end

    local tbl3 = {}
    for i = num5, num4 do
        local var1 = tbl2[i]
        if num5 < i then
            insert(tbl3, { name = "BREAK", children = {}, offset = var1.node.offset, type = getNodeType("BREAK", arg1) })
        end

        for _, child in var1.children do
            if child.name ~= "TEXT" or child.text ~= "" then
                insert(tbl3, child)
            end
        end
    end

    local child = children[num2]
    child.children = tbl3
    return num3, child
end

local function buildTableCellsLegacy(arg1, arg2): {[any]: any}?
    local tbl2 = {}
    local tbl3 = {}
    local bool1 = true
    local child = arg1.children[1]
    for i = 1, #arg1.children do
        local child2 = arg1.children[i]
        if child2.name == "TABLE_DIVIDER" then
            local tbl4 = {
                name = "TABLE_CELL",
                children = tbl3,
                offset = if tbl3[1] then tbl3[1].offset else arg1.offset,
                type = getNodeType("TABLE_CELL", arg2)
            }
            tbl4.children = tbl1.postProcessTree(tbl4, arg2)
            insert(tbl2, tbl4)

            local var1 = child.text and child.text:match("^[ \t-=]+$") ~= nil
            if not (bool1 and var1) then
                var1 = false
            end

            bool1 = var1
            tbl3 = {}
        else
            insert(tbl3, child2)
        end
    end

    return if bool1 then nil else tbl2
end

local function buildTableLegacy(children, num1: number, arg1)
    local num2 = 0
    local tbl2 = {}
    for i = num1, #children do
        local child = children[i]
        if child.name ~= "TABLE_ROW" then
            break
        end

        local tableCellsLegacy = buildTableCellsLegacy(child, arg1)

        if tableCellsLegacy then
            child.children = tableCellsLegacy
            insert(tbl2, child)
        elseif #tbl2 > 0 then
            tbl2[#tbl2].name = "TABLE_HEADER"
        end
        num2 += 1
    end

    return num2, {
        name = "TABLE",
        children = tbl2,
        offset = children[num1].offset,
        type = getNodeType("TABLE", arg1)
    }
end

local function getDelimiterAlignment(arg1)
    local str1 = ""
    for _, child in arg1.children do
        str1 ..= child.text or ""
    end

    local var1 = string.match(str1, "^%s*(.-)%s*$") or ""
    local bool1 = string.sub(var1, 1, 1) == ":"
    local bool2 = string.sub(var1, -1) == ":"

    return if bool1 and bool2 then TableAlignment.Center elseif bool2 then TableAlignment.Right elseif bool1 then TableAlignment.Left else nil
end

function tbl1.buildTable(children, num1: number, arg1)
    if not Flags.FFlagMarkdownTables then
        return buildTableLegacy(children, num1, arg1)
    end

    local num2 = 0
    local tbl2 = {}
    local tbl3 = ({})

    for i = num1, #children do
        local child = children[i]
        if child.name ~= "TABLE_ROW" then
            break
        end

        local var1, var2 = tbl1.buildTableCells(child, arg1)
        if var2 and num2 == 1 then
            tbl2[1].name = "TABLE_HEADER"
            for value, value2 in var1 do
                tbl3[value] = getDelimiterAlignment(value2)
            end
        else
            child.children = var1
            insert(tbl2, child)
        end

        num2 += 1
    end

    if tbl2[1] then
        local childrenLen = #tbl2[1].children
        for _, value in tbl2 do
            for _ = #value.children + 1, childrenLen do
                insert(value.children, tbl1.buildTableCell({}, value, arg1))
            end

            for _ = childrenLen + 1, #value.children do
                table.remove(value.children)
            end

            for k, child in value.children do
                local alignment = tbl3[k]
                if alignment then
                    child.attributes = { alignment = alignment }
                end
            end
        end
    end

    return num2, {
        name = "TABLE",
        children = tbl2,
        offset = children[num1].offset,
        type = getNodeType("TABLE", arg1)
    }
end

local function isDividerCell(tableCell)
    local str1 = ""
    for _, child in tableCell.children do
        if child.name ~= "TEXT" then
            return false
        end
        str1 ..= child.text or ""
    end

    return str1:match("^%s*:?%-+:?%s*$") ~= nil
end

local function hasContent(tbl2)
    for _, value in tbl2 do
        if value.name ~= "TEXT" or value.text and value.text:find("%S") then
            return true
        end
    end

    return false
end

function tbl1.buildTableCell(children, arg1, arg2)
    local tbl2 = {
        name = "TABLE_CELL",
        children = children,
        offset = if children[1] then children[1].offset else arg1.offset,
        type = getNodeType("TABLE_CELL", arg2)
    }
    tbl2.children = tbl1.postProcessTree(tbl2, arg2)

    return tbl2
end

function tbl1.buildTableCells(arg1, arg2)
    local tbl2 = {}
    local tbl3 = {}
    local bool1 = true

    for i = 1, #arg1.children do
        local child = arg1.children[i]
        if child.name == "TABLE_DIVIDER" then
            local tableCell = tbl1.buildTableCell(tbl3, arg1, arg2)
            insert(tbl2, tableCell)
            bool1 = bool1 and isDividerCell(tableCell)
            tbl3 = {}
        else
            insert(tbl3, child)
        end
    end

    if hasContent(tbl3) then
        local tableCell = tbl1.buildTableCell(tbl3, arg1, arg2)
        insert(tbl2, tableCell)
        bool1 = bool1 and isDividerCell(tableCell)
    end

    return tbl2, bool1 and #tbl2 > 0
end

function tbl1.mergeTextNodes(children, num1: number, bool1: boolean?, arg1)
    local str1 = ""
    local num2 = 0
    for i = num1, #children do
        local child = children[i]
        if not PLAIN_TEXT[child.name] then
            break
        end

        str1 ..= child.text
        num2 += 1
    end

    if not bool1 then
        str1 = str1:gsub("^\n*(.-)\n*$", "%1")
    end

    return num2, {
        name = "TEXT",
        text = str1,
        children = {},
        offset = children[num1].offset,
        type = getNodeType("TEXT", arg1)
    }
end

function tbl1.applyCodeSpanRules(children)
    local var1 = nil
    local var2 = nil
    local bool1 = false

    for _, child in children do
        if not (child.text and #child.text > 0) then
            continue
        end

        if var1 == nil then
            var1 = child
        end

        if child.text:find("[^\n ]") then
            var2 = child
            bool1 = true
        else
            var2 = child
        end
    end

    if var1 == nil or var2 == nil then
        return children
    end

    local var3 = (var1.text or ""):gsub("\n", " ")
    local var4 = (var2.text or ""):gsub("\n", " ")

    if var3:sub(1, 1) == " " and var4:sub(-1, -1) == " " and bool1 then
        if var1 == var2 then
            var3 = var3:sub(2, -2)
            var4 = var3
        else
            var3 = var3:sub(2)
            var4 = var4:sub(1, -2)
        end
    end

    var1.text = var3
    var2.text = var4

    return children
end

return tbl1.postProcessTree
