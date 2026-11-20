-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Theme = require(script.Parent.Theme)

local BackgroundColor3 = Theme.color("SELECTED_COLOR", Color3.fromRGB(0, 162, 255))
local var1 = Theme.color("NON_SELECTED_COLOR", Color3.fromRGB(78, 84, 96))

local ImageColor3 = Theme.color("ARROW_COLOR", Color3.fromRGB(204, 204, 204))
local var2 = Theme.color("ARROW_COLOR_HOVER", Color3.fromRGB(255, 255, 255))

local var3 = Theme.color("ARROW_COLOR_INACTIVE", Color3.fromRGB(150, 150, 150))

local uDim = UDim.new(0, 14)

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:FindFirstChild("RobloxGui")
local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local Workspace = game:GetService("Workspace")
local CorePackages = game:GetService("CorePackages")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local FFlagRefactorMenuConfirmationButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRefactorMenuConfirmationButtons)
local bool1 = game:DefineFastFlag("RepositionDropDownScrim", false)
local FFlagUIScaleEngineOptions = require(CorePackages.Workspace.Packages.SharedFlags).FFlagUIScaleEngineOptions
local FFlagUIScaleSliderImprovements = require(RobloxGui.Modules.Settings.Flags.FFlagUIScaleSliderImprovements)

local Chrome = RobloxGui.Modules.Chrome
local Service = if require(CorePackages.Workspace.Packages.Chrome).Enabled() then require(Chrome.Service) else nil
local Signals = require(CorePackages.Packages.Signals)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)

local FFlagHideShortcutsWhileIemDropdownActive = require(Chrome.Flags).FFlagHideShortcutsWhileIemDropdownActive

local engineFeature = game:GetEngineFeature("EnablePreferredTextSizeAccessGuiService")

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local bool2 = game:DefineFastFlag("IncreaseLegacyPeopleRowButtonSize", false)

local shouldSelectorArrowStep = require(RobloxGui.Modules.Settings.shouldSelectorArrowStep)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local CorePackages2 = game:GetService("CorePackages")
local AppCommonLib = require(CorePackages2.Workspace.Packages.AppCommonLib)
local Signal = AppCommonLib.Signal
local Create = AppCommonLib.Create
local BuilderIcons = require(CorePackages2.Packages.BuilderIcons)
local Migration = BuilderIcons.Migration

local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages2.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local var6 = require(RobloxGui.Modules:WaitForChild("TenFootInterface")):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local computed = Signals.createComputed(function(arg1): boolean
    return Responsive.GetInputModeStore(arg1).getLastInputType(arg1) == Responsive.Input.Touch
end)
local computed2 = Signals.createComputed(function(arg1): boolean
    return Responsive.GetInputModeStore(arg1).getLastInputType(arg1) == Responsive.Input.Pointer
end)

local tbl1 = ({})
setmetatable(tbl1, { __mode = "k" })

local SelectionImageObject = Create("ImageLabel")({ Image = "", BackgroundTransparency = 1 })

function clamp(arg1, arg2, arg3): number
    return math.max(arg1, math.min(arg2, arg3))
end

local function Linear(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    return arg3 * arg1 / arg4 + arg2
end

local function EaseOutQuad(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    arg1 /= arg4
    return arg2 - arg3 * arg1 * (arg1 - 2)
end

local function EaseInOutQuad(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    arg1 /= arg4

    if arg1 < 0.5 then
        return 2 * arg3 * arg1 * arg1 + arg2
    end

    return arg2 + arg3 * (2 * (2 - arg1) * arg1 - 1)
end

function PropertyTweener(arg1, arg2, arg3, final, arg5, arg6, callback)
    local module = {
        StartTime = tick()
    }
    module.EndTime = module.StartTime + arg5
    module.Cancelled = false

    local isFinished = false
    local percentComplete = 0

    local function finalize() -- Luacid: Inlined by compiler; 2 call sites recovered
        if arg1 then
            arg1[arg2] = arg6(1, arg3, final - arg3, 1)
        end
        isFinished = true
        percentComplete = 1
        if callback then
            callback()
        end
    end

    arg1[arg2] = arg6(0, arg3, final - arg3, arg5)
    coroutine.wrap(function()
        local var8 = tick()
        while var8 < module.EndTime and arg1 do
            if module.Cancelled then
                return
            end
            arg1[arg2] = arg6(var8 - module.StartTime, arg3, final - arg3, arg5)
            percentComplete = clamp(0, 1, (var8 - module.StartTime) / arg5)
            RunService.RenderStepped:Wait()
            var8 = tick()
        end
        if module.Cancelled == false and arg1 then
            finalize()
        end
    end)()

    function module.GetFinal(_)
        return final
    end

    function module.GetPercentComplete(_)
        return percentComplete
    end

    function module.IsFinished(_)
        return isFinished
    end

    function module.Finish(arg7)
        if not isFinished then
            arg7:Cancel()
            finalize()
        end
    end

    function module.Cancel(_)
        module.Cancelled = true
    end

    return module
end

local function isTouchInput(): boolean -- Luacid: Inlined by compiler; 28 call sites recovered
    return UserInputService.PreferredInput == Enum.PreferredInput.Touch
end

local function CreateSignal()
    local module = {}

    local bindableEvent = Instance.new("BindableEvent")

    local var8 = nil
    local var9 = nil

    function module.fire(_, ...)
        var8 = { ... }
        local select = select
        var9 = select("#", ...)
        bindableEvent:Fire()
    end

    function module.connect(_, callback): RBXScriptConnection
        if not callback then
            error("connect(nil)", 2)
        end
        return bindableEvent.Event:Connect(function()
            callback(unpack(var8, 1, var9))
        end)
    end

    function module.wait(_)
        bindableEvent.Event:wait()
        if not var8 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        end
        return unpack(var8, 1, var9)
    end

    return module
end

local function getViewportSize() -- Luacid: Inlined by compiler; 14 call sites recovered
    if _G.__TESTEZ_RUNNING_TEST__ then
        return Vector2.new(1024, 1024)
    end

    return GuiService:GetHardwareSafeViewport()
end

local function isSmallTouchScreen(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local vector2 = getViewportSize()
    return UserInputService.TouchEnabled and (vector2.Y < 500 or vector2.X < 700)
end

local function isPortrait(): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    local vector2 = getViewportSize()
    return vector2.Y > vector2.X
end

local function isTenFootInterface() -- Luacid: unused: defined but never referenced
    return var6
end

local function usesSelectedObject(): boolean -- Luacid: Inlined by compiler; 23 call sites recovered
    return not VRService.VREnabled and not not (not isTouchInput() or UserInputService.GamepadEnabled)
end

local function addHoverState(arg1, arg2, callback, callback2)
    local function onNormalButtonStateCallback()
        if arg1.Active then
            callback(arg2)
        end
    end
    local function onHoverButtonStateCallback()
        if arg1.Active then
            callback2(arg2)
        end
    end

    arg1.MouseEnter:Connect(onHoverButtonStateCallback)
    arg1.SelectionGained:Connect(onHoverButtonStateCallback)
    arg1.MouseLeave:Connect(onNormalButtonStateCallback)
    arg1.SelectionLost:Connect(onNormalButtonStateCallback)

    callback(arg2)
end

local function addOnResizedCallback(arg1, callback) -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl1[arg1] = callback
    callback(getViewportSize(), (isPortrait()))
end

local tbl2 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
}

local function MakeDefaultButton(arg1, size, callback, arg2, arg3, arg4)
    local selectionImageObject = Create("ImageLabel")({ Image = "", BackgroundTransparency = 1 })

    local str1 = "DefaultButtonStroke"
    local str2 = "DefaultButton"
    if arg1 == "DropDownFrame" then
        str1 = "ControlInputStroke"
        str2 = "ControlInputBackground"
    end

    str2 = if arg4 == "ImageButton" then "ImageButton" else str2

    local var9 = Create("ImageButton")({
        Name = arg1 .. "Button",
        AutoButtonColor = false,
        BackgroundColor3 = Theme.color(str2),
        BackgroundTransparency = Theme.transparency(str2),
        Size = size,
        ZIndex = 2,
        SelectionImageObject = selectionImageObject
    })
    Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var9 })

    local var10 = Create("UIStroke")({
        Name = "Border",
        Color = Theme.color(str1),
        Transparency = Theme.transparency(str1),
        Thickness = Theme.DefaultStokeThickness,
        Parent = var9
    })

    Create("BoolValue")({ Name = "Enabled", Parent = var9, Value = true })

    if callback then
        var9.MouseButton1Click:Connect(function()
            callback(tbl2[UserInputService:GetLastInputType()] or false)
        end)
    else
        if var10 then
            var10.Enabled = false
        end
        var9.Selectable = false
    end

    local function isPointerInput(input): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
    end

    local var11 = nil
    local function setRowRef(arg5)
        var11 = arg5
    end

    local function selectButton()
        local var12 = arg3
        if var12 == nil and arg2 then
            var12 = arg2.HubRef
        end

        if (not var12 or not var12.Active) and var12 ~= nil then
            return
        end

        var9.BackgroundColor3 = Theme.color("DefaultButtonHover")
        var9.BackgroundTransparency = Theme.transparency("DefaultButtonHover")

        local var13 = var9
        if var11 then
            var13 = var11
        end
        if var12 then
            var12:ScrollToFrame(var13)
        end
    end

    local function deselectButton() -- Luacid: Inlined by compiler; 3 call sites recovered
        var9.BackgroundColor3 = Theme.color(str2)
        var9.BackgroundTransparency = Theme.transparency(str2)
    end

    var9.InputBegan:Connect(function(input: InputObject)
        if var9.Selectable and isPointerInput(input) then
            selectButton()
        end
    end)
    var9.InputEnded:Connect(function(input: InputObject)
        if var9.Selectable and GuiService.SelectedCoreObject ~= var9 and isPointerInput(input) then
            deselectButton()
        end
    end)

    var9.SelectionGained:Connect(function()
        selectButton()
    end)
    var9.SelectionLost:Connect(function()
        deselectButton()
    end)

    local _connection = GuiService.Changed:Connect(function(property: string)
        if property ~= "SelectedCoreObject" then
            return
        end

        if not usesSelectedObject() then
            return
        end

        if GuiService.SelectedCoreObject == nil or GuiService.SelectedCoreObject ~= var9 then
            deselectButton()
        elseif var9.Selectable then
            selectButton()
        end
    end)

    return var9, setRowRef
end

local function MakeButton(arg1, text, size, callback, arg2, arg3)
    local var8, func1 = MakeDefaultButton(arg1, size, callback, arg2, arg3)

    local parent = Create("TextLabel")({
        Name = arg1 .. "TextLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = Theme.color("WhiteButtonText", Color3.fromRGB(255, 255, 255)),
        TextTransparency = Theme.transparency("WhiteButtonText", 0),
        TextYAlignment = Enum.TextYAlignment.Center,
        Font = Theme.font(Enum.Font.SourceSansBold, "Button"),
        TextSize = Theme.textSize(24, "Button"),
        Text = text,
        TextScaled = false,
        TextWrapped = true,
        ZIndex = 2,
        Parent = var8
    })
    local uiTextSizeConstraint = Instance.new("UITextSizeConstraint", parent)

    if isSmallTouchScreen() then
        parent.TextSize = Theme.textSize(18)
    elseif var6 and arg1 ~= "FriendStatus" and arg1 ~= "BlockButton" then
        parent.TextSize = Theme.textSize(36)
    end

    if not engineFeature then
        uiTextSizeConstraint.MaxTextSize = parent.TextSize
    else
        local var9 = (GuiService.PreferredTextSize.Value - 1) * 3
        uiTextSizeConstraint.MaxTextSize = parent.TextSize + var9
        local textSize = parent.TextSize
        GuiService:GetPropertyChangedSignal("PreferredTextSize"):Connect(function()
            var9 = (GuiService.PreferredTextSize.Value - 1) * 3
            uiTextSizeConstraint.MaxTextSize = textSize + var9
        end)
    end

    return var8, parent, func1
end

local function MakeImageButton(arg1, arg2, arg3, size, callback, arg4, arg5, arg6)
    arg6 = arg6 or "ImageButton"

    local var8, func1 = MakeDefaultButton(arg1, arg3, callback, arg4, arg5, arg6)

    local imageRectOffset = nil
    local imageRectSize = nil

    local var9 = Migration.uiblox[arg2] or Migration.luaApps[arg2]
    if not string.match(arg2, "^rbxasset://") then
        arg2 = Theme.Images[arg2]
    end
    if typeof(arg2) == "table" then
        imageRectOffset = arg2.ImageRectOffset
        imageRectSize = arg2.ImageRectSize
        arg2 = arg2.Image
    end

    local var10

    if var9 then
        var10 = Create("TextLabel")({
            Name = arg1 .. "TextLabel",
            BackgroundTransparency = 1,
            Size = size,
            TextSize = if bool2 then size.Y.Offset * (6 / 7) else size.Y.Offset * (2 / 3),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            TextColor3 = Color3.new(1, 1, 1),
            Text = var9.name,
            FontFace = BuilderIcons.Font[var9.variant],
            Parent = var8,
            ZIndex = 2
        })
    else
        var10 = Create("ImageLabel")({
            Name = arg1 .. "ImageLabel",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = size,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = arg2,
            ImageRectOffset = imageRectOffset,
            ImageRectSize = imageRectSize,
            ZIndex = 2,
            Parent = var8
        })
    end
    if arg6 == "ImageButton" then
        var8.Border.Thickness = 0
        var8.Border.Transparency = 1
    end
    return var8, var10, func1
end

local function AddButtonRow(arg1, arg2, text, size, callback, arg3)
    local var8, var9, func1 = MakeButton(arg2, text, size, callback, arg1, arg3)
    local var10 = Create("Frame")({
        Name = arg2 .. "Row",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, size.Y.Scale, size.Y.Offset),
        Parent = arg1.Page
    })
    var8.Parent = var10
    var8.AnchorPoint = Vector2.new(1, 0)
    var8.Position = UDim2.new(1, -20, 0, 0)
    return var10, var8, var9, func1
