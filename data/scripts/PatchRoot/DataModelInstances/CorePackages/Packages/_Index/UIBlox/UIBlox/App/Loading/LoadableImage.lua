-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = nil

pcall(function()
    RbxAnalyticsService = game:GetService("RbxAnalyticsService")
end)

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParent.Core

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Skeleton = require(scriptParentParentParentParent.Foundation).Skeleton
local DebugProps = require(scriptParent.Enum.DebugProps)
local LoadingStrategy = require(scriptParent.Enum.LoadingStrategy)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local getClosestRadius = require(scriptParentParent.Loading.getClosestRadius)

local Images = require(scriptParentParentParent.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local validateImageSetData = require(Core.ImageSet.Validator.validateImageSetData)

local ContentProvider = require(scriptParentParentParent.App.Context.ContentProvider)

local var1 = Roact.PureComponent:extend("LoadableImage")

local strictInterface = t.strictInterface
local tbl1 = {
    AnchorPoint = t.optional(t.Vector2),
    BackgroundColor3 = t.optional(t.Color3),
    BackgroundTransparency = t.optional(t.number),
    cornerRadius = t.optional(t.UDim),
    Image = t.optional(t.union(t.string, validateImageSetData)),
    ImageColor3 = t.optional(t.Color3),
    ImageTransparency = t.optional(t.number),
    ImageRectOffset = t.optional(t.union(t.Vector2, t.table)),
    ImageRectSize = t.optional(t.union(t.Vector2, t.table)),
    LayoutOrder = t.optional(t.integer),
    loadingImage = t.optional(t.union(t.string, t.table)),
    loadingStrategy = t.optional(LoadingStrategy.isEnumValue),
    loadingTimeout = t.optional(t.numberPositive),
    renderOnLoading = t.optional(t.callback),
    renderOnFailed = t.optional(t.callback),
    MaxSize = t.optional(t.Vector2),
    MinSize = t.optional(t.Vector2),
    onLoaded = t.optional(t.callback),
    Position = t.optional(t.UDim2),
    ScaleType = t.optional(t.enum(Enum.ScaleType)),
    Size = t.UDim2,
    TileSize = t.optional(t.UDim2),
    useShimmerAnimationWhileLoading = t.optional(t.boolean),
    showFailedStateWhenLoadingFailed = t.optional(t.boolean),
    ZIndex = t.optional(t.integer),
    shouldHandleReloads = t.optional(t.boolean),
    contentProvider = t.union(t.instanceOf("ContentProvider"), t.table),
    [DebugProps.forceLoading] = t.optional(t.boolean),
    [DebugProps.forceFailed] = t.optional(t.boolean)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    BackgroundTransparency = 0,
    cornerRadius = UDim.new(0, 0),
    MaxSize = Vector2.new(math.huge, math.huge),
    MinSize = Vector2.new(0, 0),
    useShimmerAnimationWhileLoading = false,
    showFailedStateWhenLoadingFailed = false,
    loadingStrategy = LoadingStrategy.Default,
    loadingTimeout = 30,
    shouldHandleReloads = false
}

function var1.init(arg1)
    arg1.currentImageLoadIndex = 0
    arg1:setState({ eagerRetrying = false })

    arg1.imageRef = Roact.createRef()
    arg1._isMounted = false
end

function var1.renderShimmer(arg1, arg2, uiSizeConstraint, arg3)
    return Roact.createElement("Frame", {
        AnchorPoint = arg1.props.AnchorPoint,
        BorderSizePixel = 0,
        BackgroundColor3 = arg2.PlaceHolder.Color,
        BackgroundTransparency = arg2.PlaceHolder.Transparency,
        LayoutOrder = arg1.props.LayoutOrder,
        Position = arg1.props.Position,
        Size = arg1.props.Size,
        ZIndex = arg1.props.ZIndex
    }, {
        Shimmer = Roact.createElement(Skeleton, {
            Size = UDim2.fromScale(1, 1),
            radius = getClosestRadius({
                None = arg3.Radius.None,
                Small = arg3.Radius.Small,
                Medium = arg3.Radius.Medium,
                Large = arg3.Size.Size_300,
                XLarge = arg3.Radius.Large,
                Circle = arg3.Radius.Circle
            }, arg1.props.cornerRadius)
        }),
        UISizeConstraint = uiSizeConstraint,
        UICorner = Roact.createElement("UICorner", { CornerRadius = arg1.props.cornerRadius }) or nil
    })
end

function var1.defaultRenderOnFail(arg1, arg2, uiSizeConstraint)
    local cornerRadius = arg1.props.cornerRadius

    local iconsStatusImageunavailable = Images["icons/status/imageunavailable"]
    local var2 = iconsStatusImageunavailable.ImageRectSize / Images.ImagesResolutionScale

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        AnchorPoint = arg1.props.AnchorPoint,
        BorderSizePixel = 0,
        BackgroundColor3 = arg2.PlaceHolder.Color,
        BackgroundTransparency = arg2.PlaceHolder.Transparency,
        LayoutOrder = arg1.props.LayoutOrder,
        Position = arg1.props.Position,
        Size = arg1.props.Size,
        ZIndex = arg1.props.ZIndex
    }
    local tbl3 = {
        EmptyIcon = Roact.createElement(ImageSetComponent.Label, {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = iconsStatusImageunavailable,
            ImageColor3 = arg2.UIDefault.Color,
            ImageTransparency = arg2.UIDefault.Transparency,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, var2.X, 0, var2.Y)
        }, {
            UICorner = if cornerRadius == UDim.new(0, 0) then nil else Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
        }),
        UISizeConstraint = uiSizeConstraint,
        UICorner = if cornerRadius == UDim.new(0, 0) then nil else Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil
    }
    return createElement(str1, tbl2, tbl3)
