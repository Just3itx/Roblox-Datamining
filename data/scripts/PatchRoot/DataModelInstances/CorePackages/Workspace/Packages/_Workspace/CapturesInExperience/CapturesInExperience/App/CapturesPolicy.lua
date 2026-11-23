-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local PolicyProvider = require(scriptParentParentParent.PolicyProvider)

local PolicyImplementation = PolicyProvider.GetPolicyImplementations.MemStorageService("app-policy")
local var2 = PolicyProvider.withGetPolicyImplementation(PolicyImplementation)

function var2.Mapper(arg1)
    return {
        eligibleForCapturesFeature = function()
            return arg1.EligibleForCapturesFeature or false
        end,
        eligibleForVideoCapture = function()
            return arg1.EligibleForVideoCapture or false
        end,
        enableCapturesBulkManagement = function()
            return arg1.EnableCapturesBulkManagement or false
        end,
        enableShareCaptureCTA = function()
            return arg1.EnableShareCaptureCTA or false
        end,
        hasVideoCaptureCapability = function()
            return arg1.HasVideoCaptureCapability or false
        end
    }
end

var2.PolicyImplementation = PolicyImplementation

return var2
