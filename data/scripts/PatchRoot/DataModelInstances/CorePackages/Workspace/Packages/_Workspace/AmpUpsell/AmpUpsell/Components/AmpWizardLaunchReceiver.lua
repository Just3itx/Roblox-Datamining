-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent

local React = require(AmpUpsellParent.React)
local useDispatch = require(AmpUpsellParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppAmpWizardLaunchBridge = require(AmpUpsell.Common.AppAmpWizardLaunchBridge)
local OpenAmpWizardContainer = require(AmpUpsell.Common.OpenAmpWizardContainer)

local function AmpWizardLaunchReceiver()
    local var1 = useDispatch()

    React.useEffect(function()
        local var2 = AppAmpWizardLaunchBridge.subscribe(function(arg1)
            var1(OpenAmpWizardContainer(arg1.featureName, arg1.completionCallback or function() end, arg1.recourseData, arg1.entryPointEventCtx, arg1.extraParameters, arg1.nameSpace, nil, nil, nil, arg1.usePrologue, arg1.prologueOptions))
        end)

        return function()
            var2:disconnect()
        end
    end, { var1 })

    return nil
end

return AmpWizardLaunchReceiver