end

function var1.isImageNonNil(arg1): boolean
    return not (arg1.props.Image == Roact.None) and arg1.props.Image ~= nil
end

function var1.getCurrentImageAssetFetchStatus(arg1, arg2)
    local var2 = arg2[arg1:getAssetFetchStatusStateKey(arg1.currentImageLoadIndex)]
    if var2 == nil then
        var2 = Enum.AssetFetchStatus.None
    end

    return var2
end

function var1.isLoadingComplete(arg1, arg2): boolean
    local currentImageAssetFetchStatus = arg1:getCurrentImageAssetFetchStatus(arg2)
    return not (currentImageAssetFetchStatus == Enum.AssetFetchStatus.None
        or currentImageAssetFetchStatus == Enum.AssetFetchStatus.Loading)
        and (currentImageAssetFetchStatus ~= Enum.AssetFetchStatus.Failure
            and currentImageAssetFetchStatus ~= Enum.AssetFetchStatus.TimedOut
            or not arg2.eagerRetrying
            or false)
end

function var1.render(arg1)
    local anchorPoint = arg1.props.AnchorPoint
    local layoutOrder = arg1.props.LayoutOrder
    local propsSize = arg1.props.Size
    local propsPosition = arg1.props.Position
    local backgroundColor3 = arg1.props.BackgroundColor3
    local backgroundTransparency = arg1.props.BackgroundTransparency
    local cornerRadius = arg1.props.cornerRadius
    local scaleType = arg1.props.ScaleType
    local zIndex = arg1.props.ZIndex
    local image = arg1.props.Image
    local imageTransparency = arg1.props.ImageTransparency
    local imageRectOffset = arg1.props.ImageRectOffset
    local imageRectSize = arg1.props.ImageRectSize
    local imageColor3 = arg1.props.ImageColor3
    local maxSize = arg1.props.MaxSize
    local minSize = arg1.props.MinSize
    local renderOnLoading = arg1.props.renderOnLoading
    local renderOnFailed = arg1.props.renderOnFailed
    local loadingImage = arg1.props.loadingImage
    local loadingStrategy = arg1.props.loadingStrategy
    local useShimmerAnimationWhileLoading = arg1.props.useShimmerAnimationWhileLoading
    local showFailedStateWhenLoadingFailed = arg1.props.showFailedStateWhenLoadingFailed
    local bool1 = arg1:isImageNonNil() and arg1:isLoadingComplete(arg1.state)

    local currentImageAssetFetchStatus = arg1:getCurrentImageAssetFetchStatus(arg1.state)
    local bool2 = currentImageAssetFetchStatus ~= Enum.AssetFetchStatus.None
    local bool3 = currentImageAssetFetchStatus == Enum.AssetFetchStatus.Failure

    local bool4 = false

    if arg1.props[DebugProps.forceLoading] then
        bool1 = false
    end
    if arg1.props[DebugProps.forceFailed] then
        bool3 = true
    end

    if maxSize.X ~= math.huge or maxSize.Y ~= math.huge or minSize.X ~= 0 or minSize.Y ~= 0 then
        bool4 = true
    end

    local uiSizeConstraint = bool4 and Roact.createElement("UISizeConstraint", { MaxSize = maxSize, MinSize = minSize })

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local tokens = arg2.Tokens

        if bool3 and renderOnFailed then
            return renderOnFailed()
        end

        if bool3 and showFailedStateWhenLoadingFailed then
            return arg1:defaultRenderOnFail(theme, uiSizeConstraint)
        end

        if not bool1 and renderOnLoading and loadingStrategy ~= LoadingStrategy.Default then
            return renderOnLoading()
        end
        if not bool1 and useShimmerAnimationWhileLoading and loadingStrategy ~= LoadingStrategy.Default then
            return arg1:renderShimmer(theme, uiSizeConstraint, tokens)
        end

        local var2 = bool1 or loadingStrategy == LoadingStrategy.Default
        local onLoading = if bool1 or not renderOnLoading or loadingStrategy ~= LoadingStrategy.Default then nil else renderOnLoading()
        local shimmer = if bool1 or not useShimmerAnimationWhileLoading or loadingStrategy ~= LoadingStrategy.Default or not bool2 then nil else arg1:renderShimmer(theme, uiSizeConstraint, tokens)
        return Roact.createElement(ImageSetComponent.Label, {
            AnchorPoint = anchorPoint,
            BackgroundColor3 = backgroundColor3 or theme.PlaceHolder.Color,
            BackgroundTransparency = backgroundTransparency or theme.PlaceHolder.Transparency,
            BorderSizePixel = 0,
            Image = var2 and image or loadingImage,
            ImageTransparency = imageTransparency,
            ImageRectOffset = imageRectOffset,
            ImageRectSize = imageRectSize,
            ImageColor3 = var2 and imageColor3 or nil,
            LayoutOrder = layoutOrder,
            Position = propsPosition,
            ScaleType = scaleType,
            TileSize = arg1.props.TileSize,
            Size = propsSize,
            ZIndex = zIndex,
            [Roact.Ref] = arg1.imageRef
        }, {
            UISizeConstraint = uiSizeConstraint,
            UICorner = if cornerRadius == UDim.new(0, 0) then nil else Roact.createElement("UICorner", { CornerRadius = cornerRadius }) or nil,
            OnLoading = onLoading,
            Shimmer = shimmer
        })
    end)
