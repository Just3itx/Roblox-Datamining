-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _EventType = require(script.Parent.Parent.EventType)
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub

local module = { Name = "LeaveGameIconHighlightEvent" }

function module.StartEvent()
    VRHub:SetShowHighlightedLeaveGameIconToggled(true)
end

function module.StopEvent()
    VRHub:SetShowHighlightedLeaveGameIconToggled(false)
end

return module
