-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local Children = require(script.Parent.Children)
local _CommonMark = require(MarkdownParent.CommonMark)
local ListMarkers = require(script.Parent.ListMarkers)
local _Registry = require(script.Parent.Registry)
local RendererNodes = require(script.Parent.RendererNodes)
local _Types = require(Markdown.Types)

local var1 = table.freeze({})

local function codeLines(str1: string?): {string} -- Luacid: unused: defined but never referenced
    local str2 = str1 or ""
    if string.sub(str2, -1) == "\n" then
        str2 = string.sub(str2, 1, -2)
    end
    return string.split(str2, "\n")
end

local function pushInOrder<T>(tbl1, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
    for i = #tbl2, 1, -1 do
        table.insert(tbl1, tbl2[i])
    end
end

local function beginLine(tbl1, entry)
    local _out = tbl1._out
    local tbl2 = {
        entry = entry,
        mark = #_out.children,
        startedBefore = tbl1._startedLine,
        contentStart = 0
    }

    if tbl1._startedLine then
        RendererNodes.append(_out, "BREAK")
        if entry.separator == "paragraph" then
            RendererNodes.append(_out, "BREAK")
        end
    end
    tbl1._startedLine = true
    if entry.prefix ~= nil then
        RendererNodes.appendText(_out, entry.prefix)
    end
    tbl2.contentStart = if entry.prefix ~= nil then tbl2.mark else #_out.children
    return tbl2
end

local function endLine(tbl1, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
    local children = tbl1._out.children
    if #children > tbl2.contentStart then
        tbl1._drew[tbl2.entry.top] = true
        return
    end
    for i = #children, tbl2.mark + 1, -1 do
        children[i] = nil
    end
    tbl1._startedLine = tbl2.startedBefore
end

local module = {}

function module.start(_units, _out, _registry, _drop)
    local _stack = {}
    local tbl2 = {}
    for top, unit in _units do
        table.insert(tbl2, { unit = unit, separator = "paragraph", level = 0, top = top })
    end

    pushInOrder(_stack, tbl2)
    return {
        _units = _units,
        _out = _out,
        _registry = _registry,
        _drop = _drop or var1,
        _stack = _stack,
        _startedLine = #_out.children > 0,
        _drew = {},
        _openLine = nil
    }
end

function module.resume(tbl1)
    local _openLine = tbl1._openLine
    if _openLine ~= nil then
        tbl1._openLine = nil
        endLine(tbl1, _openLine)
    end

    local _out = tbl1._out
    local _stack = tbl1._stack
    while #_stack > 0 do
        local var2 = table.remove(_stack)
        local block = var2.unit.block
        local kind = if block == nil then nil else block.kind

        if block == nil then
            tbl1._openLine = beginLine(tbl1, var2)
            return var2.unit.inlines or {}, nil
        end

        if tbl1._drop[block.kind] then
            continue
        end
        if kind == "Paragraph" or kind == "Heading" then
            tbl1._openLine = beginLine(tbl1, var2)
            return nil, block
        end

        if kind == "FencedCodeBlock" or kind == "IndentedCodeBlock" then
            local tbl2 = beginLine(tbl1, var2)
            local literal = block.literal or ""

            if string.sub(literal, -1) == "\n" then
                literal = string.sub(literal, 1, -2)
            end
            for value, value2 in string.split(literal, "\n") do
                if value > 1 then
                    RendererNodes.append(_out, "BREAK")
                end
                if value2 ~= "" then
                    RendererNodes.appendText(_out, value2)
                end
            end

            local children = tbl1._out.children
            if #children > tbl2.contentStart then
                tbl1._drew[tbl2.entry.top] = true
            else
                for i = #children, tbl2.mark + 1, -1 do
                    children[i] = nil
                end
                tbl1._startedLine = tbl2.startedBefore
            end
        elseif kind == "HtmlBlock" then
            local tbl2 = beginLine(tbl1, var2)
            local literal = block.literal
            if literal ~= nil and literal ~= "" then
                RendererNodes.appendText(_out, literal)
            end

            local children = tbl1._out.children
            if #children > tbl2.contentStart then
                tbl1._drew[tbl2.entry.top] = true
            else
                for i = #children, tbl2.mark + 1, -1 do
                    children[i] = nil
                end
                tbl1._startedLine = tbl2.startedBefore
            end
        elseif kind == "ThematicBreak" then
            local tbl2 = beginLine(tbl1, var2)
            RendererNodes.appendText(_out, "---")
            local children = tbl1._out.children
            if #children > tbl2.contentStart then
                tbl1._drew[tbl2.entry.top] = true
            else
                for i = #children, tbl2.mark + 1, -1 do
                    children[i] = nil
                end
                tbl1._startedLine = tbl2.startedBefore
            end
        elseif kind == "BulletList" or kind == "OrderedList" then
            local separator = var2.separator
            if var2.prefix ~= nil then
                endLine(tbl1, (beginLine(tbl1, var2)))
                separator = "line"
            end

            local str1 = string.rep("  ", var2.level)
            local var3 = ListMarkers.bulletPrefix(block)
            local var4 = ListMarkers.startNumber(block)
            local tbl2 = {}
            for _, unit in Children.units(block, tbl1._registry, true) do
                local var5

                if unit.block == nil or unit.block.kind ~= "ListItem" then
                    var5 = nil
                elseif var4 == nil then
                    var5 = str1 .. var3
                else
                    var5 = `{str1}{ListMarkers.orderedPrefix(var4)}. `
                    var4 += 1
                end

                table.insert(
                    tbl2,
                    {
                        unit = unit,
                        separator = if #tbl2 ~= 0 then "line" else separator,
                        prefix = var5,
                        level = var2.level,
                        top = var2.top
                    }
                )
            end

            pushInOrder(_stack, tbl2)
        else
            local var3 = Children.units(block, tbl1._registry, false)
            if #var3 == 0 then
                endLine(tbl1, (beginLine(tbl1, var2)))
            end

            local level = if kind == "ListItem" then var2.level + 1 else var2.level
            local str1 = if kind == "ListItem" then "line" else "paragraph"
            local tbl2 = {}
            for value, unit in var3 do
                table.insert(tbl2, {
                    unit = unit,
                    separator = if value == 1 then var2.separator else str1,
                    prefix = if value == 1 then var2.prefix else nil,
                    level = level,
                    top = var2.top
                })
            end

            pushInOrder(_stack, tbl2)
        end
    end

    return nil, nil
end

function module.drawnUnits(tbl1)
    local result = {}
    for k, _unit in tbl1._units do
        if tbl1._drew[k] then
            table.insert(result, _unit)
        end
    end
    return result
end

return module