end

function var1.maybeCallOnLoaded(arg1, arg2)
    if not arg1.props.onLoaded then
        return
    end

    local var2 = arg1:isLoadingComplete(arg2)
    local var3 = arg1:isLoadingComplete(arg1.state)
    if not var2 and var3 then
        arg1.props.onLoaded()
    end
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg2.Image ~= arg1.props.Image then
        arg1:loadImage()
    end
    arg1:maybeCallOnLoaded(arg3)
end

function var1.didMount(arg1)
    arg1._isMounted = true

    arg1:loadImage()
end

function var1.willUnmount(arg1)
    arg1._isMounted = false
    arg1:dropConnections()
end

function var1.isTerminalStatus(_, assetFetchStatus): boolean
    return assetFetchStatus == Enum.AssetFetchStatus.Success
        or assetFetchStatus == Enum.AssetFetchStatus.Failure
        or assetFetchStatus == Enum.AssetFetchStatus.TimedOut
end

function var1.getImageUri(arg1)
    if not arg1.props.Image then
        return nil
    end

    if typeof(arg1.props.Image) == "string" then
        return arg1.props.Image
    end

    return arg1.props.Image.Image
end

function var1.awaitImageLoaded(arg1, arg2, arg3)
    if arg1:isTerminalStatus(arg3) then
        return
    end

    local imageUri = arg1:getImageUri()

    local function func1(arg4) -- Luacid: Inlined by compiler; 1 call site recovered
        arg1:updateAssetFetchStatusForImageLoadIndex(arg4, arg2, imageUri)
        arg1:maybeReportCounter("Await", arg4)
        if arg1:isTerminalStatus(arg4) and arg1.awaitImageLoadedConnection then
            arg1.awaitImageLoadedConnection:Disconnect()
            arg1.awaitImageLoadedConnection = nil
        end
    end

    if imageUri == "" then
        func1(Enum.AssetFetchStatus.Success)
        return
    end

    arg1.awaitImageLoadedConnection = arg1.props.contentProvider:GetAssetFetchStatusChangedSignal(imageUri):Connect(func1)
