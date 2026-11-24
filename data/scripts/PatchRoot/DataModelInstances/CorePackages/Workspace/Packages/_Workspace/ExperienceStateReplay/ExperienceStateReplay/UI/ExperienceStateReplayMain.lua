-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

if not game:GetEngineFeature("RecordingServicePlaybackApiLua") then
    return tbl1
end

if not game:GetEngineFeature("DmctPlaybackClientApp") and game.PlaceId ~= 123012592984338 then
    return tbl1
end

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local scriptParent = script.Parent
tbl1.state = require(scriptParent.PlaybackState).new(false, false, false)

tbl1.screenGui = Instance.new("ScreenGui")
tbl1.screenGui.Parent = RobloxGui

require(scriptParent.CreateControlBar).createControlBar(tbl1)

require(scriptParent.CreateLoadingOverlay).createLoadingOverlay(tbl1)

require(scriptParent.CreateButtonsTime).createButtonsTime(tbl1)

require(scriptParent.CreateScrubber).createScrubber(tbl1)

require(scriptParent.CreateHelpText).createHelpText(tbl1)

require(scriptParent.ControlButtonsTime).setupControl(tbl1)

require(scriptParent.ControlVisibility).setupControl(tbl1)

local LoadSlices = require(scriptParent.LoadSlices)
if not game:GetEngineFeature("DmctPlaybackClientApp") then
    LoadSlices.experienceCallback(tbl1)
end

require(scriptParent.ControlScrubber).setupControl(tbl1)

require(scriptParent.ListenPlaybackStatusUpdated).setupListener(tbl1)

require(scriptParent.CreateSpectatorCamera).createSpectatorCamera(tbl1)

if game:GetEngineFeature("DmctPlaybackClientApp") then
    require(scriptParent.ReplaySelector).create(tbl1, function(arg1)
        LoadSlices.loadGUID(tbl1, arg1)
    end)
end

return tbl1
