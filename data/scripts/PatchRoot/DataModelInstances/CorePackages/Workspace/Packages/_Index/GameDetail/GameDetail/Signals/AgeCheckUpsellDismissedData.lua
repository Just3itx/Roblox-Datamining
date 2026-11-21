-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
local Signals = require(GameDetailParent.Signals)

local FFlagLuaAppDismissUnlockUpsell = require(GameDetailParent.SharedFlags).FFlagLuaAppDismissUnlockUpsell

local var1, var2 = Signals.createSignal(false)

local function getIsAgeCheckUpsellDismissed(arg1)
    return var1(arg1)
end

local function setAgeCheckUpsellDismissed()
    var2(true)
end

local function getLocalPlayerUserId(): number? -- Luacid: unused: defined but never referenced
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or nil
    return if userId == nil or userId <= 0 then nil else userId
end

if FFlagLuaAppDismissUnlockUpsell then
    local userId = if Players.LocalPlayer then Players.LocalPlayer.UserId or nil else nil
    local var3 = if userId == nil or userId <= 0 then nil else userId

    Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
        local userId2 = Players.LocalPlayer and Players.LocalPlayer.UserId or nil
        if userId2 == nil or userId2 <= 0 then
            userId2 = nil
        end

        if userId2 ~= var3 then
            var3 = userId2
            var2(false)
        end
    end)
end

return {
    getIsAgeCheckUpsellDismissed = getIsAgeCheckUpsellDismissed,
    setAgeCheckUpsellDismissed = setAgeCheckUpsellDismissed
}
