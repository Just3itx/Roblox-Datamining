-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local var1 = require(InlineRichText.Logger):new(script.Name)

local Cryo = require(InlineRichTextParent.Cryo)

local tbl1 = ({})

local function getMemoKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return `${str1}___${str2}`
end

local function getMemo(str1: string, str2: string, str3: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local memoKey = getMemoKey(str2, str3)

    return tbl1[str1][memoKey]
end

local function setMemo(str1: string, str2: string, str3: string, bool1: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    local memoKey = getMemoKey(str2, str3)

    tbl1[str1][memoKey] = bool1
end

local function isDescendant(tbl2, str1: string, str2: string, str3: string)
    if not tbl1[str1] then
        tbl1[str1] = {}
    end

    local tbl3 = ({})
    local function dfs(str4: string)
        tbl3[str4] = true
        local memo = getMemo(str1, str4, str3)
        if memo ~= nil then
            return memo
        end
        local var2 = tbl2[str4]
        if not var2 then
            var1:error(`Node {str4} not found in graph`)
            setMemo(str1, str4, str3, false)
            return false
        end

        if var2.children[str3] then
            setMemo(str1, str4, str3, true)
            return true
        end

        local bool1 = false

        for _, value in (Cryo.List.filter(Cryo.Dictionary.keys(var2.children), function(arg1): boolean
            return not not (not tbl3[arg1] and var2.children[arg1])
        end)) do
            if dfs(value) then
                bool1 = true
                break
            end
        end

        setMemo(str1, str4, str3, bool1)
        return bool1
    end
    return (dfs(str2))
end

return isDescendant
