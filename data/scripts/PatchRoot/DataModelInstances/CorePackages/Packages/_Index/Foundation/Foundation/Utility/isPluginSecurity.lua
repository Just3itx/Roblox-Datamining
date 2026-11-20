-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local Wrappers = require(Foundation.Utility.Wrappers)

local function isPluginSecurity(): boolean
    local CoreGui = Wrappers.Services.CoreGui
    local success, _result = pcall(function()
        local _children = CoreGui:GetChildren()
    end)

    return success
end

return isPluginSecurity
