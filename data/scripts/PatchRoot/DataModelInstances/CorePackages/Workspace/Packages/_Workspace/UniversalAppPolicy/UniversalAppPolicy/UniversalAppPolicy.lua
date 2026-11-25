-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local PolicyProvider = require(scriptParentParent.PolicyProvider)

local UniversalAppGetPolicy = require(script.Parent.UniversalAppGetPolicy)

return (PolicyProvider.withGetPolicyImplementation(UniversalAppGetPolicy))
