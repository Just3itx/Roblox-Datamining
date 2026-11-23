-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getThumbSizeVectorFromParamString(str1: string)
    local tbl1 = string.split(str1, "&")
    if #tbl1 == 2 then
        local var1 = string.match(tbl1[1], "%d[%d.]*")
        local var2 = string.match(tbl1[2], "%d[%d.]*")
        if var1 and var2 then
            return Vector2.new(tonumber(var1), tonumber(var2))
        end
    end
    return nil
end

return getThumbSizeVectorFromParamString
