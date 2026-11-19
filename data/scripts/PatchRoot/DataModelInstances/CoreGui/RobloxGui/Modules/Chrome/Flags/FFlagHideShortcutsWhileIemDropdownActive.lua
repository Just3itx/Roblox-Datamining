-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local FFlagEnableConsoleExpControls = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableConsoleExpControls

local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()

return FFlagEnableConsoleExpControls and var1
