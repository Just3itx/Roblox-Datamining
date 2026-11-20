-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local _Workspace = game:GetService("Workspace")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.Constants)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)

local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local SetKeepOutArea = require(scriptParentParentParent.Actions.SetKeepOutArea)
local RemoveKeepOutArea = require(scriptParentParentParent.Actions.RemoveKeepOutArea)

local _SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagTopBarSignalizeHealthBar = CoreGuiCommon.Flags.FFlagTopBarSignalizeHealthBar
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

local Chrome = scriptParentParentParent.Parent.Chrome
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
if ChromeEnabled() then
    local _service = require(Chrome.Service)
end
local var1 = ChromeEnabled()

local uDim2 = UDim2.new(0, 80, 0, 6)
if var1 then
    uDim2 = UDim2.new(0, 125, 0, 20)
end
local uDim2_2 = UDim2.new(0, 50, 0, 16)
local uDim2_3 = UDim2.new(0, 80, 0, 20)
local uDim2_4 = UDim2.new(0, 220, 0, 16)

local var2 = Roact.PureComponent:extend("HealthBar")

var2.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    healthEnabled = if FFlagTopBarSignalizeHealthBar then nil else t.boolean,
    health = if FFlagTopBarSignalizeHealthBar then nil else t.number,
    maxHealth = if FFlagTopBarSignalizeHealthBar then nil else t.number,
    setKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback,
    removeKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback
})

local function color3ToVector3(arg1): Vector3 -- Luacid: Inlined by compiler; 3 call sites recovered
    return Vector3.new(arg1.r, arg1.g, arg1.b)
end

local tbl1 = {
    [color3ToVector3(Constants.HealthRedColor)] = 0.1,
    [color3ToVector3(Constants.HealthYellowColor)] = 0.5,
    [color3ToVector3(Constants.HealthGreenColor)] = 0.8
}

local HealthRedColor = Constants.HealthRedColor

local HealthGreenColor = Constants.HealthGreenColor

local function getHealthBarColor(arg1)
    if arg1 <= 0.1 then
        return HealthRedColor
    end

    if arg1 >= 0.8 then
        return HealthGreenColor
    end

    local vec3 = Vector3.new(0, 0, 0)
    local num1 = 0
    for k, value in pairs(tbl1) do
        local var3 = arg1 - value
        if var3 == 0 then
            return Color3.new(k.x, k.y, k.z)
        end
        local var4 = 1 / (var3 * var3)
        vec3 += var4 * k
        num1 += var4
    end

    local var3 = vec3 / num1
    return Color3.new(var3.x, var3.y, var3.z)
end