end

local function MakeRoundedRectFocusState(arg1, name: string)
    local selectionImageObject = Create("Frame")({ BackgroundTransparency = 1, Size = UDim2.new(1, 12, 1, 12), Position = UDim2.fromOffset(-6, -6) })

    Create("UICorner")({ CornerRadius = uDim, Parent = selectionImageObject })

    local var9 = Create("UIStroke")(
        {
            Color = Theme.selectionCursor.AnimatedColor,
            Transparency = 0,
            Thickness = 3,
            Parent = selectionImageObject
        }
    )
    local var10 = Create("UIGradient")({
        Rotation = 0,
        Color = Theme.selectionCursor.GradientColorSequence,
        Transparency = Theme.selectionCursor.GradientTransparencySequence,
        Parent = var9
    })
    RunService:UnbindFromRenderStep(name)

    RunService:BindToRenderStep(name, Enum.RenderPriority.Last.Value, function()
        local rotation = var10.Rotation + 2
        local gradientColorSequence = Theme.selectionCursor.GradientColorSequence
        local gradientTransparencySequence = Theme.selectionCursor.GradientTransparencySequence

        if UserGameSettings.ReducedMotion then
            local num1 = (math.sin(math.rad(rotation)) + 1) / 2

            local value = gradientColorSequence.Keypoints[1].Value
            local value2 = gradientColorSequence.Keypoints[#gradientColorSequence.Keypoints].Value
            gradientColorSequence = ColorSequence.new(value:lerp(value2, num1))

            local value3 = gradientTransparencySequence.Keypoints[1].Value
            local value4 = gradientTransparencySequence.Keypoints[#gradientTransparencySequence.Keypoints].Value
            gradientTransparencySequence = NumberSequence.new(value3 + (value4 - value3) * num1)
        end

        var10.Rotation = rotation
        var10.Color = gradientColorSequence
        var10.Transparency = gradientTransparencySequence
    end)

    arg1.AncestryChanged:Connect(function(_: Instance, parent: Instance)
        if not parent then
            RunService:UnbindFromRenderStep(name)
        end
    end)

    arg1.SelectionImageObject = selectionImageObject
end

local function CreateDropDown(arg1, arg2, arg3)
    local var8 = Theme.color("SELECTION_TEXT_COLOR_NORMAL", Color3.fromRGB(178, 178, 178))
    local lightStoneGrey = Color3.fromRGB(229, 229, 229)

    local textColor3 = Theme.color("SELECTION_TEXT_COLOR_HIGHLIGHTED", Color3.fromRGB(255, 255, 255))

    local dropDownFrame = nil

    local module = {
        CurrentIndex = nil,
        UpdateDropDownList = nil,
        DropDownFrame = nil,
        Selections = nil
    }
    Instance.new("BindableEvent").Name = "IndexChanged"

    if type(arg1) ~= "table" then
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2)
        return module
    end

    local indexChanged = Instance.new("BindableEvent")
    indexChanged.Name = "IndexChanged"

    local currentVisible = true
    local selectionName = HttpService:GenerateGUID(false)
    local dropDownFrameEnabled = nil
    local tbl3 = arg1

    local vector2, _vector2 = GuiService:GetGuiInset()
    local var10 = Create("ImageButton")({
        Name = "DropDownFullscreenFrame",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, if bool1 then vector2.Y else 0),
        Position = if bool1 then UDim2.new(0, 0, 0, -vector2.Y) else nil,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        ZIndex = 10,
        Active = true,
        Visible = false,
        Selectable = false,
        AutoButtonColor = false,
        Parent = CoreGui.RobloxGui
    })

    local function onVREnabled(property: string)
        if property ~= "VREnabled" then
            return
        end
        if VRService.VREnabled then
            if isInExperienceUIVREnabled then
                local vrSpatialUi = require(CorePackages2.Workspace.Packages.VrSpatialUi)
                local panelType = vrSpatialUi.Constants.PanelType
                var10.Parent = vrSpatialUi.UIManager.getInstance():getPanelObject(panelType.MoreMenu)
                var10.BackgroundTransparency = 0.2
            else
                local panel3D = require(CorePackages2.Workspace.Packages.VrCommon).Panel3D
                var10.Parent = panel3D.Get("SettingsMenu"):GetGUI()
                var10.BackgroundTransparency = 1
            end
        else
            var10.Parent = CoreGui.RobloxGui
            var10.BackgroundTransparency = 0.2
        end

        if module.UpdateDropDownList then
            module:UpdateDropDownList(tbl3)
        end
    end
    VRService.Changed:Connect(onVREnabled)
    onVREnabled("VREnabled")

    local var11 = Create("ImageLabel")({
        Name = "DropDownSelectionFrame",
        Image = "",
        ScaleType = Enum.ScaleType.Stretch,
        SliceCenter = Rect.new(8, 6, 46, 44),
        BackgroundTransparency = Theme.transparency("DropdownListBg", 1),
        BackgroundColor3 = Theme.color("DropdownListBg"),
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 10,
        Parent = var10
    })

    Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var11 })

    local var12 = Create("ScrollingFrame")({
        Name = "DropDownScrollingFrame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 1, -25),
        Position = UDim2.new(0, 10, 0, 10),
        ZIndex = 10,
        ScrollBarThickness = Theme.DefaultScrollBarThickness,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = var11
    })

    local connection = nil
    local bool3 = false
    local function func1(arg4, userInputState)
        if arg4 ~= nil and userInputState ~= Enum.UserInputState.Begin then
            return
        end
        module.DropDownFrame.Selectable = currentVisible

        arg3:SetActive(true)

        if var10.Visible and usesSelectedObject() then
            GuiService.SelectedCoreObject = dropDownFrame
        end
        var10.Visible = false
        if connection then
            connection:Disconnect()
        end
        ContextActionService:UnbindCoreAction(selectionName .. "Action")
        ContextActionService:UnbindCoreAction(selectionName .. "FreezeAction")

        dropDownFrameEnabled.Value = currentVisible
        bool3 = false

        if VRService.VREnabled and not isInExperienceUIVREnabled then
            require(CorePackages2.Workspace.Packages.VrCommon).Panel3D.Get("SettingsMenu"):SetSubpanelDepth(var10, 0)
        end
    end

    local function func2() end

    local function func3()
        if not currentVisible then
            return
        end

        module.DropDownFrame.Selectable = false
        bool3 = true

        var10.Visible = true
        if VRService.VREnabled and not isInExperienceUIVREnabled then
            require(CorePackages2.Workspace.Packages.VrCommon).Panel3D.Get("SettingsMenu"):SetSubpanelDepth(var10, 0.5)
        end

        dropDownFrame = module.DropDownFrame
        if module.CurrentIndex and module.CurrentIndex > 0 then
            GuiService.SelectedCoreObject = module.Selections[module.CurrentIndex]
        elseif #module.Selections > 0 then
            GuiService.SelectedCoreObject = module.Selections[1]
        end

        connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
            for i = 1, #module.Selections do
                if GuiService.SelectedCoreObject == module.Selections[i] then
                    module.Selections[i].TextColor3 = textColor3
                else
                    module.Selections[i].TextColor3 = VRService.VREnabled and lightStoneGrey or var8
                end
            end
        end)

        local functionToBind = func1
        if FFlagHideShortcutsWhileIemDropdownActive then
            Service:setHideShortcutBar("InExperienceMenuDropdown", true)
            functionToBind = function(arg4, userInputState)
                func1(arg4, userInputState)
                Service:setHideShortcutBar("InExperienceMenuDropdown", false)
            end
        end

        ContextActionService:BindCoreAction(
            selectionName .. "FreezeAction",
            func2,
            false,
            Enum.UserInputType.Keyboard,
            Enum.UserInputType.Gamepad1
        )
        ContextActionService:BindCoreAction(
            selectionName .. "Action",
            functionToBind,
            false,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.Escape
        )

        arg3:SetActive(false)

        dropDownFrameEnabled.Value = false
    end

    local dropDownFrameTextLabelText = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.ChooseOne")

    local uDim2 = UDim2.new(0.6, 0, 0, 40)
    module.DropDownFrame = MakeButton("DropDownFrame", dropDownFrameTextLabelText, uDim2, func3, nil, arg3)
    module.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0)
    module.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5)

    dropDownFrameEnabled = module.DropDownFrame.Enabled
    local dropDownFrameTextLabel = module.DropDownFrame.DropDownFrameTextLabel
    dropDownFrameTextLabel.Position = UDim2.new(0, 15, 0, 0)
    dropDownFrameTextLabel.Size = UDim2.new(1, -50, 1, 0)
    dropDownFrameTextLabel.ClipsDescendants = true
    dropDownFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left
    local dropDownImage = Create("ImageLabel")({
        Name = "DropDownImage",
        Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0, 15, 0, 10),
        Position = UDim2.new(1, -12, 0.5, 0),
        ZIndex = 2,
        Parent = module.DropDownFrame
    })
    module.DropDownImage = dropDownImage

    local function setSelection(arg4)
        local bool4 = false
        for currentIndex, Selection in pairs(module.Selections) do
            if currentIndex == arg4 then
                dropDownFrameTextLabel.Text = Selection.Text
                module.CurrentIndex = currentIndex
                bool4 = true
            end
        end

        if bool4 then
            indexChanged:Fire(arg4)
        end
    end

    local function setSelectionByValue(text): boolean
        local bool4 = false
        for currentIndex, Selection in pairs(module.Selections) do
            if Selection.Text == text then
                dropDownFrameTextLabel.Text = Selection.Text
                module.CurrentIndex = currentIndex
                bool4 = true
            end
        end

        if bool4 then
            indexChanged:Fire(module.CurrentIndex)
        end
        return bool4
    end

    local function setIsFaded(bool4: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool4 then
            module.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
            module.DropDownFrame.ImageTransparency = 0.5
            module.DropDownImage.ImageTransparency = 0.5
            return
        end
        module.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
        module.DropDownFrame.ImageTransparency = 0
        module.DropDownImage.ImageTransparency = 0
    end

    module.IndexChanged = indexChanged.Event

    function module.SetSelectionIndex(_, arg4)
        setSelection(arg4)
    end

    function module.SetSelectionByValue(_, text): boolean
        return (setSelectionByValue(text))
    end

    function module.ResetSelectionIndex(_)
        module.CurrentIndex = nil
        dropDownFrameTextLabel.Text = dropDownFrameTextLabelText
        func1()
    end

    function module.GetSelectedIndex(_)
        return module.CurrentIndex
    end

    function module.SetZIndex(_, zIndex)
        module.DropDownFrame.ZIndex = zIndex
        dropDownImage.ZIndex = zIndex
        dropDownFrameTextLabel.ZIndex = zIndex
    end

    function module.SetInteractable(_, visible)
        currentVisible = visible
        module.DropDownFrame.Selectable = currentVisible

        if not currentVisible then
            func1()
            setIsFaded(VRService.VREnabled)
            if not VRService.VREnabled then
                module:SetZIndex(1)
            end
        else
            setIsFaded(false)

            if not VRService.VREnabled then
                module:SetZIndex(2)
            end
        end

        dropDownFrameEnabled.Value = visible and not bool3

        module.DropDownImage.Visible = visible
        if visible then
            module.DropDownFrame.ImageTransparency = 0
            return
        end
        module.DropDownFrame.ImageTransparency = 0.5
    end

    function module.SetAutoLocalize(_, autoLocalize)
        var10.AutoLocalize = autoLocalize
    end

    function module.UpdateDropDownList(_, arg4)
        tbl3 = arg4

        if module.Selections then
            for i = 1, #module.Selections do
                module.Selections[i]:Destroy()
            end
        end

        module.Selections = {}
        module.SelectionInfo = {}

        local vrEnabled = VRService.VREnabled
        local font = vrEnabled and Theme.font(Enum.Font.SourceSansBold, "Bold") or Theme.font(Enum.Font.SourceSans, "UtilityText")
        local textSize = vrEnabled and Theme.textSize(36) or Theme.textSize(24, "UtilityText")

        local yOffset = if vrEnabled then 70 else 50
        local num1 = yOffset + 1

        local xOffset = if vrEnabled then 600 else 400
        local num2 = 0

        for currentIndex, value in pairs(arg4) do
            local selectionImageObject = Create("Frame")({ BackgroundTransparency = 0.7, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0) })

            Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = selectionImageObject })

            local bool4 = typeof(value) == "table"
            local title, subtitle

            if bool4 then
                title = value.title
                subtitle = value.subtitle
                num2 += 10
            else
                title = value
                subtitle = ""
            end

            local var18

            if bool4 then
                var18 = Create("TextButton")({
                    Name = "Selection" .. tostring(currentIndex),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Size = UDim2.new(1, -28, 0, yOffset + 10),
                    Position = UDim2.new(0, 14, 0, (currentIndex - 1) * (num1 + 10)),
                    TextColor3 = VRService.VREnabled and lightStoneGrey or var8,
                    Font = font,
                    TextSize = textSize,
                    Text = title,
                    ZIndex = 10,
                    SelectionImageObject = selectionImageObject,
                    Parent = var12
                })

                Create("TextLabel")({
                    Name = "Subtitle" .. tostring(currentIndex),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -28, 0, yOffset * 0.8),
                    Position = UDim2.new(0, 14, 0, 15),
                    TextColor3 = VRService.VREnabled and lightStoneGrey or var8,
                    Font = font,
                    TextSize = textSize * 0.8,
                    Text = subtitle,
                    ZIndex = 10,
                    Parent = var18
                })
            else
                var18 = Create("TextButton")({
                    Name = "Selection" .. tostring(currentIndex),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, -28, 0, yOffset),
                    Position = UDim2.new(0, 14, 0, (currentIndex - 1) * num1),
                    TextColor3 = VRService.VREnabled and lightStoneGrey or var8,
                    Font = font,
                    TextSize = textSize,
                    Text = value,
                    ZIndex = 10,
                    SelectionImageObject = selectionImageObject,
                    Parent = var12
                })
            end

            if currentIndex == arg2 then
                module.CurrentIndex = currentIndex
                dropDownFrameTextLabel.Text = title
                var18.TextColor3 = textColor3
            elseif not arg2 and currentIndex == 1 then
                var18.TextColor3 = textColor3
            end

            local function clicked()
                dropDownFrameTextLabel.Text = var18.Text
                func1()
                module.CurrentIndex = currentIndex
                indexChanged:Fire(currentIndex)
            end

            var18.MouseButton1Click:Connect(clicked)

            var18.MouseEnter:Connect(function()
                if usesSelectedObject() then
                    GuiService.SelectedCoreObject = var18
                end
            end)

            module.Selections[currentIndex] = var18
            module.SelectionInfo[var18] = { Clicked = clicked }
        end

        GuiService:RemoveSelectionGroup(selectionName)
        GuiService:AddSelectionTuple(selectionName, unpack(module.Selections))

        var12.CanvasSize = UDim2.new(1, -20, 0, #arg4 * num1 + num2)

        local function updateDropDownSize()
            if var12.CanvasSize.Y.Offset < var10.AbsoluteSize.Y - 10 then
                var11.Size = UDim2.new(0, xOffset, 0, var12.CanvasSize.Y.Offset + 25)
                return
            end

            var11.Size = UDim2.new(0, xOffset, 0.9, 0)
        end

        var10.Changed:Connect(function(arg5)
            if arg5 ~= "AbsoluteSize" then
                return
            end
            updateDropDownSize()
        end)

        updateDropDownSize()
    end

    module:UpdateDropDownList(arg1)

    var10.MouseButton1Click:Connect(func1)

    arg3.PoppedMenu:Connect(function(arg4)
        if arg4 == var10 then
            func1()
        end
    end)

    return module
end

local function CreateSelector(arg1, arg2)
    local num1 = 0

    local module = { HubRef = nil, SetSelectionIndex = nil }

    if type(arg1) ~= "table" then
        error("CreateSelector selectionStringTable (first arg) is not a table", 2)
        return module
    end

    local indexChanged = Instance.new("BindableEvent")
    indexChanged.Name = "IndexChanged"

    local bool3 = true

    module.CurrentIndex = 0

    module.SelectorFrame = Create("ImageButton")({
        Name = "Selector",
        Image = "",
        AutoButtonColor = false,
        NextSelectionLeft = module.SelectorFrame,
        NextSelectionRight = module.SelectorFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 0, 50),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        ZIndex = 2,
        SelectionImageObject = SelectionImageObject
    })

    local var8 = Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, Theme.SelectorArrowButtonWidth, 0, 50),
        Image = "",
        ZIndex = 3,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Parent = module.SelectorFrame
    })
    local var9 = Create("ImageButton")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, Theme.SelectorArrowButtonWidth, 0, 50),
        Image = "",
        ZIndex = 3,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Parent = module.SelectorFrame
    })

    local var10 = Create("ImageLabel")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
        ImageColor3 = ImageColor3,
        ZIndex = 4,
        Parent = var8
    })
    local var11 = Create("ImageLabel")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
        ImageColor3 = ImageColor3,
        ZIndex = 4,
        Parent = var9
    })

    if not isTouchInput() then
        local function func1(arg3)
            arg3.ImageColor3 = ImageColor3
        end

        local function func2(arg3)
            arg3.ImageColor3 = var2
        end
        addHoverState(var8, var10, func1, func2)
        addHoverState(var9, var11, func1, func2)
    end

    module.Selections = {}
    local tbl3 = ({})
    local tbl4 = ({})

    local var12 = Create("ImageButton")({
        Name = "AutoSelectButton",
        BackgroundTransparency = 1,
        Image = "",
        Position = UDim2.new(0, var8.Size.X.Offset, 0, 0),
        Size = UDim2.new(1, var8.Size.X.Offset * -2, 1, 0),
        Parent = module.SelectorFrame,
        ZIndex = 2,
        SelectionImageObject = SelectionImageObject
    })
    var12.MouseButton1Click:Connect(function()
        if not bool3 or #module.Selections <= 1 then
            return
        end

        local var13 = module.CurrentIndex + 1
        local var14 = if #module.Selections < var13 then 1 else var13

        module:SetSelectionIndex(var14)

        if usesSelectedObject() then
            GuiService.SelectedCoreObject = module.SelectorFrame
        end
    end)
    tbl4[var12] = true

    local function setSelection(arg3, num2: number)
        for currentIndex, Selection in pairs(module.Selections) do
            local bool4 = currentIndex == arg3

            local uDim2 = UDim2.new(0, var8.Size.X.Offset, 0, 0)
            local uDim2_2 = UDim2.new(0, var8.Size.X.Offset * num2 * 3, 0, 0)

            if tbl3[Selection] then
                uDim2_2 = UDim2.new(0, var8.Size.X.Offset * -num2 * 3, 0, 0)
            end

            if uDim2_2.X.Offset < 0 then
                uDim2_2 = UDim2.new(0, uDim2_2.X.Offset + Selection.AbsoluteSize.X / 4, 0, 0)
            end

            if bool4 then
                tbl3[Selection] = true
                Selection.Position = uDim2_2
                Selection.Visible = true
                PropertyTweener(Selection, "TextTransparency", 1, 0, 0.165, EaseOutQuad)
                if Selection:IsDescendantOf(game) then
                    Selection:TweenPositionInternal(uDim2, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true)
                else
                    Selection.Position = uDim2
                end
                module.CurrentIndex = currentIndex
                indexChanged:Fire(arg3)
            elseif tbl3[Selection] then
                tbl3[Selection] = false
                PropertyTweener(Selection, "TextTransparency", 0, 1, 0.165, EaseOutQuad)
                if Selection:IsDescendantOf(game) then
                    Selection:TweenPositionInternal(uDim2_2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true)
                else
                    Selection.Position = uDim2_2
                end
            end
        end
    end

    local function stepFunc(arg3, num2: number) -- Luacid: Inlined by compiler; 4 call sites recovered
        if not bool3
            or arg3 ~= nil
                and arg3.UserInputType ~= Enum.UserInputType.MouseButton1
                and arg3.UserInputType ~= Enum.UserInputType.Gamepad1
                and arg3.UserInputType ~= Enum.UserInputType.Gamepad2
                and arg3.UserInputType ~= Enum.UserInputType.Gamepad3
                and arg3.UserInputType ~= Enum.UserInputType.Gamepad4
                and arg3.UserInputType ~= Enum.UserInputType.Keyboard
        then
            return
        end

        if usesSelectedObject() then
            GuiService.SelectedCoreObject = module.SelectorFrame
        end

        local var13 = num2 + module.CurrentIndex

        local num3 = if module.CurrentIndex < var13 then 1 else -1

        local var14 = if #module.Selections < var13 then 1 else var13 < 1 and #module.Selections or var13

        setSelection(var14, num3)
    end

    local connection = nil
    local function connectToGuiService() -- Luacid: Inlined by compiler; 2 call sites recovered
        connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
            if #module.Selections <= 0 then
                return
            end

            if GuiService.SelectedCoreObject ~= nil and tbl4[GuiService.SelectedCoreObject] and not VRService.VREnabled then
                GuiService.SelectedCoreObject = module.SelectorFrame
            end
        end)
    end

    module.IndexChanged = indexChanged.Event

    function module.SetSelectionIndex(_, arg3)
        setSelection(arg3, 1)
    end

    function module.GetSelectedIndex(_)
        return module.CurrentIndex
    end

    function module.SetZIndex(_, zIndex)
        var8.ZIndex = zIndex
        var9.ZIndex = zIndex
        var10.ZIndex = zIndex
        var11.ZIndex = zIndex

        for i = 1, #module.Selections do
            module.Selections[i].ZIndex = zIndex
        end
    end

    function module.SetInteractable(_, arg3)
        bool3 = arg3
        module.SelectorFrame.Selectable = bool3

        var8.Active = bool3
        var9.Active = bool3

        var8.Visible = bool3
        var9.Visible = bool3

        if not bool3 then
            for _, Selection in pairs(module.Selections) do
                Selection.TextColor3 = Theme.color("NotInteractableSelection", Color3.fromRGB(255, 255, 255))
            end
            var10.ImageColor3 = var3
            var11.ImageColor3 = var3
            return
        end
        for _, Selection in pairs(module.Selections) do
            Selection.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        var10.ImageColor3 = ImageColor3
        var11.ImageColor3 = ImageColor3
    end

    function module.UpdateOptions(_, arg3)
        for _, Selection in pairs(module.Selections) do
            Selection:Destroy()
        end

        tbl3 = {}
        module.Selections = {}

        for currentIndex, value in pairs(arg3) do
            local var13 = Create("TextLabel")({
                Name = "Selection" .. tostring(currentIndex),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, var8.Size.X.Offset * -2, 1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextYAlignment = Enum.TextYAlignment.Center,
                Font = Theme.font(Enum.Font.SourceSans, "UtilityText"),
                TextSize = Theme.textSize(24, "UtilityText"),
                TextWrapped = true,
                Text = value,
                ZIndex = 2,
                Visible = false,
                Parent = module.SelectorFrame
            })

            if var6 then
                var13.TextSize = Theme.textSize(36)
            end

            if currentIndex == arg2 then
                module.CurrentIndex = currentIndex
                var13.Position = UDim2.new(0, var8.Size.X.Offset, 0, 0)
                var13.Visible = true

                tbl3[var13] = true
            else
                tbl3[var13] = false
            end

            module.Selections[currentIndex] = var13
        end

        local bool4 = #module.Selections > 1
        var8.Visible = bool4
        var9.Visible = bool4
    end

    local function onVREnabled(property: string) -- Luacid: Inlined by compiler; 1 call site recovered
        if property ~= "VREnabled" then
            return
        end
        local vrEnabled = VRService.VREnabled
        var8.Selectable = vrEnabled
        var9.Selectable = vrEnabled
        var12.Selectable = vrEnabled
    end
    VRService.Changed:Connect(onVREnabled)
    onVREnabled("VREnabled")

    var8.InputBegan:Connect(function(input: InputObject)
        if shouldSelectorArrowStep(input.UserInputType, computed(false), computed2(false)) then
            stepFunc(nil, -1)
        end
    end)

    var9.InputBegan:Connect(function(input: InputObject)
        if shouldSelectorArrowStep(input.UserInputType, computed(false), computed2(false)) then
            stepFunc(nil, 1)
        end
    end)

    local bool4 = true
    module:UpdateOptions(arg1)

    UserInputService.InputBegan:Connect(function(input: InputObject)
        if not bool3 then
            return
        end

        if not bool4 then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.Gamepad1 and input.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end

        if GuiService.SelectedCoreObject ~= module.SelectorFrame then
            return
        end

        if input.KeyCode == Enum.KeyCode.DPadLeft or input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.A then
            stepFunc(input, -1)
        elseif input.KeyCode == Enum.KeyCode.DPadRight or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.D then
            stepFunc(input, 1)
        end
    end)

    UserInputService.InputChanged:Connect(function(input: InputObject)
        if not bool3 then
            return
        end

        if not bool4 then
            num1 = 0
            return
        end

        if input.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        local selectedCoreObject = GuiService.SelectedCoreObject
        if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SelectorFrame.Parent)) then
            return
        end

        if input.KeyCode ~= Enum.KeyCode.Thumbstick1 then
            return
        end

        if input.Position.X > 0.8 and input.Delta.X > 0 and num1 ~= 1 then
            num1 = 1
            stepFunc(input, num1)
        elseif input.Position.X < -0.8 and input.Delta.X < 0 and num1 ~= -1 then
            num1 = -1
            stepFunc(input, num1)
        elseif math.abs(input.Position.X) < 0.8 then
            num1 = 0
        end
    end)

    module.SelectorFrame.AncestryChanged:Connect(function(_: Instance, parent: Instance)
        bool4 = parent
        if bool4 then
            connectToGuiService()
            return
        end

        if connection then
            connection:Disconnect()
        end
    end)

    addOnResizedCallback(module.SelectorFrame, function(_, arg3) -- name: onResized
        local textSize = if arg3 then Theme.textSize(16) else var6 and Theme.textSize(36) or Theme.textSize(24, "UtilityText")

        for _, Selection in pairs(module.Selections) do
            Selection.TextSize = textSize
        end
    end)

    connectToGuiService()
    return module
