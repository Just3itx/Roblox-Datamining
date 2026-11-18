-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:31:24Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function splitStringWithMarks(arg1, tbl1: {string})
    if type(arg1) ~= "string" or type(tbl1) ~= "table" then
        return arg1, ""
    end

    for _, value in ipairs(tbl1) do
        local var1, var2 = arg1.find(arg1, value, nil, true)

        if var1 ~= nil then
            return arg1.sub(arg1, 1, var1 - 1), (arg1.sub(arg1, var2 + 1))
        end
    end

    return arg1, ""
end

local function findFileNameFromPath(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) ~= "string" then
        return ""
    end

    return string.match(arg1, "([^.]*)$")
end

local function ProcessErrorStack(arg1, arg2)
    local tbl1 = {}
    local tbl2 = ({})

    local var1 = arg2 or 0

    if type(arg1) ~= "string" then
        return tbl1, tbl2
    end

    for value in arg1:gmatch("[^\r\n]+") do
        local var2, var3 = splitStringWithMarks(value, { ", line ", ", Line ", ":" })
        local var4, fileNameFromPath = splitStringWithMarks(var3, { " - " })
        local var5

        if fileNameFromPath == "" and var4 ~= "" then
            local var6
            var5, var6 = string.match(var4, "^(%d+)%s*(.*)")
            if var5 then
                if var6 ~= "" then
                    fileNameFromPath = var6
                end
            else
                var5 = var4
            end
        else
            var5 = var4
        end

        if var5 == "" or var2 == "" then
            continue
        end
        local _, _, var6 = string.find(var2, "Script '(.*)'")
        if var6 == nil then
            var6 = var2
        end

        arg2 = tbl2[var6]
        if arg2 == nil then
            arg2 = var1 + 1

            tbl2[var6] = arg2
            var1 = arg2
        end

        if fileNameFromPath == "" then
            fileNameFromPath = findFileNameFromPath(var6)
        end

        table.insert(tbl1, { line = var5, funcName = fileNameFromPath, sourceCode = tostring(arg2) })
    end

    local tbl3 = {}
    for path, value in pairs(tbl2) do
        tbl3[tostring(value)] = { path = path }
    end

    return tbl1, tbl3, var1
end

return ProcessErrorStack
