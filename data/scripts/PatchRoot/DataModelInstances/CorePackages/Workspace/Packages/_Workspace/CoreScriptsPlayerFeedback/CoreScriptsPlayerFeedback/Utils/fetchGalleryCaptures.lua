-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function fetchGalleryCaptures(tbl1, tbl2)
    local var1 = tbl2 or { Enum.CaptureType.Screenshot }
    local var2 = if tbl1 ~= nil then tbl1 else game:GetService("CaptureService")

    local success, result = pcall(function()
        local var3, var4 = var2:ReadCapturesFromGalleryAsync(var1, false)
        return if var3 == Enum.ReadCapturesFromGalleryResult.Success then var4 else nil
    end)
    return if success and result ~= nil then result else nil
end

return fetchGalleryCaptures
