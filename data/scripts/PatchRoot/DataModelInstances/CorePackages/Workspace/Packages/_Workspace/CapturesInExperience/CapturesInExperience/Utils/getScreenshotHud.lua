-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

return function(): ScreenshotHud?
    return GuiService:FindFirstChildWhichIsA("ScreenshotHud")
end
