-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local scriptParentParent = script.Parent.Parent
local Colors = require(scriptParentParent.Colors)
local PromptPurchase = require(scriptParentParent.Thunks.PromptPurchase)
local getSelectionImageObjectRounded = require(scriptParentParent.getSelectionImageObjectRounded)

local UtilityFunctions = require(scriptParentParent.UtilityFunctions)

local var1 = Roact.PureComponent:extend("BuyButton")

function var1.init(arg1)
    arg1.selectedImage = getSelectionImageObjectRounded()
    arg1.connections = {}
    arg1.lastGamepadFocus = nil

    function arg1.onPromptPurchaseFinished()
        if arg1.props.gamepadEnabled and arg1.props.visible then
            GuiService.SelectedCoreObject = arg1.lastGamepadFocus
        end
    end
end

function var1.render(arg1)
    local itemType = arg1.props.itemType
    local itemId = arg1.props.itemId
    local showRobuxIcon = arg1.props.showRobuxIcon
    local forSale = arg1.props.forSale
    local promptPurchase = arg1.props.promptPurchase
    local buyText = arg1.props.buyText
    local buyButtonRef = arg1.props.buyButtonRef
    local collectibleItemId = arg1.props.collectibleItemId
    local collectibleLowestAvailableResaleProductId = arg1.props.collectibleLowestAvailableResaleProductId
    local collectibleLowestAvailableResaleItemInstanceId = arg1.props.collectibleLowestAvailableResaleItemInstanceId
    local collectibleLowestResalePrice = arg1.props.collectibleLowestResalePrice

    local var2 = UtilityFunctions.isLimited2Point0_Or_LimitedCollectible(arg1.props.assetInfo)
    local uDim2 = UDim2.new(0, arg1:getBuyButtonTextSize(buyText), 1, 0)

    local num1 = if forSale then 0 else 0.5

    local createElement = Roact.createElement
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, -32, 0, 44),
        Image = "rbxasset://textures/ui/InspectMenu/Button_white.png",
        ImageColor3 = Colors.Green,
        SelectionImageObject = arg1.selectedImage,
        LayoutOrder = 3,
        ImageTransparency = num1,
        [Roact.Ref] = buyButtonRef
    }

    tbl1[Roact.Event.Activated] = function()
        if not forSale then
            return
        end

        if arg1.props.gamepadEnabled and arg1.props.visible then
            arg1.lastGamepadFocus = GuiService.SelectedCoreObject
            GuiService.SelectedCoreObject = nil
        end
        promptPurchase(
            itemId,
            itemType,
            collectibleItemId,
            collectibleLowestAvailableResaleProductId,
            collectibleLowestAvailableResaleItemInstanceId,
            collectibleLowestResalePrice,
            var2
        )
    end

    return createElement("ImageButton", tbl1, {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        RobuxIcon = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 16, 0, 16),
            Image = "rbxasset://textures/ui/common/robux_small.png",
            ImageTransparency = num1,
            ImageColor3 = Colors.White,
            LayoutOrder = 1,
            Visible = showRobuxIcon
        }),
        BuyText = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Size = uDim2,
            Text = tostring(buyText),
            Font = AppFonts.default:getDefault(),
            TextSize = 16,
            TextColor3 = Colors.White,
            TextTransparency = num1,
            LayoutOrder = 2,
            TextXAlignment = Enum.TextXAlignment.Center
        })
    })
end

function var1.didMount(arg1)
    local connection = MarketplaceService.PromptPurchaseFinished:Connect(arg1.onPromptPurchaseFinished)

    local connection2 = MarketplaceService.PromptBundlePurchaseFinished:Connect(arg1.onPromptPurchaseFinished)
    table.insert(arg1.connections, connection)
    table.insert(arg1.connections, connection2)
end

function var1.willUnmount(arg1)
    for _, connection in pairs(arg1.connections) do
        connection:Disconnect()
    end
end

function var1.getBuyButtonTextSize(arg1, arg2)
    if not arg1.props.buyButtonRef.current then
        return 0
    end

    local vector2 = TextService:GetTextSize(
        tostring(arg2),
        16,
        AppFonts.default:getDefault(),
        Vector2.new(arg1.props.buyButtonRef.current.AbsoluteSize.X, 5000)
    )
    arg1.props.buyButtonRef.Size = UDim2.new(0, 1, 0, vector2.Y)
    return vector2.X > 32 and vector2.X or 32
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        locale = arg1.locale,
        view = arg1.view,
        assetInfo = arg1.assets[assetId],
        gamepadEnabled = arg1.gamepadEnabled,
        visible = arg1.visible
    }
end, function(callback)
    return {
        promptPurchase = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
            callback(PromptPurchase(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
        end
    }
end)(var1)
