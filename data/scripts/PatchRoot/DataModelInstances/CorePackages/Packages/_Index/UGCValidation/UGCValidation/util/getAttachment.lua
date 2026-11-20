-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAttachment(arg1, tbl1)
    for _, value in pairs(tbl1) do
        local var1 = arg1:FindFirstChild(value)
        if var1 then
            return if var1:IsA("Attachment") then var1 else var1
        end
    end

    return nil
end

return getAttachment
