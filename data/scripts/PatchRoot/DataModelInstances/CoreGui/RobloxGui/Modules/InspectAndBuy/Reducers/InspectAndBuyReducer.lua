-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local FetchingStatus = require(CorePackages.Workspace.Packages.Http).Reducers.FetchingStatus
local scriptParent = script.Parent
local Rodux = require(CorePackages.Packages.Rodux)
local View = require(scriptParent.View)
local PlayerId = require(scriptParent.PlayerId)
local PlayerName = require(scriptParent.PlayerName)
local Assets = require(scriptParent.Assets)
local AssetBundles = require(scriptParent.AssetBundles)
local Bundles = require(scriptParent.Bundles)
local EquippedAssets = require(scriptParent.EquippedAssets)
local DetailsInformation = require(scriptParent.DetailsInformation)
local TryingOnInfo = require(scriptParent.TryingOnInfo)
local Favorites = require(scriptParent.Favorites)
local Locale = require(scriptParent.Locale)
local Visible = require(scriptParent.Visible)
local ItemBeingPurchased = require(scriptParent.ItemBeingPurchased)
local IsLoaded = require(scriptParent.IsLoaded)
local IsSubjectToChinaPolicies = require(scriptParent.IsSubjectToChinaPolicies)
local GamepadEnabled = require(scriptParent.GamepadEnabled)
local StoreId = require(scriptParent.StoreId)
local CollectibleResellableInstances = require(scriptParent.CollectibleResellableInstances)
local CreatingExperiences = require(scriptParent.CreatingExperiences)
local Overlay = require(scriptParent.Overlay)
local scriptParentParent = script.Parent.Parent
local FFlagAXEnableFetchAvatarPreview = require(scriptParentParent.Flags.FFlagAXEnableFetchAvatarPreview)
local AvatarPreviewDetails = require(scriptParent.AvatarPreviewDetails)

local combineReducers = Rodux.combineReducers
local tbl1 = {
    view = View,
    playerId = PlayerId,
    playerName = PlayerName,
    assets = Assets,
    avatarPreviewDetails = 0,
    bundles = 0,
    assetBundles = 0,
    equippedAssets = 0,
    detailsInformation = 0,
    tryingOnInfo = 0,
    favorites = 0,
    locale = 0,
    visible = 0,
    itemBeingPurchased = 0,
    gamepadEnabled = 0,
    isLoaded = 0,
    isSubjectToChinaPolicies = 0,
    FetchingStatus = 0,
    storeId = 0,
    collectibleResellableInstances = 0,
    creatingExperiences = 0,
    overlay = 0
}

if not FFlagAXEnableFetchAvatarPreview then
    AvatarPreviewDetails = nil
end

tbl1.avatarPreviewDetails = AvatarPreviewDetails
tbl1.bundles = Bundles
tbl1.assetBundles = AssetBundles
tbl1.equippedAssets = EquippedAssets
tbl1.detailsInformation = DetailsInformation
tbl1.tryingOnInfo = TryingOnInfo
tbl1.favorites = Favorites
tbl1.locale = Locale
tbl1.visible = Visible
tbl1.itemBeingPurchased = ItemBeingPurchased
tbl1.gamepadEnabled = GamepadEnabled
tbl1.isLoaded = IsLoaded
tbl1.isSubjectToChinaPolicies = IsSubjectToChinaPolicies
tbl1.FetchingStatus = FetchingStatus
tbl1.storeId = StoreId
tbl1.collectibleResellableInstances = CollectibleResellableInstances
tbl1.creatingExperiences = CreatingExperiences
tbl1.overlay = Overlay
return combineReducers(tbl1)
