-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")

local Constants = require(WhatsNew.Constants)
local EntryStorage = require(script.Parent.EntryStorage)
local _Types = require(WhatsNew.Types)

local Players = game:GetService("Players")

local function getAccountAgeDays(): number -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    return if localPlayer == nil then math.huge else localPlayer.AccountAge
end

return {
    createResolveDeps = function(tbl1)
        local tbl2 = tbl1 or {}
        local accountAgeDays = tbl2.accountAgeDays or getAccountAgeDays()

        return {
            storage = EntryStorage.getEntries(),
            onboardingEligible = accountAgeDays < Constants.OnboardingAccountAge,
            currentTime = tbl2.currentTime or DateTime.now().UnixTimestamp
        }
    end
}
