-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Promise = require(CorePackages.Packages.Promise)
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local TrackerMenu = require(RobloxGui.Modules.Tracker.TrackerMenu)
local TrackerPromptType = require(RobloxGui.Modules.Tracker.TrackerPromptType)

return function()
    TrackerMenu:showPrompt(TrackerPromptType.None)
    Promise.delay(1 / 60):andThen(function()
        TrackerMenu:showPrompt(TrackerPromptType.VideoNoPermission)
    end)
end
