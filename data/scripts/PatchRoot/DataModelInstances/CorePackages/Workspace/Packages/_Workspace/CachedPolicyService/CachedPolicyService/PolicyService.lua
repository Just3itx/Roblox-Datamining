-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Players = game:GetService("Players")

local IsSubjectToChinaPolicies = true
local IsContentSharingAllowed = false
local policyInfoForPlayerAsync = nil
local bool1 = false
local bool2 = false

local bindableEvent = Instance.new("BindableEvent")

local module = {}

function module.InitAsync(_)
    if _G.__TESTEZ_RUNNING_TEST__ then
        IsSubjectToChinaPolicies = false
        IsContentSharingAllowed = true
        return
    end

    if bool1 then
        return
    end

    if bool2 then
        bindableEvent.Event:Wait()
        return
    end

    bool2 = true

    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players.PlayerAdded:Wait()
        localPlayer = Players.LocalPlayer
    end
    assert(localPlayer, "")

    pcall(function()
        policyInfoForPlayerAsync = game:GetService("PolicyService"):GetPolicyInfoForPlayerAsync(localPlayer)
    end)
    if policyInfoForPlayerAsync then
        IsSubjectToChinaPolicies = policyInfoForPlayerAsync.IsSubjectToChinaPolicies
        IsContentSharingAllowed = policyInfoForPlayerAsync.IsContentSharingAllowed
    end

    bool1 = true
    bindableEvent:Fire()
end

function module.IsSubjectToChinaPolicies(arg1)
    arg1:InitAsync()

    return IsSubjectToChinaPolicies
end

function module.IsContentSharingAllowed(arg1)
    arg1:InitAsync()

    return IsContentSharingAllowed
end

return module
