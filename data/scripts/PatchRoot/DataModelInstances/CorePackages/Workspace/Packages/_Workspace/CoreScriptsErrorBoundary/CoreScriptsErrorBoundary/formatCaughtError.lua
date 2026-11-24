-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatCaughtError(arg1, tbl1)
    local str1 = `[CoreScriptsErrorBoundary surface={tbl1.surface}]`
    if tbl1.componentStack then
        str1 ..= tbl1.componentStack
    end

    if typeof(arg1) ~= "table" or arg1.message == nil or arg1.stack == nil then
        return tostring(arg1) .. "\n" .. str1
    end

    return str1 .. "\n------ Error caught by React ------\n" .. tostring(arg1.message) .. "\n------ Error caught by React ------\n" .. tostring(arg1.stack)
end

return formatCaughtError
