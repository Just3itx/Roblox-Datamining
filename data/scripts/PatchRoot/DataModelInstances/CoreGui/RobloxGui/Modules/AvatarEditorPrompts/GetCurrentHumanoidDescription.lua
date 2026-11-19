-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Promise = require(CorePackages.Packages.Promise)

return function()
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function(): HumanoidDescription
            return Players:GetHumanoidDescriptionFromUserIdAsync(Players.LocalPlayer.UserId)
        end)

        if success then
            callback(result)
            return
        end
        callback2()
    end)
end
