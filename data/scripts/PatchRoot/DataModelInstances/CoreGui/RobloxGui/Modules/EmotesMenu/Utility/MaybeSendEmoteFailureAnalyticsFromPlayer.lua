-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local function MaybeSendEmoteFailureAnalyticsFromPlayer(arg1, callback): boolean
    local character = arg1.Character
    if not character then
        callback(Constants.ErrorTypes.TemporarilyUnavailable)
        return true
    end

    local var1 = if character then character:FindFirstChildOfClass("Humanoid") or nil else nil

    if not var1 then
        callback(Constants.ErrorTypes.TemporarilyUnavailable)
        return true
    end

    if var1 and var1.RigType ~= Enum.HumanoidRigType.R15 then
        callback(Constants.ErrorTypes.SwitchToR15)
        return true
    end

    local animate = character and character:FindFirstChild("Animate") or nil
    local var2 = var1 and var1:FindFirstChildOfClass("HumanoidDescription") or nil
    if not (animate and var2) then
        callback(Constants.ErrorTypes.NotSupported)
        return true
    end

    local playEmote = animate and animate:FindFirstChild("PlayEmote") or nil
    if playEmote and playEmote:IsA("BindableFunction") then
        return false
    end

    callback(Constants.ErrorTypes.NotSupported)
    return true
end

return MaybeSendEmoteFailureAnalyticsFromPlayer
