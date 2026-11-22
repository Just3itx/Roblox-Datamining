-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUiParent = script:FindFirstAncestor("PromptsServerDrivenUi").Parent

local getSduiClientPageScope = require(PromptsServerDrivenUiParent.SduiCoreSystem).getSduiClientPageScope

local function setPromptDismissedInPageScope(str1: string, str2: string)
    local sduiClientPageScope = getSduiClientPageScope(str1)
    local var1 = sduiClientPageScope.get("dismissedPromptTypes")
    local var2 = typeof(var1) ~= "table" and {} or table.clone(var1)

    var2[str2] = true
    sduiClientPageScope.set("dismissedPromptTypes", var2)
end

return setPromptDismissedInPageScope
