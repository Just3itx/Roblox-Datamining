-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local Constants = require(script.Parent.Parent.TopBar.Constants)

local CreateLayoutValues = PlayerList.Common.CreateLayoutValues
return function(arg1)
    return CreateLayoutValues(arg1, Constants)
end
