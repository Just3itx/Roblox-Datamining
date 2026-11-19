-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local module = {}
module.__index = module

function module.new()
    local tbl1 = {
        evenStream = EventStream.new(RbxAnalyticsService)
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:sendCoreGuiFinalAnalytic()
    local tbl1 = {
        placeid = tostring(game.PlaceId),
        universeid = tostring(game.GameId),
        sessionid = RbxAnalyticsService:GetSessionId()
    }
    for _, enumItem in Enum.CoreGuiType:GetEnumItems() do
        tbl1[enumItem.Name] = tostring(StarterGui:GetCoreGuiEnabled(enumItem))
    end

    local str1 = ""
    pcall(function()
        str1 = tostring(StarterGui:GetCore("ResetButtonCallback"))
    end)
    tbl1.ResetButtonCallback = str1
    self.evenStream:sendEventDeferred("core_gui_final_state", "core_gui_final_state", tbl1)
end

return module
