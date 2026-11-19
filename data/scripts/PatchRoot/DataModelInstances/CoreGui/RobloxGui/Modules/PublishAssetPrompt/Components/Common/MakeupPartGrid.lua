-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local GridMetrics = UIBlox.App.Grid.GridMetrics
local DefaultMetricsGridView = UIBlox.App.Grid.DefaultMetricsGridView
local ItemTile = UIBlox.Tile.ItemTile

local Constants = require(script.Parent.Parent.Parent.Constants)
local AvatarItemCard = require(script.Parent.Parent.PublishAvatarPrompt.AvatarParts.AvatarItemCard)

local GetFFlagUploadMakeupSupport = require(script.Parent.Parent.Parent.Flags.GetFFlagUploadMakeupSupport)

local vector2 = Vector2.new(20, 20)

local tbl1 = {
    [Enum.AvatarAssetType.FaceMakeup] = "Face Makeup",
    [Enum.AvatarAssetType.LipMakeup] = "Lip Makeup",
    [Enum.AvatarAssetType.EyeMakeup] = "Eye Makeup",
    [Enum.AvatarAssetType.EyebrowAccessory] = "Eyebrow",
    [Enum.AvatarAssetType.EyelashAccessory] = "Eyelash"
}

local function getItemsFromFolder(makeupFolder, name: string, makeupEntries, bool1: boolean)
    local itemsFromFolder = {}
    local children = makeupFolder:GetChildren()

    for i, asset in ipairs(children) do
        if not (asset:IsA("Decal") or asset:IsA("Accessory")) then
            continue
        end

        local var1 = nil
        local assetType = if makeupEntries and makeupEntries[i] then makeupEntries[i].assetType else nil
        local childName

        if bool1 then
            if GetFFlagUploadMakeupSupport() then
                local childName2 = asset.Name
                if assetType and tbl1[assetType] then
                    childName2 = tbl1[assetType]
                end
                childName = name .. " - " .. childName2
            else
                childName = asset.Name
                if assetType and tbl1[assetType] then
                    childName = tbl1[assetType]
                    var1 = name
                else
                    var1 = name
                end
            end
        else
            childName = name
        end

        if makeupEntries and makeupEntries[i] and makeupEntries[i].sortOrder then
            i = makeupEntries[i].sortOrder
        end

        table.insert(
            itemsFromFolder,
            {
                asset = asset,
                assetType = assetType,
                bodyName = var1,
                partName = childName,
                LayoutOrder = i
            }
        )
    end

    table.sort(itemsFromFolder, function(arg1, arg2): boolean
        return (arg1.LayoutOrder or 0) < (arg2.LayoutOrder or 0)
    end)

    return itemsFromFolder
end

local function MakeupPartGrid(tbl2)
    local items, var2 = React.useState({})

    local var3 = tbl2.showAssetTypeInLabel == nil or tbl2.showAssetTypeInLabel

    React.useEffect(function()
        if tbl2.makeupFolder then
            var2((getItemsFromFolder(tbl2.makeupFolder, tbl2.name, tbl2.makeupEntries, var3)))
            return
        end

        if not tbl2.singleDecal then
            local tbl3 = ({})

            tbl3[1] = {}
            tbl3[2] = {}

            var2(tbl3)
            return
        end

        local name = tbl2.name
        local singleAssetType = tbl2.singleAssetType
        local name2

        if var3 then
            name2 = tbl2.name
            name = tbl2.singleDecal.Name
            if singleAssetType and tbl1[singleAssetType] then
                name = tbl1[singleAssetType]
            end
        else
            name2 = nil
        end

        var2({{ asset = tbl2.singleDecal, assetType = singleAssetType, bodyName = name2, partName = name, LayoutOrder = 1 }})
    end, { tbl2.makeupFolder, tbl2.singleDecal })

    React.useEffect(function()
        if not items[1] or not items[1].asset then
            return
        end

        local tbl3 = ({})
        for value, value2 in items do
            local bodyName = value2.bodyName
            local partName = value2.partName

            if GetFFlagUploadMakeupSupport() then
                if var3 then
                    local var4 = value2.assetType and tbl1[value2.assetType] or ""
                    partName = tbl2.name .. " - " .. var4
                else
                    partName = tbl2.name
                end

                bodyName = nil
            elseif var3 then
                bodyName = tbl2.name
            else
                partName = tbl2.name
            end

            local tbl4 = {
                asset = value2.asset,
                assetType = value2.assetType,
                bodyName = bodyName,
                partName = partName,
                LayoutOrder = value2.LayoutOrder
            }
            tbl3[value] = tbl4
        end

        var2(tbl3)
    end, { tbl2.name })

    local var4 = if tbl2.screenSize.Y > tbl2.screenSize.X then Constants.ItemCardWidthPortrait else Constants.ItemCardWidthLandscape

    local renderItem = React.useCallback(function(arg1)
        if not arg1.asset then
            return React.createElement(ItemTile)
        end

        return React.createElement(AvatarItemCard, {
            asset = arg1.asset,
            assetType = arg1.assetType,
            bodyName = arg1.bodyName,
            partName = arg1.partName,
            viewportSize = var4
        })
    end, { var4, tbl2.name })

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl2.LayoutOrder,
        BackgroundTransparency = 1
    }, {
        Grid = React.createElement(DefaultMetricsGridView, {
            getItemHeight = function(num1: number): number
                return num1 * (4 / 3)
            end,
            getItemMetrics = GridMetrics.makeCustomMetricsGetter({ minimumItemsPerRow = 2, minimumItemWidth = var4 }),
            renderItem = renderItem,
            itemPadding = vector2,
            items = items
        })
    })
end

return MakeupPartGrid
