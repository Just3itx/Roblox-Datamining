-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFrameStride(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1.stride or tbl1.cellSize or tbl1.frameSize + (tbl1.padding or 0)
end

return {
    getDurationSeconds = function(tbl1)
        return tbl1.frameCount / tbl1.fps
    end,
    getFrameIndex = function(tbl1, num1: number, bool1: boolean)
        local num2 = math.floor(num1 * tbl1.fps)

        if bool1 then
            return num2 % tbl1.frameCount + 1
        end

        return math.min(num2 + 1, tbl1.frameCount)
    end,
    getFrameRect = function(tbl1, num1: number)
        local frameIndex = math.clamp(num1, 1, tbl1.frameCount)
        local num3 = frameIndex - 1
        local var1 = num3 % tbl1.columns
        local num4 = math.floor(num3 / tbl1.columns)
        local frameStride = getFrameStride(tbl1)
        return {
            frameIndex = frameIndex,
            offset = Vector2.new(var1 * frameStride, num4 * frameStride),
            size = Vector2.new(tbl1.frameSize, tbl1.frameSize)
        }
    end,
    getFrameStride = getFrameStride
}