end

local function ShowAlert(text, arg1, arg2, callback, arg3)
    local robloxGui = CoreGui.RobloxGui
    if robloxGui:FindFirstChild("AlertViewFullScreen") then
        return
    end

    local var8 = nil

    local function onVREnabled(property: string)
        if property ~= "VREnabled" then
            return
        end
        local var9 = nil
        if VRService.VREnabled then
            if isInExperienceUIVREnabled then
                local vrSpatialUi = require(CorePackages2.Workspace.Packages.VrSpatialUi)
                local panelType = vrSpatialUi.Constants.PanelType
                robloxGui = vrSpatialUi.UIManager.getInstance():getPanelObject(panelType.MoreMenu)
            else
                var9 = require(CorePackages2.Workspace.Packages.VrCommon).Panel3D.Get("SettingsMenu")
                robloxGui = var9:GetGUI()
            end
        else
            robloxGui = CoreGui.RobloxGui
        end
        if not var8 or var8.Parent == nil then
            return
        end

        var8.Parent = robloxGui
        if VRService.VREnabled and not isInExperienceUIVREnabled then
            var9:SetSubpanelDepth(var8, 0.5)
        end
    end

    local connection = VRService.Changed:Connect(onVREnabled)

    var8 = Create("ImageLabel")({
        Name = "AlertViewBacking",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.new(0, 400, 0, 350),
        Position = UDim2.new(0.5, -200, 0.5, -175),
        ZIndex = 9,
        Parent = robloxGui
    })
    onVREnabled("VREnabled")

    if not arg3 then
        if isInExperienceUIVREnabled or not VRService.VREnabled then
            local uDim2 = UDim2.new(0.8, 0, 0, 350)
            var8.Size = uDim2
            local uDim2_2 = UDim2.new(0.1, 0, 0.1, 0)
            var8.Position = uDim2_2
        else
            var8.ImageTransparency = 0
        end
    else
        var8.ImageTransparency = 0
    end

    if CoreGui.RobloxGui.AbsoluteSize.Y <= var8.Size.Y.Offset then
        local uDim2 = UDim2.new(var8.Size.X.Scale, var8.Size.X.Offset, var8.Size.Y.Scale, CoreGui.RobloxGui.AbsoluteSize.Y)
        var8.Size = uDim2

        local uDim2_2 = UDim2.new(var8.Position.X.Scale, -var8.Size.X.Offset / 2, 0.5, -var8.Size.Y.Offset / 2)
        var8.Position = uDim2_2
    end

    if not arg3 then
        Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var8 })

        local backgroundColor3 = Theme.color("MenuContainer")
        var8.BackgroundColor3 = backgroundColor3
        local backgroundTransparency = Theme.transparency("MenuContainer")
        var8.BackgroundTransparency = backgroundTransparency
    end

    Create("TextLabel")({
        Name = "AlertViewText",
        BackgroundTransparency = 1,
        Size = UDim2.new(0.95, 0, 0.6, 0),
        Position = UDim2.new(0.025, 0, 0.05, 0),
        Font = Theme.font(Enum.Font.SourceSansBold, "Bold"),
        TextSize = Theme.textSize(36),
        Text = text,
        TextWrapped = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 10,
        Parent = var8
    })

    Create("ImageLabel")({ Image = "", BackgroundTransparency = 1 })

    local actionName = HttpService:GenerateGUID(false)

    local function func1(_, userInputState)
        if VRService.VREnabled and (userInputState == Enum.UserInputState.Begin or userInputState == Enum.UserInputState.Cancel)
            or not var8
        then
            return
        end

        if VRService.VREnabled and not isInExperienceUIVREnabled then
            require(CorePackages2.Workspace.Packages.VrCommon).Panel3D.Get("SettingsMenu"):SetSubpanelDepth(var8, 0)
        end

        var8:Destroy()
        var8 = nil
        if callback then
            callback()
        end
        ContextActionService:UnbindCoreAction(actionName)
        GuiService.SelectedCoreObject = nil
        if arg2 then
            arg2:ShowBar()
        end
        if connection then
            connection:Disconnect()
        end
    end

    local uDim2 = UDim2.new(1, -20, 0, 60)
    local uDim2_2 = UDim2.new(0, 10, 0.65, 0)
    if not arg3 then
        uDim2 = UDim2.new(0, 200, 0, 50)
        uDim2_2 = UDim2.new(0.5, -100, 0.65, 0)
    end

    local var9, var10 = MakeButton("AlertViewButton", arg1, uDim2, func1)
    var9.Position = uDim2_2
    var9.NextSelectionLeft = var9
    var9.NextSelectionRight = var9
    var9.NextSelectionUp = var9
    var9.NextSelectionDown = var9
    var9.ZIndex = 9
    var10.ZIndex = var9.ZIndex
    var9.Parent = var8

    if usesSelectedObject() then
        GuiService.SelectedCoreObject = var9
    end

    GuiService.SelectedCoreObject = var9

    ContextActionService:BindCoreAction(
        actionName,
        func1,
        false,
        Enum.KeyCode.Escape,
        Enum.KeyCode.ButtonB,
        Enum.KeyCode.ButtonA
    )

    if arg2 and (isInExperienceUIVREnabled or not VRService.VREnabled) then
        arg2:HideBar()
        arg2.Pages.CurrentPage:Hide(1, 1)
    end
