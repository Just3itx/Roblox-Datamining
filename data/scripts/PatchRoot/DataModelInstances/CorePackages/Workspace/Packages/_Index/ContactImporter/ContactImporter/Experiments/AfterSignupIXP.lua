-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local IXPService = game:GetService("IXPService")

local useUserExperiment = require(scriptParentParentParent.RoactAppExperiment).useUserExperiment

local FStringPVCIAfterSignupLayer = require(scriptParentParent.Flags.FStringPVCIAfterSignupLayer)
local FStringPVCIAfterSignupVariantKey = require(scriptParentParent.Flags.FStringPVCIAfterSignupVariantKey)

local function func1(arg1)
    return (arg1[FStringPVCIAfterSignupLayer] or {})[FStringPVCIAfterSignupVariantKey]
end

return {
    usePVAndCIAfterSignupVariant = function(tbl1)
        return (useUserExperiment({ FStringPVCIAfterSignupLayer }, func1, (tbl1 or { isExposureEnabled = false }).isExposureEnabled))
    end,
    logExposure = function()
        IXPService:LogUserLayerExposure(FStringPVCIAfterSignupLayer)
    end
}
