-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local FFlagBuildExperienceDevProductModerationReadback = require(BuildExperience.Flags.FFlagBuildExperienceDevProductModerationReadback)
local wasDeveloperProductTextModerated = require(BuildExperience.utils.wasDeveloperProductTextModerated)

local _chatTypes = require(script.Parent.chatTypes)
local chatConstants = require(script.Parent.chatConstants)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local createManageDevProductStore = require(script.Parent.createManageDevProductStore)
local FFlagBuildExperienceDevProductRecovery = require(BuildExperience.Flags.FFlagBuildExperienceDevProductRecovery)

local FFlagBuildExperienceMonetizationFailureCauses = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationFailureCauses)

local FFlagBuildExperienceRemoveDevProductPriceCap = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceRemoveDevProductPriceCap
local toolControllerUtils = require(script.Parent.toolControllerUtils)
local monetizationFailureCauses = require(BuildExperience.utils.monetizationFailureCauses)
local downloadGeneratedImageAsync = require(BuildExperience.utils.downloadGeneratedImageAsync)

local StudioManageDevProductTool = CreatorAgentChat.StudioManageDevProductTool
local debug2 = CreatorAgentChat.debug
local awaitRequestState = toolControllerUtils.awaitRequestState
local getToolCallOrder = toolControllerUtils.getToolCallOrder

local manageDevProductStore = createManageDevProductStore()

local function awaitPromise(arg1)
    local var1 = nil
    local var2 = nil
    local bool1 = false
    arg1:andThen(function(arg2)
        var1 = arg2
        bool1 = true
    end, function(arg2)
        var2 = arg2
        bool1 = true
    end)
    local var3 = os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS
    while not bool1 and os.clock() < var3 do
        task.wait()
    end
    if not bool1 then
        arg1:cancel()
        var2 = "The request timed out and its outcome is unknown. List developer products before retrying."
    end

    local var4, var5 = var1, var2
    return var4, var5
end

