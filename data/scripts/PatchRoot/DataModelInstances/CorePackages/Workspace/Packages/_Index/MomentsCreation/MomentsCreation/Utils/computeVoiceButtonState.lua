-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function trimWhitespace(text: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return (text:gsub("^%s*(.-)%s*$", "%1"))
end

local function computeVoiceButtonState(tbl1)
    local isGenerating = tbl1.ttsState == "loading"
    local isError = tbl1.ttsState == "error"
    local var1 = trimWhitespace(tbl1.text)
    local num1 = utf8.len(var1) or 0
    local bool3 = var1 ~= tbl1.lastGeneratedText
    local isModerated = isError and tbl1.errorReason == "moderated" and not bool3
    local isTooManyDigits = isError and tbl1.errorReason == "tooManyDigits" and not bool3
    local charCount = utf8.len(tbl1.text) or 0
    local isOverLimit = tbl1.maxChars < charCount

    local var2 = tbl1.hasGenerated or tbl1.lastSavedText ~= ""
    local var3 = num1 == 0 and var2 and bool3
    local bool7 = var1:match("%w") ~= nil
    local bool8 = num1 > 0 and not isOverLimit and bool7
    local bool9 = isError and not (isModerated or isTooManyDigits)
    if var3 or bool8 then
        if bool3 then
            bool8 = not isGenerating
        else
            bool8 = bool9 and not isGenerating
        end
    end

    local var4 = tbl1.hasGenerated or tbl1.hasCleared
    local bool10 = tbl1.lastGeneratedText ~= tbl1.lastSavedText
    local var5 = tbl1.hasGenerated and (tbl1.startTime or 0) ~= (tbl1.lastSavedStartTime or 0)
    local var6 = tbl1.hasGenerated and (tbl1.voiceId or 0) ~= (tbl1.lastSavedVoiceId or 0)
    if var4 then
        if bool10 or var5 or var6 then
            var6 = not (bool3 or isGenerating or isError)
        end
    else
        var6 = var4
    end

    return {
        isGenerating = isGenerating,
        isError = isError,
        charCount = charCount,
        isOverLimit = isOverLimit,
        canGenerate = bool8,
        isModerated = isModerated,
        isTooManyDigits = isTooManyDigits,
        showSave = var6
    }
end

return computeVoiceButtonState
