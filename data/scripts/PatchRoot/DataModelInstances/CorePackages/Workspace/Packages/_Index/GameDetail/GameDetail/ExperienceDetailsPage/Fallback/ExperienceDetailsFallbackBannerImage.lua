-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image

local useExperienceBannerImage = require(script.Parent.Parent.useExperienceBannerImage)
local useGameInfo = require(script.Parent.Parent.useGameInfo)

local function ExperienceDetailsBannerImageSkeleton()
    return React.createElement(View, { tag = "size-full bg-surface-100" })
end

return {
    Skeleton = React.memo(ExperienceDetailsBannerImageSkeleton),
    Error = React.memo(function(tbl1) -- name: ExperienceDetailsBannerImageError
        local var1 = useGameInfo(tbl1.universeId)
        local var2 = useExperienceBannerImage(tbl1.universeId)

        local var3 = var1 and var1.isUnavailable == true
        local url = var2.status == "Success" and var2.url

        if var3 or not url then
            return React.createElement(ExperienceDetailsBannerImageSkeleton)
        end

        return React.createElement(Image, { Image = var2.url, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop })
    end)
}
