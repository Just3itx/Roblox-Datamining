-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local scriptParentParent = script.Parent.Parent
local Roact = require(CorePackages.Packages.Roact)
local Cryo = require(CorePackages.Packages.Cryo)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Skeleton = require(CorePackages.Packages.Foundation).Skeleton

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local AssetCard = require(scriptParentParent.Components.AssetCard)
local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)
local SetAssetFromBundleInfo = require(scriptParentParent.Actions.SetAssetFromBundleInfo)

local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav

local var1 = Roact.PureComponent:extend("AssetList")

function var1.calculateCanvasSize(arg1, arg2, arg3, arg4)
    local current = arg1.gridFrameRef.current
    local view = arg1.props.view

    local view2 = arg1.props.views[view]

    if current then
        local var2 = view2.TopSizeY + 15
        local yOffset = math.ceil(arg3 / arg2) * (arg4 + 10) + var2
        current.Parent.CanvasSize = UDim2.new(1, 0, 0, yOffset)
    end
end

function var1.init(arg1)
    local view = arg1.props.view

    local view2 = arg1.props.views[view]

    arg1.gridFrameRef = Roact.createRef()

    arg1.state = {
        assetCardSizeX = view2.AssetCardMaxSizeX,
        assetCardSizeY = view2.AssetCardMaxSizeY,
        assetCardsLoaded = not FFlagAddNewPlayerListMobileFocusNav and nil
    }
end

function var1.render(arg1)
    local view = arg1.props.view

    local view2 = arg1.props.views[view]

    local assets = arg1.props.assets
    local maxAssetCardsPerRow = view2.MaxAssetCardsPerRow
    local assetCardSizeX = arg1.state.assetCardSizeX
    local assetCardSizeY = arg1.state.assetCardSizeY
    local tbl1 = ({})
    local num1 = 0

    tbl1.UIGridLayout = Roact.createElement("UIGridLayout", {
        CellPadding = UDim2.new(0, 10, 0, 10),
        CellSize = UDim2.new(0, assetCardSizeX, 0, assetCardSizeY),
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        FillDirectionMaxCells = maxAssetCardsPerRow
    })

    for _, assetInfo in pairs(assets) do
        num1 += 1
        tbl1[assetInfo.assetId] = Roact.createElement(AssetCard, { assetInfo = assetInfo, assetCardSizeX = assetCardSizeX })
    end

    if num1 == 0 then
        for i = 1, 30 do
            local createElement = Roact.createElement
            local var2 = Skeleton
            local tbl2 = {
                Size = UDim2.new(1, 0, 0, assetCardSizeX)
            }
            tbl1[i] = createElement(var2, tbl2)
        end
    elseif FFlagAddNewPlayerListMobileFocusNav then
        arg1:setState({ assetCardsLoaded = true })
    end

    arg1:calculateCanvasSize(maxAssetCardsPerRow, num1, assetCardSizeY)

    local createElement = Roact.createElement
    local tbl2 = {
        Size = UDim2.new(1, -(2 * view2.BorderPaddingSize), 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 3,
        [Roact.Ref] = arg1.gridFrameRef
    }

    tbl2[Roact.Change.AbsoluteSize] = function(_)
        spawn(function()
            arg1:resize()
        end)
    end

    return createElement("Frame", tbl2, tbl1)
end

function var1.didMount(arg1)
    arg1:resize()
    arg1.mounted = true
end

function var1.updateAssetsFromBundles(arg1)
    local bundles = arg1.props.bundles
    local assetBundles = arg1.props.assetBundles
    local assets = arg1.props.assets
    local var2 = Cryo.Dictionary.keys(assets)

    if not bundles or Cryo.isEmpty(bundles) then
        return
    end
    local num1 = 1
    for _, value in pairs(bundles) do
        local assetIds = value.assetIds
        for i = 1, #assetIds do
            local str1 = tostring(assetIds[i])
            if not table.find(var2, str1) then
                continue
            end

            local var3 = assetBundles[str1] or {}

            if #var3 == 1 or num1 == 1 and #var3 > 1 and assets[str1] and assets[str1].parentBundleId == nil then
                arg1.props.dispatchSetAssetFromBundleInfo(str1, value)
            end
        end
        num1 += 1
    end
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.view ~= arg2.view then
        arg1:resize()
    end

    if arg1.mounted
        and arg1.props.gamepadEnabled
        and not arg1.props.detailsInformation.viewingDetails
        and arg1.props.visible
        and (not FFlagAddNewPlayerListMobileFocusNav or arg1.state.assetCardsLoaded)
    then
        GuiService.SelectedCoreObject = arg1.gridFrameRef.current:FindFirstChildWhichIsA("GuiObject")
    end

    if arg1.props.assetBundles ~= arg2.assetBundles or arg1.props.bundles ~= arg2.bundles then
        arg1:updateAssetsFromBundles()
    end
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

function var1.resize(arg1)
    local current = arg1.gridFrameRef.current
    local view = arg1.props.view

    local view2 = arg1.props.views[view]

    if not current then
        return
    end

    local maxAssetCardsPerRow = view2.MaxAssetCardsPerRow

    local num1 = math.floor((current.AbsoluteSize.X - 10 * (maxAssetCardsPerRow - 1)) / maxAssetCardsPerRow)
    local assetCardSizeX = math.min(num1, view2.AssetCardMaxSizeX)
    local assetCardSizeY = math.min(num1 / 0.68, view2.AssetCardMaxSizeY)

    if arg1.state.assetCardSizeX ~= assetCardSizeX or arg1.state.assetCardSizeY ~= assetCardSizeY then
        arg1:setState({ assetCardSizeX = assetCardSizeX, assetCardSizeY = assetCardSizeY })
    end
end

return RoactRodux.connect(function(arg1, _)
    return {
        view = arg1.view,
        visible = arg1.visible,
        assets = arg1.assets,
        bundles = arg1.bundles,
        assetBundles = arg1.assetBundles,
        detailsInformation = arg1.detailsInformation,
        gamepadEnabled = arg1.gamepadEnabled
    }
end, function(callback)
    return {
        dispatchSetAssetFromBundleInfo = function(arg1, arg2)
            callback(SetAssetFromBundleInfo(arg1, arg2))
        end
    }
end)(function(arg1) -- name: AssetListWrapper
    return Roact.createElement(InspectAndBuyContext.Consumer, {
        render = function(views)
            local var2 = Cryo.Dictionary.join(arg1, { views = views })
            return Roact.createElement(var1, var2)
        end
    })
end)
