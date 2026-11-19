-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local UtilityFunctions = require(scriptParentParent.UtilityFunctions)
local GetAssetFavoriteCount = require(scriptParentParent.Thunks.GetAssetFavoriteCount)
local GetBundleFavoriteCount = require(scriptParentParent.Thunks.GetBundleFavoriteCount)
local GotCurrentFavoriteCount = require(scriptParentParent.Selectors.GotCurrentFavoriteCount)
local getSelectionImageObjectRegular = require(scriptParentParent.getSelectionImageObjectRegular)

local var1 = Roact.PureComponent:extend("Favorites")

function var1.setText(arg1)
    local assetInfo = arg1.props.assetInfo or {}
    local bool1 = assetInfo.parentBundleId ~= nil

    local bundleInfo = arg1.props.bundleInfo

    if bool1 then
        local bundleId = UtilityFunctions.getBundleId(assetInfo)
        if bundleInfo[bundleId] then
            arg1.numFavorites = bundleInfo[bundleId].numFavorites
        end
    elseif assetInfo then
        arg1.numFavorites = assetInfo.numFavorites
    end
end

function var1.init(arg1)
    arg1.numFavorites = ""
    arg1.selectionImageObject = getSelectionImageObjectRegular()
end

function var1.willUpdate(arg1, arg2)
    local getAssetFavoriteCount = arg1.props.getAssetFavoriteCount
    local getBundleFavoriteCount = arg1.props.getBundleFavoriteCount

    if not arg2.assetInfo then
        return
    end

    local assetInfo = arg2.assetInfo
    local bool1 = assetInfo.parentBundleId ~= nil

    if arg2.gotCurrentFavoriteCount then
        return
    end

    coroutine.wrap(function()
        if not bool1 then
            getAssetFavoriteCount(assetInfo.assetId)
            return
        end
        local bundleId = UtilityFunctions.getBundleId(assetInfo)
        getBundleFavoriteCount(bundleId)
    end)()
end

function var1.render(arg1)
    arg1:setText()

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }, {
        FavoriteIcon = Roact.createElement("ImageButton", {
            Selectable = false,
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/InspectMenu/ico_favorite.png",
            SelectionImageObject = arg1.selectionImageObject
        }),
        FavoriteText = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, -16, 1, 0),
            Position = UDim2.new(0, 21, 0, 0),
            BackgroundTransparency = 1,
            Text = arg1.numFavorites or "",
            Font = AppFonts.default:getDefault(),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextSize = 12,
            TextColor3 = Color3.new(1, 1, 1)
        })
    })
end

function var1.shouldUpdate(_, arg1): boolean
    return not not arg1.detailsInformation.viewingDetails
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        detailsInformation = arg1.detailsInformation,
        assetInfo = arg1.assets[assetId],
        bundleInfo = arg1.bundles,
        gotCurrentFavoriteCount = GotCurrentFavoriteCount(arg1)
    }
end, function(callback)
    return {
        getAssetFavoriteCount = function(arg1)
            callback(GetAssetFavoriteCount(arg1))
        end,
        getBundleFavoriteCount = function(arg1)
            callback(GetBundleFavoriteCount(arg1))
        end
    }
end)(var1)
