-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Registry = require(script.Parent.Registry)
local RendererNodes = require(script.Parent.RendererNodes)
local _Types = require(Markdown.Types)

local var1 = table.freeze({ QUOTE = true })

local module = {}

function module.isDroppable(str1: string): boolean
    return var1[str1] == true
end

function module.finish(tbl1, tbl2, arg1)
    for value, value2 in tbl1 do
        value.text = table.concat(value2)
    end
    if not arg1.dropEmpty then
        return
    end
    local tbl3 = ({})
    local tbl4 = ({})
    for value, value2 in tbl2 do
        if #value.children == 0 then
            tbl3[value] = true
            tbl4[value2] = true
        end
    end
    for value in tbl4 do
        local children = value.children
        local num1 = 0
        for i = 1, #children do
            local child = children[i]
            if not tbl3[child] then
                num1 += 1
                children[num1] = child
                child.index = num1
                child.offset = RendererNodes.offsetAt(value, child, num1)
            end
        end
        for i = #children, num1 + 1, -1 do
            children[i] = nil
        end
    end
end

return module
