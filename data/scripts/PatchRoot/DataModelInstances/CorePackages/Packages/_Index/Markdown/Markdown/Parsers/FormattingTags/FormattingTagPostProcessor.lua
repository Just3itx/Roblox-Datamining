-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local _CommonMark = require(MarkdownParent.CommonMark)
local FormattingTag = require(script.Parent.FormattingTag)

local TAGS = FormattingTag.TAGS

local module = {}
module.__index = module

function module.new(_maxNesting: number?)
    return (setmetatable({ _maxNesting = _maxNesting }, module))
end

local function tagOf(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.kind == "FormattingTagText" or arg1.kind == "HtmlInline" then TAGS[arg1.literal] else nil
end

local function containersTopDown(arg1)
    local tbl1 = {
        [arg1] = 0
    }
    local tbl2 = { arg1 }
    local tbl3 = {}

    while #tbl2 > 0 do
        local var1 = table.remove(tbl2)
        if var1:getFirstChild() == nil then
            continue
        end

        table.insert(tbl3, var1)
        local firstChild = var1:getFirstChild()
        while firstChild do
            tbl1[firstChild] = tbl1[var1] + (if firstChild.isBlock then 0 else 1)
            table.insert(tbl2, firstChild)
            firstChild = firstChild:getNext()
        end
    end

    return tbl3, tbl1
end

local function wrap(arg1, arg2, name, tbl1, num1: number?): boolean
    local next = arg1:getNext()
    local num2 = 0

    while next ~= arg2 do
        num2 = math.max(num2, tbl1[next] or 0)
        next = next:getNext()
    end
    if num1 ~= nil and num1 <= num2 then
        return false
    end

    local formattingTag = FormattingTag.new(name)
    arg1:insertBefore(formattingTag)
    local next2 = arg1:getNext()
    while next2 ~= arg2 do
        local next3 = next2:getNext()
        formattingTag:appendChild(next2)
        next2 = next3
    end

    arg1:unlink()
    arg2:unlink()
    tbl1[formattingTag] = num2 + 1
    return true
end

local function pairChildren(arg1, tbl1, num1: number?)
    local firstChild = arg1:getFirstChild()
    local tbl2 = {
        b = {},
        i = {},
        u = {},
        s = {}
    }
    local tbl3 = ({})
    local tbl4 = ({})

    while firstChild ~= nil do
        local next = firstChild:getNext()
        local var1 = tagOf(firstChild)

        if var1 ~= nil then
            local var2 = tbl2[var1.name]
            if not var1.closing then
                table.insert(tbl3, firstChild)
                table.insert(tbl4, var1.name)
                table.insert(var2, #tbl3)
            else
                local var3 = var2[#var2]
                if var3 ~= nil then
                    local var4 = tbl3[var3]
                    for i = #tbl3, var3, -1 do
                        table.remove(tbl2[tbl4[i]])
                        tbl3[i] = nil
                        tbl4[i] = nil
                    end
                    if not wrap(var4, firstChild, var1.name, tbl1, num1) then
                        for i = #tbl3, 1, -1 do
                            table.remove(tbl2[tbl4[i]])
                            tbl3[i] = nil
                            tbl4[i] = nil
                        end
                    end
                end
            end
        end

        firstChild = next
    end
end

function module:process<T>(arg1: T): T
    local tbl1 = ({})
    local tbl2, tbl3 = containersTopDown(arg1)
    local _maxNesting = self._maxNesting
    for i = #tbl2, 1, -1 do
        local var1 = tbl2[i]
        local var2 = if _maxNesting == nil then nil else _maxNesting - tbl3[var1]
        pairChildren(var1, tbl1, var2)
        if var1.isBlock then
            continue
        end
        local firstChild = var1:getFirstChild()
        local num1 = 0

        while firstChild ~= nil do
            num1 = math.max(num1, tbl1[firstChild] or 0)
            firstChild = firstChild:getNext()
        end
        tbl1[var1] = num1 + 1
    end

    return arg1
end

return module
