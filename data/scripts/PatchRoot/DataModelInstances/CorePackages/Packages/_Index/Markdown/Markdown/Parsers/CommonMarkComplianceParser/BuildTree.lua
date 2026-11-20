-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local Constants = require(script.Parent.Parent.Constants)
local LISTS = Constants.LISTS
local STYLED_TEXT = Constants.STYLED_TEXT
local DIVIDERS = Constants.DIVIDERS

local NodeType = require(Markdown.Enums.NodeType)
local getNodeType = require(script.Parent.Parent.getNodeType)
local isNodeBlock = require(script.Parent.Parent.isNodeBlock)
local Flags = require(Markdown.Parent.MarkdownCore).Flags

local insert = table.insert

local tbl1 = {
    area = true,
    base = true,
    br = true,
    col = true,
    embed = true,
    hr = true,
    img = true,
    input = true,
    link = true,
    meta = true,
    source = true,
    track = true,
    wbr = true
}

local tbl2 = { Button = true }

local tbl3 = {}

local function createTextNode(arg1, arg2)
    return {
        name = "TEXT",
        text = arg1.text,
        children = {},
        offset = arg1.offset,
        type = getNodeType("TEXT", arg2)
    }
end

local function createHorizontalRuleNode(arg1, arg2, arg3)
    local name = if arg2.type == NodeType.Root or arg2.type == NodeType.Block and arg2.name ~= "TABLE_ROW" then "DIVIDER" else "BREAK"

    return {
        name = name,
        children = {},
        offset = arg1.offset,
        type = getNodeType(name, arg3)
    }
end

local function isLineStartAfter(arg1, bool1: boolean): boolean
    if arg1.isBlock then
        return true
    end

    if arg1.name ~= "TEXT" then
        return false
    end

    local var1 = string.match(arg1.text, "\n([^\n]*)$")

    if var1 then
        return string.find(var1, "^[ \t]*$") ~= nil
    end

    return bool1 and string.find(arg1.text, "^[ \t]*$") ~= nil
end

local function isWellFormedOpenTag(text: string)
    local var1 = string.match(text, "^<%a[%w%-]*(.-)>$")

    while var1 and string.find(var1, "%S") do
        local var2 = string.match(var1, "^%s+[%a_:][%w_%.:%-]*(.*)$")
        if not var2 then
            return false
        end

        var1 = string.match(var2, "^%s*=%s*\"[^\"]*\"(.*)$")
            or string.match(var2, "^%s*=%s*'[^']*'(.*)$")
            or string.match(var2, "^%s*=%s*[^%s\"'=<>`]+(.*)$")
            or var2
    end

    return var1 ~= nil
end

