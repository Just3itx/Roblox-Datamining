-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = game:GetService("CorePackages").Packages
local React = require(Packages.React)

local Players = game:GetService("Players")

local function useLocalPlayer()
    return React.useMemo(function(): Player
        local localPlayer = Players.LocalPlayer
        while not localPlayer do
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            localPlayer = Players.LocalPlayer
        end
        assert(localPlayer ~= nil)
        return localPlayer
    end)
end

return useLocalPlayer
