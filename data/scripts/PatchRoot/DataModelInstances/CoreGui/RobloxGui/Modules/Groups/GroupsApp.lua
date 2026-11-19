-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local var1 = require(CorePackages.Workspace.Packages.Groups).GroupsInExperienceApp.createApp()

var1.mountCoreUI(RobloxGui)

return var1
