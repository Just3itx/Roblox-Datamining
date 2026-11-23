-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isMessagePreviewable(tbl1)
    if tbl1.isPreviewable == nil then
        if tbl1.is_previewable == nil then
            return false
        end

        return tbl1.is_previewable
    end

    return tbl1.isPreviewable
end

return isMessagePreviewable