end

function var1.maybeReportCounter(_, arg1, arg2)
    pcall(function()
        local var2 = "UIBlox_LoadableImage_" .. arg1 .. "_" .. tostring(arg2)
        RbxAnalyticsService:ReportCounter(var2)
    end)
end

function var1.preloadImageWithRetryLogic(arg1, arg2)
    local imageUri = arg1:getImageUri()
    local num1 = 0

    local none = Enum.AssetFetchStatus.None
    while true do
        if not arg1._isMounted then
            return
        end

        if num1 > 0 then
            task.wait(math.pow(2, num1 - 1) * 1.5)
        end

        arg1.props.contentProvider:PreloadAsync({ imageUri }, function(_, arg3)
            local imageUri2 = arg1:getImageUri()
            if arg1._isMounted and imageUri2 == imageUri then
                arg1:maybeReportCounter("PreloadAsync", arg3)
                none = arg3
                arg1:updateAssetFetchStatusForImageLoadIndex(arg3, arg2, imageUri)
            end
        end)

        local imageUri2 = arg1:getImageUri()

        if not arg1._isMounted or imageUri2 ~= imageUri then
            return
        end

        local success = Enum.AssetFetchStatus.Success

        if none == success then
            break
        end

        num1 += 1
        local failure = Enum.AssetFetchStatus.Failure

        if none == failure and num1 > 3 then
            break
        end
        local timedOut = Enum.AssetFetchStatus.TimedOut

        if none == timedOut and num1 > 5 then
            break
        end

        arg1:setState({ eagerRetrying = true })
    end

    arg1:setState({ eagerRetrying = false })
end

function var1.getAssetFetchStatusStateKey(_, arg1): string
    return "assetFetchStatus_" .. tostring(arg1)
end

function var1.updateAssetFetchStatusForImageLoadIndex(arg1, arg2, arg3, _)
    local tbl2 = {
        [arg1:getAssetFetchStatusStateKey(arg3)] = arg2
    }
    arg1:setState(tbl2)
end

function var1.dropConnections(arg1)
    if arg1.listenForReloadsConnection then
        arg1.listenForReloadsConnection:Disconnect()
        arg1.listenForReloadsConnection = nil
    end
    if arg1.awaitImageLoadedConnection then
        arg1.awaitImageLoadedConnection:Disconnect()
        arg1.awaitImageLoadedConnection = nil
    end
end

function var1.loadImage(arg1)
    local currentImageLoadIndex = arg1.currentImageLoadIndex + 1
    arg1.currentImageLoadIndex = currentImageLoadIndex

    local imageUri = arg1:getImageUri()
    local loadingStrategy = arg1.props.loadingStrategy

    arg1:dropConnections()

    if imageUri == nil then
        arg1:updateAssetFetchStatusForImageLoadIndex(Enum.AssetFetchStatus.Success, currentImageLoadIndex, imageUri)

        arg1:setState({ eagerRetrying = false })

        return
    end

    local assetFetchStatus = arg1.props.contentProvider:GetAssetFetchStatus(imageUri)
    arg1:maybeReportCounter("InitialStatus", assetFetchStatus)
    arg1:updateAssetFetchStatusForImageLoadIndex(assetFetchStatus, currentImageLoadIndex, imageUri)

    if arg1.props.shouldHandleReloads then
        arg1.listenForReloadsConnection = arg1.props.contentProvider:GetAssetFetchStatusChangedSignal(imageUri):Connect(function(arg2, _)
            arg1:maybeReportCounter("Reloads", arg2)
            arg1:updateAssetFetchStatusForImageLoadIndex(arg2, currentImageLoadIndex, imageUri)
        end)
    end
    if loadingStrategy == LoadingStrategy.Eager then
        task.spawn(function()
            arg1:preloadImageWithRetryLogic(currentImageLoadIndex)
        end)
    elseif loadingStrategy == LoadingStrategy.Default then
        arg1:awaitImageLoaded(currentImageLoadIndex, assetFetchStatus)
    end
end

return function(arg1)
    return Roact.createElement(ContentProvider.Consumer, {
        render = function(contentProvider)
            local var2 = Cryo.Dictionary.join(arg1, { contentProvider = contentProvider })

            return Roact.createElement(var1, var2)
        end
    })
end
