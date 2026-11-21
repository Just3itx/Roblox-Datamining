-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius

local ItemCardThumbnailSkeleton = require(script.Parent.ItemCardThumbnailSkeleton)

local useDesignTokens = require(AvatarExperienceUIKitParent.Style).useDesignTokens

local FFlagLuaAppHomePageFirstImageLoadObserver = require(AvatarExperienceUIKitParent.SharedFlags).FFlagLuaAppHomePageFirstImageLoadObserver

local FFlagAXTestSkeletonInCatalog = require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXTestSkeletonInCatalog
local var1 = game:DefineFastFlag("AXTestDontUseSkeletonOnloadInCatalog", false) and FFlagAXTestSkeletonInCatalog

return React.forwardRef(function(tbl1, arg1) -- name: ItemCardThumbnail
    local var2, var3 = React.useState(false)
    local var4 = useDesignTokens()
    local tag = tbl1.tag
    if FFlagLuaAppHomePageFirstImageLoadObserver then
        tag = if tag then `{tag} observed-image` else "observed-image"
    end

    local ref = React.useCallback(function(current)
        if typeof(arg1) == "function" then
            arg1(current)
        elseif typeof(arg1) == "table" then
            arg1.current = current
        end
        var3(false)
        if not current or not tbl1.url then
            return
        end

        local connection = nil
        local var5 = tick()
        connection = RunService.Heartbeat:Connect(function(deltaTime: number)
            var5 += deltaTime
            if current.IsLoaded then
                var3(true)
                if tbl1.onLoaded then
                    tbl1.onLoaded(var5)
                end
                connection:Disconnect()
                return
            end

            if not current.Parent then
                connection:Disconnect()
            end
        end)
    end, { tbl1.onLoaded, tbl1.url })

    if FFlagAXTestSkeletonInCatalog and tbl1.inSkeletonExperiment then
        return React.createElement(React.Fragment, nil, {
            ItemCardThumbnailSkeleton = if var1 or var2 then nil else React.createElement(ItemCardThumbnailSkeleton, {
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2,
                testId = `item-card-thumbnail-skeleton-{tbl1.url}`,
                radius = Radius.Medium
            }),
            ItemCardThumbnailImage = React.createElement(
                Image,
                {
                    imageRect = tbl1.imageRect,
                    Image = tbl1.url,
                    Size = UDim2.fromScale(1, 1),
                    ScaleType = Enum.ScaleType.Crop,
                    ref = ref,
                    testId = `item-card-thumbnail-image-{tbl1.url}`,
                    tag = tbl1.tag
                },
                {
                    CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var4.Radius.Medium) })
                }
            )
        })
    end

    return React.createElement(React.Fragment, nil, {
        ItemCardThumbnailSkeleton = if var2 then nil else React.createElement(Skeleton, {
            Size = UDim2.fromScale(1, 1),
            ZIndex = 2,
            testId = `item-card-thumbnail-skeleton-{tbl1.url}`,
            radius = Radius.Medium
        }),
        ItemCardThumbnailImage = React.createElement(
            Image,
            {
                imageRect = tbl1.imageRect,
                Image = tbl1.url,
                Size = UDim2.fromScale(1, 1),
                ScaleType = Enum.ScaleType.Crop,
                ref = ref,
                testId = `item-card-thumbnail-image-{tbl1.url}`,
                tag = tag
            },
            {
                CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, var4.Radius.Medium) })
            }
        )
    })
end)
