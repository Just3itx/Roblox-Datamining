-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UniversalAppPolicy = script:FindFirstAncestor("UniversalAppPolicy")
local UniversalAppPolicyParent = UniversalAppPolicy.Parent

local Signals = require(UniversalAppPolicyParent.Signals)
local AppFeaturePolicies = require(UniversalAppPolicy.AppFeaturePolicies)
local UniversalAppGetPolicy = require(UniversalAppPolicy.UniversalAppGetPolicy)

local function createAppPolicyStore()
    local getAppPolicy, var2 = Signals.createSignal(AppFeaturePolicies(UniversalAppGetPolicy.read() or {}))

    UniversalAppGetPolicy.onPolicyChanged(function(arg1)
        var2(AppFeaturePolicies(arg1 or {}))
    end)

    return { getAppPolicy = getAppPolicy }
end

return createAppPolicyStore
