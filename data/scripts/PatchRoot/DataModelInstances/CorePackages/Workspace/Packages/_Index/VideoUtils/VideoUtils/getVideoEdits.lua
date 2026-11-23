-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isTime(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return type(arg1) == "number" and arg1 >= 0 and arg1 < math.huge
end

local function isUnset(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return arg1 == nil or arg1 == "" or arg1 == 0
end

return {
    getVideoEdits = function(tbl1)
        local var1

        if isUnset(tbl1.trimStartTime) and isUnset(tbl1.trimEndTime) then
            var1 = nil
        else
            if not (isTime(tbl1.trimStartTime) and isTime(tbl1.trimEndTime)) then
                return nil, false
            end
            local trimStartTime = tbl1.trimStartTime
            local trimEndTime = tbl1.trimEndTime
            if trimEndTime <= trimStartTime then
                return nil, false
            end

            var1 = { startTime = trimStartTime, endTime = trimEndTime }
        end

        local var2

        if isUnset(tbl1.musicAssetId) and isUnset(tbl1.musicStartTime) then
            var2 = nil
        else
            local musicAssetId = tbl1.musicAssetId
            local startTime = if tbl1.musicStartTime == nil then 0 else tbl1.musicStartTime

            if type(musicAssetId) ~= "string"
                or string.match(musicAssetId, "^%d+$") == nil
                or (tonumber(musicAssetId) or 0) <= 0
                or (tonumber(musicAssetId) or 0) == math.huge
                or not isTime(startTime)
            then
                return nil, false
            end

            var2 = { assetId = musicAssetId, startTime = startTime }
        end

        return var1 ~= nil and { trim = var1, music = var2 } or var2 ~= nil and {
            trim = var1,
            music = var2
        } or nil, true
    end,
    getPlaybackRange = function(num1: number, tbl1)
        local var1 = if tbl1 then math.min(tbl1.startTime, num1) else 0

        if not tbl1 then
            return var1, num1
        end

        return var1, math.min(tbl1.endTime, num1)
    end
}
