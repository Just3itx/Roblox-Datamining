-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local Constants = require(script.Parent.Parent.Constants)
local LISTS = Constants.LISTS
local STYLED_TEXT = Constants.STYLED_TEXT
local DIVIDERS = Constants.DIVIDERS

local insert = table.insert

local NodeType = require(Markdown.Enums.NodeType)
local getNodeType = require(script.Parent.Parent.getNodeType)
local isNodeBlock = require(script.Parent.Parent.isNodeBlock)

local tbl1 = {}

function tbl1.buildTree(tbl2, arg1)
    local tbl3 = {
        name = "ROOT",
        children = {},
        offset = 1,
        type = NodeType.Root
    }
    local num1 = 1
    local tbl4 = { tbl3 }

    while num1 <= #tbl2 do
        local var1 = tbl2[num1]
        local var2 = tbl4[#tbl4]
        if var1.name == "CODE_BLOCK" and var1.capture then
            local text = string.gsub(var1.capture[2], "^%s*(.-)%s*$", "%1")
            insert(var2.children, {
                name = "CODE_BLOCK",
                text = text,
                children = {},
                attributes = {
                    language = var1.capture[1]
                },
                offset = var1.offset,
                type = getNodeType("CODE_BLOCK", arg1)
            })
        elseif var1.name == "INLINE_CODE" and var1.capture then
            local children = var2.children
            local tbl5 = {
                name = "STYLED_TEXT",
                attributes = { style = "INLINE_CODE" },
                children = {{
                    name = "TEXT",
                    text = var1.capture[1],
                    children = {},
                    offset = var1.offset,
                    type = getNodeType("TEXT", arg1)
                }},
                offset = var1.offset,
                type = getNodeType("STYLED_TEXT", arg1)
            }
            insert(children, tbl5)
        elseif STYLED_TEXT[var1.name] then
            if not tbl1.closeNode(tbl4, function(arg2): boolean
                if arg2.name ~= "STYLED_TEXT" or not (arg2.attributes and arg2.attributes.style) then
                    return false
                end

                assert(
                    arg2.attributes.style == var1.name,
                    `Can't put {var1.name} at {var1.offset} inside {arg2.attributes.style} at {arg2.offset}`
                )
                return true
            end) then
                insert(tbl4, {
                    name = "STYLED_TEXT",
                    attributes = {
                        style = var1.name
                    },
                    children = {},
                    offset = var1.offset,
                    type = getNodeType("STYLED_TEXT", arg1)
                })
            end
        elseif LISTS[var1.name] and var1.capture then
            tbl1.closeNode(tbl4, function(arg2)
                return isNodeBlock(arg2)
            end)
            insert(tbl4, {
                name = "LIST_ITEM",
                children = {},
                attributes = {
                    depth = #var1.capture[1],
                    prefix = var1.capture[2]
                },
                offset = var1.offset,
                type = getNodeType("LIST_ITEM", arg1)
            })
        elseif var1.isBlock then
            tbl1.closeNode(tbl4, function(arg2)
                return isNodeBlock(arg2)
            end)
            local attributes = {}

            if var1.name == "HEADING" and var1.capture then
                attributes.depth = #var1.capture[1]
            end

            insert(
                if DIVIDERS[var1.name] then tbl4[#tbl4].children else tbl4,
                {
                    name = var1.name,
                    children = {},
                    attributes = attributes,
                    offset = var1.offset,
                    type = getNodeType(var1.name, arg1)
                }
            )
        elseif var1.name == "ESCAPE" and var1.capture then
            insert(
                var2.children,
                {
                    name = "TEXT",
                    text = var1.capture[1],
                    offset = var1.offset,
                    children = {},
                    type = getNodeType("TEXT", arg1)
                }
            )
        elseif var1.name == "LINK" and var1.capture then
            local offset = string.find(var1.text, var1.capture[1], 1, true)
            local children = var2.children
            local tbl5 = {
                name = "LINK",
                text = var1.capture[1],
                url = var1.capture[2],
                offset = var1.offset,
                children = {{
                    name = "TEXT",
                    text = var1.capture[1],
                    offset = offset or var1.offset,
                    children = {},
                    type = getNodeType("TEXT", arg1)
                }},
                type = getNodeType("LINK", arg1)
            }
            insert(children, tbl5)
        elseif var1.name == "IMAGE" and var1.capture then
            insert(var2.children, {
                name = var1.name,
                text = var1.capture[1],
                url = var1.capture[2],
                offset = var1.offset,
                children = {},
                type = getNodeType("IMAGE", arg1)
            })
        elseif var1.name == "OPEN_CLOSE" and var1.capture then
            local text = var1.capture[1]
            local var4 = var1.capture[2]
            if var1.capture and text == "br" then
                insert(var2.children, { name = "BREAK", children = {}, offset = var1.offset, type = getNodeType("BREAK", arg1) })
            else
                insert(var2.children, {
                    name = "TAG",
                    text = text,
                    attributes = not var4 and {} or tbl1.parseXmlAttributes(var4),
                    children = {},
                    offset = var1.offset,
                    type = if arg1.inlineTags[text] then NodeType.InlineSpan else NodeType.Block
                })
            end
        elseif var1.name == "OPEN" and var1.capture then
            local text = var1.capture[1]
            local var4 = var1.capture[2]

            if var1.capture and text == "br" then
                insert(var2.children, { name = "BREAK", children = {}, offset = var1.offset, type = getNodeType("BREAK", arg1) })
            else
                insert(tbl4, {
                    name = "TAG",
                    text = text,
                    attributes = not var4 and {} or tbl1.parseXmlAttributes(var4),
                    children = {},
                    offset = var1.offset,
                    type = if arg1.inlineTags[text] then NodeType.InlineSpan else NodeType.Block
                })
            end
        elseif var1.name == "CLOSE" and var1.capture then
            local var3 = var1.capture[1]

            assert(tbl1.closeNode(tbl4, function(arg2): boolean
                if arg2.name ~= "TAG" then
                    return false
                end

                assert(
                    arg2.text == var3,
                    `Found <{arg2.text}> at {arg2.offset} when trying to close </{var3}> at {var1.offset}`
                )
                return true
            end), `No open tag exists trying to close </{var3}> at {var1.offset}`)
        else
            insert(
                var2.children,
                {
                    name = var1.name,
                    text = var1.text,
                    children = {},
                    offset = var1.offset,
                    type = getNodeType(var1.name, arg1)
                }
            )
        end

        num1 += 1
    end

    tbl1.closeNode(tbl4, function(arg2)
        return isNodeBlock(arg2)
    end)

    tbl1.closeNode(tbl4, function(arg2): boolean
        return arg2.name == "ROOT"
    end)
    return tbl3
end

function tbl1.closeNode(tbl2, name)
    local lastNodeIndex = tbl1.findLastNodeIndex(tbl2, name)
    if not lastNodeIndex then
        return nil
    end

    local var1 = tbl2[lastNodeIndex]

    for i = lastNodeIndex + 1, #tbl2 do
        insert(var1.children, tbl2[i])
    end

    for _ = lastNodeIndex + 1, #tbl2 do
        table.remove(tbl2)
    end

    local var2 = tbl2[lastNodeIndex - 1]
    if var2 then
        table.remove(tbl2)
        insert(var2.children, var1)
    end

    return var1
end

function tbl1.findLastNodeIndex(tbl2, name)
    for i = #tbl2, 1, -1 do
        local var1 = tbl2[i]

        if if typeof(name) == "string" then var1.name == name else name(var1) then
            return i
        end
    end
    return nil
end

function tbl1.parseXmlAttributes(str1: string)
    local result = ({})

    for value, value2 in (str1:gmatch("%s*([A-Za-z0-9_-]+)=\"([^\"]+)\"%s*")) do
        result[value] = value2
    end
    return result
end

return tbl1.buildTree
