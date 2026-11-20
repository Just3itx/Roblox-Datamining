-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local _CommonMark = require(MarkdownParent.CommonMark)
local _Registry = require(script.Parent.Registry)

local module = {}

function module.units(arg1, arg2, bool1: boolean)
    local result = {}
    local var1 = nil
    local function flushRun() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var1 ~= nil then
            table.insert(result, { inlines = var1 })
            var1 = nil
        end
    end

    local tbl1 = { arg1:getFirstChild() }
    local num1 = 1

    while num1 > 0 do
        local block = tbl1[num1]
        if block == nil then
            tbl1[num1] = nil
            num1 -= 1
            flushRun()
        else
            tbl1[num1] = block:getNext()
            if block.isBlock then
                local var3 = if bool1 and block.kind == "ListItem" then "handler" else (arg2.block[block.kind] or arg2.unknownBlock).form
                if var3 ~= "drop" then
                    if var3 == "children" then
                        flushRun()
                        num1 += 1
                        tbl1[num1] = block:getFirstChild()
                    else
                        flushRun()
                        table.insert(result, { block = block })
                    end
                end
            elseif var1 == nil then
                var1 = { block }
            else
                table.insert(var1, block)
            end
        end
    end
    return result
end

function module.isList(tbl1): boolean
    local block = tbl1.block
    return not (block == nil) and (block.kind == "BulletList" or block.kind == "OrderedList")
end

function module.isParagraphLike(tbl1): boolean
    local block = tbl1.block
    return block == nil or block.kind == "Paragraph"
end

return module
