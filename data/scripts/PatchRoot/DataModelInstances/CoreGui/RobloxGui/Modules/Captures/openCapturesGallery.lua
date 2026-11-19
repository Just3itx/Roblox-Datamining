-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function openCapturesGallery(tbl1): boolean
    local capturesPage = tbl1.Instance.CapturesPage
    if not capturesPage then
        return false
    end

    if tbl1:GetVisibility() then
        tbl1:SwitchToPage(capturesPage, true)
    else
        tbl1:SetVisibility(true, false, capturesPage)
    end

    return true
end

return openCapturesGallery
