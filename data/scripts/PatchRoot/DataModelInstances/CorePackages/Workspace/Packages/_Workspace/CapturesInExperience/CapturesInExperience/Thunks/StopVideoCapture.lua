-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CaptureService = game:GetService("CaptureService")

local engineFeature = game:GetEngineFeature("EnableVideoCaptureApiLua")

return function()
    return function(_)
        if engineFeature then
            CaptureService:StopVideoCaptureInternal()
        end
    end
end