end

local function CreateNewSlider(arg1, arg2, arg3, text, text2)
    local module = {}

    local var8 = tonumber(arg1)
    local value = arg2

    local num1 = 0
    local var10 = nil

    local currentSelectable = true

    local var11 = nil

    local bool3 = false
    local bool4 = false

    local var12 = nil

    local name = HttpService:GenerateGUID(false)

    if var8 <= 0 then
        error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2)
        return
    end

    local var13 = text or text2

    local valueChanged = Instance.new("BindableEvent")
    valueChanged.Name = "ValueChanged"
    local signal = Signal.new()

    local var14 = Create("ImageButton")
    local tbl3 = {
        Name = "Slider",
        Image = "",
        AutoButtonColor = false,
        NextSelectionLeft = module.SliderFrame,
        NextSelectionRight = module.SliderFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.6, 0, 0, 50),
        AutomaticSize = if var13 then Enum.AutomaticSize.Y else nil,
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        SelectionImageObject = SelectionImageObject,
        ZIndex = 2
    }
    module.SliderFrame = var14(tbl3)
    local sliderFrame

    if var13 then
        sliderFrame = Create("Frame")({
            Name = "StepsAndButtonsContainer",
            Size = UDim2.new(1, 0, 0, 50),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Parent = module.SliderFrame
        })

        Create("UIListLayout")({
            Name = "UIListLayout",
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = module.SliderFrame
        })

        local var15 = Create("Frame")({
            Name = "SliderLabels",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Parent = module.SliderFrame,
            LayoutOrder = 2
        })

        Create("UIPadding")(
            {
                Name = "UIPadding",
                PaddingRight = UDim.new(0, 50),
                PaddingLeft = UDim.new(0, 50),
                Parent = var15
            }
        )
        local function isWideEnough(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
            return RobloxGui.AbsoluteSize.X > 460
        end
        if text then
            module.LeftLabel = Create("TextLabel")({
                Name = "LeftLabel",
                Text = text,
                Font = Theme.font(Enum.Font.SourceSans, "UtilityRow"),
                TextSize = Theme.textSize(18, "UtilityRow"),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextTransparency = 0.25,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = var15,
                Visible = isWideEnough()
            })
        end

        if text2 then
            module.RightLabel = Create("TextLabel")({
                Name = "RightLabel",
                Text = text2,
                Font = Theme.font(Enum.Font.SourceSans, "UtilityRow"),
                TextSize = Theme.textSize(18, "UtilityRow"),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextTransparency = 0.25,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextWrapped = true,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = var15,
                Visible = isWideEnough()
            })
        end

        RobloxGui:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
            if module.LeftLabel then
                module.LeftLabel.Visible = not not isWideEnough()
            end

            if module.RightLabel then
                module.RightLabel.Visible = not not isWideEnough()
            end
        end)
    else
        sliderFrame = nil
    end

    local var15 = Create("Frame")
    local tbl4 = {
        Name = "StepsContainer",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -100, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Parent = if var13 then sliderFrame else module.SliderFrame
    }
    module.StepsContainer = var15(tbl4)

    local var16 = Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, Theme.SelectorArrowButtonWidth, 0, 50),
        Image = "",
        ZIndex = 3,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Active = true,
        Parent = if var13 then sliderFrame else module.SliderFrame
    })
    local var17 = Create("ImageButton")
    local tbl5 = {
        Name = "RightButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, Theme.SelectorArrowButtonWidth, 0, 50),
        Image = "",
        ZIndex = 3,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Active = true,
        Parent = 0
    }
    if not var13 then
        sliderFrame = module.SliderFrame
    end

    tbl5.Parent = sliderFrame
    local var18 = var17(tbl5)
    local var19 = Create("ImageLabel")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
        ZIndex = 4,
        Parent = var16,
        ImageColor3 = isTouchInput() and var2 or ImageColor3
    })
    local var20 = Create("ImageLabel")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        Image = "rbxasset://textures/ui/Settings/Slider/More.png",
        ZIndex = 4,
        Parent = var18,
        ImageColor3 = isTouchInput() and var2 or ImageColor3
    })

    if not isTouchInput() then
        local function func1(arg4)
            arg4.ImageColor3 = ImageColor3
        end

        local function func2(arg4)
            arg4.ImageColor3 = var2
        end

        addHoverState(var16, var19, func1, func2)
        addHoverState(var18, var20, func1, func2)
    end

    module.Steps = {}

    local xScale = 1 / var8

    for i = 1, var8 do
        local var21 = Create("ImageButton")({
            Name = "Step" .. tostring(i),
            BackgroundColor3 = BackgroundColor3,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Active = false,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new((i - 1) * xScale, 2, 0.5, 0),
            Size = UDim2.new(xScale, -4, 0, 24),
            Image = "",
            ZIndex = 3,
            Selectable = false,
            ImageTransparency = 0.36,
            Parent = module.StepsContainer,
            SelectionImageObject = SelectionImageObject
        })

        if value < i then
            var21.BackgroundColor3 = var1
        end

        if i == 1 or i == var8 then
            Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var21 })

            Create("Frame")({
                Name = "Filler",
                BackgroundColor3 = var21.BackgroundColor3,
                Parent = var21,
                Size = UDim2.new(0.25, 0, 1, 0),
                BorderSizePixel = 0,
                Position = if i == 1 then UDim2.new(0.75, 0, 0, 0) else UDim2.new(0, 0, 0, 0)
            })
        end

        module.Steps[#module.Steps + 1] = var21
    end

    local function hideSelection()
        for i = 1, var8 do
            module.Steps[i].BackgroundColor3 = var1
            if FFlagUIScaleEngineOptions and var11 then
                module.Steps[i].BackgroundTransparency = if var11[i] then 0 else 0.8
            elseif i == 1 or i == var8 then
                module.Steps[i].Filler.BackgroundColor3 = var1
            end
        end
    end
    local function showSelection()
        for i = 1, var8 do
            if value < i then
                break
            end

            if FFlagUIScaleEngineOptions and var11 then
                if var11[i] or i == value and not FFlagUIScaleSliderImprovements then
                    module.Steps[i].BackgroundTransparency = 0
                    module.Steps[i].BackgroundColor3 = BackgroundColor3
                end
            else
                module.Steps[i].BackgroundColor3 = BackgroundColor3
                if i == 1 or i == var8 then
                    module.Steps[i].Filler.BackgroundColor3 = BackgroundColor3
                end
            end
        end
    end

    local function updateEnabledArrows() -- Luacid: Inlined by compiler; 3 call sites recovered
        local bool5 = false
        local bool6 = false
        for value3, value2 in var11 do
            if value2 then
                bool5 = bool5 or value3 < value
                bool6 = bool6 or value < value3
            end
        end
        var16.Visible = currentSelectable and bool5
        var18.Visible = currentSelectable and bool6
    end

    local function setCurrentStep(arg4, arg5)
        if FFlagUIScaleEngineOptions and var11 and not arg5 and arg4 ~= value then
            arg4 = math.clamp(arg4, 1, var8)
            local num2 = if arg4 < value then -1 else 1

            while not var11[arg4] do
                arg4 += num2
                if arg4 < 1 or var8 < arg4 then
                    return
                end
            end
        end

        arg3 = arg3 or 0

        var16.Visible = true
        var18.Visible = true

        if arg4 <= arg3 then
            arg4 = arg3
            var16.Visible = false
        end
        if var8 <= arg4 then
            arg4 = var8
            var18.Visible = false
        end

        if value == arg4 then
            if FFlagUIScaleEngineOptions and var11 then
                updateEnabledArrows()
                return
            end

            return
        end

        value = arg4
        if FFlagUIScaleEngineOptions and var11 then
            updateEnabledArrows()
        end

        hideSelection()
        showSelection()

        var10 = tick()
        if FFlagUIScaleSliderImprovements and bool3 then
            bool4 = true
        elseif signal then
            signal:fire(value)
        else
            valueChanged:Fire(value)
        end
    end

    local function endDeferredValueChanged() -- Luacid: Inlined by compiler; 3 call sites recovered
        bool3 = false
        var12 = nil
        if not bool4 then
            return
        end
        bool4 = false
        if signal then
            signal:fire(value)
            return
        end
        valueChanged:Fire(value)
    end

    local function isActivateEvent(arg4): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
        if not arg4 then
            return false
        end

        return arg4.UserInputType == Enum.UserInputType.MouseButton1
            or arg4.UserInputType == Enum.UserInputType.Touch
            or arg4.UserInputType == Enum.UserInputType.Gamepad1 and arg4.KeyCode == Enum.KeyCode.ButtonA
    end

    local function mouseDownFunc(arg4, arg5, arg6)
        if not currentSelectable
            or FFlagUIScaleEngineOptions and var11 and not arg6 and not var11[arg5]
            or arg4 == nil
            or not isActivateEvent(arg4)
        then
            return
        end

        if usesSelectedObject() and not VRService.VREnabled then
            GuiService.SelectedCoreObject = module.SliderFrame
        end

        if FFlagUIScaleSliderImprovements and arg4 ~= var12 then
            endDeferredValueChanged()
            local bool5 = FFlagUIScaleEngineOptions

            if bool5 then
                if var11 == nil then
                    bool5 = false
                else
                    bool5 = not (arg6 or VRService.VREnabled)
                end
            end

            bool3 = bool5

            if not bool3 then
                arg4 = nil
            end

            var12 = arg4
        end

        if VRService.VREnabled then
            num1 = 0
        elseif arg6 then
            num1 = arg5 - value
        else
            num1 = 0

            local connection = nil

            local connection2 = UserInputService.InputChanged:Connect(function(input: InputObject)
                if input.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local inputPositionX = input.Position.X
                for i = 1, var8 do
                    local absolutePositionX = module.Steps[i].AbsolutePosition.X
                    local absoluteSizeX = module.Steps[i].AbsoluteSize.X
                    if absolutePositionX <= inputPositionX and inputPositionX <= absolutePositionX + absoluteSizeX then
                        setCurrentStep(i)
                        return
                    end

                    if i == 1 and inputPositionX < absolutePositionX then
                        setCurrentStep(0)
                        return
                    end

                    if i == var8 and absolutePositionX <= inputPositionX then
                        setCurrentStep(i)
                        return
                    end
                end
            end)
            connection = UserInputService.InputEnded:Connect(function(input: InputObject)
                if not isActivateEvent(input) then
                    return
                end

                num1 = 0
                connection:Disconnect()
                connection2:Disconnect()
                if FFlagUIScaleSliderImprovements and bool3 then
                    endDeferredValueChanged()
                end
            end)
        end

        setCurrentStep(arg5)
    end

    local function mouseUpFunc(inputObject: InputObject) -- Luacid: Inlined by compiler; 4 call sites recovered
        if currentSelectable and isActivateEvent(inputObject) then
            num1 = 0
        end
    end

    module.ValueChanged = valueChanged.Event
    if signal then
        module.ValueChanged = signal
    end

    function module.SetValue(_, arg4)
        if FFlagUIScaleEngineOptions then
            setCurrentStep(arg4, var11 ~= nil)
            return
        end
        setCurrentStep(arg4)
    end

    function module.GetValue(_)
        return value
    end

    function module.SetEnabledSteps(_, arg4)
        if not FFlagUIScaleEngineOptions then
            return
        end
        var11 = arg4
        for k, step in module.Steps do
            local filler = step:FindFirstChild("Filler")
            if filler then
                local uiCorner = step:FindFirstChildOfClass("UICorner")
                uiCorner.TopLeftRadius = if k == 1 then Theme.DefaultCornerRadius else UDim.new(0, 0)
                uiCorner.BottomLeftRadius = uiCorner.TopLeftRadius
                uiCorner.TopRightRadius = if k == var8 then Theme.DefaultCornerRadius else UDim.new(0, 0)
                uiCorner.BottomRightRadius = uiCorner.TopRightRadius
                filler:Destroy()
            end
            local var21 = currentSelectable and arg4[k]

            step.BackgroundTransparency = if arg4[k] or k == value then 0 else 0.8
            step.Active = VRService.VREnabled and var21
            step.Selectable = VRService.VREnabled and var21
        end
        hideSelection()
        showSelection()
        updateEnabledArrows()
    end

    function module.SetInteractable(_, selectable)
        num1 = 0
        currentSelectable = selectable
        module.SliderFrame.Selectable = selectable
        if not currentSelectable then
            hideSelection()
            return
        end
        showSelection()
    end

    function module.SetZIndex(_, zIndex)
        var16.ZIndex = zIndex
        var18.ZIndex = zIndex
        var19.ZIndex = zIndex
        var20.ZIndex = zIndex

        for i = 1, #module.Steps do
            module.Steps[i].ZIndex = zIndex
        end
    end

    function module.SetMinStep(_, arg4)
        if arg4 >= 0 and arg4 <= var8 then
            arg3 = arg4
        end

        if value <= arg3 then
            value = arg3
            var16.Visible = false
        end
        if var8 <= value then
            value = var8
            var18.Visible = false
        end
    end

    var16.InputBegan:Connect(function(input: InputObject)
        mouseDownFunc(input, value - 1, true)
    end)
    var16.InputEnded:Connect(function(input: InputObject)
        mouseUpFunc(input)
    end)

    var18.InputBegan:Connect(function(input: InputObject)
        mouseDownFunc(input, value + 1, true)
    end)
    var18.InputEnded:Connect(function(input: InputObject)
        mouseUpFunc(input)
    end)

    local function onVREnabled(property: string)
        if property ~= "VREnabled" then
            return
        end

        if not VRService.VREnabled then
            var16.Selectable = false
            var18.Selectable = false
            module.SliderFrame.Selectable = currentSelectable
            for i = 1, var8 do
                module.Steps[i].Selectable = false
                module.Steps[i].Active = false
            end

            return
        end

        var16.Selectable = currentSelectable
        var18.Selectable = currentSelectable
        module.SliderFrame.Selectable = currentSelectable

        for i = 1, var8 do
            if FFlagUIScaleEngineOptions and var11 then
                local var21 = currentSelectable and var11[i]
                module.Steps[i].Selectable = var21
                module.Steps[i].Active = var21
            else
                module.Steps[i].Selectable = currentSelectable
                module.Steps[i].Active = currentSelectable
            end
        end
    end
    VRService.Changed:Connect(onVREnabled)
    onVREnabled("VREnabled")

    for i = 1, var8 do
        module.Steps[i].InputBegan:Connect(function(input: InputObject)
            mouseDownFunc(input, i)
        end)
        module.Steps[i].InputEnded:Connect(function(input: InputObject)
            mouseUpFunc(input)
        end)
    end

    module.SliderFrame.InputBegan:Connect(function(input: InputObject)
        if VRService.VREnabled then
            local selectedCoreObject = GuiService.SelectedCoreObject
            if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent)) then
                return
            end
        end
        mouseDownFunc(input, value)
    end)
    module.SliderFrame.InputEnded:Connect(function(input: InputObject)
        if VRService.VREnabled then
            local selectedCoreObject = GuiService.SelectedCoreObject
            if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent)) then
                return
            end
        end

        mouseUpFunc(input)
    end)

    local function func1()
        if var10 == nil then
            return
        end

        if tick() - var10 >= 0.2 then
            setCurrentStep(value + num1)
        end
    end

    local bool5 = true

    local tbl6 = {
        [Enum.KeyCode.Thumbstick1] = true,
        [Enum.KeyCode.DPadLeft] = -1,
        [Enum.KeyCode.DPadRight] = 1,
        [Enum.KeyCode.Left] = -1,
        [Enum.KeyCode.Right] = 1,
        [Enum.KeyCode.A] = -1,
        [Enum.KeyCode.D] = 1,
        [Enum.KeyCode.ButtonA] = true
    }
    UserInputService.InputBegan:Connect(function(input: InputObject)
        if not currentSelectable
            or not bool5
            or input.UserInputType ~= Enum.UserInputType.Gamepad1 and input.UserInputType ~= Enum.UserInputType.Keyboard
        then
            return
        end

        local selectedCoreObject = GuiService.SelectedCoreObject
        if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent)) then
            return
        end

        if FFlagUIScaleSliderImprovements and bool3 and tbl6[input.KeyCode] then
            endDeferredValueChanged()
        end

        if tbl6[input.KeyCode] == -1 then
            num1 = -1
            setCurrentStep(value - 1)
        elseif tbl6[input.KeyCode] == 1 then
            num1 = 1
            setCurrentStep(value + 1)
        end
    end)

    UserInputService.InputEnded:Connect(function(input: InputObject)
        if not currentSelectable
            or input.UserInputType ~= Enum.UserInputType.Gamepad1 and input.UserInputType ~= Enum.UserInputType.Keyboard
        then
            return
        end

        local selectedCoreObject = GuiService.SelectedCoreObject
        if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent)) then
            return
        end

        if tbl6[input.KeyCode] then
            num1 = 0
        end
    end)

    UserInputService.InputChanged:Connect(function(input: InputObject)
        if not (currentSelectable and bool5) then
            num1 = 0
            return
        end

        if input.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        local selectedCoreObject = GuiService.SelectedCoreObject
        if not (selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent)) then
            return
        end

        if input.KeyCode ~= Enum.KeyCode.Thumbstick1 then
            return
        end

        if input.Position.X > 0.8 and input.Delta.X > 0 and num1 ~= 1 then
            num1 = 1
            setCurrentStep(value + 1)
        elseif input.Position.X < -0.8 and input.Delta.X < 0 and num1 ~= -1 then
            num1 = -1
            setCurrentStep(value - 1)
        elseif math.abs(input.Position.X) < 0.8 then
            num1 = 0
        end
    end)

    local bool6 = false
    GuiService.Changed:Connect(function(property: string)
        if property ~= "SelectedCoreObject" then
            return
        end

        local selectedCoreObject = GuiService.SelectedCoreObject
        if selectedCoreObject and selectedCoreObject:IsDescendantOf(module.SliderFrame.Parent) then
            if not bool6 then
                bool6 = true
                var10 = tick()
                RunService:BindToRenderStep(name, Enum.RenderPriority.Input.Value + 1, func1)
            end
        elseif bool6 then
            bool6 = false
            RunService:UnbindFromRenderStep(name)
        end
    end)

    module.SliderFrame.AncestryChanged:Connect(function(_: Instance, parent: Instance)
        bool5 = parent
    end)

    setCurrentStep(value)

    return module
