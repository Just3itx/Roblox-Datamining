-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local CorePackages = game:GetService("CorePackages")
local GameSettings = UserSettings().GameSettings

local Utility = require(RobloxGui.Modules.Settings.Utility)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local var1 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local var2 = nil
if isInExperienceUIVREnabled then
    local LocalizationService = game:GetService("LocalizationService")
    var2 = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId)
end

local HelpConstants = if isInExperienceUIVREnabled then require(RobloxGui.Modules.Settings.Resources.HelpConstants) else nil

local function Initialize()
    local var3 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()
    var3.HelpPages = {}
    var3.HelpPageContents = {}
    var3.ActiveHelpScheme = nil

    local var4 = nil

    function var3.GetCurrentInputType(_): string
        if isInExperienceUIVREnabled and isSpatial() then
            return "SpatialGamepad"
        end

        if var4 == nil then
            local platform = UserInputService:GetPlatform()

            if platform == Enum.Platform.XBoxOne or platform == Enum.Platform.WiiU then
                return "Gamepad"
            end

            if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX then
                return "KeyboardMouse"
            end

            return "Touch"
        end

        if var4 == Enum.UserInputType.Keyboard
            or var4 == Enum.UserInputType.MouseMovement
            or var4 == Enum.UserInputType.MouseButton1
            or var4 == Enum.UserInputType.MouseButton2
            or var4 == Enum.UserInputType.MouseButton3
            or var4 == Enum.UserInputType.MouseWheel
        then
            return "KeyboardMouse"
        end

        if var4 == Enum.UserInputType.Touch then
            return "Touch"
        end

        if var4 == Enum.UserInputType.Gamepad1
            or var4 == Enum.UserInputType.Gamepad2
            or var4 == Enum.UserInputType.Gamepad3
            or var4 == Enum.UserInputType.Gamepad4
        then
            return "Gamepad"
        end

        return "KeyboardMouse"
    end

    local function createPCHelp(arg1)
        local function createPCGroup(text: string, arg2)
            local var5 = Create("Frame")({
                Size = UDim2.new(1 / 3, -4, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Name = "PCGroupFrame" .. tostring(text)
            })

            Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 2),
                Parent = var5,
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            local var6 = Create("TextLabel")({
                Position = UDim2.new(0, 9, 0, 0),
                Size = UDim2.new(1, -9, 0, 30),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = text,
                Font = Theme.font(Enum.Font.SourceSansBold, "HelpTitle"),
                FontSize = Theme.fontSize(Enum.FontSize.Size18, "HelpTitle"),
                TextColor3 = Color3.new(1, 1, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Name = "PCGroupTitle" .. tostring(text),
                ZIndex = 2,
                LayoutOrder = 1,
                Parent = var5
            })

            Create("UIPadding")({ PaddingLeft = UDim.new(0, 9), Parent = var6 })

            local num1 = 0

            local offset = var6.Size.Y.Offset
            for i = 1, #arg2 do
                for k, value in pairs(arg2[i]) do
                    local var7 = Create("Frame")({
                        Size = UDim2.new(1, 0, 0, 42),
                        Position = UDim2.new(0, 0, 0, offset + num1 * 44),
                        BackgroundTransparency = Theme.transparency("InputActionBackground", 0.65),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = i + 1,
                        BorderSizePixel = 0,
                        ZIndex = 2,
                        Name = "ActionInputBinding" .. tostring(k),
                        Parent = var5
                    })

                    var7.BackgroundColor3 = Theme.color("InputActionBackground")
                    Create("UICorner")({ CornerRadius = UDim.new(0, 3), Parent = var7 })

                    local parent = Create("TextLabel")({
                        Size = UDim2.new(0.4, -9, 0, 42),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Position = UDim2.new(0, 9, 0, 0),
                        BackgroundTransparency = 1,
                        Text = k,
                        Font = Theme.font(Enum.Font.SourceSansBold, "HelpTitle"),
                        FontSize = Theme.fontSize(Enum.FontSize.Size18, "HelpTitle"),
                        TextColor3 = Color3.new(1, 1, 1),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Name = k .. "Label",
                        ZIndex = 2,
                        Parent = var7,
                        TextWrapped = true
                    })

                    Instance.new("UITextSizeConstraint", parent).MaxTextSize = Theme.textSize(28)

                    Create("TextLabel")({
                        Size = UDim2.new(0.5, 0, 0, 42),
                        Position = UDim2.new(0.5, -4, 0, 0),
                        BackgroundTransparency = 1,
                        Text = value,
                        Font = Theme.font(Enum.Font.SourceSans, "HelpText"),
                        FontSize = Theme.fontSize(Enum.FontSize.Size18, "HelpText"),
                        TextColor3 = Color3.new(1, 1, 1),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Name = value .. "Label",
                        ZIndex = 2,
                        Parent = var7,
                        TextWrapped = true,
                        TextScaled = false,
                        AutomaticSize = Enum.AutomaticSize.Y
                    })

                    num1 += 1
                end
            end

            var5.Size = UDim2.new(var5.Size.X.Scale, var5.Size.X.Offset, 0, offset + num1 * 44)

            return var5
        end

        local bool1 = UserInputService:GetPlatform() == Enum.Platform.OSX

        local pCGroup = createPCGroup("Character Movement", {
            {
                ["Move Forward"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.W) .. "/" .. RobloxTranslator:FormatByKey("InGame.HelpMenu.UpArrow")
            },
            {
                ["Move Backward"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.S) .. "/" .. RobloxTranslator:FormatByKey("InGame.HelpMenu.DownArrow")
            },
            {
                ["Move Left"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.A) .. "/" .. RobloxTranslator:FormatByKey("InGame.HelpMenu.LeftArrow")
            },
            {
                ["Move Right"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.D) .. "/" .. RobloxTranslator:FormatByKey("InGame.HelpMenu.RightArrow")
            },
            { Jump = "Space" }
        })
        pCGroup.Parent = arg1
        pCGroup.LayoutOrder = 1

        local str1 = UserInputService:GetStringForKeyCode(Enum.KeyCode.One) .. "," .. UserInputService:GetStringForKeyCode(Enum.KeyCode.Two) .. "," .. UserInputService:GetStringForKeyCode(Enum.KeyCode.Three) .. "..."
        local pCGroup2 = createPCGroup("Accessories", {
            { ["Equip Tools"] = str1 },
            { ["Unequip Tools"] = str1 },
            { ["Drop Tool"] = "Backspace" },
            { ["Use Tool"] = "Left Mouse Button" }
        })
        pCGroup2.Position = UDim2.new(1 / 3, 4, 0, 0)
        pCGroup2.Parent = arg1
        pCGroup2.LayoutOrder = 2

        local tbl1 = {}

        table.insert(tbl1, { ["UI Selection Toggle"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.BackSlash) })

        local bool2 = not CachedPolicyService:IsSubjectToChinaPolicies()

        if bool2 then
            table.insert(tbl1, { Screenshot = if bool1 then "Opt + 1" else "Alt + 1" })

            if not bool1 then
                table.insert(tbl1, { ["Record Video"] = "F12" })
            end
        end

        if bool2 then
            table.insert(tbl1, { ["Dev Console"] = if bool1 then "F9/fn + F9" else "F9" })
        end
        table.insert(tbl1, { Mouselock = "Shift" })
        if bool2 then
            table.insert(tbl1, { ["Graphics Level"] = if bool1 then "F10/fn + F10" else "F10" })
            table.insert(tbl1, { Fullscreen = if bool1 then "Ctrl + Cmd + F" else "F11" })
        end

        if bool2 then
            table.insert(tbl1, { ["Perf. Stats"] = if bool1 then "Fn+Opt+Cmd+F7" else "Ctrl + Shift + F7" })
        end
        local pCGroup3 = createPCGroup("Misc", tbl1)

        pCGroup3.Position = UDim2.new(2 / 3, 8, 0, 0)
        pCGroup3.Parent = arg1
        pCGroup3.LayoutOrder = 3

        local pCGroup4 = createPCGroup("Camera Movement", {
            { Rotate = "Right Mouse Button" },
            { ["Zoom In/Out"] = "Mouse Wheel" },
            {
                ["Zoom In"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.I)
            },
            {
                ["Zoom Out"] = UserInputService:GetStringForKeyCode(Enum.KeyCode.O)
            }
        })
        pCGroup4.Position = UDim2.new(0, 0, pCGroup.Size.Y.Scale, pCGroup.Size.Y.Offset + 50)
        pCGroup4.Parent = arg1
        pCGroup4.LayoutOrder = 4

        local pCGroup5 = createPCGroup("Menu Items", {
            { ["Roblox Menu"] = "Esc" },
            {
                Backpack = UserInputService:GetStringForKeyCode(Enum.KeyCode.Backquote)
            },
            { Playerlist = "Tab" },
            {
                Chat = UserInputService:GetStringForKeyCode(Enum.KeyCode.Slash)
            }
        })
        pCGroup5.Position = UDim2.new(1 / 3, 4, pCGroup.Size.Y.Scale, pCGroup.Size.Y.Offset + 50)
        pCGroup5.Parent = arg1
        pCGroup5.LayoutOrder = 5

        arg1.Size = UDim2.new(arg1.Size.X.Scale, arg1.Size.X.Offset, 0, pCGroup5.Size.Y.Offset + pCGroup5.Position.Y.Offset)
    end

    local function createGamepadHelp(arg1)
        local xOffset = math.max(var3.Page.AbsoluteSize.X * 0.58, 270)
        local uDim2 = UDim2.new(0, xOffset, 0, xOffset * 0.64)
        local uDim2_2 = UDim2.new(0.5, -uDim2.X.Offset / 2 + 30, 0.5, -uDim2.Y.Offset / 2 + 7)

        local var5 = Create("ImageLabel")({
            Name = "GamepadImage",
            Size = uDim2,
            Position = uDim2_2,
            Image = "rbxasset://textures/ui/Settings/Help/PlatformController.png",
            BackgroundTransparency = 1,
            ZIndex = 2,
            Parent = arg1
        })
        arg1.Size = UDim2.new(arg1.Size.X.Scale, arg1.Size.X.Offset, 0, var5.Size.Y.Offset + 100)

        local fontSize = var1 and Theme.fontSize(Enum.FontSize.Size36) or Theme.fontSize(Enum.FontSize.Size24)
        local var7 = fontSize == Theme.fontSize(Enum.FontSize.Size36) and Theme.textSize(36) or Theme.textSize(24)
        local function createGamepadLabel(string, position, size, arg2)
            local var8 = Create("TextLabel")({
                Position = position,
                Size = size,
                BackgroundTransparency = 1,
                Text = string,
                TextXAlignment = arg2 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
                AnchorPoint = arg2 and Vector2.new(1, 0.5) or Vector2.new(0, 0.5),
                Font = Theme.font(Enum.Font.SourceSansBold, "HelpGamepad"),
                FontSize = fontSize,
                TextColor3 = Color3.new(1, 1, 1),
                Name = string .. "Label",
                ZIndex = 2,
                Parent = var5,
                TextTruncate = Enum.TextTruncate.AtEnd
            })

            var8.TextWrapped = true

            local textSizeX = TextService:GetTextSize(string, var7, Theme.font(Enum.Font.SourceSansBold, "Bold"), Vector2.new(0, 0)).X
            local num1 = math.abs(position.X.Offset)
            local var9 = arg1

            local function updateNameLabelSize()
                local xOffset2 = arg2 and var9.AbsoluteSize.X / 2 + 30 - num1 or var9.AbsoluteSize.X / 2 - 30 - num1

                var8.Size = UDim2.new(var8.Size.X.Scale, xOffset2, var8.Size.Y.Scale, var7 * 2)
                var8.TextScaled = false

                if not (xOffset2 < textSizeX) then
                    var8.FontSize = fontSize
                end
            end

            local _connection = var9:GetPropertyChangedSignal("AbsoluteSize"):connect(function()
                updateNameLabelSize()
            end)

            updateNameLabelSize()
        end

        local xOffset2 = -var5.Size.X.Offset / 2 - 20
        local xOffset3 = var5.Size.X.Offset / 2 - 20
        local xOffset4 = xOffset3 + 40

        createGamepadLabel("Switch Tool", UDim2.new(0.5, xOffset2, 0, 15), UDim2.new(0, 100, 0, var7), true)
        createGamepadLabel(
            RobloxTranslator:FormatByKey("InGame.HelpMenu.Controls.ToggleGameMenu"),
            UDim2.new(0.5, xOffset2, 0.15, 10),
            UDim2.new(0, 164, 0, var7),
            true
        )
        createGamepadLabel("Move", UDim2.new(0.5, xOffset2, 0.31, 5), UDim2.new(0, 46, 0, var7), true)
        createGamepadLabel("Menu Navigation", UDim2.new(0.5, xOffset2, 0.46, 0), UDim2.new(0, 164, 0, var7), true)

        createGamepadLabel("Use Tool", UDim2.new(0.5, xOffset3, 0, 15), UDim2.new(0, 73, 0, var7))
        createGamepadLabel("Roblox Menu", UDim2.new(0.5, xOffset3, 0.15, 10), UDim2.new(0, 122, 0, var7))
        createGamepadLabel("Back", UDim2.new(0.5, xOffset3, 0.31, 5), UDim2.new(0, 43, 0, var7))
        createGamepadLabel("Jump", UDim2.new(0.5, xOffset3, 0.46, 0), UDim2.new(0, 49, 0, var7))
        createGamepadLabel("Rotate Camera", UDim2.new(0.5, xOffset4, 0.62, -10), UDim2.new(0, 132, 0, var7))
        createGamepadLabel("Camera Zoom", UDim2.new(0.5, xOffset4, 0.77, -10), UDim2.new(0, 122, 0, var7))
    end

    local function updateTouchLayout(touchMovementMode)
        var3.ActiveHelpScheme = touchMovementMode
        local isPortrait = Utility:IsPortrait()
        if not var3.HelpPages.Touch then
            return
        end

        local touch = var3.HelpPageContents.Touch

        local function hideUneeded(arg1: {JumpImage: boolean, MoveImageCTM: boolean, MoveImageDTS: boolean} | {JumpLabel: boolean, MoveImageDTS: boolean} | {MoveImageCTM: boolean}) -- Luacid: Inlined by compiler; 1 call site recovered
            if not arg1 then
                return
            end

            for k, value in pairs(touch) do
                value.Visible = not arg1[k]
            end
        end

        local tbl1

        if touchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or touchMovementMode == Enum.TouchMovementMode.Default then
            touch.MoveLabel.Position = isPortrait and UDim2.new(0.25, -touch.MoveLabel.AbsoluteSize.x / 2, 0.75, -50)
                or UDim2.new(0.15, -touch.MoveLabel.AbsoluteSize.x / 2, 0.85, -touch.MoveLabel.AbsoluteSize.y)
            touch.JumpLabel.Position = isPortrait and UDim2.new(0.75, -touch.JumpLabel.AbsoluteSize.x / 2, 0.75, -50)
                or UDim2.new(0.85, -60, 0.85, -touch.JumpLabel.AbsoluteSize.y)
            touch.RotateLabel.Position = isPortrait and UDim2.new(1, -touch.RotateLabel.AbsoluteSize.x - 20, 0.02, 0)
                or UDim2.new(0.85, -touch.RotateLabel.AbsoluteSize.x / 2, 0.02, 0)
            touch.UseToolLabel.Position = isPortrait and UDim2.new(0.5, -touch.UseToolLabel.AbsoluteSize.x / 2, 0.5, -100)
                or UDim2.new(0.5, -touch.UseToolLabel.AbsoluteSize.x / 2, 0.5, -60)

            touch.EquipLabel.Position = isPortrait and UDim2.new(0.5, -60, 0.75, 50) or UDim2.new(0.5, -60, 0.64, 0)
            touch.ZoomLabel.Position = isPortrait and UDim2.new(0, 20, 0.02, 0) or UDim2.new(0.15, -60, 0.02, 0)
            tbl1 = { MoveImageCTM = true }
        elseif touchMovementMode == Enum.TouchMovementMode.ClickToMove then
            touch.MoveLabel.Position = isPortrait and UDim2.new(0.25, -touch.MoveLabel.AbsoluteSize.x / 2, 0.5, 0)
                or UDim2.new(0.25, -touch.MoveLabel.AbsoluteSize.x / 2, 0.5, 40)
            touch.RotateLabel.Position = isPortrait and UDim2.new(1, -touch.RotateLabel.AbsoluteSize.x - 20, 0.02, 0) or UDim2.new(0.5, -60, 0.02, 0)
            touch.UseToolLabel.Position = isPortrait and UDim2.new(0.75, -touch.UseToolLabel.AbsoluteSize.x / 2, 0.5, 0) or UDim2.new(0.85, -60, 0.02, 0)

            touch.EquipLabel.Position = isPortrait and UDim2.new(0.5, -60, 0.75, 50) or UDim2.new(0.5, -60, 0.64, 0)
            touch.ZoomLabel.Position = isPortrait and UDim2.new(0, 20, 0.02, 0) or UDim2.new(0.15, -60, 0.02, 0)
            tbl1 = { MoveImageDTS = true, JumpLabel = true }
        else
            touch.MoveLabel.Position = isPortrait and UDim2.new(0.06, 0, 1, -120) or UDim2.new(0.06, 0, 0.58, 0)
            touch.JumpLabel.Position = isPortrait and UDim2.new(0.94, -touch.JumpLabel.AbsoluteSize.x, 1, -120) or UDim2.new(0.8, 0, 0.58, 0)
            touch.RotateLabel.Position = isPortrait and UDim2.new(1, -touch.RotateLabel.AbsoluteSize.x - 20, 0.02, 0) or UDim2.new(0.5, -60, 0.02, 0)
            touch.UseToolLabel.Position = isPortrait and UDim2.new(0.5, -touch.UseToolLabel.AbsoluteSize.x / 2, 0.25, 50) or UDim2.new(0.85, -60, 0.02, 0)

            touch.EquipLabel.Position = isPortrait and UDim2.new(0.5, -60, 0.75, 50) or UDim2.new(0.5, -60, 0.64, 0)
            touch.ZoomLabel.Position = isPortrait and UDim2.new(0, 20, 0.02, 0) or UDim2.new(0.15, -60, 0.02, 0)
            tbl1 = { MoveImageDTS = true, MoveImageCTM = true, JumpImage = true }
        end

        hideUneeded(tbl1)
    end

    local function createTouchHelp(arg1)
        local touchHelp = ({})
        local isSmallTouchScreen = Utility:IsSmallTouchScreen()
        local yOffset = GuiService:GetScreenResolution().y - 350
        if isSmallTouchScreen then
            yOffset = GuiService:GetScreenResolution().y - 100
        end
        arg1.Size = UDim2.new(1, 0, 0, yOffset)

        local function createTouchLabel(text: string, uDim2: UDim2, uDim2_2: UDim2, arg2)
            local var5 = Create("TextLabel")(
                {
                    Position = uDim2,
                    Size = uDim2_2,
                    BackgroundTransparency = 1,
                    Name = text .. "Frame",
                    Parent = arg2
                }
            )
            local parent = Create("TextLabel")({
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = text,
                Font = Theme.font(Enum.Font.SourceSansBold, "HelpTouch"),
                FontSize = Theme.fontSize(Enum.FontSize.Size14, "HelpTouch"),
                TextColor3 = Color3.new(1, 1, 1),
                Name = text .. "Label",
                ZIndex = 3,
                Parent = var5,
                TextScaled = true,
                TextWrapped = true
            })

            if not isSmallTouchScreen then
                parent.FontSize = Theme.fontSize(Enum.FontSize.Size18, "HelpTitle")
                parent.Size = UDim2.new(parent.Size.X.Scale, parent.Size.X.Offset, parent.Size.Y.Scale, parent.Size.Y.Offset + 4)
            end

            Create("ImageLabel")({
                Name = text .. "BackgroundImage",
                Size = UDim2.new(1.25, 0, 1.25, 0),
                Position = UDim2.new(-0.125, 0, -0.065, 0),
                BackgroundTransparency = 1,
                Image = "rbxasset://textures/ui/Settings/Radial/RadialLabel.png",
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 2, 65, 21),
                ZIndex = 2,
                Parent = var5
            })

            Instance.new("UITextSizeConstraint", parent).MaxTextSize = Theme.textSize(18, "HelpText")

            return var5
        end

        local function createTouchGestureImage(str1: string, image: string, uDim2: UDim2, uDim2_2: UDim2, arg2) -- Luacid: Inlined by compiler; 6 call sites recovered
            return (Create("ImageLabel")(
                {
                    Name = str1,
                    Size = uDim2_2,
                    Position = uDim2,
                    BackgroundTransparency = 1,
                    Image = image,
                    ZIndex = 2,
                    Parent = arg2
                }
            ))
        end

        local num1 = if isSmallTouchScreen then 0 else 30

        touchHelp.MoveLabel = createTouchLabel("Move", UDim2.new(0.06, 0, 0.58, 0), UDim2.new(0, num1 + 77, 0, 25), arg1)
        touchHelp.MoveImageDTS = createTouchGestureImage(
            "MoveImageDTS",
            "rbxasset://textures/ui/Settings/Help/RotateCameraGesture.png",
            UDim2.new(0.5, -32, 1, 3),
            UDim2.new(0, 65, 0, 48),
            touchHelp.MoveLabel
        )
        touchHelp.MoveImageCTM = createTouchGestureImage(
            "MoveImageCTM",
            "rbxasset://textures/ui/Settings/Help/UseToolGesture.png",
            UDim2.new(0.5, -19, 1, 3),
            UDim2.new(0, 38, 0, 52),
            touchHelp.MoveLabel
        )

        touchHelp.JumpLabel = createTouchLabel("Jump", UDim2.new(0.8, 0, 0.58, 0), UDim2.new(0, num1 + 77, 0, 25), arg1)
        touchHelp.JumpImage = createTouchGestureImage(
            "JumpImage",
            "rbxasset://textures/ui/Settings/Help/UseToolGesture.png",
            UDim2.new(0.5, -19, 1, 3),
            UDim2.new(0, 38, 0, 52),
            touchHelp.JumpLabel
        )
        touchHelp.EquipLabel = createTouchLabel("Equip/Unequip Tools", UDim2.new(0.5, -60, 0.64, 0), UDim2.new(0, num1 + 120, 0, 25), arg1)

        touchHelp.ZoomLabel = createTouchLabel("Zoom In/Out", UDim2.new(0.15, -60, 0.02, 0), UDim2.new(0, 120, 0, 25), arg1)
        touchHelp.ZoomImage = createTouchGestureImage(
            "ZoomImage",
            "rbxasset://textures/ui/Settings/Help/ZoomGesture.png",
            UDim2.new(0.5, -26, 1, 3),
            UDim2.new(0, 53, 0, 59),
            touchHelp.ZoomLabel
        )
        touchHelp.RotateLabel = createTouchLabel("Rotate Camera", UDim2.new(0.5, -60, 0.02, 0), UDim2.new(0, 120, 0, 25), arg1)
        touchHelp.RotateImage = createTouchGestureImage(
            "RotateImage",
            "rbxasset://textures/ui/Settings/Help/RotateCameraGesture.png",
            UDim2.new(0.5, -32, 1, 3),
            UDim2.new(0, 65, 0, 48),
            touchHelp.RotateLabel
        )
        touchHelp.UseToolLabel = createTouchLabel("Use Tool", UDim2.new(0.85, -60, 0.02, 0), UDim2.new(0, 120, 0, 25), arg1)
        touchHelp.ToolImage = createTouchGestureImage(
            "ToolImage",
            "rbxasset://textures/ui/Settings/Help/UseToolGesture.png",
            UDim2.new(0.5, -19, 1, 3),
            UDim2.new(0, 38, 0, 52),
            touchHelp.UseToolLabel
        )
        return touchHelp
    end

    local function createSpatialGamepadHelp(arg1)
        local gamepadQuest = HelpConstants.Images.GamepadQuest
        local questGamepadLabels = HelpConstants.Labels.QuestGamepadLabels

        local image = gamepadQuest.Image
        local heightRatio = gamepadQuest.HeightRatio
        local localizationKeyPrefix = questGamepadLabels.LocalizationKeyPrefix
        local labelRelativeTextHeight = questGamepadLabels.LabelRelativeTextHeight
        local labelsInfo = questGamepadLabels.LabelsInfo

        local var5 = Create("ImageLabel")({
            Name = "SpatialGamepadImage",
            Size = UDim2.new(1, 0, heightRatio, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Image = image,
            BackgroundTransparency = 1,
            ZIndex = 2,
            Parent = arg1
        })

        local uiPadding = var3.Page:FindFirstChildOfClass("UIPadding")
        local num1 = if uiPadding then uiPadding.PaddingLeft.Offset + uiPadding.PaddingRight.Offset else 0
        arg1.Size = UDim2.new(arg1.Size.X.Scale, arg1.Size.X.Offset, 0, (var3.Page.AbsoluteSize.X - num1) * heightRatio)

        for _, value in labelsInfo do
            local var6 = localizationKeyPrefix .. value.labelKey
            local var7 = var2:Format(var6)

            Create("TextLabel")({
                Name = value.labelKey,
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(value.xPosition, value.yPosition),
                Size = UDim2.fromScale(value.width, labelRelativeTextHeight),
                Text = var7,
                TextXAlignment = value.xAlignment or Enum.TextXAlignment.Right,
                Font = Theme.font(nil, "HelpGamepad"),
                TextColor3 = Theme.color("TextEmphasis"),
                TextTransparency = Theme.transparency("TextEmphasis"),
                ZIndex = 2,
                TextScaled = true,
                Parent = var5
            })
        end
    end

    local function createHelpDisplay(arg1)
        local touchHelp = nil
        local var5 = Create("Frame")({
            Size = UDim2.new(1, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Name = "HelpFrame" .. tostring(arg1)
        })
        if arg1 == "KeyboardMouse" then
            Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                Wraps = true,
                Parent = var5,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            })
        end

        if arg1 == "KeyboardMouse" then
            createPCHelp(var5)
        elseif arg1 == "Gamepad" then
            createGamepadHelp(var5)
        elseif arg1 == "Touch" then
            touchHelp = createTouchHelp(var5)
        elseif isInExperienceUIVREnabled and arg1 == "SpatialGamepad" then
            createSpatialGamepadHelp(var5)
        end

        return var5, touchHelp
    end

    local function displayHelp(arg1)
        for _, value in pairs(var3.HelpPages) do
            if value == arg1 then
                value.Parent = var3.Page
                var3.Page.Size = value.Size
                if var1 then
                    var3.Page.Size = UDim2.new(value.Size.X.Scale, value.Size.X.Offset, value.Size.Y.Scale, 0)
                end
            else
                value.Parent = nil
            end
        end
        if UserInputService:GetPlatform() == Enum.Platform.XBoxOne then
            var3.HubRef.PageViewClipper.ClipsDescendants = false
            var3.HubRef.PageView.ClipsDescendants = false
        end
    end

    local function switchToHelp(arg1)
        local var5 = var3.HelpPages[arg1]
        if var5 then
            displayHelp(var5)
            if arg1 == "Touch" then
                local touchMovementMode = GameSettings.TouchMovementMode
                if var3.ActiveHelpScheme ~= touchMovementMode then
                    updateTouchLayout(touchMovementMode)
                end
            end
        else
            local helpPages = var3.HelpPages
            local helpPageContents = var3.HelpPageContents
            local var6, var7 = createHelpDisplay(arg1)
            helpPages[arg1] = var6
            helpPageContents[arg1] = var7
            switchToHelp(arg1)
        end
    end

    local function showTypeOfHelp() -- Luacid: Inlined by compiler; 2 call sites recovered
        switchToHelp(var3:GetCurrentInputType())
    end

    function var3.PageDisplayed(_)
        if not var3.LastInputTypeChangedConnection then
            var3.LastInputTypeChangedConnection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
                if lastInputType ~= Enum.UserInputType.Focus and lastInputType ~= Enum.UserInputType.None then
                    var4 = lastInputType
                    showTypeOfHelp()
                end
            end)
        end

        var4 = UserInputService:GetLastInputType()
        showTypeOfHelp()
    end

    function var3.PageHidden(_)
        if var3.LastInputTypeChangedConnection then
            var3.LastInputTypeChangedConnection:Disconnect()
            var3.LastInputTypeChangedConnection = nil
        end
    end

    local function adjustForScreenLayout(arg1)
        if var3:GetCurrentInputType() ~= "Touch" then
            return
        end

        local touchMovementMode = GameSettings.TouchMovementMode
        local isSmallTouchScreen = Utility:IsSmallTouchScreen()
        local var5 = arg1 or GuiService:GetScreenResolution()
        local yOffset = var5.y - 350
        if isSmallTouchScreen then
            yOffset = var5.y - 120
        end
        var3.HelpPages.Touch.Size = UDim2.new(1, 0, 0, yOffset)
        updateTouchLayout(touchMovementMode)
    end

    var3.TabHeader.Name = "HelpTab"
    local iconsMenuHelp = uiblox["icons/menu/help"]
    var3.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[iconsMenuHelp.variant]
    var3.TabHeader.TabLabel.Icon.Text = iconsMenuHelp.name
    var3.TabHeader.TabLabel.Title.Text = "Help"

    var3.Page.Name = "Help"

    Utility:OnResized(var3, function(arg1, _)
        if var3.HelpPages.Touch then
            adjustForScreenLayout(arg1)
        end
    end)

    return var3
end

local var3 = Initialize()

var3.Displayed.Event:connect(function()
    var3:PageDisplayed()
    if var3.HubRef.VersionContainer then
        var3.HubRef.VersionContainer.Visible = true
    end
end)

var3.Hidden.Event:connect(function()
    var3:PageHidden()
    var3.HubRef.PageViewClipper.ClipsDescendants = true
    var3.HubRef.PageView.ClipsDescendants = true

    var3.HubRef:ShowShield()
    if var3.HubRef.VersionContainer then
        var3.HubRef.VersionContainer.Visible = false
    end
end)

return var3
