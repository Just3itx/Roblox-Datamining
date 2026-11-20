-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)

local TrackerPrompt = require(RobloxGui.Modules.Tracker.TrackerPrompt)

local tbl1 = ({})
tbl1.__index = tbl1

function tbl1:showPrompt(promptType)
    if self.trackerPrompt then
        Roact.update(self.trackerPrompt, Roact.createElement(TrackerPrompt, { promptType = promptType }))
        return
    end

    self.trackerPrompt = Roact.mount(Roact.createElement(TrackerPrompt, { promptType = promptType }), CoreGui, "RobloxTrackerPromptGui")
end

function tbl1.new()
    local tbl2 = { trackerPrompt = nil }
    setmetatable(tbl2, tbl1)

    return tbl2
end

return tbl1.new()
