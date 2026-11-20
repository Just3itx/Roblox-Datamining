-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function dumpProperty(arg1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return arg1[str1]
    end)
    if success then
        return tostring(result)
    end

    return nil
end

local function dumpInstance(arg1, tbl1)
    local name = arg1.Name
    local bool1 = false
    for _, value in tbl1 or {} do
        local var1 = dumpProperty(arg1, value)

        if not var1 then
            continue
        end

        local var2

        if not bool1 then
            var2 = name .. "   ("
            bool1 = true
        else
            var2 = name .. ", "
        end
        name = var2 .. value .. "=" .. var1
    end

    if bool1 then
        name ..= ")"
    end

    return name .. "\n"
end

local function dumpInstanceTree(arg1, tbl1, str1: string)
    if arg1 == nil then
        return str1 .. "[nil Instance]\n"
    end

    if arg1.Name == nil then
        return str1 .. "[Invalid Instance]\n"
    end
    local var1 = str1 .. dumpInstance(arg1, tbl1)

    for _, child in arg1:GetChildren() do
        var1 ..= dumpInstanceTree(child, tbl1, str1 .. "   ")
    end
    return var1
end

return function(arg1, tbl1)
    return (dumpInstanceTree(arg1, tbl1, ""))
end
