-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownParent = script:FindFirstAncestor("Markdown").Parent
local var1 = require(MarkdownParent.CommonMark).Internal.BlockQuoteParser.Factory.new()

local function isInsideBlockQuote(arg1) -- Luacid: unused: defined but never referenced
    while arg1 ~= nil do
        if arg1.kind == "BlockQuote" then
            return true
        end
        arg1 = arg1:getParent()
    end
    return false
end

local module = {}

local Factory = {}
Factory.__index = Factory

function Factory.new()
    return (setmetatable({}, Factory))
end

function Factory.tryStart(_, arg1, arg2)
    local var2 = var1:tryStart(arg1, arg2)
    if var2 ~= nil then
        local block = arg2:getMatchedBlockParser():getBlock()
        local bool1

        while true do
            if block == nil then
                bool1 = false
                break
            end

            if block.kind == "BlockQuote" then
                bool1 = true
                break
            end

            block = block:getParent()
        end
        if not bool1 then
            return var2
        end
    end

    return nil
end

module.Factory = Factory

function module.extension()
    return {
        extendParser = function(arg1)
            arg1:customBlockParserFactory(Factory.new())
        end
    }
end

return module
