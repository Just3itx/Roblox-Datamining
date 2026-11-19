-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local FFlagRemoveHardCodedFriendLimitPrompt = require(RobloxGui.Modules.Flags.FFlagRemoveHardCodedFriendLimitPrompt)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local module = {}
module.__index = module

local str1 = game:GetService("ContentProvider").BaseUrl:lower()
local var1 = string.gsub(str1, "http:", "https:")
local var2 = string.gsub(var1, "www", "friends") .. "v1/users/{userId}/friends/count"

function module.GetFriendCountAsync(_, arg1)
    local count = nil

    local success, result = pcall(function(): string
        local apiUrl = string.gsub(var2, "{userId}", tostring(arg1))
        return HttpRbxApiService:GetAsyncFullUrl(apiUrl)
    end)
    if not success then
        print(var2, "failed because", result)
        return nil
    end

    local var3 = HttpService:JSONDecode(result)

    if var3.count then
        count = var3.count
    end

    return count
end

function module.MaxFriendCount(_): number
    assert(
        not FFlagRemoveHardCodedFriendLimitPrompt,
        "Should not call MaxFriendCount when FFlagRemoveHardCodedFriendLimitPrompt is enabled"
    )
    return 200
end

local bindableEvent = Instance.new("BindableEvent")
local bindableEvent2 = Instance.new("BindableEvent")

LocalPlayer.FriendStatusChanged:connect(function(player: Player, friendStatus: Enum.FriendStatus)
    if friendStatus == Enum.FriendStatus.Friend then
        bindableEvent:Fire(player)
    elseif friendStatus == Enum.FriendStatus.NotFriend then
        bindableEvent2:Fire(player)
    end
end)

StarterGui:RegisterGetCore("PlayerFriendedEvent", function()
    return bindableEvent
end)

StarterGui:RegisterGetCore("PlayerUnfriendedEvent", function()
    return bindableEvent2
end)
return module
