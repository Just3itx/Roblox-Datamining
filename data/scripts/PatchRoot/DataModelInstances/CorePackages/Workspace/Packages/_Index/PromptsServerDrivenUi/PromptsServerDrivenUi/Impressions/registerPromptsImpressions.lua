-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUi = script:FindFirstAncestor("PromptsServerDrivenUi")
local PromptsServerDrivenUiParent = PromptsServerDrivenUi.Parent

local SduiCoreSystem = require(PromptsServerDrivenUiParent.SduiCoreSystem)
local SduiImpressionEventType = SduiCoreSystem.SduiImpressionEventType
local getSduiImpressionHandlerRegistry = SduiCoreSystem.getSduiImpressionHandlerRegistry

local function registerPromptsImpressions()
    local tbl1 = {
        [SduiImpressionEventType.promptImpressions] = {
            lazyHandler = function()
                return require(PromptsServerDrivenUi.Impressions.SduiPromptImpressionsHandler)
            end,
            skipItemImpressionsLog = false
        }
    }

    getSduiImpressionHandlerRegistry().registerImpressionHandlerConfigs(tbl1)
end

return registerPromptsImpressions
