-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InputUiParent = script:FindFirstAncestor("InputUi").Parent
local React = require(InputUiParent.React)
local Players = game:GetService("Players")
local ThirdPartyUserService = nil
pcall(function()
    ThirdPartyUserService = game:GetService("ThirdPartyUserService")
end)
local GamepadDisconnectedModalView = require(script.Parent.GamepadDisconnectedModalView)

local function getPlatformOrRobloxUsername() -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if ThirdPartyUserService then ThirdPartyUserService:GetUserPlatformName() else ""

    if var1 == "" or var1 == nil then
        local localPlayer = Players.LocalPlayer
        if localPlayer then
            var1 = localPlayer.DisplayName or localPlayer.Name
        end
    end
    return var1 or ""
end

return function(_)
    local username = getPlatformOrRobloxUsername()
    return React.createElement(GamepadDisconnectedModalView, { username = username })
end
