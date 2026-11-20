-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Chrome = CoreGui:WaitForChild("RobloxGui").Modules.Chrome

local React = require(CorePackages.Packages.React)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local useObservableValue = require(Chrome.ChromeShared.Hooks.useObservableValue)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local GamepadConnector = if SharedFlags.FFlagEnableConsoleExpControls and var1 then require(script.Parent.Parent.GamepadConnector) else nil
local var2 = require(Chrome.ChromeShared.Service.ChromeUtils).ObservableValue.new(true)

local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local FFlagEnableInExperienceShop = SharedFlags.FFlagEnableInExperienceShop

local var3 = InExperienceShop.FFlagEnableExperienceShopGlobalIcon and FFlagEnableInExperienceShop and var1

local FFlagCenterInExperienceShopWindow = InExperienceShop.FFlagCenterInExperienceShopWindow
local FFlagExperienceShopNewIconography = InExperienceShop.FFlagExperienceShopNewIconography
local ShopGlobalIcon = InExperienceShop.ShopGlobalIcon
local CommonIcon = if var3 then require(Chrome.Integrations.CommonIcon) else nil
local Service = if var3 then require(Chrome.Service) else nil
local Constants = if var3 then require(Chrome.ChromeShared.Unibar.Constants) else nil
local useMappedSignal = if var3 then require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal else nil

local var4 = if var3 and Service and Constants then require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen(Constants.IN_EXPERIENCE_SHOP_ID)
end) else nil

local toggleInExperienceShopWindow = if var3 then require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).toggleInExperienceShopWindow else nil

local function getShopGlobalIconEnabled(arg1)
    if not var3 then
        return false
    end
    local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
    if getShopGlobalIconStore then
        return (getShopGlobalIconStore(arg1).getEnabled(arg1))
    end

    return false
end

local function getShopGlobalStatusIndicatorEnabled(arg1)
    if not var3 then
        return false
    end
    local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
    if getShopGlobalIconStore then
        return (getShopGlobalIconStore(arg1).getStatusIndicatorEnabled(arg1))
    end

    return false
end

local function handleShopGlobalIconActivated()
    if not var3 then
        return
    end
    if FFlagCenterInExperienceShopWindow then
        if toggleInExperienceShopWindow then
            toggleInExperienceShopWindow()
        end
    elseif Service and Constants then
        Service:toggleWindow(Constants.IN_EXPERIENCE_SHOP_ID)
    end
end

local function ShopIcon(tbl1)
    local var5 = SignalsReact.useSignalState(getShopGlobalIconEnabled)
    local showStatusIndicator = SignalsReact.useSignalState(getShopGlobalStatusIndicatorEnabled)

    React.useEffect(function()
        if var3 then
            return InExperienceShop.initShopGlobalIcon and InExperienceShop.initShopGlobalIcon() or function() end
        end
    end, {})

    local isActive = (useMappedSignal or function()
        return nil
    end)(if var5 then var4 else nil)

    local var8 = useObservableValue(if GamepadConnector == nil then var2 else GamepadConnector:getShowTopBar())

    if not (var3 and var5 and ShopGlobalIcon) then
        return nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromOffset(0, tbl1.buttonSize),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        Icon = React.createElement(ShopGlobalIcon, {
            buttonSize = tbl1.buttonSize,
            leftGap = tbl1.leftGap,
            hidden = var8 == false,
            showStatusIndicator = showStatusIndicator,
            onActivated = handleShopGlobalIconActivated,
            onAreaChanged = tbl1.onAreaChanged,
            isActive = isActive,
            icon = if FFlagExperienceShopNewIconography or not (CommonIcon and var4) then nil else CommonIcon("BuildingStore", nil, var4)
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return ShopIcon