function var2.init(arg1)
    arg1.rootRef = Roact.createRef()
    if FFlagTopBarSignalizeHealthBar then
        local health, setHealth = Roact.createBinding(Constants.InitialHealth)
        arg1.health = health
        arg1.setHealth = setHealth
        local maxHealth, setMaxHealth = Roact.createBinding(Constants.InitialHealth)
        arg1.maxHealth = maxHealth
        arg1.setMaxHealth = setMaxHealth
        local isDead, setIsDead = Roact.createBinding(false)
        arg1.isDead = isDead
        arg1.setIsDead = setIsDead
        arg1.healthPercent = Roact.joinBindings({ arg1.health, arg1.maxHealth, arg1.isDead }):map(function(arg2)
            local var9 = arg2[1]
            local var10 = arg2[2]

            local num1 = 1

            if arg2[3] then
                return 0
            end

            if var10 > 0 then
                num1 = math.clamp(var9 / var10, 0, 1)
            end

            return num1
        end)
        arg1.healthVisible = Roact.joinBindings({ arg1.health, arg1.maxHealth }):map(function(arg2): boolean
            return arg2[1] < arg2[2]
        end)

        if CoreGuiCommon.Stores.GetLocalHumanoidStore then
            arg1.localHumanoidStore = CoreGuiCommon.Stores.GetLocalHumanoidStore(false)
            arg1.disposeHealthConnection = Signals.createEffect(function(arg2)
                local healthValue = arg1.localHumanoidStore.getHealthValue(arg2)

                arg1.setHealth(healthValue.health or Constants.InitialHealth)
                arg1.setMaxHealth(healthValue.maxHealth or Constants.InitialHealth)
                arg1.setIsDead(healthValue.isDead)
            end)
        end

        local function getHealthEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
            return StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health)
        end

        arg1.coreGuiChangedSignalConn = StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType: Enum.CoreGuiType, enabled: boolean)
            if coreGuiType == Enum.CoreGuiType.Health or coreGuiType == Enum.CoreGuiType.All then
                arg1:setState({ mountHealthBar = enabled })
            end
        end)

        arg1:setState({ mountHealthBar = getHealthEnabled() })
    end

    if FFlagTopBarSignalizeKeepOutAreas then
        arg1.keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize
    local screenSizeBinding, setScreenSizeBinding = Roact.createBinding(getViewportSize(false))
    arg1.screenSizeBinding = screenSizeBinding
    arg1.setScreenSizeBinding = setScreenSizeBinding

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1.setScreenSizeBinding(getViewportSize(arg2))
    end)

    arg1.healthbarSizeBinding = arg1.screenSizeBinding:map(function(arg2)
        if TenFootInterface:IsEnabled() then
            return uDim2_4
        end

        if var1 and arg2.X <= 320 then
            return uDim2_2
        end

        if var1 and arg2.X <= 393 then
            return uDim2_3
        end

        return uDim2
    end)
end

function var2.onUnmount(arg1)
    if FFlagTopBarSignalizeHealthBar then
        arg1.coreGuiChangedSignalConn:Disconnect()
        arg1.disposeHealthConnection()
    end
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

