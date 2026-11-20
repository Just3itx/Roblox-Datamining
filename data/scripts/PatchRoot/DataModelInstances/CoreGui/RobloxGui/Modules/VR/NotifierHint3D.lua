-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local var1 = require(CorePackages.Workspace.Packages.AppCommonLib).Create("ImageLabel")({
    Name = "NotificationObject",
    Position = UDim2.new(0.5, -860, 1, -301),
    Size = UDim2.new(0, 1700, 0, 1000),
    BackgroundTransparency = 1,
    Image = "rbxasset://textures/ui/VR/notifier_glow.png",
    ImageTransparency = 0,
    BorderSizePixel = 0
})

module.DEFAULT_DURATION = 5

local function CreateNotificationEffect()
    local module2 = {}

    local connection = nil

    function module2.Init(arg1, arg2)
        local startTime = tick()
        local var2 = startTime + arg2

        if connection then
            connection:disconnect()
            connection = nil
        end
        connection = RunService.RenderStepped:connect(function()
            if tick() >= var2 then
                arg1:Cancel()
                return
            end
            var1.Parent = RobloxGui
            local num1 = (math.sin((tick() - startTime) * 2.5 + math.pi / 2) + 1) / 2

            var1.ImageTransparency = num1 * 0.5 + 0.5
        end)
    end

    function module2.Cancel(_)
        if connection then
            connection:disconnect()
            connection = nil
        end
        var1.Parent = nil
    end

    return module2
end

local notificationEffect = CreateNotificationEffect()

function module.BeginNotification(arg1, arg2)
    arg1:CancelNotification()
    notificationEffect:Init(arg2 or arg1.DEFAULT_DURATION)
end

function module.CancelNotification(_)
    notificationEffect:Cancel()
end

return module
