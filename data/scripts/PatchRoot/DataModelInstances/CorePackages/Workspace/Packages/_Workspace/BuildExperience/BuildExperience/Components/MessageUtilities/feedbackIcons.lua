-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Promise = require(BuildExperienceParent.Promise)

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FeedbackAction = require(script.Parent.FeedbackAction)
local _UserFeedback = require(script.Parent.UserFeedback)
local GetAgentRollbackRequestStore = require(BuildExperience.Stores.GetAgentRollbackRequestStore)

local IconName = Foundation.Enums.IconName
local debug2 = CreatorAgentChat.debug
local num1 = game:DefineFastInt("BuildAgentRollbackNoteTimeoutSeconds", 5)

local function getRollbackTargetVersionNumber(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1.rollbackTargetVersionNumber ~= nil then
        return arg1.rollbackTargetVersionNumber
    end

    local publishedVersionNumber = arg1.publishedVersionNumber
    return if publishedVersionNumber == nil or not (publishedVersionNumber > 1) then nil else publishedVersionNumber - 1
end

local function formatDebugValue(rawError) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(rawError) == "table" then
        local success, result = pcall(function(): string
            return HttpService:JSONEncode(rawError)
        end)
        if success then
            return result
        end
    end
    return tostring(rawError)
end

local function getVersionNumber(arg1): number? -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber(arg1.version)
end

local function findVersionNote(arg1, num2: number)
    if arg1 == nil or typeof(arg1.placeVersions) ~= "table" then
        return nil
    end

    for _, placeVersion in arg1.placeVersions do
        if getVersionNumber(placeVersion) == num2 then
            return {
                title = placeVersion.title,
                description = placeVersion.description
            }
        end
    end

    return nil
end

local function fetchVersionNote(arg1, num2: number, num3: number, cursor: string?, num4: number)
    if num4 <= 0 then
        return Promise.resolve(nil)
    end
    return arg1.fetchPageHistory(num2, { cursor = cursor }):andThen(function(arg2)
        local versionNote = findVersionNote(arg2, num3)
        if versionNote ~= nil then
            return versionNote
        elseif arg2.nextCursor ~= nil and arg2.nextCursor ~= "" then
            return fetchVersionNote(arg1, num2, num3, arg2.nextCursor, num4 - 1)
        end

        return nil
    end)
end

return {
    canRevert = function(arg1): boolean
        return not (arg1.placeId == nil) and getRollbackTargetVersionNumber(arg1) ~= nil
    end,
    getRollbackTargetVersionNumber = getRollbackTargetVersionNumber,
    getFeedbackIcons = function(tbl1)
        local feedbackIcons = {}
        if tbl1 ~= nil and tbl1.includeCopy then
            table.insert(
                feedbackIcons,
                {
                    iconName = tbl1.copyIconName or IconName.TwoStackedSquares,
                    action = FeedbackAction.COPY,
                    testId = tbl1.copyTestId
                }
            )
        end

        local isRatingDisabled = if tbl1 == nil then nil else tbl1.isRatingDisabled
        table.insert(
            feedbackIcons,
            {
                iconName = IconName.ThumbUp,
                action = FeedbackAction.THUMBS_UP,
                isDisabled = isRatingDisabled
            }
        )
        table.insert(
            feedbackIcons,
            {
                iconName = IconName.ThumbDown,
                action = FeedbackAction.THUMBS_DOWN,
                isDisabled = isRatingDisabled
            }
        )

        if tbl1 ~= nil and tbl1.includeRevert then
            table.insert(feedbackIcons, {
                iconName = IconName.ArrowCurlToLeft,
                action = FeedbackAction.REVERT,
                isDisabled = tbl1.isRevertDisabled,
                allowRepeatedActivation = true
            })
        end

        return feedbackIcons
    end,
    requestAgentRollback = function(feedbackIds)
        local placeId = feedbackIds.placeId
        local rollbackTargetVersionNumber = getRollbackTargetVersionNumber(feedbackIds)

        if placeId == nil or rollbackTargetVersionNumber == nil then
            debug2.log("warn", "agent feedback revert missing rollback ids", { feedbackIds = feedbackIds })

            return Promise.reject("agent_rollback_missing_ids")
        end

        local agentRollbackRequestStore = GetAgentRollbackRequestStore(false)
        local var1, var2 = agentRollbackRequestStore.beginRequest({ universeId = feedbackIds.universeId, placeId = placeId })

        if var1 ~= nil then
            local placeVersionHistoryStore = PlaceVersionHistory.getPlaceVersionHistoryStore()
            local num2 = 3

            placeVersionHistoryStore.fetchPageHistory(placeId, { cursor = nil }):andThen(function(arg1)
                local versionNote = findVersionNote(arg1, rollbackTargetVersionNumber)
                if versionNote ~= nil then
                    return versionNote
                elseif arg1.nextCursor ~= nil and arg1.nextCursor ~= "" then
                    return fetchVersionNote(placeVersionHistoryStore, placeId, rollbackTargetVersionNumber, arg1.nextCursor, num2 - 1)
                end

                return nil
            end):timeout(num1):catch(function(rawError)
                local log = debug2.log
                local tbl1 = {
                    placeId = placeId,
                    restoredVersion = rollbackTargetVersionNumber,
                    error = 0,
                    rawError = 0
                }
                local error = formatDebugValue(rawError)
                local str1 = "warn"
                local str2 = "agent feedback revert source note load failed"
                tbl1.error = error
                tbl1.rawError = rawError
                log(str1, str2, tbl1)

                return nil
            end):andThen(function(arg1)
                agentRollbackRequestStore.setRequestData(var1, {
                    versionNumber = rollbackTargetVersionNumber,
                    noteTitle = if arg1 == nil then nil else arg1.title,
                    noteDescription = if arg1 == nil then nil else arg1.description
                })
            end):catch(
                function(rawError)
                    local log = debug2.log
                    local tbl1 = {
                        placeId = placeId,
                        restoredVersion = rollbackTargetVersionNumber,
                        error = 0,
                        rawError = 0
                    }
                    local error = formatDebugValue(rawError)
                    local str1 = "warn"
                    local str2 = "agent feedback revert request preparation failed"
                    tbl1.error = error
                    tbl1.rawError = rawError
                    log(str1, str2, tbl1)

                    agentRollbackRequestStore.failRequest(var1)
                end
            )
        end

        return var2:catch(function(rawError)
            local log = debug2.log
            local tbl1 = {
                placeId = placeId,
                versionToRollback = rollbackTargetVersionNumber,
                error = 0,
                rawError = 0
            }
            local var3 = formatDebugValue(rawError)
            local str1 = "warn"
            local str2 = "agent feedback revert request failed"
            tbl1.error = var3
            tbl1.rawError = rawError
            log(str1, str2, tbl1)

            error(rawError)
        end)
    end
}
