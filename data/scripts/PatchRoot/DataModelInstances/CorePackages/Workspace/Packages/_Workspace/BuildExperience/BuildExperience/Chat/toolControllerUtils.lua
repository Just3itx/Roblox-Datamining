-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local Promise = require(BuildExperienceParent.Promise)

local chatConstants = require(script.Parent.chatConstants)
local downloadGeneratedImageAsync = require(BuildExperience.utils.downloadGeneratedImageAsync)
local monetizationFailureCauses = require(BuildExperience.utils.monetizationFailureCauses)

return {
    awaitRequestState = function(arg1, num1: number)
        while arg1(false).status == "pending" do
            if num1 <= os.clock() then
                return arg1(false)
            end
            task.wait()
        end
        return arg1(false)
    end,
    isConversationGone = function(num1: number?): boolean
        return num1 == CreatorAgentChat.ErrorCodes.NotFound or num1 == CreatorAgentChat.ErrorCodes.Gone
    end,
    getToolCallOrder = function(arg1, toolCallId: string)
        for k, activityItem in arg1.activityItems do
            if activityItem.kind == "tool_call" and activityItem.toolCallId == toolCallId then
                return k
            end
        end

        local tbl1 = {}
        for k in arg1.toolCalls do
            table.insert(tbl1, k)
        end
        table.sort(tbl1)
        for value, value2 in tbl1 do
            if value2 == toolCallId then
                return value
            end
        end

        return 0
    end,
    withGeneratedImage = function(num1: number?, str1: string, func1: (...any) -> (...any))
        if num1 == nil then
            return func1(nil)
        end
        return downloadGeneratedImageAsync(num1):timeout(
            chatConstants.CAS_RPC_TIMEOUT_SECONDS,
            monetizationFailureCauses.MESSAGES.imagePreparing
        ):andThen(
            func1,
            function(arg1)
                if typeof(arg1) ~= "string" or monetizationFailureCauses.classify(arg1) == nil then
                    arg1 = monetizationFailureCauses.MESSAGES.imageFailed
                end
                return Promise.reject({ errorMessage = `{str1} {arg1}`, retryable = true })
            end
        )
    end
}
