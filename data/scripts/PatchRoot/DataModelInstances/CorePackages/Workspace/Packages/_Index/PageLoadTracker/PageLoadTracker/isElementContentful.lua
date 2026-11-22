-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ImageLabel = true,
    ImageButton = true,
    TextLabel = true,
    TextBox = true,
    TextButton = true,
    VideoFrame = true,
    ViewportFrame = true
}

function isElementContentful(arg1)
    return if arg1.Visible and arg1.BackgroundTransparency ~= 1 then tbl1[arg1.ClassName] else false
end

return isElementContentful
