-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppInteractionFeedbackConfigParent = script:FindFirstAncestor("RobloxAppInteractionFeedbackConfig").Parent
local React = require(RobloxAppInteractionFeedbackConfigParent.React)
local Responsive = require(RobloxAppInteractionFeedbackConfigParent.Responsive)
local AppUserLayers = require(RobloxAppInteractionFeedbackConfigParent.ExperimentLayers).AppUserLayers
local RoactAppExperiment = require(RobloxAppInteractionFeedbackConfigParent.RoactAppExperiment)
local InteractionFeedbackContext = require(RobloxAppInteractionFeedbackConfigParent.InteractionFeedback).InteractionFeedbackContext
local SpatialConfig = require(script.Parent.SpatialConfig)
local DirectionalConfig = require(script.Parent.DirectionalConfig)
local PointerConfig = require(script.Parent.PointerConfig)
local TouchConfig = require(script.Parent.TouchConfig)

local useUserExperiment = RoactAppExperiment.useUserExperiment
local bool1 = game:DefineFastFlag("MobileSoundAndHapticsEnabledIXP", false)
local bool2 = game:DefineFastFlag("MobileSoundAndHapticsIXPBypass", false)

local function InteractionFeedbackProvider(tbl1)
    local var1 = Responsive.useLastInput()
    local var2 = Responsive.useIsSpatial()
    local var3 = if bool1 then useUserExperiment({ AppUserLayers.MobileSoundAndHapticsLayer }, function(arg1)
        return (arg1[AppUserLayers.MobileSoundAndHapticsLayer] or {}).mobileSoundAndHapticsEnabled
    end) else nil

    local value = React.useMemo(function()
        if var2 then
            return SpatialConfig
        end

        if var1 == Responsive.Input.Touch then
            if bool2 or bool1 and var3 then
                return TouchConfig
            end

            return {}
        end

        if var1 == Responsive.Input.Directional then
            return DirectionalConfig
        end

        if var1 == Responsive.Input.Pointer then
            return PointerConfig
        end

        return {}
    end, { var2, var1 })

    return React.createElement(InteractionFeedbackContext.Provider, { value = value }, tbl1.children)
end

return InteractionFeedbackProvider
