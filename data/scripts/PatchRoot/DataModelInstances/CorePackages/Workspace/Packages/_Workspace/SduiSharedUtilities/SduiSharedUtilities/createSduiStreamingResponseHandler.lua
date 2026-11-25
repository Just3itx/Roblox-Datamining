-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local SduiStreamingResponseUtils = require(SduiSharedUtilities.SduiStreamingResponseUtils)

local function createSduiStreamingResponseHandler(tbl1)
    local num1 = 0
    local var1 = nil
    local var2 = nil
    local str1 = ""

    local function processExtractedFrames(tbl2)
        for _, value in tbl2 do
            local var3, var4 = tbl1.processFrame(value)
            if not var3 then
                var2 = var4
                return
            end

            num1 += 1
            var1 = var4
        end
    end

    local function extractAndProcessFrames(str2: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local success, result, result2 = pcall(SduiStreamingResponseUtils.extractFrames, str2)
        if not success then
            var2 = result
            return
        end

        str1 = result2
        processExtractedFrames(result)
    end

    return {
        handleChunk = function(str2: string)
            tbl1.loadTimer.logUiStreamChunkReceived()

            if #str2 == 0 or var2 ~= nil then
                return
            end

            str1 ..= str2
            extractAndProcessFrames(str1)
        end,
        finalize = function(buf)
            if num1 == 0 and not SduiStreamingResponseUtils.isEmptyResponseBody(buf) then
                if typeof(buf) == "buffer" then
                    buf = buffer.tostring(buf)
                end

                if typeof(buf) == "string" and #buf > 0 then
                    str1 = buf
                    extractAndProcessFrames(str1)
                end
            end

            if var2 ~= nil then
                return { ok = false, value = var2 }
            end

            if #str1 > 0 then
                return {
                    ok = false,
                    value = `Streaming response for {tbl1.configKey} ended with {#str1} undecoded bytes remaining`
                }
            end

            if num1 > 0 then
                return { ok = true, value = var1 }
            end

            return {
                ok = false,
                value = `Streaming request for {tbl1.configKey} completed without receiving data`
            }
        end
    }
end

return createSduiStreamingResponseHandler
