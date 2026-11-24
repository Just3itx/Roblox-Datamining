-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local useAudioAnalyzer = require(script.Parent.useAudioAnalyzer)

local random = Random.new()

local function amplitudeToDecibels(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if num1 <= 0 then
        return -math.huge
    end

    return math.log10(num1) * 20
end

local function amplitudeToNormalized(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = amplitudeToDecibels(num1)

    if num2 == -math.huge then
        return 0
    end
    return math.clamp((num2 - -60) / 60, 0, 1)
end

return {
    BAR_WIDTH = 2,
    BAR_GAP = 2,
    ITEM_WIDTH = 4,
    RENDER_INTERVAL = 0.1,
    amplitudeToDecibels = amplitudeToDecibels,
    amplitudeToNormalized = amplitudeToNormalized,
    sampleVolume = function(arg1, tbl1, bool1: boolean)
        if not arg1 then
            return random:NextNumber(0, 1)
        end

        local num1 = amplitudeToNormalized(arg1.RmsLevel)
        local current = math.max(tbl1.current * 0.95, num1)
        tbl1.current = current

        return if bool1 then if current > 0.01 then num1 / current else num1 else num1
    end,
    useAudioAnalyzer = useAudioAnalyzer
}
