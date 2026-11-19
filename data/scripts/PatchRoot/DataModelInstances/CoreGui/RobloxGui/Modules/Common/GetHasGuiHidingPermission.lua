-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Promise = require(CorePackages.Packages.Promise)

local RobloxGui = CoreGui.RobloxGui
local GetFIntCanHideGuiGroupId = require(RobloxGui.Modules.Flags.GetFIntCanHideGuiGroupId)

return function(_, arg1, _)
    return Promise.new(function(callback, callback2)
        if not game:GetEngineFeature("GuiHidingApiSupport") then
            callback(false)
            return
        end

        if not arg1 then
            callback2("Invalid local player")
            return
        end

        local isInGroupAsync = false
        local success, result = pcall(function()
            local fIntCanHideGuiGroupId = GetFIntCanHideGuiGroupId()
            isInGroupAsync = arg1:IsInGroupAsync(fIntCanHideGuiGroupId)
        end)

        if success then
            callback(isInGroupAsync)
        else
            callback2(result)
        end
    end)
end
