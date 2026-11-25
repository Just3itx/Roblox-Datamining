-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local createSduiFocusActivationStore = require(SduiSharedUtilities.FocusNavigation.createSduiFocusActivationStore)

local var1 = nil

local function getSduiFocusActivationStore()
    if var1 == nil then
        var1 = createSduiFocusActivationStore()
    end
    return var1
end

return getSduiFocusActivationStore
