-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local SharedFlagsParent = script:FindFirstAncestor("SharedFlags").Parent
local AppStorageJsonCacheUtils = require(SharedFlagsParent.AppCommonLib).Utils.AppStorageJsonCacheUtils

local GetFFlagEnableAppStorageJsonCacheInABTest = require(script.Parent.GetFFlagEnableAppStorageJsonCacheInABTest)

local str1 = game:DefineFastString("ExperienceReactDeferredScheduler_LayerName", "UIEcosystem.User")

return function()
    if GetFFlagEnableAppStorageJsonCacheInABTest() then
        local cachedJsonForKey = AppStorageJsonCacheUtils.default:getCachedJsonForKey("ExperimentCache")
        if cachedJsonForKey then
            return cachedJsonForKey[str1]
        end
    else
        local success, result = pcall(function(): string
            return AppStorageService:GetItem("ExperimentCache")
        end)
        if success then
            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)

            if success2 and result2 then
                return result2[str1]
            end
        end
    end
    return nil
end
