-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScript = script:FindFirstAncestor("ExperienceLoadingScript")
local ExperienceLoadingScriptParent = ExperienceLoadingScript.Parent

local CachedPolicyService = require(ExperienceLoadingScriptParent.CachedPolicyService)
local SetIsSubjectToChinaPolicies = require(ExperienceLoadingScript.Actions.SetIsSubjectToChinaPolicies)

return function()
    return function(arg1)
        coroutine.wrap(function()
            local isSubjectToChinaPolicies = CachedPolicyService:IsSubjectToChinaPolicies()
            arg1:dispatch(SetIsSubjectToChinaPolicies(isSubjectToChinaPolicies))
        end)()
    end
end
