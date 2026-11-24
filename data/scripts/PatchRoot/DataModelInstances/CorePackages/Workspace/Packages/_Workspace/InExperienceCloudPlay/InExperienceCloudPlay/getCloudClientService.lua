-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("CloudClientSessionApi")

local function getCloudClientService(arg1)
    if not engineFeature then
        return nil
    end
    return ((arg1 or game):GetService("CloudClientService"))
end

return getCloudClientService
