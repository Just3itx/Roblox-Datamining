-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local chatConstants = require(BuildExperience.Chat.chatConstants)
local reportPromptFirstResponseLatency = require(BuildExperience.Telemetry.reportPromptFirstResponseLatency)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local tbl1 = { FirstResponse = "first_response", MidTurn = "mid_turn" }

local function createPromptLifecycleTelemetry(func1: (...any) -> (...any))
    local var1 = nil
    local var2 = nil
    local var3 = nil
    local bool1 = false
    local isWaitingOnUser = false
    local bool2 = false
    local var4 = nil

    local function cancelStallTimer() -- Luacid: Inlined by compiler; 3 call sites recovered
        if var4 ~= nil then
            task.cancel(var4)
            var4 = nil
        end
    end

    local function getMsSince(num1: number?): number -- Luacid: Inlined by compiler; 6 call sites recovered
        if num1 == nil then
            return 0
        end

        return math.max(0, math.round((os.clock() - num1) * 1000))
    end

    local function getLifecycleParameters()
        local tbl2 = {
            elapsedMs = tostring((getMsSince(var1))),
            receivedResponse = tostring(var3 ~= nil),
            stalled = tostring(bool1)
        }

        if var3 ~= nil then
            tbl2.firstResponseMs = tostring(var3)
        end

        return tbl2
    end

    local function reportStall(num1: number) -- Luacid: unused: defined but never referenced
        bool1 = true

        local lifecycleParameters = getLifecycleParameters()
        lifecycleParameters.stage = if var3 == nil then "first_response" else "mid_turn"

        lifecycleParameters.idleMs = tostring((getMsSince(var2)))
        lifecycleParameters.thresholdSeconds = tostring(num1)

        sendBuildExperienceEvent("SEND_PROMPT_STALLED", func1(), lifecycleParameters)
    end

    local function scheduleStallCheck(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        var4 = task.delay(num1, function()
            var4 = nil

            if bool2 or isWaitingOnUser or var2 == nil then
                return
            end

            local promptStallSeconds = chatConstants.PROMPT_STALL_SECONDS
            local var5 = promptStallSeconds - (os.clock() - var2)
            if var5 > 0 then
                scheduleStallCheck(var5)
                return
            end

            bool1 = true

            local lifecycleParameters = getLifecycleParameters()
            lifecycleParameters.stage = if var3 ~= nil then tbl1.MidTurn else tbl1.FirstResponse

            lifecycleParameters.idleMs = tostring((getMsSince(var2)))
            lifecycleParameters.thresholdSeconds = tostring(promptStallSeconds)

            sendBuildExperienceEvent("SEND_PROMPT_STALLED", func1(), lifecycleParameters)
        end)
    end

    local function finish() -- Luacid: Inlined by compiler; 1 call site recovered
        bool2 = true
        cancelStallTimer()
    end

    return {
        start = function()
            if var1 ~= nil or bool2 then
                return
            end

            var1 = os.clock()
            var2 = var1
            sendBuildExperienceEvent("SEND_PROMPT_START", func1())

            scheduleStallCheck(chatConstants.PROMPT_STALL_SECONDS)
        end,
        markActivity = function(tbl2)
            if var1 == nil or bool2 then
                return
            end

            var2 = os.clock()
            isWaitingOnUser = tbl2.isWaitingOnUser

            if tbl2.hasResponse and var3 == nil then
                local msSince = getMsSince(var1)
                var3 = msSince

                reportPromptFirstResponseLatency(msSince, bool1)
            end

            if isWaitingOnUser then
                cancelStallTimer()
            elseif var4 == nil then
                scheduleStallCheck(chatConstants.PROMPT_STALL_SECONDS)
            end
        end,
        reportUserStop = function()
            if var1 == nil or bool2 then
                return
            end

            sendBuildExperienceEvent("SEND_PROMPT_STOPPED", func1(), (getLifecycleParameters()))
            finish()
        end,
        finish = finish,
        getLifecycleParameters = getLifecycleParameters
    }
end

return createPromptLifecycleTelemetry