local function mayCloseLaterInStream(token, bool1: boolean, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = token.capture[1]

    local bool2 = not tbl2[var1]

    if bool2 then
        if arg1.inlineTags[var1] == true or bool1 then
            bool1 = isWellFormedOpenTag(token.text)
        end
    else
        bool1 = bool2
    end

    return bool1
end

local function findUnpairedTags(tbl4, arg1)
    local unpairedTags = ({})
    local tbl5 = ({})
    local bool1 = true
    local bool2 = false
    local num1 = 1

    local function closeOpenTagsFrom(num2: number) -- Luacid: Inlined by compiler; 4 call sites recovered
        for i = #tbl5, num2, -1 do
            unpairedTags[tbl5[i].token] = true
            tbl5[i] = nil
        end
    end

    for _, token in tbl4 do
        local bool3 = isLineStartAfter(token, bool1)

        if token.isBlock then
            if bool2 then
                closeOpenTagsFrom(num1)
            end

            for value2, value3 in tbl5 do
                if arg1.inlineTags[value3.tag] then
                    closeOpenTagsFrom(value2)
                    break
                end
            end

            bool2 = token.name == "TABLE_ROW"
            if bool2 then
                num1 = #tbl5 + 1
            else
                num1 = 1
            end
        elseif bool2 and token.name == "TABLE_DIVIDER" then
            closeOpenTagsFrom(num1)
        end

        local startsLine = bool1
        bool1 = bool3

        if not token.capture then
            continue
        end

        local tag = token.capture[1]
        if token.name == "OPEN" and not tbl1[tag] then
            insert(tbl5, { token = token, tag = tag, startsLine = startsLine })
        elseif token.name == "CLOSE" then
            local var2 = nil
            for i = #tbl5, num1, -1 do
                if tbl5[i].tag == tag then
                    var2 = i
                    break
                end
            end

            if var2 then
                closeOpenTagsFrom(var2 + 1)
                tbl5[var2] = nil
            else
                unpairedTags[token] = true
            end
        end
    end

    for _, value in tbl5 do
        if not (arg1.isStreaming and mayCloseLaterInStream(value.token, value.startsLine, arg1)) then
            unpairedTags[value.token] = true
        end
    end

    return unpairedTags
end

function tbl3.buildTree(tbl4, arg1)
    local tbl5 = not Flags.FFlagMarkdownTagFallbacks and {} or findUnpairedTags(tbl4, arg1)

    local tbl6 = {
        name = "ROOT",
        children = {},
        offset = 1,
        type = NodeType.Root
    }
    local num1 = 1
    local tbl7 = { tbl6 }

    while true do
        if not (num1 <= #tbl4) then
            tbl3.closeNode(tbl7, function(arg2)
                return isNodeBlock(arg2)
            end)

            tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "ROOT"
            end)
            return tbl6
        end

        local var1 = tbl4[num1]
        local var2 = tbl7[#tbl7]
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
        elseif var1.name == "EMPHASIS_START" then
            insert(tbl7, {
                name = "STYLED_TEXT",
                attributes = {
                    style = var1.text
                },
                children = {},
                offset = var1.offset,
                type = getNodeType("STYLED_TEXT", arg1)
            })
        elseif var1.name == "EMPHASIS_END" then
            tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "STYLED_TEXT"
            end)
        elseif Flags.FFlagMarkdownTagFallbacks and tbl5[var1] and var1.name == "OPEN" and var1.capture and tbl2[var1.capture[1]] then
            local var3 = var1.capture[2]
            insert(var2.children, {
                name = "TAG",
                text = var1.capture[1],
                attributes = not var3 and {} or tbl3.parseXmlAttributes(var3),
                children = {},
                offset = var1.offset,
                type = NodeType.Block
            })
        elseif STYLED_TEXT[var1.name] or Flags.FFlagMarkdownTagFallbacks and tbl5[var1] then
            insert(var2.children, (createTextNode(var1, arg1)))
        elseif LISTS[var1.name] and var1.capture then
            tbl3.closeNode(tbl7, function(arg2)
                return isNodeBlock(arg2)
            end)
            insert(tbl7, {
                name = "LIST_ITEM",
                children = {},
                attributes = {
                    depth = #var1.capture[1],
                    prefix = var1.capture[2]
                },
                offset = var1.offset,
                type = getNodeType("LIST_ITEM", arg1)
            })
        elseif var1.name == "HEADING" and not var1.isBlock then
            if not tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "HEADING"
            end) then
                insert(var2.children, (createTextNode(var1, arg1)))
            end
        elseif var1.isBlock then
            tbl3.closeNode(tbl7, function(arg2)
                return isNodeBlock(arg2)
            end)

            local var3 = if DIVIDERS[var1.name] then tbl7[#tbl7].children else tbl7
            local attributes = {}
            local children = {}

            if var1.name == "HEADING" and var1.capture then
                attributes.depth = #var1.capture[1]
            end

            insert(var3, {
                name = var1.name,
                children = children,
                attributes = attributes,
                offset = var1.offset,
                type = getNodeType(var1.name, arg1)
            })
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
        elseif var1.name == "LINK_START" and var1.capture then
            insert(tbl7, {
                text = var1.capture[1],
                name = "LINK",
                attributes = {
                    url = var1.capture[2],
                    title = var1.capture[3]
                },
                children = {},
                offset = var1.offset,
                type = getNodeType("LINK", arg1)
            })
        elseif var1.name == "LINK_END" then
            tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "LINK"
            end)
        elseif var1.name == "IMAGE" and var1.capture then
            insert(var2.children, {
                name = var1.name,
                text = var1.capture[1],
                attributes = {
                    url = var1.capture[2],
                    title = var1.capture[3]
                },
                offset = var1.offset,
                children = {},
                type = getNodeType("IMAGE", arg1)
            })
        elseif var1.name == "OPEN_CLOSE" and var1.capture then
            local text = var1.capture[1]
            local var4 = var1.capture[2]
            if var1.capture and text == "br" then
                insert(var2.children, { name = "BREAK", children = {}, offset = var1.offset, type = getNodeType("BREAK", arg1) })
            elseif Flags.FFlagMarkdownTagFallbacks and text == "hr" then
                insert(var2.children, (createHorizontalRuleNode(var1, var2, arg1)))
            else
                insert(var2.children, {
                    name = "TAG",
                    text = text,
                    attributes = not var4 and {} or tbl3.parseXmlAttributes(var4),
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
            elseif Flags.FFlagMarkdownTagFallbacks and text == "hr" then
                insert(var2.children, (createHorizontalRuleNode(var1, var2, arg1)))
            elseif Flags.FFlagMarkdownTagFallbacks and tbl1[text] then
                insert(var2.children, {
                    name = "TAG",
                    text = text,
                    attributes = not var4 and {} or tbl3.parseXmlAttributes(var4),
                    children = {},
                    offset = var1.offset,
                    type = if arg1.inlineTags[text] then NodeType.InlineSpan else NodeType.Block
                })
            else
                insert(tbl7, {
                    name = "TAG",
                    text = text,
                    attributes = not var4 and {} or tbl3.parseXmlAttributes(var4),
                    children = {},
                    offset = var1.offset,
                    type = if arg1.inlineTags[text] then NodeType.InlineSpan else NodeType.Block
                })
            end
        elseif Flags.FFlagMarkdownTagFallbacks and var1.name == "CLOSE" and var1.capture then
            local var3 = var1.capture[1]
            if not tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "TAG" and arg2.text == var3
            end) then
                insert(var2.children, (createTextNode(var1, arg1)))
            end
        elseif var1.name == "CLOSE" and var1.capture then
            local var3 = var1.capture[1]

            assert(tbl3.closeNode(tbl7, function(arg2): boolean
                if arg2.name ~= "TAG" then
                    return false
                end

                assert(
                    arg2.text == var3,
                    `Found <{arg2.text}> at {arg2.offset} when trying to close </{var3}> at {var1.offset}`
                )
                return true
            end), `No open tag exists trying to close </{var3}> at {var1.offset}`)
        elseif var2.name == "HEADING" then
            local var3 = string.find(var1.text, "\n", 1, true)
            if not var3 then
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
                num1 += 1
                continue
            end

            local text = string.sub(var1.text, 1, var3 - 1)
            local str1 = string.sub(var1.text, var3 + 1)
            if string.find(str1, "%S") == nil then
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
                num1 += 1
                continue
            end

            insert(
                var2.children,
                {
                    name = var1.name,
                    text = text,
                    children = {},
                    offset = var1.offset,
                    type = getNodeType(var1.name, arg1)
                }
            )
            tbl3.closeNode(tbl7, function(arg2): boolean
                return arg2.name == "HEADING"
            end)
            local tbl8 = {
                name = "PARAGRAPH",
                children = {{
                    name = "TEXT",
                    text = str1,
                    children = {},
                    offset = var1.offset + var3 + 1,
                    type = getNodeType("TEXT", arg1)
                }},
                offset = var1.offset,
                type = getNodeType("PARAGRAPH", arg1)
            }
            insert(tbl7, tbl8)
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
end

function tbl3.closeNode(tbl4, name)
    local lastNodeIndex = tbl3.findLastNodeIndex(tbl4, name)
    if not lastNodeIndex then
        return nil
    end

    local var1 = tbl4[lastNodeIndex]

    for i = lastNodeIndex + 1, #tbl4 do
        insert(var1.children, tbl4[i])
    end

    for _ = lastNodeIndex + 1, #tbl4 do
        table.remove(tbl4)
    end

    local var2 = tbl4[lastNodeIndex - 1]
    if var2 then
        table.remove(tbl4)
        insert(var2.children, var1)
    end

    return var1
end

function tbl3.findLastNodeIndex(tbl4, name)
    for i = #tbl4, 1, -1 do
        local var1 = tbl4[i]

        if if typeof(name) == "string" then var1.name == name else name(var1) then
            return i
        end
    end
    return nil
end

function tbl3.parseXmlAttributes(str1: string)
    local result = ({})

    for value, value2 in (str1:gmatch("%s*([A-Za-z0-9_-]+)=\"([^\"]+)\"%s*")) do
        result[value] = value2
    end
    return result
end

return tbl3.buildTree
