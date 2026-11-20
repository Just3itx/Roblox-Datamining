-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local UIBlox = require(CorePackages.Packages.UIBlox)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images

local PresenceType = {
    Offline = "OFFLINE",
    Online = "ONLINE",
    InGame = "IN_GAME",
    InStudio = "IN_STUDIO"
}

local tbl2 = {}
local tbl3 = {
    Image = "component_assets/circle_16",
    Color = Color3.fromRGB(0, 180, 109),
    Size = UDim2.new(0, 12, 0, 12)
}
tbl2[PresenceType.Online] = tbl3

tbl2[PresenceType.InGame] = { Image = "icons/menu/games_small" }

tbl2[PresenceType.InStudio] = { Image = "icons/logo/studiologo_small" }

return {
    PresenceType = PresenceType,
    GetIcon = function(str1: string)
        local var1 = tbl2[str1]
        if not var1 then
            return
        end

        return React.createElement(ImageSetLabel, {
            Image = Images[var1.Image],
            BackgroundTransparency = 1,
            ImageColor3 = var1.Color,
            Size = var1.Size or UDim2.new(0, IconSize.Small, 0, IconSize.Small)
        })
    end
}
