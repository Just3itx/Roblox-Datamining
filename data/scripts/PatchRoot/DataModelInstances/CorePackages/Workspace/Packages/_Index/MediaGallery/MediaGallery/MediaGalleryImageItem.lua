-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local Foundation = require(MediaGalleryParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local IconButton = Foundation.IconButton
local InputSize = Foundation.Enums.InputSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local Image = Foundation.Image

local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)

local getImageUri = require(MediaGallery.getImageUri)

return React.memo(function(tbl1) -- name: MediaGalleryImageItem
    local var1 = useTokens()

    local imageId = tbl1.imageId
    if tbl1.isYouTubeVideo and (imageId == nil or imageId == "") and tbl1.videoHash then
        imageId = string.format("https://img.youtube.com/vi/%s/hqdefault.jpg", tbl1.videoHash)
    end
    local uDim = UDim.new(0, tbl1.cornerRadius or var1.Radius.Medium)

    React.useEffect(function()
        if not imageId then
            return
        end

        task.spawn(function()
            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Image = getImageUri(imageId)
            game:GetService("ContentProvider"):PreloadAsync({ imageLabel })
            imageLabel:Destroy()
        end)
    end, { imageId })

    local var2 = React.useCallback(function(assetFetchStatus)
        if tbl1.onMediaResolved then
            tbl1.onMediaResolved(assetFetchStatus == Enum.AssetFetchStatus.Success)
        end
    end, { tbl1.onMediaResolved })

    local onActivated = React.useCallback(function()
        if not tbl1.onYouTubeVideoPlay then
            return
        end

        tbl1.onYouTubeVideoPlay(
            {
                index = tbl1.itemIndex,
                imageId = imageId,
                videoHash = tbl1.videoHash or "",
                videoTitle = tbl1.videoTitle
            }
        )
    end, {
        tbl1.videoHash,
        tbl1.videoTitle,
        imageId,
        tbl1.onYouTubeVideoPlay,
        tbl1.itemIndex
    })
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = tbl1.itemIndex,
        Size = tbl1.Size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = { Image = 0, GradientOverlay = 0, PlayButton = 0, ItemOverlay = 0 }
    local createElement2 = React.createElement
    local var4 = Image
    local tbl4 = {
        cornerRadius = uDim,
        Size = UDim2.fromScale(1, 1),
        Image = getImageUri(imageId),
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = 1,
        onLoaded = 0
    }
    if not tbl1.onMediaResolved then
        var2 = nil
    end

    tbl4.onLoaded = var2
    tbl3.Image = createElement2(var4, tbl4)
    local element

    if tbl1.showGradient == false or not tbl1.gradientOverlayHeight then
        element = nil
    else
        element = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, tbl1.gradientOverlayHeight),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = 2
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.2) })
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = uDim })
        })
    end

    tbl3.GradientOverlay = element
    local element2

    if tbl1.isYouTubeVideo then
        element2 = React.createElement(IconButton, {
            icon = {
                name = Foundation.Enums.IconName.PlayLarge
            },
            size = InputSize.Large,
            variant = ButtonVariant.OverMedia,
            isCircular = true,
            onActivated = onActivated,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -var1.Size.Size_500, 1, -var1.Size.Size_500),
            ZIndex = 3
        })
    else
        element2 = nil
    end

    tbl3.PlayButton = element2

    tbl3.ItemOverlay = if tbl1.overlay then React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 5
        },
        {
            Overlay = tbl1.overlay
        }
    ) else nil
    return createElement(str1, tbl2, tbl3)
end)
