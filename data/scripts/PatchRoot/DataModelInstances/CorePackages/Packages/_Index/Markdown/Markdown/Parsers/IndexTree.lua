-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local _Types = require(Markdown.Types)

local function assignIndex(arg1, index: number) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1.index = index
    if not arg1.children then
        return
    end

    for k, child in arg1.children do
        assignIndex(child, k)
    end
end

local function indexTree<T>(arg1: T): T
    assignIndex(arg1, 1)
    return arg1
end

return indexTree
