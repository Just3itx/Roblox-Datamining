-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local bool1 = game:DefineFastFlag("EnableConsoleExpControlsIXP684", false)

local success, result = pcall(function(): string
    return AppStorageService:GetItem("ExperienceMenuVersion")
end)
return if success and (result == "hamburger" or result == "submenu") then bool1 else false
