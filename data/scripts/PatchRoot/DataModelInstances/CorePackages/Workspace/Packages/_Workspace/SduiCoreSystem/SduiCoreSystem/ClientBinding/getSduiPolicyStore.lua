-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent
local Signals = require(SduiCoreSystemParent.Signals)
local _UniversalAppPolicy = require(SduiCoreSystemParent.UniversalAppPolicy)

local function createSduiPolicyStore() -- Luacid: Inlined by compiler; 1 call site recovered
    local getAppPolicy, setAppPolicy = Signals.createSignal(nil)

    return { getAppPolicy = getAppPolicy, setAppPolicy = setAppPolicy }
end

local var1 = nil

local function getSduiPolicyStore()
    if var1 == nil then
        var1 = createSduiPolicyStore()
    end
    return var1
end

return getSduiPolicyStore
