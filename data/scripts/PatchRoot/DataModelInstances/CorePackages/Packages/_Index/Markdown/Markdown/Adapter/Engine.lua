-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _AdapterTypes = require(script.Parent.AdapterTypes)
local Children = require(script.Parent.Children)
local _CommonMark = require(MarkdownParent.CommonMark)
local FlattenBlocks = require(script.Parent.FlattenBlocks)
local Passes = require(script.Parent.Passes)
local _Registry = require(script.Parent.Registry)
local RendererNodes = require(script.Parent.RendererNodes)
local _Types = require(Markdown.Types)

local function newToken(tbl1) -- Luacid: Inlined by compiler; 7 call sites recovered
    tbl1.lastToken += 1
    return tbl1.lastToken
end

local function append(tbl1, arg1, str1: string, arg2)
    local var1 = RendererNodes.append(arg1, str1, arg2)
    if not RendererNodes.isInline(var1) then
        tbl1.depths[var1] = (tbl1.depths[arg1] or 0) + 1
        if Passes.isDroppable(str1) then
            tbl1.droppable[var1] = arg1
        end
    end
    return var1
end

local function emitText(tbl1, arg1, str1: string, lastTextToken: number)
    if str1 == "" then
        return
    end
    local lastText = tbl1.lastText
    if lastText ~= nil and tbl1.lastTextToken == lastTextToken and tbl1.registry.passes.mergeText then
        local children = arg1.children
        if children[#children] == lastText then
            local textPart = tbl1.textParts[lastText]
            if textPart == nil then
                tbl1.textParts[lastText] = { lastText.text, str1 }
                return
            end
            table.insert(textPart, str1)

            return
        end
    end
    tbl1.lastText = RendererNodes.appendText(arg1, str1)
    tbl1.lastTextToken = lastTextToken
end

local function inlineChainFrame(cursor, into, token: number, depth: number) -- Luacid: Inlined by compiler; 5 call sites recovered
    return {
        kind = "inlines",
        into = into,
        cursor = cursor,
        index = 0,
        token = token,
        depth = depth
    }
end

local function hasBlockChild(node) -- Luacid: Inlined by compiler; 1 call site recovered
    local firstChild = node:getFirstChild()
    while firstChild ~= nil do
        if firstChild.isBlock then
            return true
        end
        firstChild = firstChild:getNext()
    end
    return false
end

local function childrenFrame(tbl1, node, into, num1: number?, num2: number)
    if RendererNodes.holdsBlocks(into) then
        return {
            kind = "units",
            into = into,
            units = Children.units(node, tbl1.registry, false),
            index = 0
        }
    elseif RendererNodes.isInline(into) or not hasBlockChild(node) then
        return inlineChainFrame(node:getFirstChild(), into, num1 or newToken(tbl1), tbl1.depths[into] or num2)
    end

    return {
        kind = "flatten",
        into = into,
        node = node,
        index = 0,
        inlineOnly = tbl1.registry.blockInText == "drop"
    }
end

local tbl1 = {}
tbl1.__index = tbl1

local function newContext(_run, parent, _token: number?, depth: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return (setmetatable({
        parent = parent,
        depth = depth,
        isFirstTopLevel = parent == _run.root and #parent.children == 0,
        options = _run.options,
        _run = _run,
        _token = _token,
        _pending = nil,
        _closed = false
    }, tbl1))
end

local function schedule(arg1, tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1._closed then
        error("An adapter context schedules work only while its handler runs")
    end
    local _pending = arg1._pending
    if _pending == nil then
        arg1._pending = { tbl2 }
        return
    end
    table.insert(_pending, tbl2)
end

local function tokenOf(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local _token = arg1._token
    if _token ~= nil then
        return _token
    end
    local lastToken = newToken(arg1._run)
    arg1._token = lastToken
    return lastToken
end

function tbl1:block(str1: string, arg1)
    return (append(self._run, self.parent, str1, arg1))
end

function tbl1:append(arg1, str1: string, arg2)
    return (append(self._run, arg1, str1, arg2))
end

function tbl1:text(str1: string)
    if RendererNodes.holdsBlocks(self.parent) then
        error(`ctx:text needs an inline target, not {self.parent.name}`)
    end
    emitText(self._run, self.parent, str1, (tokenOf(self)))
end

function tbl1:adaptChildrenOf(node, arg1)
    schedule(self, (childrenFrame(self._run, node, arg1 or self.parent, self._token, self.depth)))
end

function tbl1:adaptInlinesOf(arg1, into)
    schedule(self, (inlineChainFrame(arg1:getFirstChild(), into, tokenOf(self), self._run.depths[into] or self.depth)))
end

function tbl1.flatten(arg1, node, into, options)
    schedule(arg1, { kind = "flatten", into = into, node = node, options = options, index = 0 })
end

function tbl1.childrenOf(_, arg1)
    local firstChild = arg1:getFirstChild()
    return function()
        local var1 = firstChild
        if var1 ~= nil then
            firstChild = var1:getNext()
        end
        return var1
    end
end

function tbl1:plainText(arg1): string
    local registry = self._run.registry

    local firstChild = arg1:getFirstChild()
    local tbl2 = {}

    while firstChild ~= nil do
        local var1 = registry.inline[firstChild.kind] or registry.unknownInline
        local bool1 = false
        if var1.form == "text" then
            table.insert(tbl2, var1.text(firstChild))
        elseif var1.form ~= "drop" then
            local var2 = if firstChild.kind == "HardLineBreak" then "\n" else firstChild.literal
            if type(var2) == "string" then
                table.insert(tbl2, var2)
                bool1 = true
            else
                bool1 = true
            end
        end

        local firstChild2 = if bool1 then firstChild:getFirstChild() else nil

        if firstChild2 == nil then
            while firstChild ~= arg1 and firstChild:getNext() == nil do
                firstChild = firstChild:getParent()
            end
            if firstChild == arg1 then
                firstChild2 = nil
            else
                firstChild2 = firstChild:getNext()
            end
        end

        firstChild = firstChild2
    end

    return table.concat(tbl2)
end

function tbl1:gap(kind, node)
    table.insert(self._run.gaps, { kind = kind, node = node })
end

function tbl1:_units(arg1, bool1: boolean)
    return Children.units(arg1, self._run.registry, bool1)
end

function tbl1._flattenUnits(arg1, units, into, options, node)
    schedule(arg1, { kind = "flatten", into = into, units = units, options = options, node = node, index = 0 })
end

local function callHandler(_run, callback, arg1, into, _token: number?, depth: number)
    local var1 = newContext(_run, into, _token, depth)
    callback(arg1, var1)
    var1._closed = true
    local _pending = var1._pending
    if _pending == nil then
        return
    end

    for i = #_pending, 1, -1 do
        table.insert(_run.stack, _pending[i])
    end
end

local function adaptUnit(_run, unit, into)
    local block = unit.block
    if block == nil then
        local var1 = append(_run, into, "PARAGRAPH")
        table.insert(
            _run.stack,
            {
                kind = "inlines",
                into = var1,
                list = unit.inlines,
                index = 0,
                token = newToken(_run),
                depth = _run.depths[var1]
            }
        )
        return
    end
    local registry = _run.registry
    local var1 = registry.block[block.kind] or registry.unknownBlock
    if var1.form == "as" then
        local var2 = if var1.attributes == nil then nil else var1.attributes(block)
        local var3 = append(_run, into, var1.as, var2)
        table.insert(_run.stack, (childrenFrame(_run, block, var3, nil, _run.depths[var3])))
        return
    end

    if var1.form == "handler" then
        callHandler(_run, var1.handler, block, into, nil, _run.depths[into] or 0)
    end
end

local function adaptInline(_run, arg1, tbl2)
    local registry = _run.registry
    local var1 = registry.inline[arg1.kind] or registry.unknownInline
    local form = var1.form
    local into = tbl2.into
    local token = tbl2.token
    if form == "text" then
        emitText(_run, into, var1.text(arg1), token)
        return
    elseif form == "style" then
        local var2 = append(_run, into, "STYLED_TEXT", { style = var1.style })
        local firstChild = arg1:getFirstChild()
        if firstChild ~= nil then
            table.insert(_run.stack, (inlineChainFrame(firstChild, var2, token, tbl2.depth)))
        end

        return
    end
    if form == "children" then
        local firstChild = arg1:getFirstChild()
        if firstChild ~= nil then
            table.insert(_run.stack, (inlineChainFrame(firstChild, into, token, tbl2.depth)))
        end
    elseif form == "handler" then
        callHandler(_run, var1.handler, arg1, into, token, tbl2.depth)
    end
end

local var1 = table.freeze({})

local function startFlatten(tbl2, tbl3)
    local var2 = tbl3.options or var1
    local var3 = tbl3.units or Children.units(tbl3.node, tbl2.registry, false)
    local except = var2.except
    local tbl4

    if except == nil and not tbl3.inlineOnly then
        tbl4 = var3
    else
        tbl4 = {}
        local afterExcept = ({})
        local bool1 = false
        for _, value in var3 do
            if except ~= nil and value.block == except then
                bool1 = true
            elseif not tbl3.inlineOnly or value.block == nil then
                table.insert(tbl4, value)
                afterExcept[value] = bool1
            end
        end

        tbl3.afterExcept = afterExcept
    end
    tbl3.flattening = FlattenBlocks.start(tbl4, tbl3.into, tbl2.registry, var2.drop)
end

local function finishFlatten(tbl2, tbl3)
    local gap = (tbl3.options or var1).gap
    if gap == nil then
        return
    end
    local var2 = FlattenBlocks.drawnUnits(tbl3.flattening)
    local bool1 = #var2 > 1 or #var2 == 1 and not Children.isParagraphLike(var2[1])
    local afterExcept = tbl3.afterExcept
    if afterExcept ~= nil then
        for _, value in var2 do
            bool1 = bool1 or afterExcept[value] == true
        end
    end
    if bool1 then
        table.insert(tbl2.gaps, { kind = gap, node = tbl3.node })
    end
end

local function stepFlatten(tbl2, tbl3)
    if tbl3.flattening == nil then
        startFlatten(tbl2, tbl3)
    end
    local list, var3 = FlattenBlocks.resume(tbl3.flattening)
    if list == nil and var3 == nil then
        table.remove(tbl2.stack)
        finishFlatten(tbl2, tbl3)
        return
    end
    local into = tbl3.into
    local depth = tbl2.depths[into] or 0
    if list == nil then
        table.insert(tbl2.stack, (inlineChainFrame(var3:getFirstChild(), into, newToken(tbl2), depth)))

        return
    end

    table.insert(
        tbl2.stack,
        {
            kind = "inlines",
            into = into,
            list = list,
            index = 0,
            token = newToken(tbl2),
            depth = depth
        }
    )
end

local function drain(_run)
    local stack = _run.stack
    while #stack > 0 do
        local var2 = stack[#stack]
        local kind = var2.kind
        if kind == "units" then
            var2.index += 1
            local unit = var2.units[var2.index]
            if unit == nil then
                table.remove(stack)
            else
                adaptUnit(_run, unit, var2.into)
            end
        elseif kind == "inlines" then
            local list = var2.list
            local cursor

            if list ~= nil then
                var2.index += 1
                cursor = list[var2.index]
            else
                cursor = var2.cursor
                if cursor ~= nil then
                    var2.cursor = cursor:getNext()
                end
            end
            if cursor == nil then
                stack[#stack] = nil
            else
                adaptInline(_run, cursor, var2)
            end
        else
            stepFlatten(_run, var2)
        end
    end
end

local module = {}

local var2 = table.freeze({})

function module.adapt(registry, node, options)
    local root = RendererNodes.create("ROOT")
    root.index = 1
    root.offset = 1
    local tbl2 = {
        registry = registry,
        root = root,
        stack = {},
        gaps = {},
        options = options or var2,
        lastText = nil,
        lastTextToken = 0,
        textParts = {},
        droppable = {},
        depths = {
            [root] = 0
        },
        lastToken = 0
    }

    table.insert(tbl2.stack, (childrenFrame(tbl2, node, root, nil, 0)))
    drain(tbl2)
    Passes.finish(tbl2.textParts, tbl2.droppable, registry.passes)
    return root, tbl2.gaps
end

return module
