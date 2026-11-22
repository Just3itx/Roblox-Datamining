-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _SplitPaneEducationalTourSteps = require(script.Parent.SplitPaneEducationalTourSteps)

local function getSplitPaneEducationalTourVideoAssetId(arg1, bool1: boolean, bool2: boolean)
    if bool2 then
        if bool1 and arg1.collapsedGamepadVideoAssetId ~= nil then
            return arg1.collapsedGamepadVideoAssetId
        end

        if arg1.collapsedVideoAssetId ~= nil then
            return arg1.collapsedVideoAssetId
        end
    end
    return if bool1 and arg1.gamepadVideoAssetId ~= nil then arg1.gamepadVideoAssetId else arg1.videoAssetId
end

return getSplitPaneEducationalTourVideoAssetId
