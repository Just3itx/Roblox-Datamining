-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")

local scriptParentParentParent = script.Parent.Parent.Parent

local AppNavBar = require(scriptParentParentParent.AppNavBar)
local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)
local Responsive = require(scriptParentParentParent.Responsive)
local SignalsReact = require(scriptParentParentParent.SignalsReact)

local FFlagSplitPaneFixClassicThemeHeader = require(scriptParentParentParent.SharedFlags).FFlagSplitPaneFixClassicThemeHeader
local SplitPane = if FFlagSplitPaneFixClassicThemeHeader then require(scriptParentParentParent.SplitPane) else nil
local SplitPaneStore = if FFlagSplitPaneFixClassicThemeHeader then SplitPane.SplitPaneStore else nil
local useNavBarPlacement = AppNavBar.useNavBarPlacement
local useNavBarSize = AppNavBar.useNavBarSize
local Placement = AppNavBar.Placement

local useTokens = Foundation.Hooks.useTokens
local Image = Foundation.Image
local View = Foundation.View

local function getScreenWidth(): number -- Luacid: Inlined by compiler; 1 call site recovered
    local currentCamera = Workspace.CurrentCamera
    return if currentCamera then currentCamera.ViewportSize.X else GuiService:GetScreenResolution().X
end

return React.memo(function(tbl1) -- name: AppHeaderBarClassicThemeBackground
    local var1 = useTokens()

    local var2 = Responsive.useDeviceInsets()

    local var3 = useNavBarPlacement()
    local var4 = useNavBarSize()
    local var5 = if var3 ~= Placement.Left then 0 else var4

    local var6 = nil
    local var7 = nil
    if FFlagSplitPaneFixClassicThemeHeader then
        local store = SplitPaneStore.getStore()
        var6 = SignalsReact.useSignalState(store.getSupportPaneModeIfActive) == SplitPane.SupportPaneMode.Normal

        var7 = SignalsReact.useSignalState(store.getContentRegionRect)
    end

    local var8, var9 = React.useBinding(UDim2.fromOffset(0, 0))
    local var10, var11 = React.useBinding(UDim2.fromOffset(0, 0))

    local var12 = React.useRef(nil)

    local useCallback = React.useCallback
    local function func1(current)
        if not current then
            return
        end

        var12.current = current

        local current2 = tbl1.containerRef.current
        if not current2 then
            return
        end

        local vector2 = Vector2.new(-var2.left + var5, -var2.top)
        local var13 = vector2 - current.AbsolutePosition
        local xOffset = if FFlagSplitPaneFixClassicThemeHeader and var6 and var7 then var7.Max.X - vector2.X else getScreenWidth() + var2.left + var2.right - var5
        local yOffset = current2.AbsolutePosition.Y + current2.AbsoluteSize.Y - vector2.Y

        var9(UDim2.fromOffset(current.Position.X.Offset + var13.X, current.Position.Y.Offset + var13.Y))

        var11(UDim2.fromOffset(xOffset, yOffset))
    end

    local containerRef = tbl1.containerRef
    local left = var2.left
    local top = var2.top
    local right = var2.right
    local var13 = if FFlagSplitPaneFixClassicThemeHeader then var6 else nil
    local var14 = if FFlagSplitPaneFixClassicThemeHeader then var7 else nil
    local ref = useCallback(func1, { var5, containerRef, left, top, right, var13, var14 })

    React.useEffect(function()
        ref(var12.current)

        local tbl2 = {}

        local currentCamera = Workspace.CurrentCamera
        if currentCamera then
            table.insert(tbl2, currentCamera:GetPropertyChangedSignal("ViewportSize"))
        end

        local current = tbl1.containerRef.current
        if current then
            table.insert(tbl2, current:GetPropertyChangedSignal("AbsolutePosition"))
            table.insert(tbl2, current:GetPropertyChangedSignal("AbsoluteSize"))
        end

        local tbl3 = {}
        for _, value in tbl2 do
            table.insert(tbl3, (value:Connect(function()
                ref(var12.current)
            end)))
        end
        return function()
            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, { tbl1.containerRef, ref })

    return React.createElement(View, { tag = "size-0", ZIndex = -1 }, {
        Background = React.createElement(
            View,
            {
                tag = "clip",
                Position = var8,
                Size = var10,
                backgroundStyle = var1.Color.Extended.White.White_100,
                ref = ref
            },
            {
                Gradient = React.createElement("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, tbl1.config.gradientColor), ColorSequenceKeypoint.new(0.33, tbl1.config.gradientColor), ColorSequenceKeypoint.new(1, var1.Color.Surface.Surface_0.Color3) })
                }),
                CenterImage = React.createElement(Image, {
                    tag = "position-top-center anchor-top-center size-full",
                    Image = tbl1.config.centerImage,
                    ScaleType = Enum.ScaleType.Stretch,
                    sizeConstraint = {
                        MinSize = Vector2.new(960, 0),
                        MaxSize = Vector2.new(1920, math.huge)
                    }
                })
            }
        )
    })
end)
