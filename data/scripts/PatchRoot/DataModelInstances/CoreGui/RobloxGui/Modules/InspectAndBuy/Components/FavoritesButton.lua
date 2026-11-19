-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local scriptParentParent = script.Parent.Parent
local Colors = require(scriptParentParent.Colors)
local CreateFavoriteForAsset = require(scriptParentParent.Thunks.CreateFavoriteForAsset)
local DeleteFavoriteForAsset = require(scriptParentParent.Thunks.DeleteFavoriteForAsset)
local CreateFavoriteForBundle = require(scriptParentParent.Thunks.CreateFavoriteForBundle)
local DeleteFavoriteForBundle = require(scriptParentParent.Thunks.DeleteFavoriteForBundle)
local GetFavoriteForAsset = require(scriptParentParent.Thunks.GetFavoriteForAsset)
local GetFavoriteForBundle = require(scriptParentParent.Thunks.GetFavoriteForBundle)
local GotFavoriteForDetailsItem = require(scriptParentParent.Selectors.GotFavoriteForDetailsItem)
local IsDetailsItemPartOfBundleAndOffsale = require(scriptParentParent.Selectors.IsDetailsItemPartOfBundleAndOffsale)
local GetIsFavorite = require(scriptParentParent.Selectors.GetIsFavorite)
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local getSelectionImageObjectRounded = require(scriptParentParent.getSelectionImageObjectRounded)

local Favorite = require(script.Parent.Common.ControllerShortcutKeycodes).Favorite

local var1 = Roact.PureComponent:extend("FavoritesButton")

function var1.init(arg1)
    arg1.selectedImage = getSelectionImageObjectRounded()
    arg1.fetchFavoriteRetries = 0

    ContextActionService:BindCoreAction("FavoriteGamepadShortcut", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.End then
            return Enum.ContextActionResult.Pass
        end

        arg1:activateButton()
        return Enum.ContextActionResult.Sink
    end, false, Favorite)
end

function var1.willUpdate(arg1, arg2)
    local gotFavoriteForDetailsItem = arg2.gotFavoriteForDetailsItem
    local getFavoriteForAsset = arg1.props.getFavoriteForAsset
    local getFavoriteForBundle = arg1.props.getFavoriteForBundle
    if not arg2 or not arg2.assetInfo or gotFavoriteForDetailsItem or not (arg1.fetchFavoriteRetries < 10) then
        return
    end

    local assetInfo = arg2.assetInfo
    local var2 = assetInfo and assetInfo.parentBundleId ~= nil

    coroutine.wrap(function()
        if not var2 then
            getFavoriteForAsset(assetInfo.assetId)
            return
        end
        local bundleId = UtilityFunctions.getBundleId(assetInfo)
        getFavoriteForBundle(bundleId)
    end)()
    arg1.fetchFavoriteRetries += 1
end

function var1.activateButton(arg1)
    local isFavorited = arg1.props.isFavorited
    local isDetailsItemPartOfBundleAndOffsale = arg1.props.IsDetailsItemPartOfBundleAndOffsale
    local createFavoriteForAsset = arg1.props.createFavoriteForAsset
    local deleteFavoriteForAsset = arg1.props.deleteFavoriteForAsset
    local createFavoriteForBundle = arg1.props.createFavoriteForBundle
    local deleteFavoriteForBundle = arg1.props.deleteFavoriteForBundle
    local assetInfo = arg1.props.assetInfo

    if isFavorited then
        if isDetailsItemPartOfBundleAndOffsale then
            deleteFavoriteForBundle((UtilityFunctions.getBundleId(assetInfo)))
            return
        end
        deleteFavoriteForAsset(assetInfo.assetId)
    elseif isDetailsItemPartOfBundleAndOffsale then
        createFavoriteForBundle((UtilityFunctions.getBundleId(assetInfo)))
    else
        createFavoriteForAsset(assetInfo.assetId)
    end
end

function var1.willUnmount(_)
    ContextActionService:UnbindCoreAction("FavoriteGamepadShortcut")
end

function var1.render(arg1)
    local isFavorited = arg1.props.isFavorited
    local favoriteButtonRef = arg1.props.favoriteButtonRef

    local createElement = Roact.createElement
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 44, 0, 44),
        LayoutOrder = 1,
        Image = "rbxasset://textures/ui/InspectMenu/Button_outline.png",
        ImageColor3 = Colors.White,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(5, 5, 120, 20),
        SelectionImageObject = arg1.selectedImage,
        Visible = true,
        [Roact.Ref] = favoriteButtonRef
    }

    tbl1[Roact.Event.Activated] = function()
        arg1:activateButton()
    end

    return createElement("ImageButton", tbl1, {
        FavoriteIcon = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 26, 0, 26),
            Position = UDim2.new(0, 22, 0, 22),
            Image = if isFavorited then "rbxasset://textures/ui/InspectMenu/ico_favorite.png" else "rbxasset://textures/ui/InspectMenu/ico_favorite_off.png",
            ImageColor3 = Colors.White
        })
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        view = arg1.view,
        assetInfo = arg1.assets[assetId],
        bundleInfo = arg1.bundles,
        gotFavoriteForDetailsItem = GotFavoriteForDetailsItem(arg1),
        isFavorited = GetIsFavorite(arg1),
        IsDetailsItemPartOfBundleAndOffsale = IsDetailsItemPartOfBundleAndOffsale(arg1)
    }
end, function(callback)
    return {
        createFavoriteForAsset = function(arg1)
            callback(CreateFavoriteForAsset(arg1))
        end,
        deleteFavoriteForAsset = function(arg1)
            callback(DeleteFavoriteForAsset(arg1))
        end,
        createFavoriteForBundle = function(arg1)
            callback(CreateFavoriteForBundle(arg1))
        end,
        deleteFavoriteForBundle = function(arg1)
            callback(DeleteFavoriteForBundle(arg1))
        end,
        getFavoriteForAsset = function(arg1)
            callback(GetFavoriteForAsset(arg1))
        end,
        getFavoriteForBundle = function(arg1)
            callback(GetFavoriteForBundle(arg1))
        end
    }
end)(var1)
