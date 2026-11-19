-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local VideoCaptureService = game:GetService("VideoCaptureService")

local var1 = nil
VideoCaptureService.DevicesChanged:Connect(function()
    var1 = VideoCaptureService:GetCameraDevices()
end)

return {
    GetDevices = function()
        var1 = var1 or VideoCaptureService:GetCameraDevices()

        return var1
    end
}
