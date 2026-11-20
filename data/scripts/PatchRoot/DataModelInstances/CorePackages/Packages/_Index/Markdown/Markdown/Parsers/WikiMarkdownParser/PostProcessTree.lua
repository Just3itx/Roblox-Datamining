-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local insert = table.insert

local Constants = require(script.Parent.Parent.Constants)
local CONTAINERS = Constants.CONTAINERS
local INLINE_TEXT = Constants.INLINE_TEXT
local PLAIN_TEXT = Constants.PLAIN_TEXT
local STYLED_TEXT = Constants.STYLED_TEXT

local getNodeType = require(script.Parent.Parent.getNodeType)
local isNodeBlock = require(script.Parent.Parent.isNodeBlock)

local tbl1 = {}

function tbl1.postProcessTree(arg1, arg2)
    local result = {}
    local num1 = 1
    local children = arg1.children
    local inlineTag = arg1.name == "TAG" and arg2.inlineTags[arg1.text]
    local var1 = CONTAINERS[arg1.name] and not inlineTag
    while num1 <= #children do
        local child = children[num1]
        local inlineTag2 = child.name == "TAG" and child.text and arg2.inlineTags[child.text]

        if (INLINE_TEXT[child.name] or inlineTag2) and var1 then
            local var2, var3 = tbl1.buildParagraph(children, num1, arg2)
            assert(var2 > 0, "Did not find an inline node when expected")

            if #var3.children > 0 then
                insert(result, var3)
            end
            num1 += var2
        elseif PLAIN_TEXT[child.name] then
            local var2, var3 = tbl1.mergeTextNodes(children, num1, arg2)
            assert(var2 > 0, "Did not find a text node when expected")

            if var3.text and #var3.text > 0 then
                insert(result, var3)
            end
            num1 += var2
        elseif child.name == "LIST_ITEM" then
            local var2, var3 = tbl1.buildList(children, num1, arg2)
            insert(result, var3)
            assert(var2 > 0, "Did not find a list node when expected")
            num1 += var2
        elseif child.name == "TABLE_ROW" then
            local var2, var3 = tbl1.buildTable(children, num1, arg2)
            insert(result, var3)
            assert(var2 > 0, "Did not find a table row node when expected")
            num1 += var2
        elseif child.name == "LINE_BREAK" then
            num1 += 1
        else
            child.children = tbl1.postProcessTree(child, arg2)
            insert(result, child)
            num1 += 1
        end
    end
    if isNodeBlock(arg1) then
        local var2 = result[1]
        if var2 and var2.text then
            var2.text = var2.text:gsub("^%s+", "")
        end
        local var3 = result[#result]
        if var3 and var3.text then
            var3.text = var3.text:gsub("%s+$", "")
        end
    end
    return result
end

function tbl1.buildParagraph(children, num1: number, arg1)
    local num2 = num1
    local num3 = 0
    local tbl2 = {}

    while num1 <= #children do
        local child = children[num1]
        local inlineTag = child.name == "TAG" and child.text and arg1.inlineTags[child.text]
        local var1 = INLINE_TEXT[child.name] or inlineTag

        if PLAIN_TEXT[child.name] then
            local var2, var3 = tbl1.mergeTextNodes(children, num1, arg1)

            if var3.text and #var3.text > 0 then
                insert(tbl2, var3)
            end
            assert(var2 > 0, "Did not find a rich text node when expected")
            num3 += var2
            num1 += var2
        else
            if not var1 then
                break
            end

            insert(tbl2, child)
            num3 += 1
            num1 += 1
        end
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
        local var2, var3 = tbl1.mergeTextNodes(arg1.children, 1, arg2)
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

function tbl1.buildTable(children, num1: number, arg1)
    local num2 = 0
    local tbl2 = {}
    for i = num1, #children do
        local child = children[i]
        if child.name ~= "TABLE_ROW" then
            break
        end

        local tableCells = tbl1.buildTableCells(child, arg1)

        if tableCells then
            child.children = tableCells
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

function tbl1.buildTableCells(arg1, arg2): {[any]: any}?
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

function tbl1.mergeTextNodes(children, num1: number, arg1)
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

    return num2, {
        name = "TEXT",
        text = str1:gsub("^\n*(.-)\n*$", "%1"),
        children = {},
        offset = children[num1].offset,
        type = getNodeType("TEXT", arg1)
    }
end

return tbl1.postProcessTree