local function messageFromRejection(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "table" and typeof(arg1.errorMessage) == "string" then
        return arg1.errorMessage
    elseif arg1 == nil then
        return "The request timed out."
    end
    return tostring(arg1)
end

local function detailCodeForFailure(action: string, str1: string): string
    local str2 = string.lower(str1)

    if string.find(str2, "outcome is unknown", 1, true) then
        return "outcome_unknown"
    end

    if string.find(str2, "universe", 1, true) and string.find(str2, "publish", 1, true) then
        return "universe_not_published"
    end

    return action .. "_failed"
end

local function describeImageFailure(str1: string?)
    if str1 == nil or string.find(string.lower(str1), "outcome is unknown", 1, true) then
        return monetizationFailureCauses.MESSAGES.imageTimedOut
    end

    if monetizationFailureCauses.classify(str1) == nil then
        return monetizationFailureCauses.MESSAGES.imageFailed
    end

    return str1
end

local function awaitMutation(arg1)
    local var1, var2 = awaitPromise(arg1)
    if var1 ~= nil then
        return var1, nil
    end

    local product = if typeof(var2) == "table" then var2.product else nil
    local responseCode = if typeof(var2) == "table" then var2.responseCode else nil
    local bool1 = product == nil and responseCode == 429
    local var3 = if FFlagBuildExperienceDevProductModerationReadback and typeof(var2) == "table" and var2.outcome == "unverified" then "readback_unverified" else nil

    return product, messageFromRejection(var2), bool1, var3
end

local function proposalFromFlow(tbl1, isApproved: boolean?, isRejected: boolean?)
    return {
        toolCallId = tbl1.toolCallId,
        callOrder = tbl1.callOrder,
        action = tbl1.action,
        name = tbl1.name,
        description = tbl1.description,
        priceInRobux = tbl1.priceInRobux,
        productId = tbl1.productId,
        imageAssetId = tbl1.imageAssetId,
        isApproved = isApproved,
        isRejected = isRejected,
        isPending = if FFlagBuildExperienceDevProductRecovery then tbl1.isPending else nil,
        hasError = if FFlagBuildExperienceDevProductRecovery then not (tbl1.resultError == nil) and not isRejected else nil,
        errorCause = if FFlagBuildExperienceDevProductRecovery
            and FFlagBuildExperienceMonetizationFailureCauses
            and tbl1.resultError ~= nil
            and not isRejected then monetizationFailureCauses.classify(tbl1.resultError) or (if tbl1.canRetry then "rateLimited" else nil) else nil,
        canRetry = if FFlagBuildExperienceDevProductRecovery then tbl1.canRetry and not isRejected else nil
    }
end

local function moderationError(tbl1, arg1)
    if tbl1.action ~= "create" and tbl1.action ~= "update" then
        return nil
    end

    local bool1, bool2

    if FFlagBuildExperienceDevProductModerationReadback then
        bool1 = wasDeveloperProductTextModerated(tbl1.name, arg1.name)
        bool2 = wasDeveloperProductTextModerated(tbl1.description, arg1.description)
    else
        if tbl1.name == nil or arg1.name == nil then
            bool1 = false
        else
            bool1 = arg1.name ~= tbl1.name
        end

        if tbl1.description == nil or tbl1.description == "" or arg1.description == nil then
            bool2 = false
        else
            bool2 = arg1.description ~= tbl1.description
        end
    end

    if not (bool1 or bool2) then
        return nil
    end

    local var1 = if FFlagBuildExperienceMonetizationFailureCauses then monetizationFailureCauses.MESSAGES.moderated .. " Do not create another product; product %s already exists. Ask the creator for plainer wording and update this product." else monetizationFailureCauses.MESSAGES.moderated .. " Product %s already exists; do not create another. Ask the creator for plainer wording and update this product."
    local productId = arg1.productId or tbl1.productId or "unknown"
    return var1:format(tostring(productId))
end

local function createManageDevProductController(arg1, tbl1, arg2, callback, tbl2)
    local var1 = tbl2 or StudioManageDevProductTool
    local var2 = manageDevProductStore
    local var3 = nil
    local tbl3 = ({})
    local var4 = nil

    local function performMutation(tbl4)
        local universeId = tbl4.universeId
        if universeId == nil then
            return nil, monetizationFailureCauses.MESSAGES.noUniverse
        elseif not FFlagBuildExperienceRemoveDevProductPriceCap
            and tbl4.priceInRobux ~= nil
            and (tbl4.priceInRobux < 1 or tbl4.priceInRobux > 100)
        then
            return nil, "Developer-product prices must be between 1 and 100 Robux."
        elseif tbl4.action == "create" then
            if tbl4.name == nil or tbl4.name == "" or tbl4.priceInRobux == nil then
                return nil, "A name and price are required to create a developer product."
            end

            local var5

            if tbl4.imageAssetId == nil then
                var5 = nil
            else
                local var6
                var5, var6 = awaitMutation(downloadGeneratedImageAsync(tbl4.imageAssetId))
                if var5 == nil then
                    if FFlagBuildExperienceDevProductRecovery then
                        if FFlagBuildExperienceMonetizationFailureCauses then
                            return nil, `The product image could not be loaded. No product was created. {describeImageFailure(var6)}`, true
                        end
                        return nil, "The product image could not be loaded. No product was created.", true
                    end
                    return nil, var6
                end
            end
            return awaitMutation(
                var2.create(
                    universeId,
                    {
                        name = tbl4.name,
                        description = tbl4.description,
                        priceInRobux = tbl4.priceInRobux,
                        imageFile = var5
                    }
                )
            )
        elseif tbl4.productId == nil then
            return nil, "A productId is required for this action."
        elseif tbl4.action == "update" then
            return awaitMutation(
                var2.update(
                    universeId,
                    tbl4.productId,
                    {
                        name = tbl4.name,
                        description = tbl4.description,
                        priceInRobux = tbl4.priceInRobux
                    },
                    FFlagBuildExperienceDevProductModerationReadback
                )
            )
        elseif tbl4.action == "activate" then
            return awaitMutation(var2.activate(universeId, tbl4.productId))
        elseif tbl4.action == "deactivate" then
            return awaitMutation(var2.deactivate(universeId, tbl4.productId))
        else
            return nil, ("Unsupported action '%s'."):format(tbl4.action)
        end
    end
    local function clearMutationCard(tbl4) -- Luacid: Inlined by compiler; 3 call sites recovered
        arg2.removeDevProductTool(tbl4.toolCallId)
        arg2.removeDevProductAction(tbl4.toolCallId)
    end

    local function recoverFailedSubmission(tbl4, str1: string?, num1: number?)
        if FFlagBuildExperienceDevProductRecovery and var3 ~= tbl4 then
            arg2.removeDevProductAction(tbl4.toolCallId)
            return
        end

        if not FFlagBuildExperienceDevProductRecovery
            or not FFlagBuildExperienceMonetizationFailureCauses
            or not tbl4.attempted
            or not toolControllerUtils.isConversationGone(num1)
        then
            tbl4.submitted = false
            if callback == nil then
                return
            end
            arg2.setDevProductTool((proposalFromFlow(tbl4, false, false)))
            callback(str1, num1)
            return
        end

        tbl4.isPending = false
        tbl4.canRetry = false
        tbl1[tbl4.toolCallId] = true
        arg2.markSubmitted(tbl4.toolCallId)
        arg2.setDevProductTool((proposalFromFlow(tbl4, true, false)))
        arg2.removeDevProductAction(tbl4.toolCallId)
        var3 = nil
        if callback ~= nil then
            callback(str1, num1)
        end
    end
    local function submitResult(tbl4, tbl5, bool1: boolean, str1: string?)
        local var5 = arg1.submitActiveToolResult(tbl5, bool1, tbl4.turnId, tbl4.referenceId)
        if var5 == nil then
            debug2.log(
                "warn",
                "manage_developer_product tool_result submit aborted (no active session)",
                {
                    toolCallId = tbl4.toolCallId
                }
            )
            recoverFailedSubmission(tbl4, str1, nil)
            return
        end

        local var6 = awaitRequestState(var5.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        if var6.status == "succeeded" then
            tbl1[tbl4.toolCallId] = true
            arg2.markSubmitted(tbl4.toolCallId)

            arg2.removeDevProductAction(tbl4.toolCallId)
            if var3 == tbl4 then
                var3 = nil
            end
            return
        end

        recoverFailedSubmission(tbl4, str1, var6.errorCode)
        debug2.log("warn", "manage_developer_product tool_result submit failed", {
            sessionId = tbl4.sessionId,
            toolCallId = tbl4.toolCallId,
            turnId = tbl4.turnId,
            referenceId = tbl4.referenceId,
            action = tbl4.action,
            state = debug2.formatRequestState(var6)
        })
    end

    local function submitApproval(tbl4)
        local result, resultError, resultDetailCode

        if tbl4.attempted then
            result = tbl4.result
            resultError = tbl4.resultError
            resultDetailCode = tbl4.resultDetailCode
        else
            tbl4.attempted = true
            local var5
            result, resultError, var5, resultDetailCode = performMutation(tbl4)
            if result ~= nil and resultError == nil then
                resultError = moderationError(tbl4, result)
                if resultError ~= nil then
                    resultDetailCode = "name_moderated"
                end
            end

            tbl4.result = result
            tbl4.resultError = resultError
            if resultError ~= nil and resultDetailCode == nil then
                resultDetailCode = detailCodeForFailure(tbl4.action, resultError)
            end
            tbl4.resultDetailCode = resultDetailCode

            if FFlagBuildExperienceDevProductRecovery and resultError ~= nil and var5 and tbl4.action == "create" and var3 == tbl4 then
                tbl4.attempted = false
                tbl4.submitted = false
                tbl4.isPending = false
                tbl4.canRetry = true
                arg2.setDevProductTool((proposalFromFlow(tbl4, false, false)))
                return
            end
        end
        if FFlagBuildExperienceDevProductRecovery then
            tbl4.isPending = false
            tbl4.canRetry = false
            if arg2.getOptimisticLocalTools(false).devProductByToolCallId[tbl4.toolCallId] ~= nil then
                arg2.setDevProductTool((proposalFromFlow(tbl4, true, false)))
            end
        end

        local var5, var6

        if result ~= nil and resultError == nil then
            var5, var6 = var1.formatResultContent({ status = "ok", action = tbl4.action, product = result })
        else
            var5 = var1.formatResultContent({
                status = "error",
                action = tbl4.action,
                detailCode = resultDetailCode,
                message = resultError or "The developer product change failed.",
                product = result
            })
            var6 = true
        end

        submitResult(tbl4, var5, var6, nil)
    end

    local function submitRejection(tbl4, str1: string?)
        if tbl4.attempted then
            arg2.setDevProductTool((proposalFromFlow(tbl4, true, false)))
            submitApproval(tbl4)
            return
        end
        local var5 = var1.formatRejectionContent(tbl4.action, str1)
        submitResult(tbl4, var5, false, str1)
    end

    local function onApproveImpl()
        local var5 = var3
        if var5 == nil or var5.submitted then
            return
        end
        var5.submitted = true
        if FFlagBuildExperienceDevProductRecovery then
            var5.isPending = true
            var5.canRetry = false
        end
        arg2.setDevProductTool((proposalFromFlow(var5, true, false)))
        task.spawn(function()
            submitApproval(var5)
        end)
    end

    local function onRejectImpl()
        local var5 = var3
        if var5 == nil or var5.submitted then
            return
        end
        var5.submitted = true
        arg2.setDevProductTool((proposalFromFlow(var5, false, true)))
        task.spawn(function()
            submitRejection(var5, nil)
        end)
    end
    local function runListRequest(toolCallId: string, num1: number?, str1: string?, sessionId: string)
        local universeId = arg1.universeId
        local var5 = nil
        local noUniverse

        if universeId == nil then
            noUniverse = monetizationFailureCauses.MESSAGES.noUniverse
        else
            var5, noUniverse = awaitMutation(var2.list(universeId))
        end

        local var6, var7

        if var5 ~= nil then
            var6, var7 = var1.formatResultContent({
                status = "ok",
                action = "list",
                count = #var5.developerProducts,
                products = var5.developerProducts,
                nextPageToken = var5.nextPageToken,
                truncated = var5.nextPageToken ~= nil
            })
        else
            var6 = var1.formatResultContent({
                status = "error",
                action = "list",
                detailCode = "list_failed",
                message = noUniverse or "Could not list developer products."
            })
            var7 = true
        end

        local var8 = arg1.submitActiveToolResult(var6, var7, num1, str1)
        tbl3[toolCallId] = nil
        if var8 == nil then
            tbl1[toolCallId] = nil
            return
        end
        local var9 = awaitRequestState(var8.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
        if var9.status == "succeeded" then
            return
        end

        tbl1[toolCallId] = nil
        if var9.status == "pending" then
            var8.dispose()
        end
        debug2.log(
            "warn",
            "manage_developer_product list submit failed",
            {
                sessionId = sessionId,
                toolCallId = toolCallId,
                state = debug2.formatRequestState(var9)
            }
        )
    end

    local function clearMutationFlow() -- Luacid: Inlined by compiler; 1 call site recovered
        local var5 = var3
        if var5 ~= nil then
            clearMutationCard(var5)
        end

        var3 = nil
        var4 = nil
    end

    return {
        syncManageDevProductRequests = function(arg3): boolean
            local toolCallId, var6, turnId, referenceId = var1.findManageDevProductRequestInTurnState(arg3, tbl1)
            if toolCallId == nil then
                clearMutationFlow()
                return false
            end

            local var9, var10, var11 = var1.parseManageDevProductInput(var6)
            if var9 ~= nil then
                if var1.getActionKind(var9.action) == "read" then
                    if tbl3[toolCallId] then
                        return true
                    end
                    tbl1[toolCallId] = true
                    tbl3[toolCallId] = true
                    task.spawn(function()
                        runListRequest(toolCallId, turnId, referenceId, arg3.sessionId)
                    end)
                    return true
                end

                if toolCallId ~= var4 then
                    var4 = toolCallId
                    local tbl4 = {
                        sessionId = arg3.sessionId,
                        toolCallId = toolCallId,
                        callOrder = getToolCallOrder(arg3, toolCallId),
                        turnId = turnId,
                        referenceId = referenceId,
                        universeId = arg1.universeId,
                        action = var9.action,
                        name = var9.name,
                        description = var9.description,
                        priceInRobux = var9.priceInRobux,
                        productId = var9.productId,
                        imageAssetId = var9.imageAssetId,
                        submitted = false,
                        attempted = false
                    }

                    var3 = tbl4
                    arg2.setDevProductTool((proposalFromFlow(tbl4, false, false)))
                    arg2.setDevProductAction(toolCallId, onApproveImpl, onRejectImpl)
                    debug2.log(
                        "info",
                        "manage_developer_product proposal displayed",
                        {
                            toolCallId = toolCallId,
                            turnId = turnId,
                            referenceId = referenceId,
                            action = var9.action
                        }
                    )
                end

                return true
            end

            if tbl3[toolCallId] then
                return true
            end
            tbl3[toolCallId] = true
            task.spawn(function()
                local bool1

                if var10 == nil then
                    bool1 = FFlagBuildExperienceDevProductRecovery

                    if bool1 then
                        if typeof(var6) == "table" and typeof(var6.action) == "string" and string.lower(var6.action) == "update" then
                            bool1 = var6.imageAssetId ~= nil
                        else
                            bool1 = false
                        end
                    end
                else
                    bool1 = false
                end

                local kind = if var1.resolveRequestKind == nil then nil else var1.resolveRequestKind(var6)
                local var13 = var1.formatResultContent({
                    status = "error",
                    kind = kind,
                    action = if bool1 then "update" else "unknown",
                    detailCode = if bool1 then "unsupported_image_update" else var11 or "invalid_arguments",
                    message = if bool1 then "Editing an existing developer product's image is not supported. No product was changed. Do not claim the image was updated or create a replacement product." else var10 or "The developer-product request was malformed."
                })
                local var14 = arg1.submitActiveToolResult(var13, true, turnId, referenceId)
                tbl3[toolCallId] = nil
                if var14 == nil then
                    return
                end

                local var15 = awaitRequestState(var14.state, os.clock() + chatConstants.CAS_RPC_TIMEOUT_SECONDS)
                if var15.status == "succeeded" then
                    tbl1[toolCallId] = true
                elseif var15.status == "pending" then
                    var14.dispose()
                end
            end)
            return true
        end,
        stopPending = function(): boolean
            local bool1 = false
            for value in tbl3 do
                tbl3[value] = nil
                tbl1[value] = nil
                bool1 = true
            end

            local var5 = var3
            if var5 ~= nil and not var5.submitted then
                var5.submitted = true
                clearMutationCard(var5)
                var3 = nil
                var4 = nil
                bool1 = true
            end

            return bool1
        end,
        trySubmitComposerText = function(str1: string): boolean
            local var5 = var3
            if var5 == nil or var5.submitted then
                return false
            end
            var5.submitted = true
            arg2.setDevProductTool((proposalFromFlow(var5, false, true)))
            task.spawn(function()
                submitRejection(var5, str1)
            end)
            return true
        end
    }
end
return createManageDevProductController
