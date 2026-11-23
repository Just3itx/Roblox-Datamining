-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MessageBusService = game:GetService("MessageBusService")

local messageId = MessageBusService:GetMessageId("BuildExperience", "instanceSelectionRequest")
local messageId2 = MessageBusService:GetMessageId("BuildExperience", "instanceSelectionResult")

local function getActiveRequest(): {[any]: any}?
    local last = MessageBusService:GetLast(messageId)

    return if typeof(last) == "table" and last.active == true and typeof(last.requestId) == "string" and last.requestId ~= "" then last else nil
end

local function defaultDependencies()
    local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
    return {
        canEnterCaptureMode = function(): boolean
            return not game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") or ExperienceStateCaptureService:CanEnterCaptureMode()
        end,
        createRequestId = function(): string
            return HttpService:GenerateGUID(false)
        end,
        getActiveRequest = getActiveRequest,
        publishRequest = function(arg1)
            MessageBusService:Publish(messageId, arg1)
        end,
        publishResult = function(arg1)
            MessageBusService:Publish(messageId2, arg1)
        end,
        subscribeToResult = function(callback): Instance
            return MessageBusService:Subscribe(messageId2, callback, false, false)
        end,
        subscribeToCaptureModeExit = function(callback)
            if not game:GetEngineFeature("ExperienceStateCaptureIsInBackground") then
                return nil
            end
            return ExperienceStateCaptureService:GetPropertyChangedSignal("IsInBackground"):Connect(function()
                if not ExperienceStateCaptureService.IsInBackground then
                    callback()
                end
            end)
        end,
        toggleCaptureMode = function()
            ExperienceStateCaptureService:ToggleCaptureMode()
        end
    }
end

return {
    beginSelection = function(callback: (...any) -> (...any), tbl1): boolean
        local var1 = tbl1 or defaultDependencies()
        if not var1.canEnterCaptureMode() then
            return false
        end

        local requestId = var1.createRequestId()
        local var2 = nil
        local var3 = nil
        local function disconnect() -- Luacid: Inlined by compiler; 3 call sites recovered
            var2:Disconnect()
            if var3 ~= nil then
                var3:Disconnect()
            end
        end

        var2 = var1.subscribeToResult(function(arg1)
            if typeof(arg1) ~= "table" or arg1.requestId ~= requestId then
                return
            end

            disconnect()
            callback(arg1)
        end)

        var3 = var1.subscribeToCaptureModeExit(function()
            local activeRequest = var1.getActiveRequest()
            if activeRequest == nil or activeRequest.requestId ~= requestId then
                var3:Disconnect()
                return
            end

            disconnect()
            var1.publishRequest({ active = false, requestId = requestId })

            callback({ requestId = requestId, status = "cancelled" })
        end)

        var1.publishRequest({ active = true, requestId = requestId })

        local success = pcall(var1.toggleCaptureMode)
        if not success then
            disconnect()
            var1.publishRequest({ active = false, requestId = requestId })
        end

        return success
    end,
    finishSelection = function(tbl1, tbl2): boolean
        local var1 = tbl2 or defaultDependencies()
        local activeRequest = var1.getActiveRequest()
        if activeRequest == nil then
            return false
        end

        var1.publishResult({
            requestId = activeRequest.requestId,
            status = tbl1.status,
            path = tbl1.path,
            displayName = tbl1.displayName,
            className = tbl1.className
        })
        var1.publishRequest({ active = false, requestId = activeRequest.requestId })

        var1.toggleCaptureMode()
        return true
    end,
    getActiveRequest = getActiveRequest
}
