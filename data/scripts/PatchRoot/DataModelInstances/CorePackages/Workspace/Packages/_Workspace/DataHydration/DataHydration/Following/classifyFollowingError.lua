-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _FollowingStoreTypes = require(script.Parent.FollowingStoreTypes)
local FollowingUpdateErrorTypeEnum = require(script.Parent.FollowingUpdateErrorTypeEnum)

local tbl1 = {
    [2] = FollowingUpdateErrorTypeEnum.Blocked,
    [3] = FollowingUpdateErrorTypeEnum.Blocked,
    [8] = FollowingUpdateErrorTypeEnum.SelfFollow,
    [9] = FollowingUpdateErrorTypeEnum.FloodLimit,
    [14] = FollowingUpdateErrorTypeEnum.Captcha,
    [429] = FollowingUpdateErrorTypeEnum.FloodLimit,
    [503] = FollowingUpdateErrorTypeEnum.Unavailable
}

local function classifyFollowingError(arg1)
    local responseCode = if type(arg1) == "table" then arg1.responseCode else nil
    local var1 = if type(responseCode) == "number" then tbl1[responseCode] else nil

    if var1 == nil then
        var1 = FollowingUpdateErrorTypeEnum.NetworkError
    end
    return { type = "error", errorType = var1, responseCode = responseCode }
end

return classifyFollowingError
