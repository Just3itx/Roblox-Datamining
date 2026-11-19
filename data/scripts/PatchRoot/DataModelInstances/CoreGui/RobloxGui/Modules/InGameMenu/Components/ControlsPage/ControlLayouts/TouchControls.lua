-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.InGameMenuDependencies).Roact

local KeyboardControls = require(script.Parent.KeyboardControls)

local function TouchControls(arg1)
    return Roact.createElement(KeyboardControls, arg1)
end

return TouchControls
