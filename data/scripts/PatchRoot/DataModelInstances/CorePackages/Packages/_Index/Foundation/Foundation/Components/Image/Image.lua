-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local FoundationCloudAssets = require(FoundationParent.FoundationCloudAssets)
local FoundationImages = require(FoundationParent.FoundationImages)
local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local useOnLoaded = require(script.Parent.useOnLoaded)

local Assets = FoundationCloudAssets.Assets
local Interactable = require(Foundation.Components.Interactable)
local Images = FoundationImages.Images
local IconImages_DEPRECATED = FoundationImages.IconImages_DEPRECATED

local getScaledSlice = require(script.Parent.ImageSet.getScaledSlice)
local isCloudAsset = require(script.Parent.CloudAsset.isCloudAsset)
local isFoundationImage = require(script.Parent.ImageSet.isFoundationImage)

local GuiObjectChildren = require(Foundation.Utility.GuiObjectChildren)
local _Types = require(Foundation.Components.Types)
local indexBindable = require(Foundation.Utility.indexBindable)
local useDefaultTags = require(Foundation.Utility.useDefaultTags)
local withDefaults = require(Foundation.Utility.withDefaults)
local withGuiObjectProps = require(Foundation.Utility.withGuiObjectProps)

local useStyleTags = require(Foundation.Providers.Style.useStyleTags)

local tbl1 = {
    AutoLocalize = false,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    isDisabled = false
}

local function getAspectRatio(vector2: Vector2) -- Luacid: Inlined by compiler; 6 call sites recovered
    return vector2.X / vector2.Y
end

local bool1 = _G.__DEV__ == true

