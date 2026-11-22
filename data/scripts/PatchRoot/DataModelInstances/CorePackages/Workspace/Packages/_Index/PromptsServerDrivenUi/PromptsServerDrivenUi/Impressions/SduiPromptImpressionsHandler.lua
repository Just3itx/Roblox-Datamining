-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUiParent = script:FindFirstAncestor("PromptsServerDrivenUi").Parent

local SduiErrorType = require(PromptsServerDrivenUiParent.SduiCoreSystem).SduiErrors.SduiErrorType

local ServerTriggeredModalImpressions = require(PromptsServerDrivenUiParent.ServerTriggeredModalImpressions)
local postPromptImpression = ServerTriggeredModalImpressions.postPromptImpression
local sendModalImpressionEvent = ServerTriggeredModalImpressions.sendModalImpressionEvent

local tbl1 = {}

local function SduiPromptImpressionsHandler(arg1, tbl2, tbl3, _, _: number?)
    tbl3 = tbl3 or tbl1

    if #tbl2 == 0 or #tbl3 == 0 then
        arg1.dependencies.logger.reportError(SduiErrorType.FailedToLogPromptImpressions, {
            name = "SduiPromptImpressionsHandler",
            message = `No entries to log: impressionIndexes={#tbl2}, itemAnalyticsDatas={#tbl3}`
        }, arg1.appPage)
        return
    end

    for _, value in tbl2 do
        local var1 = tbl3[value] or tbl1

        if typeof(var1.promptType) ~= "string" then
            arg1.dependencies.logger.reportError(
                SduiErrorType.FailedToLogPromptImpressions,
                {
                    name = "SduiPromptImpressionsHandler",
                    message = `Missing promptType at index {value}`
                },
                arg1.appPage
            )
        elseif typeof(var1.promptId) ~= "string" then
            arg1.dependencies.logger.reportError(
                SduiErrorType.FailedToLogPromptImpressions,
                {
                    name = "SduiPromptImpressionsHandler",
                    message = `Missing promptId at index {value}`
                },
                arg1.appPage
            )
        else
            postPromptImpression(arg1.dependencies.networking, var1.promptType, var1.promptId):catch(function()
                arg1.dependencies.logger.reportError(
                    SduiErrorType.FailedToLogPromptImpressions,
                    {
                        name = "SduiPromptImpressionsHandler",
                        message = `Failed to POST prompt impression for {var1.promptType}`
                    },
                    arg1.appPage
                )
            end)

            sendModalImpressionEvent(var1.promptId, var1.promptType)
        end
    end
end
return SduiPromptImpressionsHandler
