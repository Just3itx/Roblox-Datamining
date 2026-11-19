-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = game:GetService("CorePackages").Packages
local React = require(Packages.React)
local VideoCaptureService = game:GetService("VideoCaptureService")
local FaceAnimatorService = game:GetService("FaceAnimatorService")
local FaceChatUtils = require(script.Parent.Parent.Utils.FaceChatUtils)

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local var1 = require(RobloxGui.Modules.SelfView.Analytics).new()

local TrackerMode = Enum.TrackerMode

local trackerMode = FaceChatUtils.getTrackerMode()
local bool1 = not (trackerMode ~= TrackerMode.Video) or trackerMode == TrackerMode.AudioVideo
local bool2 = not (trackerMode ~= TrackerMode.Audio) or trackerMode == TrackerMode.AudioVideo

return function()
    local var2, var3 = React.useState(TrackerMode.None)

    local var4 = React.useCallback(function()
        local trackerMode2 = FaceChatUtils.getTrackerMode()

        local bool3 = trackerMode2 == TrackerMode.Video or trackerMode2 == TrackerMode.AudioVideo
        if bool3 ~= bool1 then
            var1:reportCamState(bool3)
            bool1 = bool3
        end
        local bool4 = trackerMode2 == TrackerMode.Audio or trackerMode2 == TrackerMode.AudioVideo
        if bool4 ~= bool2 then
            var1:reportMicState(bool4)
            bool2 = bool4
        end

        var3(trackerMode2)
    end)

    React.useEffect(function()
        if not VideoCaptureService then
            return function() end
        end

        var4()
        local connection = VideoCaptureService.Started:Connect(var4)
        local connection2 = VideoCaptureService.Stopped:Connect(var4)
        local connection3 = VideoCaptureService.DevicesChanged:Connect(var4)

        local connection4 = FaceAnimatorService:GetPropertyChangedSignal("VideoAnimationEnabled"):Connect(var4)

        local connection5 = FaceAnimatorService:GetPropertyChangedSignal("AudioAnimationEnabled"):Connect(var4)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
            connection4:Disconnect()
            connection5:Disconnect()
        end
    end, {})

    return var2
end
