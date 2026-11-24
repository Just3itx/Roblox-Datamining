-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeParent = script:FindFirstAncestor("Chrome").Parent

local SharedFlags = require(ChromeParent.SharedFlags)

local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagExperienceMenuGamepadExposureEnabled = SharedFlags.FFlagExperienceMenuGamepadExposureEnabled

game:DefineFastFlag("EnableInGameMenuChrome", false)
local bool1 = game:DefineFastFlag("DebugEnableChromeOnUnsupportedDevices", false)

local VRService = game:GetService("VRService")
local var1 = require(ChromeParent.AppCommonLib).isTenFootInterface()
local isInExperienceUIVREnabled = require(ChromeParent.SharedExperimentDefinition).isInExperienceUIVREnabled

return function(): boolean
    if bool1 then
        return true
    elseif VRService.VREnabled then
        return not not isInExperienceUIVREnabled
    elseif FFlagExperienceMenuGamepadExposureEnabled then
        return true
    elseif var1 and not FFlagEnableConsoleExpControls then
        return false
    end

    return game:GetFastFlag("EnableInGameMenuChrome")
end