local function getFoundationImageAsset(str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    local var1 = IconImages_DEPRECATED[str1]
    if var1 then
        return var1
    elseif bool1 then
        return Images[str1]
    end

    return rawget(Images, str1)
end

local function shouldUseFoundationSlice(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if isFoundationImage(str1) then isCloudAsset(str1) or getFoundationImageAsset(str1) ~= nil else false
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Image
    local var1 = withDefaults(arg1, tbl1)

    local bool2 = var1.onStateChanged ~= nil or var1.onActivated ~= nil or var1.onSecondaryActivated ~= nil

    local aspectRatio = var1.aspectRatio

    local var2, var3 = React.useState(false)
    React.useEffect(function()
        if not ReactIs.isBinding(var1.Image) then
            return
        end

        local image = var1.Image
        var3(isCloudAsset(image:getValue()))

        local var4 = React.__subscribeToBinding(image, function(str1: string)
            var3(isCloudAsset(str1))
        end)

        return function()
            var4()
        end
    end, { var1.Image, aspectRatio })

    local image, imageRectOffset, imageRectSize, var4 = React.useMemo(function()
        local image = var1.Image
        local offset = if var1.imageRect then var1.imageRect.offset else nil
        local size = if var1.imageRect then var1.imageRect.size else nil
        local var4 = aspectRatio

        if not ReactIs.isBinding(var1.Image) then
            if typeof(var1.Image) == "string" and isFoundationImage(var1.Image) then
                if isCloudAsset(var1.Image) then
                    local asset = Assets[var1.Image]
                    local assetId = asset.assetId
                    return assetId, offset, size, getAspectRatio(asset.size)
                end

                local foundationImageAsset = getFoundationImageAsset(var1.Image)
                if foundationImageAsset then
                    image = foundationImageAsset.Image
                    offset = foundationImageAsset.ImageRectOffset
                    size = foundationImageAsset.ImageRectSize
                end
            end

            return image, offset, size, var4
        end

        local function getImageBindingValue(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
            return var1.Image:map(function(str2: string)
                if not isFoundationImage(str2) then
                    if str1 == "Image" then
                        return str2
                    end

                    if str1 == "ImageRectOffset" and var1.imageRect then
                        return var1.imageRect.offset
                    end

                    if str1 == "ImageRectSize" and var1.imageRect then
                        return var1.imageRect.size
                    end

                    return nil
                end
                if not isCloudAsset(str2) then
                    local foundationImageAsset = getFoundationImageAsset(str2)
                    return if str1 == "AspectRatio" then aspectRatio elseif foundationImageAsset then foundationImageAsset[str1] elseif str1 == "Image" then str2 else nil
                end

                local asset = Assets[str2]
                if str1 == "Image" then
                    return asset.assetId
                elseif str1 == "AspectRatio" then
                    return getAspectRatio(asset.size)
                end
                return nil
            end)
        end

        local var5 = if var2 then getImageBindingValue("AspectRatio") else aspectRatio
        return getImageBindingValue("Image"), getImageBindingValue("ImageRectOffset"), getImageBindingValue("ImageRectSize"), var5
    end, {
        var1.Image,
        var1.imageRect,
        var2,
        aspectRatio,
        Images
    })

    local center = nil
    local scale = nil
    local scaleType = var1.ScaleType
    if var1.slice then
        if ReactIs.isBinding(var1.Image) then
            local var8 = var1.Image:map(function(str1: string)
                if shouldUseFoundationSlice(str1) then
                    return getScaledSlice(var1.slice.center, var1.slice.scale)
                end
                return var1.slice
            end)

            center = var8:map(function(arg2)
                return arg2.center
            end)
            scale = var8:map(function(arg2)
                return arg2.scale
            end)
        elseif typeof(var1.Image) == "string" then
            if shouldUseFoundationSlice(var1.Image) then
                local scaledSlice = getScaledSlice(var1.slice.center, var1.slice.scale)
                center = scaledSlice.center
                scale = scaledSlice.scale
            else
                center = var1.slice.center
                scale = var1.slice.scale
            end
        end
        scaleType = Enum.ScaleType.Slice
    end

    var1.aspectRatio = var4

    local str1 = if var1.backgroundStyle == nil then "gui-object-defaults" else "gui-object-defaults x-default-transparency"

    local var8 = useDefaultTags(var1.tag, str1)
    local var9 = useStyleTags(var8)
    useOnLoaded(image, var1.onLoaded)

    local imageContent = React.useMemo(function()
        if ReactIs.isBinding(var1.ImageContent) then
            return var1.ImageContent:map(function(arg2)
                if typeof(arg2) == "string" then
                    return Content.fromUri(arg2)
                end
                return arg2
            end)
        elseif typeof(var1.ImageContent) == "string" then
            return Content.fromUri(var1.ImageContent)
        end
        return var1.ImageContent
    end, { var1.ImageContent })

    local component = if bool2 then "ImageButton" else "ImageLabel"

    local var11 = withGuiObjectProps
    local tbl2 = {
        AutoButtonColor = if component == "ImageButton" then var1.AutoButtonColor else nil,
        Image = image,
        ImageContent = imageContent,
        ImageColor3 = if var1.imageStyle then indexBindable(var1.imageStyle, "Color3") else nil,
        ImageTransparency = if var1.imageStyle then indexBindable(var1.imageStyle, "Transparency") else nil,
        ImageRectOffset = imageRectOffset,
        ImageRectSize = imageRectSize,
        ResampleMode = var1.ResampleMode,
        ScaleType = scaleType,
        SliceCenter = center,
        SliceScale = scale,
        TileSize = var1.TileSize,
        ref = ref,
        [React.Tag] = var9
    }
    local var12 = var11(var1, tbl2)
    local var13

    if bool2 then
        var13 = Interactable
        var12.component = component
        var12.onActivated = var1.onActivated
        var12.onSecondaryActivated = var1.onSecondaryActivated
        var12.onStateChanged = var1.onStateChanged
        var12.stateLayer = var1.stateLayer
        var12.isDisabled = var1.isDisabled
        var12.cursor = var1.cursor
    else
        var13 = component
    end

    return React.createElement(var13, var12, GuiObjectChildren(var1))
end))
