-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Promise = require(MomentsParent.Promise)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local isStudio = require(MomentsParent.MomentsCommon.isStudio)
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration
local GetFFlagMomentTextGenerationDisableCache = require(Moments.Flags.GetFFlagMomentTextGenerationDisableCache)
local FFlagMomentTextGenerationFilteredSignal = MomentsCommon.Flags.FFlagMomentTextGenerationFilteredSignal

local tbl1 = ({})

local function log(str1: string, ...)
    if _G.__MOMENTS_DISABLE_GEN_TEXT_LOG__ then
        return
    end
    print(`[moments-gen] {string.format(str1, ...)}`)
end

local function mockResult() -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        summary = "insane save",
        description = "no way i pulled this off — clutch save on the last second, everyone was screaming lol",
        error = nil
    }
end

local function captureKey(arg1): string
    local localId = nil
    pcall(function()
        localId = arg1.LocalId
    end)
    if localId ~= nil then
        return `local:{localId}`
    elseif typeof(arg1) == "table" and arg1.assetId ~= nil then
        return `asset:{arg1.assetId}`
    end
    return `capture:{tostring(arg1)}`
end

local function resultName(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 == nil then
        return nil
    end
    local success, result = pcall(function()
        return arg1.Name
    end)
    return if success and typeof(result) == "string" then result else nil
end

local function runGeneration(arg1, str1: string, str2: string?, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl2.captureService or game:GetService("CaptureService")
    local pollIntervalSeconds = tbl2.pollIntervalSeconds or 1
    local maxPollAttempts = tbl2.maxPollAttempts or 30

    return Promise.new(function(callback, _, callback2)
        local var2 = task.spawn(function()
            local success, result, result2 = pcall(function()
                if str2 ~= nil then
                    return var1:GenerateMomentTextAsync(arg1, str2)
                end
                return var1:GenerateMomentTextAsync(arg1)
            end)

            if not success or resultName(result) ~= "Success" or typeof(result2) ~= "string" or #result2 == 0 then
                if not success then
                    log("generation start failed for %s", str1)
                end

                if isStudio() then
                    local tbl3 = mockResult()
                    callback(tbl3)
                    return
                end
                callback({ error = "REQUEST_FAILED" })

                return
            end

            log("generation started for %s", str1)

            for _ = 1, maxPollAttempts do
                task.wait(pollIntervalSeconds)

                local success2, result3, result2_2, result3_2 = pcall(function()
                    return var1:CheckMomentTextStatusAsync(result2)
                end)

                if not success2 then
                    continue
                end

                local var2 = resultName(result3)

                if var2 == "Success" then
                    log("generation succeeded for %s", str1)
                    callback({ summary = result2_2, description = result3_2, generationToken = result2 })

                    return
                end

                if FFlagMomentTextGenerationFilteredSignal and var2 == "Filtered" then
                    callback({ error = "CONTENT_FILTERED" })
                    return
                end

                if var2 == "Failed" then
                    callback({ error = "GENERATION_FAILED" })
                    return
                end
            end

            callback({ error = "TIMEOUT" })
        end)

        if GetFFlagEnableMomentTextGeneration() then
            callback2(function()
                log("generation cancelled for %s", str1)
                task.cancel(var2)
            end)
        end
    end)
end

local function generateMomentText(arg1, str1: string?, tbl2)
    local tbl3 = tbl2 or {}
    if not (tbl3.isEngineEnabled or function(): boolean
        return game:GetEngineFeature("CaptureServiceGenerateMomentText")
    end)() then
        if not isStudio() then
            return Promise.resolve({ error = "ENGINE_UNSUPPORTED" })
        end

        local tbl4 = mockResult()
        return Promise.resolve(tbl4)
    end

    local str2 = captureKey(arg1)

    if str1 ~= nil and str1 ~= "" then
        str2 = `{str2}|tone:{str1}`
    end

    if GetFFlagMomentTextGenerationDisableCache() then
        return runGeneration(arg1, str2, str1, tbl3)
    end

    if tbl1[str2] ~= nil then
        return tbl1[str2]
    end

    local var1 = runGeneration(arg1, str2, str1, tbl3)
    tbl1[str2] = var1

    var1:andThen(function(tbl4)
        if tbl4 == nil or tbl4.error ~= nil then
            tbl1[str2] = nil
        end
    end, function()
        tbl1[str2] = nil
    end)

    if GetFFlagEnableMomentTextGeneration() then
        var1:finally(function(cancelled)
            if cancelled == Promise.Status.Cancelled then
                tbl1[str2] = nil
            end
        end)
    end

    return var1
end

return generateMomentText
