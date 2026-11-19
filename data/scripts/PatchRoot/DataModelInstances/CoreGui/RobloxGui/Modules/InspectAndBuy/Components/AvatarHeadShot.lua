-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Colors = require(scriptParentParent.Colors)

local var1 = Roact.PureComponent:extend("AvatarHeadShot")

local Modules = CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules")

local Headshot = require(Modules.Common.LegacyThumbnailUrls).Headshot

function var1.render(arg1)
    local playerId = arg1.props.playerId
    local image = if playerId and playerId ~= "" then Headshot:format(playerId, 48, 48) else nil

    if not image then
        return nil
    end

    return Roact.createElement("ImageLabel", {
        Size = UDim2.new(0, 48, 0, 48),
        BackgroundColor3 = Colors.GrayBackground,
        BorderSizePixel = 0,
        Image = image,
        LayoutOrder = 1
    }, {
        MaskFrame = Roact.createElement("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = "rbxasset://textures/ui/LuaApp/graphic/gr-avatar mask-90x90.png",
            ImageColor3 = Colors.Carbon
        })
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        playerId = arg1.playerId
    }
end)(var1)