end

local yOffset = if var6 then 90 else 50

local tbl3 = ({})
local function AddNewRow(arg1, text, arg2, arg3, arg4, arg5, text2, arg6, arg7, interactable)
    local bool3 = arg2 ~= "TextBox"

    local yOffset2 = if tbl3[arg1] then tbl3[arg1] else 0

    local var8 = Create("ImageButton")({
        Name = text .. "Frame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 18, 18),
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, yOffset),
        AutomaticSize = if text2 or arg6 or arg7 then Enum.AutomaticSize.Y else nil,
        Position = UDim2.new(0, 0, 0, yOffset2),
        ZIndex = 2,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Parent = arg1.Page
    })

    var8.BackgroundColor3 = Theme.color("RowFrameBackground")
    var8.ImageColor3 = var8.BackgroundColor3
    Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = var8 })

    if var8 and arg5 then
        var8.Position = UDim2.new(var8.Position.X.Scale, var8.Position.X.Offset, var8.Position.Y.Scale, var8.Position.Y.Offset + arg5)
    end

    local var9

    if text2 then
        local var10 = Create("Frame")({
            Name = text .. "RowLabelAndDescriptionFrame",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, 0),
            Size = UDim2.new(0.4, -20, 0, 50),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = var8
        })

        var9 = Create("TextLabel")({
            Name = text .. "Label",
            Text = text,
            Font = Theme.font(Enum.Font.SourceSansBold, "UtilityRow"),
            TextSize = Theme.textSize(16, "UtilityRow"),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            ZIndex = 2,
            Parent = var10,
            LayoutOrder = 1
        })

        Create("TextLabel")({
            Name = text .. "Description",
            Text = text2,
            Font = Theme.font(Enum.Font.SourceSans, "UtilityRow"),
            TextSize = Theme.textSize(18, "UtilityRow"),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0.25,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 2,
            Parent = var10,
            LayoutOrder = 2
        })

        Create("UIListLayout")({
            Name = text .. "UIListLayout",
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
            Parent = var10
        })

        Create("UIPadding")(
            {
                Name = text .. "UIListLayout",
                PaddingBottom = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                Parent = var10
            }
        )
    else
        var9 = Create("TextLabel")({
            Name = text .. "Label",
            Text = text,
            Font = Theme.font(Enum.Font.SourceSansBold, "UtilityRow"),
            TextSize = Theme.textSize(16, "UtilityRow"),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(0.4, -20, 1, 0),
            Position = UDim2.new(0, 10, 0, 0),
            ZIndex = 2,
            Parent = var8
        })

        Create("UIPadding")(
            {
                Name = text .. "UIPadding",
                PaddingBottom = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                Parent = var9
            }
        )
    end
    if not bool3 then
        var9.Text = ""
    end

    local function onResized(_, arg8)
        if arg8 then
            var9.TextSize = Theme.textSize(16, "UtilityRow")
            return
        end

        var9.TextSize = var6 and Theme.textSize(36) or Theme.textSize(24, "UtilityText")
    end

    if _G.__TESTEZ_RUNNING_TEST__ then
        local _vector2 = Vector2.new(1024, 1024)
    else
        local _vector2 = GuiService:GetHardwareSafeViewport()
    end

    if isPortrait() then
        local textSize = Theme.textSize(16, "UtilityRow")
        var9.TextSize = textSize
    else
        local textSize = var6 and Theme.textSize(36) or Theme.textSize(24, "UtilityText")
        var9.TextSize = textSize
    end

    tbl1[var8] = onResized

    if _G.__TESTEZ_RUNNING_TEST__ then
        local _vector2 = Vector2.new(1024, 1024)
    else
        local _vector2 = GuiService:GetHardwareSafeViewport()
    end

    if isPortrait() then
        local textSize = Theme.textSize(16, "UtilityRow")
        var9.TextSize = textSize
    else
        local textSize = var6 and Theme.textSize(36) or Theme.textSize(24, "UtilityText")
        var9.TextSize = textSize
    end

    local var10 = nil
    local var11 = nil
    if arg2 == "Slider" then
        var11 = CreateNewSlider(arg3, arg4, nil, arg6, arg7)
        var11.SliderFrame.Parent = var8
        var10 = var11.SliderFrame
    elseif arg2 == "Selector" then
        var11 = CreateSelector(arg3, arg4)
        var11.SelectorFrame.Parent = var8
        var10 = var11.SelectorFrame
    elseif arg2 == "DropDown" then
        var11 = CreateDropDown(arg3, arg4, arg1.HubRef)
        var11.DropDownFrame.Parent = var8
        var10 = var11.DropDownFrame
    elseif arg2 == "TextBox" then
        local selectionImageObject = Create("ImageLabel")({ Image = "", BackgroundTransparency = 1 })

        var11 = {}
        var11.HubRef = nil

        local selectedCoreObject = Create("TextBox")({
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.6, 0, 1, 0),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = text,
            TextColor3 = Color3.fromRGB(49, 49, 49),
            BackgroundTransparency = Theme.transparency("ControlInputBackground", 0.5),
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Font = Theme.font(Enum.Font.SourceSans, "UtilityText"),
            TextSize = Theme.textSize(24, "UtilityText"),
            ZIndex = 2,
            SelectionImageObject = selectionImageObject,
            ClearTextOnFocus = false,
            Interactable = interactable,
            Parent = var8
        })
        var10 = selectedCoreObject

        selectedCoreObject.Focused:Connect(function()
            if usesSelectedObject() then
                GuiService.SelectedCoreObject = selectedCoreObject
            end

            if selectedCoreObject.Text == text then
                selectedCoreObject.Text = ""
            end
        end)
        if arg5 then
            selectedCoreObject.Position = UDim2.new(
                selectedCoreObject.Position.X.Scale,
                selectedCoreObject.Position.X.Offset,
                selectedCoreObject.Position.Y.Scale,
                selectedCoreObject.Position.Y.Offset + arg5
            )
        end

        var10.SelectionGained:Connect(function()
            if not usesSelectedObject() then
                return
            end

            selectedCoreObject.BackgroundTransparency = Theme.transparency("ControlInputBackground", 0.1)

            if var11.HubRef then
                var11.HubRef:ScrollToFrame(var10)
            end
        end)

        var10.SelectionLost:Connect(function()
            if usesSelectedObject() then
                selectedCoreObject.BackgroundTransparency = Theme.transparency("ControlInputBackground", 0.5)
            end
        end)

        local function processInput(input: InputObject)
            if input.UserInputState == Enum.UserInputState.Begin
                and input.KeyCode == Enum.KeyCode.Return
                and GuiService.SelectedCoreObject == var10
            then
                selectedCoreObject:CaptureFocus()
            end
        end

        selectedCoreObject.MouseEnter:Connect(function()
            local dropDownFullscreenFrame = CoreGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if dropDownFullscreenFrame and dropDownFullscreenFrame.Visible then
                return
            end

            local var4 = var10

            if var4 and var4.Visible and var4.ZIndex > 1 and usesSelectedObject() and arg1.Active then
                GuiService.SelectedCoreObject = var4
            end
        end)

        UserInputService.InputBegan:Connect(processInput)
    elseif arg2 == "TextEntry" then
        local selectionImageObject = Create("ImageLabel")({ Image = "", BackgroundTransparency = 1 })

        var11 = {}
        var11.HubRef = nil

        local selectedCoreObject = Create("TextBox")({
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.4, -10, 0, 40),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = text,
            TextColor3 = Color3.fromRGB(178, 178, 178),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextWrapped = false,
            Font = Theme.font(Enum.Font.SourceSans, "UtilityText"),
            TextSize = Theme.textSize(24, "UtilityText"),
            ZIndex = 2,
            SelectionImageObject = selectionImageObject,
            ClearTextOnFocus = false,
            Parent = var8
        })
        var10 = selectedCoreObject

        selectedCoreObject.Focused:Connect(function()
            if usesSelectedObject() then
                GuiService.SelectedCoreObject = selectedCoreObject
            end

            if selectedCoreObject.Text == text then
                selectedCoreObject.Text = ""
            end
        end)
        if arg5 then
            selectedCoreObject.Position = UDim2.new(
                selectedCoreObject.Position.X.Scale,
                selectedCoreObject.Position.X.Offset,
                selectedCoreObject.Position.Y.Scale,
                selectedCoreObject.Position.Y.Offset + arg5
            )
        end

        var10.SelectionGained:Connect(function()
            if not usesSelectedObject() then
                return
            end

            selectedCoreObject.BackgroundTransparency = 0.8

            if var11.HubRef then
                var11.HubRef:ScrollToFrame(var10)
            end
        end)

        var10.SelectionLost:Connect(function()
            if usesSelectedObject() then
                selectedCoreObject.BackgroundTransparency = 1
            end
        end)

        local function processInput(input: InputObject)
            if input.UserInputState == Enum.UserInputState.Begin
                and input.KeyCode == Enum.KeyCode.Return
                and GuiService.SelectedCoreObject == var10
            then
                selectedCoreObject:CaptureFocus()
            end
        end

        var8.MouseEnter:Connect(function()
            local dropDownFullscreenFrame = CoreGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if dropDownFullscreenFrame and dropDownFullscreenFrame.Visible then
                return
            end

            local var4 = var10

            if var4 and var4.Visible and var4.ZIndex > 1 and usesSelectedObject() and arg1.Active then
                GuiService.SelectedCoreObject = var4
            end
        end)

        function var11.SetZIndex(_, zIndex)
            selectedCoreObject.ZIndex = zIndex
        end

        function var11.SetInteractable(_, selectable)
            selectedCoreObject.Selectable = selectable
            if not selectable then
                selectedCoreObject.TextColor3 = Color3.fromRGB(49, 49, 49)
                selectedCoreObject.ZIndex = 1
                return
            end
            selectedCoreObject.TextColor3 = Color3.fromRGB(178, 178, 178)
            selectedCoreObject.ZIndex = 2
        end

        function var11.SetValue(_, text3)
            selectedCoreObject.Text = text3
        end

        local valueChanged = Instance.new("BindableEvent")
        valueChanged.Name = "ValueChanged"

        selectedCoreObject.FocusLost:Connect(function()
            valueChanged:Fire(selectedCoreObject.Text)
        end)

        local event = valueChanged.Event
        var11.ValueChanged = event

        UserInputService.InputBegan:Connect(processInput)
    end

    local var12 = text .. "ValueChanger"
    var11.Name = var12

    local setAutoLocalize = var11.SetAutoLocalize
    function var11.SetAutoLocalize(arg8, autoLocalize)
        var8.AutoLocalize = autoLocalize
        if setAutoLocalize then
            setAutoLocalize(arg8, autoLocalize)
        end
    end

    local var13 = yOffset2 + yOffset
    if arg5 then
        var13 += arg5
    end

    tbl3[arg1] = var13

    if bool3 then
        var8.MouseEnter:Connect(function()
            local dropDownFullscreenFrame = CoreGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if dropDownFullscreenFrame and dropDownFullscreenFrame.Visible then
                return
            end

            local selectedCoreObject = var11.SliderFrame or var11.SliderFrame or var11.DropDownFrame or var11.SelectorFrame

            if selectedCoreObject
                and selectedCoreObject.Visible
                and selectedCoreObject.ZIndex > 1
                and usesSelectedObject()
                and arg1.Active
            then
                GuiService.SelectedCoreObject = selectedCoreObject
            end
        end)
        local function onVREnabled(property: string) -- Luacid: Inlined by compiler; 1 call site recovered
            if property ~= "VREnabled" then
                return
            end

            if not VRService.VREnabled then
                var8.Selectable = false
                var8.Active = false
                return
            end

            var8.Selectable = true
            var8.Active = true
            var10.Active = true
            GuiService.Changed:Connect(function(property: string)
                if property ~= "SelectedCoreObject" then
                    return
                end

                local selectedCoreObject = GuiService.SelectedCoreObject
                if selectedCoreObject and (selectedCoreObject == var8 or selectedCoreObject:IsDescendantOf(var8)) then
                    var8.ImageTransparency = Theme.transparency("RowFrameBackground", 0.5)
                    var8.BackgroundTransparency = 1
                    return
                end
                var8.ImageTransparency = 1
                var8.BackgroundTransparency = 1
            end)
        end

        VRService.Changed:Connect(onVREnabled)
        onVREnabled("VREnabled")

        var10.SelectionGained:Connect(function()
            if not usesSelectedObject() then
                return
            end

            if VRService.VREnabled then
                var8.ImageTransparency = 0.5
                var8.BackgroundTransparency = 1
            else
                var8.ImageTransparency = 1
                var8.BackgroundTransparency = Theme.transparency("RowFrameBackground", 0.5)
            end

            if var11.HubRef then
                var11.HubRef:ScrollToFrame(var8)
            end
        end)

        var10.SelectionLost:Connect(function()
            if usesSelectedObject() then
                var8.ImageTransparency = 1
                var8.BackgroundTransparency = 1
            end
        end)
    end

    arg1:AddRow(var8, var9, var11, arg5, false)

    var11.Selection = var10

    return var8, var9, var11
