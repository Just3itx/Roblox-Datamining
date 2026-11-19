-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local var1 = require(CorePackages.Workspace.Packages.CoreScriptsPlayerFeedback).createApp()
var1.instance.Parent = RobloxGui

return var1
