-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local module = {}
module.__index = module

function module.new()
    local module2 = {
        evenStream = EventStream.new(RbxAnalyticsService),
        playSessionStart = os.clock()
    }

    function module2.sendCoreGuiAnalytic(arg1, bool1: boolean)
        local num1 = math.round((os.clock() - module2.playSessionStart) * 1000)

        local tbl1 = {
            placeid = tostring(game.PlaceId),
            universeid = tostring(game.GameId),
            type = tostring(arg1.Name),
            enabled = tostring(bool1),
            sessionid = RbxAnalyticsService:GetSessionId(),
            playSessionDurationMs = tostring(num1)
        }
        module2.evenStream:sendEventDeferred("core_gui_type", "core_gui_type", tbl1)
    end

    module2.signalConnection = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
        module2.sendCoreGuiAnalytic(coreGuiType, enabled)
    end)

    setmetatable(module2, module)
    return module2
end

function module:DisconnectSignal()
    self.signalConnection:Disconnect()
end

module.new()

return module