function var2.renderHealth(arg1)
    local var3 = if FFlagTopBarSignalizeHealthBar then nil else arg1.props.healthEnabled and arg1.props.health < arg1.props.maxHealth

    local xScale = 1
    if not FFlagTopBarSignalizeHealthBar then
        if arg1.props.isDead then
            xScale = 0
        elseif arg1.props.maxHealth > 0 then
            xScale = math.clamp(arg1.props.health / arg1.props.maxHealth, 0, 1)
        end
    end

    local healthbarSizeBinding

    if FFlagTopBarSignalizeScreenSize then
        healthbarSizeBinding = nil
    elseif var1 then
        if arg1.props.screenSize.X <= 320 then
            healthbarSizeBinding = uDim2_2
        elseif arg1.props.screenSize.X <= 393 then
            healthbarSizeBinding = uDim2_3
        else
            healthbarSizeBinding = uDim2
        end

        if TenFootInterface:IsEnabled() then
            healthbarSizeBinding = uDim2_4
        end
    else
        healthbarSizeBinding = uDim2
        if TenFootInterface:IsEnabled() then
            healthbarSizeBinding = uDim2_4
        end
    end

    local offset = if TenFootInterface:IsEnabled() then 0 else 4
    local var4, str1, str2

    if var1 then
        var4 = Rect.new(8, 8, 9, 9)
        str1 = "rbxasset://textures/ui/TopBar/HealthBarBaseTV.png"
        str2 = "rbxasset://textures/ui/TopBar/HealthBarTV.png"
    else
        var4 = Rect.new(3, 3, 4, 4)
        if TenFootInterface:IsEnabled() then
            var4 = Rect.new(8, 8, 9, 9)
            str1 = "rbxasset://textures/ui/TopBar/HealthBarBaseTV.png"
            str2 = "rbxasset://textures/ui/TopBar/HealthBarTV.png"
        else
            str1 = "rbxasset://textures/ui/TopBar/HealthBarBase.png"
            str2 = "rbxasset://textures/ui/TopBar/HealthBar.png"
        end
    end

    local function func1(arg2)
        if var1 then
            return
        end

        if (FFlagTopBarSignalizeHealthBar and arg1.healthVisible or not FFlagTopBarSignalizeHealthBar and var3) and arg2 then
            if FFlagTopBarSignalizeKeepOutAreas then
                arg1.keepOutAreasStore.setKeepOutArea(Constants.HealthBarKeepOutAreaId, arg2.AbsolutePosition, arg2.AbsoluteSize)
                return
            end
            arg1.props.setKeepOutArea(Constants.HealthBarKeepOutAreaId, arg2.AbsolutePosition, arg2.AbsoluteSize)
            return
        end

        if FFlagTopBarSignalizeKeepOutAreas then
            arg1.keepOutAreasStore.removeKeepOutArea(Constants.HealthBarKeepOutAreaId)
            return
        end
        arg1.props.removeKeepOutArea(Constants.HealthBarKeepOutAreaId)
    end

    if arg1.rootRef.current then
        func1(arg1.rootRef.current)
    end

    local imageColor3 = if FFlagTopBarSignalizeHealthBar then arg1.healthPercent:map(getHealthBarColor) else getHealthBarColor(xScale)
    local createElement = Roact.createElement
    local str3 = "Frame"

    local tbl2 = {
        AnchorPoint = if var1 then Vector2.new(1, 0) else nil,
        Position = if var1 then UDim2.new(1, 0, 0, 0) else nil,
        Visible = if FFlagTopBarSignalizeHealthBar then arg1.healthVisible else var3,
        BackgroundTransparency = 1,
        Size = if FFlagTopBarSignalizeScreenSize then arg1.healthbarSizeBinding:map(function(arg2): UDim2
            return UDim2.new(arg2.X, UDim.new(1, 0))
        end) else UDim2.new(healthbarSizeBinding.X, UDim.new(1, 0)),
        LayoutOrder = arg1.props.layoutOrder,
        [Roact.Change.AbsoluteSize] = func1,
        [Roact.Change.AbsolutePosition] = func1,
        [Roact.Ref] = arg1.rootRef
    }

    local tbl3 = {
        Padding = if ChromeEnabled then nil else Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }) or nil,
        HealthBar = 0
    }

    local createElement2 = Roact.createElement
    local str4 = "ImageLabel"
    local tbl4 = {
        BackgroundTransparency = 1,
        Image = str1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = var4,
        Size = 0,
        Position = 0,
        AnchorPoint = 0
    }

    if FFlagTopBarSignalizeScreenSize then
        healthbarSizeBinding = arg1.healthbarSizeBinding
    end

    tbl4.Size = healthbarSizeBinding
    tbl4.Position = UDim2.fromScale(0, 0.5)
    tbl4.AnchorPoint = Vector2.new(0, 0.5)
    local tbl5 = {
        Fill = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = str2,
            ImageColor3 = imageColor3,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = var4,
            Size = if FFlagTopBarSignalizeHealthBar then arg1.healthPercent:map(function(xScale2: number): UDim2
                return UDim2.fromScale(xScale2, 1)
            end) else UDim2.fromScale(xScale, 1)
        })
    }

    tbl3.HealthBar = createElement2(str4, tbl4, tbl5)
    return createElement(str3, tbl2, tbl3)
end

function var2.render(arg1)
    if FFlagTopBarSignalizeHealthBar then
        if arg1.state.mountHealthBar then
            return (arg1:renderHealth())
        end

        return nil
    end
    return arg1:renderHealth()
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        health = if FFlagTopBarSignalizeHealthBar then nil else arg1.health.currentHealth,
        maxHealth = if FFlagTopBarSignalizeHealthBar then nil else arg1.health.maxHealth,
        healthEnabled = if FFlagTopBarSignalizeHealthBar then nil else arg1.coreGuiEnabled[Enum.CoreGuiType.Health]
    }
end, not FFlagTopBarSignalizeKeepOutAreas and function(arg1) -- name: mapDispatchToProps
    return if FFlagTopBarSignalizeKeepOutAreas then {} else {
        setKeepOutArea = function(arg2, arg3, arg4)
            return arg1(SetKeepOutArea(arg2, arg3, arg4))
        end,
        removeKeepOutArea = function(arg2)
            return arg1(RemoveKeepOutArea(arg2))
        end
    }
end or nil)(var2)
