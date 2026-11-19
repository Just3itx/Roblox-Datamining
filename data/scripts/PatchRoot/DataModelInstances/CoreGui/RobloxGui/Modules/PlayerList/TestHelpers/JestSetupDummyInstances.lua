-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

if not RobloxGui:FindFirstChild("SendNotificationInfo") then
    local sendNotificationInfo = Instance.new("BindableEvent")
    sendNotificationInfo.Name = "SendNotificationInfo"
    sendNotificationInfo.Parent = RobloxGui
end
