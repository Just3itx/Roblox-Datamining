-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local function getCaptureSize(content: Content)
    local success, result = pcall(function(): Vector2
        return CaptureService:GetCaptureSizeAsync(content)
    end)

    return if success and result ~= Vector2.new(0, 0) then result else nil
end

return getCaptureSize
