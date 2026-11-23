-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local _GetBuildPromptChipsStore = require(BuildExperience.Stores.GetBuildPromptChipsStore)
local promptChipsStatus = require(BuildExperience.Stores.GetBuildPromptChipsStore.promptChipsStatus)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local FIntBuildPromptChipEditDebounceMs = require(BuildExperience.Flags.FIntBuildPromptChipEditDebounceMs)

local FFlagBuildExperienceFTUXChipExhaustedTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceFTUXChipExhaustedTelemetry)

local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local PROMPT_CHIPS_STATUS = promptChipsStatus.PROMPT_CHIPS_STATUS
local var1 = FIntBuildPromptChipEditDebounceMs / 1000
local function getChipClickParameters(arg1, prompt: string, selectedChip)
    local chips = arg1.getChips()
    local var2 = table.find(chips, selectedChip)
    return {
        chipText = selectedChip.value,
        index = if var2 == nil then nil else tostring(var2),
        chipCount = tostring(#chips),
        hasPrompt = tostring(string.find(prompt, "%S") ~= nil)
    }
end

local function useBuildPromptChipRequests(arg1, tbl1)
    local isActive = tbl1.isActive
    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(isActive)
    local telemetryGranularity = tbl1.telemetryGranularity

    local var7 = React.useCallback(function(tbl2, func1: ((...any) -> (...any))?)
        local startTime = os.clock()
        arg1.requestChips(tbl2, func1, function(arg2)
            local num1 = math.max(0, math.round((os.clock() - startTime) * 1000))
            sendBuildExperienceEvent("CHIP_LOAD", telemetryGranularity, { elapsedMs = tostring(num1), succeeded = tostring(arg2) })
        end)
    end, { arg1, telemetryGranularity })

    local var8 = React.useCallback(function()
        local current = var2.current
        if current ~= nil then
            task.cancel(current)
            var2.current = nil
        end
    end, {})

    React.useEffect(function()
        if isActive then
            var6.current = true
            return
        end

        var8()
        var3.current = nil
        var4.current = nil
        var5.current = nil

        if var6.current then
            var6.current = false
            arg1.reset()
        end
    end, { arg1, isActive, var8 })

    React.useEffect(function()
        if not isActive then
            return
        end

        if var5.current ~= nil and var5.current ~= tbl1.sessionKey then
            var8()
            var3.current = nil
            var4.current = nil
            arg1.reset()
        end
        var5.current = tbl1.sessionKey

        if not tbl1.shouldRequestInitialChips or var4.current == tbl1.sessionKey then
            return
        end

        var8()
        var4.current = tbl1.sessionKey
        var3.current = ""
        var7({ prompt = "" })
    end, {
        arg1,
        isActive,
        tbl1.sessionKey,
        tbl1.shouldRequestInitialChips,
        var8,
        var7
    })

    React.useEffect(function()
        return function()
            var8()
            var3.current = nil
            var4.current = nil
            var5.current = nil
            var6.current = false
            arg1.reset()
        end
    end, { arg1, var8 })

    local requestChipsForEdit = React.useCallback(function(str1: string)
        if not isActive then
            return
        end

        var8()

        local var9 = string.match(str1, "^%s*(.-)%s*$") or ""

        if var9 == var3.current then
            local status = arg1.getStatus()
            if status ~= PROMPT_CHIPS_STATUS.Idle and status ~= PROMPT_CHIPS_STATUS.Failed then
                return
            end
        end

        var2.current = task.delay(var1, function()
            var2.current = nil
            var3.current = var9

            sendBuildExperienceEvent("CHIP_PROMPT_EDIT", telemetryGranularity)
            var7({ prompt = var9 })
        end)
    end, {
        arg1,
        isActive,
        var8,
        var7,
        telemetryGranularity
    })
    local useCallback = React.useCallback
    local function func1(prompt: string, selectedChip, func2: ((...any) -> (...any))?)
        if not isActive then
            return
        end

        var8()
        var3.current = nil
        sendBuildExperienceEvent(
            "CHIP_CLICK",
            telemetryGranularity,
            if FFlagBuildExperienceEventContextTelemetry then getChipClickParameters(arg1, prompt, selectedChip) else nil
        )

        var7({ prompt = prompt, selectedChip = selectedChip }, func2)
    end

    local var10 = if FFlagBuildExperienceEventContextTelemetry then arg1 else nil
    local requestChipsForSelection = useCallback(func1, { isActive, var8, var7, telemetryGranularity, var10 })

    local onChipExhausted = if FFlagBuildExperienceFTUXChipExhaustedTelemetry then React.useCallback(function()
        if isActive then
            sendBuildExperienceEvent("CHIP_EXHAUSTED", telemetryGranularity)
        end
    end, { isActive, telemetryGranularity }) else nil

    return {
        requestChipsForEdit = requestChipsForEdit,
        requestChipsForSelection = requestChipsForSelection,
        onChipExhausted = onChipExhausted
    }
end

return useBuildPromptChipRequests
