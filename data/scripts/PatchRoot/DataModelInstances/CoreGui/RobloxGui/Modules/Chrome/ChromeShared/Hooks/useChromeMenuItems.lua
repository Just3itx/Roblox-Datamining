-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")
local Service = require(ChromeShared.Service)
local _Chrome = require(CorePackages.Workspace.Packages.Chrome)
local useObservableValue = require(ChromeShared.Hooks.useObservableValue)

return function()
    return useObservableValue(Service:menuList()) or {}
end
