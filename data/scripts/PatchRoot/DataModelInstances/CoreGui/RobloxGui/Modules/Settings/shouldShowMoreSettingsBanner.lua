-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

local var1 = nil

local function getAccessResponseEnum() -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = var1
    if var2 then
        return var2
    end

    local accessResponseEnum = require(CorePackages.Workspace.Packages.AccountUpgrade.Eligibility).AccessResponseEnum
    var1 = accessResponseEnum
    return accessResponseEnum
end

local function defaultGetAvailability()
    local eligibility = require(CorePackages.Workspace.Packages.AccountUpgrade.Eligibility)
    local accountUpgradeFlow = require(CorePackages.Workspace.Packages.AccountUpgrade.AccountUpgradeFlow)
    return eligibility.getAvailability(accountUpgradeFlow.Pioneer)
end

local var2 = (setmetatable({}, { __mode = "k" }))

local function getAvailabilityOnce(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    local var3 = var2[func1]
    if var3 then
        return var3
    end

    local var4 = func1()

    if var4.access == getAccessResponseEnum().Denied then
        var2[func1] = var4
    end

    return var4
end

local function shouldShowMoreSettingsBanner(func1: ((...any) -> (...any))?, func2: ((...any) -> (...any))?): boolean
    return if (func1 or isPioneerLaunch)() then getAvailabilityOnce(func2 or defaultGetAvailability).access == getAccessResponseEnum().Denied else false
end

return shouldShowMoreSettingsBanner