end

local function AddNewRowObject(arg1, text, arg2, arg3, arg4)
    local yOffset2 = if tbl3[arg1] then tbl3[arg1] else 0

    local selectedCoreObject = Create("ImageButton")({
        Name = text .. "Frame",
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10),
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, yOffset),
        Position = UDim2.new(0, 0, 0, yOffset2),
        ZIndex = 2,
        Selectable = false,
        SelectionImageObject = SelectionImageObject,
        Parent = arg1.Page
    })

    selectedCoreObject.BackgroundColor3 = Theme.color("RowFrameBackground")
    selectedCoreObject.ImageColor3 = selectedCoreObject.BackgroundColor3
    selectedCoreObject.SelectionGained:Connect(function()
        selectedCoreObject.BackgroundTransparency = Theme.transparency("RowFrameBackground", 0.5)
    end)
    selectedCoreObject.SelectionLost:Connect(function()
        selectedCoreObject.BackgroundTransparency = 1
    end)

    Create("UICorner")({ CornerRadius = Theme.DefaultCornerRadius, Parent = selectedCoreObject })

    local var9 = Create("TextLabel")({
        Name = text .. "Label",
        Text = text,
        Font = Theme.font(Enum.Font.SourceSansBold, "UtilityRow"),
        TextSize = Theme.textSize(16, "UtilityRow"),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(0.4, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        ZIndex = 2,
        Parent = selectedCoreObject
    })

    Create("UIPadding")(
        {
            Name = text .. "UIPadding",
            PaddingBottom = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            Parent = var9
        }
    )
    addOnResizedCallback(selectedCoreObject, function(_, arg5) -- name: onResized
        if arg4 then
            UDim2.new(0, 200, 1, 0)
        end
        if arg5 then
            var9.TextSize = Theme.textSize(16, "UtilityRow")
            return
        end

        var9.TextSize = var6 and Theme.textSize(36) or Theme.textSize(24, "UtilityText")
    end)

    if arg3 then
        selectedCoreObject.Position = UDim2.new(
            selectedCoreObject.Position.X.Scale,
            selectedCoreObject.Position.X.Offset,
            selectedCoreObject.Position.Y.Scale,
            selectedCoreObject.Position.Y.Offset + arg3
        )
    end

    local var10 = yOffset2 + yOffset
    if arg3 then
        var10 += arg3
    end

    tbl3[arg1] = var10

    selectedCoreObject.MouseEnter:Connect(function()
        if selectedCoreObject.Visible then
            GuiService.SelectedCoreObject = selectedCoreObject
        end
    end)

    arg2.SelectionImageObject = SelectionImageObject

    arg2.SelectionGained:Connect(function()
        if VRService.VREnabled then
            selectedCoreObject.ImageTransparency = Theme.transparency("RowFrameBackground", 0.5)
            selectedCoreObject.BackgroundTransparency = 1
            return
        end
        selectedCoreObject.ImageTransparency = 1
        selectedCoreObject.BackgroundTransparency = Theme.transparency("RowFrameBackground", 0.5)
    end)

    arg2.SelectionLost:Connect(function()
        selectedCoreObject.ImageTransparency = 1
        selectedCoreObject.BackgroundTransparency = 1
    end)

    arg2.Parent = selectedCoreObject

    arg1:AddRow(selectedCoreObject, var9, arg2, arg3, true)
    return selectedCoreObject
end

local module = {}

function module.GetEaseLinear(_)
    return Linear
end

function module.GetEaseOutQuad(_)
    return EaseOutQuad
end

function module.GetEaseInOutQuad(_)
    return EaseInOutQuad
end

function module.CreateNewSlider(_, arg1, arg2, arg3, text, text2)
    return CreateNewSlider(arg1, arg2, arg3, text, text2)
end

function module.CreateNewSelector(_, arg1, arg2)
    return (CreateSelector(arg1, arg2))
end

function module.CreateNewDropDown(_, arg1, arg2)
    return (CreateDropDown(arg1, arg2, nil))
end

function module.AddNewRow(_, arg1, text, arg2, arg3, arg4, arg5, text2, arg6, arg7, interactable)
    return AddNewRow(arg1, text, arg2, arg3, arg4, arg5, text2, arg6, arg7, interactable)
end

function module.AddNewRowObject(_, arg1, text, arg2, arg3, arg4)
    return (AddNewRowObject(arg1, text, arg2, arg3, arg4))
end

function module.ShowAlert(_, text, arg1, arg2, callback, arg3)
    ShowAlert(text, arg1, arg2, callback, arg3)
end

function module.IsSmallTouchScreen(_): boolean
    return isSmallTouchScreen()
end

function module.IsPortrait(_): boolean
    return isPortrait()
end

if FFlagRefactorMenuConfirmationButtons then
    local function isUsingGamepad() -- Luacid: Inlined by compiler; 1 call site recovered
        return tbl2[UserInputService:GetLastInputType()] or false
    end

    function module.IsUsingGamepad(_)
        return (isUsingGamepad())
    end
end

function module.MakeStyledButton(_, arg1, text, size, callback, arg2, arg3)
    return MakeButton(arg1, text, size, callback, arg2, arg3)
end

function module.MakeStyledImageButton(_, arg1, arg2, size, size2, callback, arg3, arg4, arg5)
    return MakeImageButton(arg1, arg2, size, size2, callback, arg3, arg4, arg5)
end

function module.AddButtonRow(_, arg1, arg2, text, size, callback, arg3)
    return AddButtonRow(arg1, arg2, text, size, callback, arg3)
end

function module.MakeFocusState(_, arg1, name)
    return MakeRoundedRectFocusState(arg1, name)
end

function module.CreateSignal(_)
    return (CreateSignal())
end

function module.UsesSelectedObject(_): boolean
    return usesSelectedObject()
end

function module.TweenProperty(_, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    return PropertyTweener(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
end

function module.OnResized(_, arg1, callback)
    return addOnResizedCallback(arg1, callback)
end

function module.FireOnResized(_)
    local vector2 = getViewportSize()
    local isPortrait2 = module:IsPortrait()

    for _, value in pairs(tbl1) do
        value(vector2, isPortrait2)
    end
end

function module.Lerp(_, arg1, arg2, arg3)
    return (1 - arg1) * arg2 + arg1 * arg3
end

function module.Round(_, arg1): number
    return arg1 % 1 >= 0.5 and math.ceil(arg1) or math.floor(arg1)
end

function module.IsExperienceOlderThanOneWeek(_, arg1)
    if arg1 ~= nil and arg1.Created ~= nil then
        local unixTimestampMillis = DateTime.fromIsoDate(arg1.Created).UnixTimestampMillis
        if Workspace:GetServerTimeNow() * 1000 - unixTimestampMillis > 604800000 then
            return true
        end
    end

    return false
end

return module
