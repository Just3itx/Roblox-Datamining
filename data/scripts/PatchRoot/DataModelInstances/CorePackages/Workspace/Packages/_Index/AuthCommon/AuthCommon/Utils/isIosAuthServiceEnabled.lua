-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local AuthLocalStorageKeys = require(AuthCommon.Enums.AuthLocalStorageKeys)
local AppStorageService = game:GetService("AppStorageService")

local function isIosAuthServiceEnabled(): boolean
    return AppStorageService:GetItem(AuthLocalStorageKeys.IosAuthServiceEnabled) == "true"
end

return isIosAuthServiceEnabled
