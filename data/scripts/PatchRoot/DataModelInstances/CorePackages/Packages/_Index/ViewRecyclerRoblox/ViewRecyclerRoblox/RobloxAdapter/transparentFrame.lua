-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function transparentFrame(frameName: string): Frame
    local frame = Instance.new("Frame")
    frame.Name = frameName
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    return frame
end

return transparentFrame
