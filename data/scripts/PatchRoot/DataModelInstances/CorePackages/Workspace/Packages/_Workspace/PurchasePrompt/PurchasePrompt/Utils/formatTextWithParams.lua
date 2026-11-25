-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatTextWithParams(str1: string, tbl1)
    if tbl1 ~= nil then
        for k, value in pairs(tbl1) do
            local str2 = ("{%s}"):format(k)
            str1 = string.gsub(str1, str2, function()
                return value
            end)
        end
    end
    return str1
end

return formatTextWithParams
