-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local Modules = RobloxGui.Modules
local Signals = require(CorePackages.Packages.Signals)
local InExperienceTopBar = require(CorePackages.Workspace.Packages.InExperienceTopBar)
local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal

local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local FFlagMountCoreGuiBackpack = require(Modules.Flags.FFlagMountCoreGuiBackpack)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP

local FFlagTopBarSignalizeSetCores = InExperienceTopBar.Flags.FFlagTopBarSignalizeSetCores

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local FFlagBackpackResponsiveUnits = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBackpackResponsiveUnits
local bool1 = game:DefineFastFlag("EnableHotbarHide", false)
local FFlagStudioDeviceSimVRSwitchFixes = require(CorePackages.Workspace.Packages.SharedFlags).FFlagStudioDeviceSimVRSwitchFixes

local function featureSAToolEquipEnabled(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return workspace.AuthorityMode == Enum.AuthorityMode.Server
end

local module = {
    OpenClose = nil,
    IsHotbarVisible = false,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent"),
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true
}
local num1 = 60
local Size14 = Enum.FontSize.Size14

local var1 = 0.5 * UserGameSettings.PreferredTransparency
local black = Color3.new(31 / 255, 31 / 255, 31 / 255)

local black2 = Color3.new(49 / 255, 49 / 255, 49 / 255)
local mediumBlue = Color3.new(6 / 17, 142 / 255, 233 / 255)

local var2 = 0.5 * UserGameSettings.PreferredTransparency
local white = Color3.new(1, 1, 1)

local _uDim2 = UDim2.new(0, 14, 0, 9)
local BackquoteValue = Enum.KeyCode.Backquote.Value

local cyan = Color3.new(0, 54 / 85, 1)

local str1 = "   Search"

local darkStoneGrey = Color3.new(0.37, 0.37, 0.37)

local var3 = 0.15 * UserGameSettings.PreferredTransparency

local ZeroValue = Enum.KeyCode.Zero.Value
local BackspaceValue = Enum.KeyCode.Backspace.Value

local tbl1 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local GamepadService = game:GetService("GamepadService")
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local var4 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local GameTranslator = require(Modules.GameTranslator)

pcall(function()
    str1 = RobloxTranslator:FormatByKey("InGame.UnknownNamespace.BACKPACK_SEARCH")
end)

local bool2 = true

if var4 then
    num1 = 100
    Size14 = Enum.FontSize.Size24
end

local bool3 = false
local bool4 = if FFlagBackpackResponsiveUnits then Responsive.GetInputModeStore().getPreferredInputType() == Responsive.Input.Touch
    and GuiService:GetScreenResolution().X < 1024 else UserInputService.TouchEnabled and GuiService:GetScreenResolution().X < 1024
local LocalPlayer = Players.LocalPlayer

local selectionParent = nil
local var5 = nil
local var6 = nil

local var7 = nil
local var8 = nil
local var9 = nil
local var10 = nil

local currentCharacter = nil
local var11 = nil
local Backpack = nil

local tbl2 = ({})
local var12 = nil
local tbl3 = ({})
local tbl4 = ({})
local tbl5 = ({})
local num2 = 0
local var13 = nil
local bool5 = false
local bool6 = false
local bool7 = false
local bool8 = false
local tbl6 = {}
local tbl7 = {}
local bool9 = false
local num3 = 0

local num4 = if bool4 then 3 else 10
local num5 = if bool4 then 2 else 4

local var14 = nil

module.BackpackEmpty = Create("BindableEvent")({ Name = "BackpackEmpty" })

module.BackpackItemAdded = Create("BindableEvent")({ Name = "BackpackAdded" })

module.BackpackItemRemoved = Create("BindableEvent")({ Name = "BackpackRemoved" })

local function NewGui(className: string, instanceName): Instance
    local instance = Instance.new(className)
    instance.Name = instanceName
    instance.BackgroundColor3 = Color3.new(0, 0, 0)
    instance.BackgroundTransparency = 1
    instance.BorderColor3 = Color3.new(0, 0, 0)
    instance.BorderSizePixel = 0
    instance.Size = UDim2.new(1, 0, 1, 0)
    if className:match("Text") then
        instance.TextColor3 = Color3.new(1, 1, 1)
        instance.Text = ""
        instance.Font = Enum.Font.SourceSans
        instance.FontSize = Size14
        instance.TextWrapped = true
        if className == "TextButton" then
            instance.Font = Enum.Font.SourceSansBold
            instance.BorderSizePixel = 1
        end
    end
    return instance
end

local function FindLowestEmpty() -- Luacid: Inlined by compiler; 2 call sites recovered
    for i = 1, num4 do
        local var15 = tbl2[i]
        if not var15.Tool then
            return var15
        end
    end
    return nil
end

local function isInventoryEmpty() -- Luacid: Inlined by compiler; 2 call sites recovered
    for i = num4 + 1, #tbl2 do
        local var15 = tbl2[i]
        if var15 and var15.Tool then
            return false
        end
    end
    return true
end

module.IsInventoryEmpty = isInventoryEmpty

local function UseGazeSelection(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return false
end

local function AdjustHotbarFrames(arg1)
    local visible = var7.Visible
    local num6 = visible and num4 or num2
    local num7 = 0
    local isHotbarVisible = if bool1 then num6 >= 1 and not arg1 else num6 >= 1

    for i = 1, num4 do
        local var15 = tbl2[i]
        local var16 = if bool1 then var15.Tool and not arg1 else var15.Tool

        if var16 or visible then
            num7 += 1
            var15:Readjust(num7, num6)
            var15.Frame.Visible = true
        else
            var15.Frame.Visible = false
        end
    end

    local var15 = var6
    local bool11 = not visible

    if bool11 then
        if isHotbarVisible then
            bool11 = isHotbarVisible
        else
            bool11 = not isInventoryEmpty()
        end
    end

    var15.Visible = bool11
    var6.Position = UDim2.new(0.5, -15, 1, if isHotbarVisible then -110 else -50)
    module.IsHotbarVisible = isHotbarVisible
end

local function UpdateScrollingFrameCanvasSize()
    local num6 = math.floor(var9.AbsoluteSize.X / (num1 + 5))
    local yOffset = math.ceil((#var10:GetChildren() - 1) / num6) * (num1 + 5) + 5
    var9.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local function AdjustInventoryFrames()
    for i = num4 + 1, #tbl2 do
        local var15 = tbl2[i]
        var15.Frame.LayoutOrder = var15.Index
        var15.Frame.Visible = var15.Tool ~= nil
    end
    UpdateScrollingFrameCanvasSize()
end

local function UpdateBackpackLayout()
    var5.Size = UDim2.new(0, 5 + num4 * (num1 + 5), 0, num1 + 5 + 5)
    var5.Position = UDim2.new(0.5, -var5.Size.X.Offset / 2, 1, -var5.Size.Y.Offset)
    var7.Size = UDim2.new(0, var5.Size.X.Offset, 0, var5.Size.Y.Offset * num5 + 40)
    var7.Position = UDim2.new(0.5, -var7.Size.X.Offset / 2, 1, var5.Position.Y.Offset - var7.Size.Y.Offset)

    var9.Size = UDim2.new(1, var9.ScrollBarThickness + 1, 1, -40)
    var9.Position = UDim2.new(0, 0, 0, 40)
    AdjustHotbarFrames()
    AdjustInventoryFrames()
end

local function Clamp(num6: number, arg1, arg2): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.min(arg1, math.max(num6, arg2))
end

local function CheckBounds(arg1, num6: number, num7: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize
    return absolutePosition.X < num6
        and num6 <= absolutePosition.X + absoluteSize.X
        and absolutePosition.Y < num7
        and num7 <= absolutePosition.Y + absoluteSize.Y
end

local function GetOffset(frame, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (frame.AbsolutePosition + frame.AbsoluteSize / 2 - arg1).magnitude
end

local function DisableActiveHopper() -- Luacid: Inlined by compiler; 11 call sites recovered
    var13:ToggleSelect()
    tbl3[var13]:UpdateEquipView()
    var13 = nil
end

local function UnequipAllTools() -- Luacid: Inlined by compiler; 9 call sites recovered
    if not var11 then
        return
    end

    var11:UnequipTools()
    if var13 then
        DisableActiveHopper()
    end
end

local function EquipNewTool(tool)
    UnequipAllTools()

    if tool:IsA("HopperBin") then
        tool:ToggleSelect()
        tbl3[tool]:UpdateEquipView()
        var13 = tool
        return
    end

    if featureSAToolEquipEnabled() then
        LocalPlayer:RequestTool(tool)
    end

    tool.Parent = currentCharacter
end

local function IsEquipped(tool) -- Luacid: Inlined by compiler; 5 call sites recovered
    return tool and (tool:IsA("HopperBin") and tool.Active or tool.Parent == currentCharacter)
end

local function MakeSlot(arg1, index)
    index = index or #tbl2 + 1

    local module2 = { Tool = nil, Index = index, Frame = nil }

    local var15 = nil
    local var16 = nil
    local var17 = nil
    local var18 = nil
    local connection = nil
    local var19 = nil

    local var20 = nil
    local var21 = nil

    local function UpdateSlotFading() -- Luacid: Inlined by compiler; 2 call sites recovered
        var15.SelectionImageObject = nil
        var15.BackgroundTransparency = if var15.Draggable then 0 else var2
        var15.BackgroundColor3 = var15.Draggable and black2 or black
    end

    function module2.Readjust(_, arg3, arg4)
        local var22 = var5.Size.X.Offset / 2
        local num6 = num1 + 5
        local var23 = arg3 - (arg4 / 2 + 0.5)
        var15.Position = UDim2.new(0, var22 - num1 / 2 + num6 * var23, 0, 5)
    end

    function module2.Fill(arg3, tool)
        if not tool then
            return arg3:Clear()
        end

        arg3.Tool = tool

        local function assignToolData()
            local textureId = tool.TextureId
            var17.Image = textureId

            if textureId ~= "" then
                var18.Visible = false
            else
                var18.Visible = true
            end

            GameTranslator:TranslateAndRegister(var18, tool, tool.Name)

            if var20 and tool:IsA("Tool") then
                GameTranslator:TranslateAndRegister(var20, tool, tool.ToolTip)
                local xOffset = var20.TextBounds.X + 6
                var20.Size = UDim2.new(0, xOffset, 0, 16)
                var20.Position = UDim2.new(0.5, -xOffset / 2, 0, -25)
            end
        end
        assignToolData()

        if connection then
            connection:disconnect()
            connection = nil
        end

        connection = tool.Changed:connect(function(arg4)
            if arg4 == "TextureId" or arg4 == "Name" or arg4 == "ToolTip" then
                assignToolData()
            end
        end)

        local bool10 = arg3.Index <= num4
        local visible = var7.Visible

        if not bool10 or visible then
            var15.Draggable = true
        end

        arg3:UpdateEquipView()

        if bool10 then
            num2 += 1

            if bool6 and num2 >= 1 and not bool3 then
                bool3 = true
                ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
            end
        end

        tbl3[tool] = arg3
        var12 = FindLowestEmpty()
    end

    function module2.Clear(arg3)
        if not arg3.Tool then
            return
        end
        if connection then
            connection:disconnect()
            connection = nil
        end

        var17.Image = ""
        var18.Text = ""
        if var20 then
            var20.Text = ""
            var20.Visible = false
        end
        var15.Draggable = false

        arg3:UpdateEquipView(true)

        if arg3.Index <= num4 then
            num2 -= 1
            if num2 < 1 then
                bool3 = false
                ContextActionService:UnbindAction("RBXHotbarEquip")
            end
        end

        tbl3[arg3.Tool] = nil
        arg3.Tool = nil
        var12 = FindLowestEmpty()
    end

    function module2.UpdateEquipView(arg3, arg4)
        if not arg4 and IsEquipped(arg3.Tool) then
            var14 = module2
            if not var19 then
                var19 = NewGui("Frame", "Equipped")
                var19.ZIndex = var15.ZIndex

                for _, value in pairs({ { 0.1, 1, 0, 0 }, { 0.8, 0.1, 0.1, 0 }, { 0.1, 1, 0.9, 0 }, { 0.8, 0.1, 0.1, 0.9 } }) do
                    local var22 = NewGui("Frame", "Edge")
                    var22.BackgroundTransparency = 0
                    var22.BackgroundColor3 = mediumBlue
                    var22.Size = UDim2.new(value[1], 0, value[2], 0)
                    var22.Position = UDim2.new(value[3], 0, value[4], 0)
                    var22.ZIndex = var19.ZIndex
                    var22.Parent = var19
                end
            end
            var19.Parent = var15
        elseif var19 then
            var19.Parent = nil
        end

        UpdateSlotFading()
    end

    function module2.IsEquipped(arg3)
        return (IsEquipped(arg3.Tool))
    end

    function module2.Delete(arg3)
        tbl5[var15] = nil
        var15:Destroy()
        table.remove(tbl2, arg3.Index)
        local num6 = #tbl2

        for i = arg3.Index, num6 do
            tbl2[i]:SlideBack()
        end

        UpdateScrollingFrameCanvasSize()
    end

    function module2.Swap(arg3, arg4)
        local tool = arg3.Tool
        local tool2 = arg4.Tool
        arg3:Clear()
        if tool2 then
            arg4:Clear()
            arg3:Fill(tool2)
        end
        if tool then
            arg4:Fill(tool)
            return
        end
        arg4:Clear()
    end

    function module2.SlideBack(arg3)
        arg3.Index -= 1
        var15.Name = arg3.Index
        var15.LayoutOrder = arg3.Index
    end

    function module2.TurnNumber(_, visible)
        if var21 then
            var21.Visible = visible
        end
    end

    function module2.SetClickability(arg3, arg4)
        if arg3.Tool then
            var15.Draggable = not arg4
            UpdateSlotFading()
        end
    end

    function module2.CheckTerms(arg3, arg4): number
        local num6 = 0
        local function checkEm(text, arg5) -- Luacid: Inlined by compiler; 2 call sites recovered
            local _, var22 = text:lower():gsub(arg5, "")
            num6 += var22
        end
        local tool = arg3.Tool
        if tool then
            for k in pairs(arg4) do
                checkEm(var18.Text, k)
                if tool:IsA("Tool") then
                    checkEm(var20 and var20.Text or "", k)
                end
            end
        end

        return num6
    end

    function module2.Select(_, arg3)
        if arg3 then
            return
        end

        local tool = module2.Tool
        if not tool then
            return
        end

        if IsEquipped(tool) then
            if featureSAToolEquipEnabled() and not tool:IsA("HopperBin") then
                LocalPlayer:RequestTool(nil)
            end

            UnequipAllTools()
            return
        end

        if tool.Parent == Backpack then
            EquipNewTool(tool)
        end
    end

    var15 = NewGui("TextButton", index)
    var15.BackgroundColor3 = black
    var15.BorderColor3 = white
    var15.Text = ""
    var15.AutoButtonColor = false
    var15.BorderSizePixel = 0
    local uDim2 = UDim2.new(0, num1, 0, num1)
    var15.Size = uDim2
    var15.Active = true
    var15.Draggable = false
    var15.BackgroundTransparency = var2
    var15.MouseButton1Click:connect(function()
        changeSlot(module2)
    end)

    module2.Frame = var15

    local var22 = NewGui("Frame", "SelectionObjectClipper")
    var22.Visible = false
    var22.Parent = var15

    local var23 = NewGui("ImageLabel", "Selector")
    var23.Size = UDim2.new(1, 0, 1, 0)
    var23.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
    var23.ScaleType = Enum.ScaleType.Slice
    var23.SliceCenter = Rect.new(12, 12, 52, 52)
    var23.Parent = var22

    var17 = NewGui("ImageLabel", "Icon")
    local uDim2_2 = UDim2.new(0.8, 0, 0.8, 0)
    var17.Size = uDim2_2
    local uDim2_3 = UDim2.new(0.1, 0, 0.1, 0)
    var17.Position = uDim2_3
    var17.Parent = var15

    var18 = NewGui("TextLabel", "ToolName")
    local uDim2_4 = UDim2.new(1, -2, 1, -2)
    var18.Size = uDim2_4
    local uDim2_5 = UDim2.new(0, 1, 0, 1)
    var18.Position = uDim2_5
    var18.Parent = var15

    module2.Frame.LayoutOrder = module2.Index

    if index <= num4 then
        var20 = NewGui("TextLabel", "ToolTip")
        var20.TextWrapped = false
        local top = Enum.TextYAlignment.Top
        var20.TextYAlignment = top
        local flint = Color3.new(0.4, 0.4, 0.4)
        var20.BackgroundColor3 = flint
        var20.BackgroundTransparency = 0
        var20.Visible = false
        var20.Parent = var15
        var15.MouseEnter:connect(function()
            if var20.Text ~= "" then
                var20.Visible = true
            end
        end)
        var15.MouseLeave:connect(function()
            var20.Visible = false
        end)
        function module2.MoveToInventory(arg3)
            if not (module2.Index <= num4) then
                return
            end

            local tool = module2.Tool
            arg3:Clear()
            local slot = MakeSlot(var10)
            slot:Fill(tool)

            if IsEquipped(tool) then
                UnequipAllTools()
            end

            if bool8 then
                slot.Frame.Visible = false
                slot.Parent = var7
            end
        end

        if index < 10 or index == num4 then
            local var24 = index < 10 and index or 0
            var21 = NewGui("TextLabel", "Number")
            var21.Text = var24
            local uDim2_6 = UDim2.new(0.15, 0, 0.15, 0)
            var21.Size = uDim2_6
            var21.Visible = false
            var21.Parent = var15

            tbl4[ZeroValue + var24] = function(arg3)
                module2:Select(arg3)
            end
        end
    end

    local position = var15.Position
    local num6 = 0
    local parent = nil

    var15.DragBegin:connect(function(initialPosition: UDim2)
        tbl5[var15] = true
        position = initialPosition

        var15.BorderSizePixel = 2

        var15.ZIndex = 2
        var17.ZIndex = 2
        var18.ZIndex = 2
        var15.Parent.ZIndex = 2
        if var21 then
            var21.ZIndex = 2
        end
        if var19 then
            var19.ZIndex = 2
            for _, child in pairs(var19:GetChildren()) do
                child.ZIndex = 2
            end
        end

        parent = var15.Parent
        if parent ~= var10 then
            return
        end

        local _absolutePosition = var15.AbsolutePosition
        local uDim2_6 = UDim2.new(0, var15.AbsolutePosition.X - var7.AbsolutePosition.X, 0, var15.AbsolutePosition.Y - var7.AbsolutePosition.Y)
        var15.Parent = var7
        var15.Position = uDim2_6

        var16 = NewGui("Frame", "FakeSlot")
        var16.LayoutOrder = var15.LayoutOrder
        var16.Size = var15.Size
        var16.BackgroundTransparency = 1
        var16.Parent = var10
    end)

    var15.DragStopped:connect(function(x: number, y: number)
        if var16 then
            var16:Destroy()
        end

        local var24 = tick()
        var15.Position = position
        var15.Parent = parent

        var15.BorderSizePixel = 0

        var15.ZIndex = 1
        var17.ZIndex = 1
        var18.ZIndex = 1
        parent.ZIndex = 1
        if var21 then
            var21.ZIndex = 1
        end
        if var19 then
            var19.ZIndex = 1
            for _, child in pairs(var19:GetChildren()) do
                child.ZIndex = 1
            end
        end

        tbl5[var15] = nil

        if not module2.Tool then
            return
        end

        if CheckBounds(var7, x, y) then
            if module2.Index <= num4 then
                module2:MoveToInventory()
            end

            local index = module2.Index

            if num4 < index and var24 - num6 < 0.5 then
                if var12 then
                    local tool = module2.Tool
                    module2:Clear()
                    var12:Fill(tool)
                    module2:Delete()
                    var24 = 0
                else
                    var24 = 0
                end
            end
        elseif CheckBounds(var5, x, y) then
            local tbl8 = { math.huge, nil }
            for i = 1, num4 do
                local var25 = tbl2[i]
                local offset = GetOffset(var25.Frame, Vector2.new(x, y))
                if offset < tbl8[1] then
                    tbl8 = { offset, var25 }
                end
            end

            local var25 = tbl8[2]
            if var25 ~= module2 then
                module2:Swap(var25)
                if module2.Index > num4 then
                    local tool = module2.Tool
                    if not tool then
                        module2:Delete()
                    else
                        if IsEquipped(tool) then
                            UnequipAllTools()
                        end

                        if bool8 then
                            module2.Frame.Visible = false
                            module2.Frame.Parent = var7
                        end
                    end
                end
            end
        elseif module2.Index <= num4 then
            module2:MoveToInventory()
        end

        num6 = var24
    end)

    var15.Parent = arg1
    tbl2[index] = module2

    if num4 < index then
        UpdateScrollingFrameCanvasSize()

        if var7.Visible and not bool8 then
            local var24 = var9.CanvasSize.Y.Offset - var9.AbsoluteSize.Y
            var9.CanvasPosition = Vector2.new(0, math.max(0, var24))
        end
    end

    return module2
end

local function SetNumberOfHotbarSlots(arg1) -- Luacid: unused: defined but never referenced
    if num4 == arg1 then
        return
    end

    local num6 = num4

    if arg1 < num6 then
        for i = num6, arg1 + 1, -1 do
            local var15 = tbl2[i]
            if var15 then
                var15:MoveToInventory()
                var15:Delete()
            end
        end

        for i = num6, arg1 + 1, -1 do
            local var15 = tbl2[i]
            if not var15.Tool then
                var15:Delete()
            end
        end
    else
        for i = num6, arg1 do
            num4 = i
            if tbl2[i] then
                local _ = tbl2[i]
                local tool = tbl2[i].Tool

                local slot = MakeSlot(var5, i)

                if tool then
                    slot:Fill(tool)
                else
                    var12 = var12 or slot
                end
            else
                local slot = MakeSlot(var5, i)

                slot.Frame.Visible = false

                var12 = var12 or slot
            end
        end
    end

    num4 = arg1
    num2 = 0
    for i = 1, num4 do
        if tbl2[i] and tbl2[i].Tool then
            num2 += 1
        end
    end

    UpdateBackpackLayout()
end

local function OnChildAdded(arg1)
    if not (arg1:IsA("Tool") or arg1:IsA("HopperBin")) then
        if arg1:IsA("Humanoid") and arg1.Parent == currentCharacter then
            var11 = arg1
        end
        return
    end

    if arg1.Parent == currentCharacter then
        num3 = tick()
    end

    if var13 and arg1.Parent == currentCharacter then
        DisableActiveHopper()
    end

    if not bool5 and arg1.Parent == currentCharacter and not tbl3[arg1] then
        local starterGear = LocalPlayer:FindFirstChild("StarterGear")
        if starterGear and starterGear:FindFirstChild(arg1.Name) then
            bool5 = true
            for i = (var12 or MakeSlot(var10)).Index, 1, -1 do
                local var15 = tbl2[i]
                local num6 = i - 1
                if num6 > 0 then
                    tbl2[num6]:Swap(var15)
                else
                    var15:Fill(arg1)
                end
            end

            for _, child in pairs(currentCharacter:GetChildren()) do
                if child:IsA("Tool") and child ~= arg1 then
                    child.Parent = Backpack
                end
            end
            AdjustHotbarFrames()
            return
        end
    end

    local var15 = tbl3[arg1]
    if var15 then
        var15:UpdateEquipView()
    else
        local var16 = var12 or MakeSlot(var10)
        var16:Fill(arg1)
        if var16.Index <= num4 and not var7.Visible then
            AdjustHotbarFrames()
        end
        if arg1:IsA("HopperBin") and arg1.Active then
            UnequipAllTools()
            var13 = arg1
        end
    end

    module.BackpackItemAdded:Fire()
end

local function OnChildRemoved(child: Instance)
    if not (child:IsA("Tool") or child:IsA("HopperBin")) then
        return
    end

    num3 = tick()

    local childParent = child.Parent
    if childParent == currentCharacter or childParent == Backpack then
        return
    end

    local var15 = tbl3[child]
    if var15 then
        var15:Clear()
        if var15.Index > num4 then
            var15:Delete()
        elseif not var7.Visible then
            AdjustHotbarFrames()
        end
    end

    if child == var13 then
        var13 = nil
    end

    module.BackpackItemRemoved:Fire()

    if isInventoryEmpty() then
        module.BackpackEmpty:Fire()
    end
end

local function OnCharacterAdded(character: Model)
    for i = #tbl2, 1, -1 do
        local var15 = tbl2[i]
        if var15.Tool then
            var15:Clear()
        end
        if num4 < i then
            var15:Delete()
        end
    end
    var13 = nil

    for _, value in pairs(tbl7) do
        value:disconnect()
    end
    tbl7 = {}

    currentCharacter = character
    table.insert(tbl7, character.ChildRemoved:connect(OnChildRemoved))
    table.insert(tbl7, character.ChildAdded:connect(OnChildAdded))
    for _, child in pairs(character:GetChildren()) do
        OnChildAdded(child)
    end

    Backpack = LocalPlayer:WaitForChild("Backpack")
    table.insert(tbl7, Backpack.ChildRemoved:connect(OnChildRemoved))
    table.insert(tbl7, Backpack.ChildAdded:connect(OnChildAdded))
    for _, child in pairs(Backpack:GetChildren()) do
        OnChildAdded(child)
    end

    AdjustHotbarFrames()
end

local function OnInputBegan(input: InputObject, gameProcessedEvent: boolean)
    if input.UserInputType == Enum.UserInputType.Keyboard and not bool7 and (bool6 or input.KeyCode.Value == BackspaceValue) then
        local var15 = tbl4[input.KeyCode.Value]
        if var15 then
            var15(gameProcessedEvent)
        end
    end

    local userInputType = input.UserInputType
    if not gameProcessedEvent
        and (userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch)
        and var7.Visible
    then
        module.OpenClose()
    end
end

local function OnUISChanged(property: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if property ~= "KeyboardEnabled" and property ~= "VREnabled" then
        return
    end

    local bool10 = UserInputService.KeyboardEnabled and not VRService.VREnabled
    for i = 1, num4 do
        tbl2[i]:TurnNumber(bool10)
    end
end

local var15 = nil
local var16 = nil

local function func1() end
local vector2 = Vector2.new(0, 0)

function unbindAllGamepadEquipActions()
    ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
    ContextActionService:UnbindAction("RBXCloseInventory")
end

local function setHotbarVisibility(visible, arg1) -- Luacid: unused: defined but never referenced
    for i = 1, num4 do
        local var17 = tbl2[i]
        if var17 and var17.Frame and (arg1 or var17.Tool) then
            var17.Frame.Visible = visible
        end
    end
end

local function getInputDirection(arg1): Vector2
    local num6 = if arg1.UserInputState == Enum.UserInputState.End then -1 else 1

    if arg1.KeyCode == Enum.KeyCode.Thumbstick1 then
        local magnitude = arg1.Position.magnitude

        if magnitude > 0.98 then
            vector2 = Vector2.new(arg1.Position.x / magnitude, -arg1.Position.y / magnitude)
        else
            vector2 = Vector2.new(0, 0)
        end
    elseif arg1.KeyCode == Enum.KeyCode.DPadLeft then
        vector2 = Vector2.new(vector2.x - num6 * 1, vector2.y)
    elseif arg1.KeyCode == Enum.KeyCode.DPadRight then
        vector2 = Vector2.new(vector2.x + num6 * 1, vector2.y)
    elseif arg1.KeyCode == Enum.KeyCode.DPadUp then
        vector2 = Vector2.new(vector2.x, vector2.y - num6 * 1)
    elseif arg1.KeyCode == Enum.KeyCode.DPadDown then
        vector2 = Vector2.new(vector2.x, vector2.y + num6 * 1)
    else
        vector2 = Vector2.new(0, 0)
    end

    return vector2
end

local function _(_, _, arg1) -- Luacid: unused: defined but never referenced
    local vector2_2 = getInputDirection(arg1)

    if vector2_2 == Vector2.new(0, 0) then
        return
    end

    local num6 = math.atan2(vector2_2.y, vector2_2.x) - -(math.pi / 2)
    if num6 < 0 then
        num6 += math.pi * 2
    end

    local num7 = math.floor(num6 / (math.pi / 4) + 1 + 0.5)
    local num8 = if num4 < num7 then 1 else num7

    if not (num8 > 0) then
        UnequipAllTools()
        return
    end

    local var17 = tbl2[num8]
    if var17 and var17.Tool and not var17:IsEquipped() then
        var17:Select()
    end
end

function changeToolFunc(_, userInputState, arg1)
    if userInputState ~= Enum.UserInputState.Begin then
        return
    end
    if var15
        and (var15.KeyCode == Enum.KeyCode.ButtonR1 and arg1.KeyCode == Enum.KeyCode.ButtonL1
            or var15.KeyCode == Enum.KeyCode.ButtonL1 and arg1.KeyCode == Enum.KeyCode.ButtonR1)
        and tick() - var16 <= 0.06
    then
        UnequipAllTools()
        var15 = arg1
        var16 = tick()
        return
    end

    var15 = arg1
    var16 = tick()

    delay(0.06, function()
        if var15 ~= arg1 then
            return
        end

        local num6 = if arg1.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

        for i = 1, num4 do
            if not tbl2[i]:IsEquipped() then
                continue
            end
            local num7 = num6 + i
            local bool10 = false
            if num4 < num7 then
                num7 = 1
                bool10 = true
            elseif num7 < 1 then
                num7 = num4
                bool10 = true
            end

            local num8 = num7

            while not tbl2[num7].Tool do
                num7 += num6
                if num7 == num8 then
                    return
                end
                if num4 < num7 then
                    num7 = 1
                    bool10 = true
                elseif num7 < 1 then
                    num7 = num4
                    bool10 = true
                end
            end

            if bool10 then
                UnequipAllTools()
                var14 = nil
                return
            end
            tbl2[num7]:Select()

            return
        end

        if var14 and var14.Tool then
            var14:Select()
            return
        end

        for i = num6 == -1 and num4 or 1, if num6 == -1 then 1 else num4, num6 do
            if tbl2[i].Tool then
                tbl2[i]:Select()
                return
            end
        end
    end)
end

function getGamepadSwapSlot()
    for i = 1, #tbl2 do
        if tbl2[i].Frame.BorderSizePixel > 0 then
            return tbl2[i]
        end
    end
end

function changeSlot(arg1)
    local gamepadCursorEnabled = GamepadService.GamepadCursorEnabled

    if arg1.Frame ~= GuiService.SelectedCoreObject or gamepadCursorEnabled then
        arg1:Select()
        var8.SelectionImageObject.Visible = false
        return
    end

    local gamepadSwapSlot = getGamepadSwapSlot()

    if not gamepadSwapSlot then
        local frameSize = arg1.Frame.Size
        local framePosition = arg1.Frame.Position
        arg1.Frame:TweenSizeAndPositionInternal(
            frameSize + UDim2.new(0, 10, 0, 10),
            framePosition - UDim2.new(0, 5, 0, 5),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.1,
            true,
            function()
                arg1.Frame:TweenSizeAndPositionInternal(
                    frameSize,
                    framePosition,
                    Enum.EasingDirection.In,
                    Enum.EasingStyle.Quad,
                    0.1,
                    true
                )
            end
        )

        arg1.Frame.BorderSizePixel = 3
        var8.SelectionImageObject.Visible = true
        return
    end

    gamepadSwapSlot.Frame.BorderSizePixel = 0
    if gamepadSwapSlot == arg1 then
        return
    end

    arg1:Swap(gamepadSwapSlot)
    var8.SelectionImageObject.Visible = false

    local index = arg1.Index

    if num4 < index and not arg1.Tool then
        if GuiService.SelectedCoreObject == arg1.Frame then
            GuiService.SelectedCoreObject = gamepadSwapSlot.Frame
        end
        arg1:Delete()
    end

    local index2 = gamepadSwapSlot.Index

    if not (num4 < index2) or gamepadSwapSlot.Tool then
        return
    end

    if GuiService.SelectedCoreObject == gamepadSwapSlot.Frame then
        GuiService.SelectedCoreObject = arg1.Frame
    end
    gamepadSwapSlot:Delete()
end

function enableGamepadInventoryControl()
    local function func2(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        if getGamepadSwapSlot() then
            local gamepadSwapSlot = getGamepadSwapSlot()
            if gamepadSwapSlot then
                gamepadSwapSlot.Frame.BorderSizePixel = 0
            end
        elseif var7.Visible then
            module.OpenClose()
        end
    end

    ContextActionService:BindAction("RBXBackpackHasGamepadFocus", func1, false, Enum.UserInputType.Gamepad1)
    ContextActionService:BindAction("RBXCloseInventory", func2, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

    if not UseGazeSelection() then
        GuiService.SelectedCoreObject = var5:FindFirstChild("1")
    end
end

function disableGamepadInventoryControl()
    unbindAllGamepadEquipActions()

    for i = 1, num4 do
        local var17 = tbl2[i]
        if var17 and var17.Frame then
            var17.Frame.BorderSizePixel = 0
        end
    end

    if GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(selectionParent) then
        GuiService.SelectedCoreObject = nil
    end
end

local function bindBackpackHotbarAction() -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool6 and not bool3 then
        bool3 = true
        ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
    end
end

local function unbindBackpackHotbarAction() -- Luacid: Inlined by compiler; 1 call site recovered
    disableGamepadInventoryControl()
    bool3 = false
    ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected()
    if not VRService.VREnabled then
        bool9 = false
        disableGamepadInventoryControl()
    end
end

function gamepadConnected()
    if VRService.VREnabled then
        return
    end

    bool9 = true
    if FFlagStudioDeviceSimVRSwitchFixes then
        GuiService:RemoveSelectionGroup("RBXBackpackSelection")
    end
    GuiService:AddSelectionParent("RBXBackpackSelection", selectionParent)

    if num2 >= 1 then
        bindBackpackHotbarAction()
    end

    if var7.Visible then
        enableGamepadInventoryControl()
    end
end

local function OnCoreGuiChanged(coreGuiType: Enum.CoreGuiType, enabled: boolean)
    if coreGuiType ~= Enum.CoreGuiType.Backpack and coreGuiType ~= Enum.CoreGuiType.All then
        return
    end

    enabled = enabled and bool2
    bool6 = enabled
    if FFlagMountCoreGuiBackpack then
        if enabled then
            selectionParent.Parent = RobloxGui
        else
            selectionParent.Parent = nil
        end
    else
        selectionParent.Visible = enabled
    end

    for _, value in pairs(tbl6) do
        if enabled then
            GuiService:AddKey(value)
        else
            GuiService:RemoveKey(value)
        end
    end

    if not enabled then
        unbindBackpackHotbarAction()
        return
    end

    if num2 >= 1 then
        bindBackpackHotbarAction()
    end
end

local function MakeVRRoundButton(name: string, image: string)
    local var17 = NewGui("ImageButton", name)
    var17.Size = UDim2.new(0, 40, 0, 40)
    var17.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"

    local var18 = NewGui("ImageLabel", "Icon")
    var18.Size = UDim2.new(0.5, 0, 0.5, 0)
    var18.Position = UDim2.new(0.25, 0, 0.25, 0)
    var18.Image = image
    var18.Parent = var17

    local selectionImageObject = NewGui("ImageLabel", "Selection")
    selectionImageObject.Size = UDim2.new(0.9, 0, 0.9, 0)
    selectionImageObject.Position = UDim2.new(0.05, 0, 0.05, 0)
    selectionImageObject.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
    var17.SelectionImageObject = selectionImageObject

    return var17, var18, selectionImageObject
end

selectionParent = NewGui("Frame", "Backpack")
if FFlagMountCoreGuiBackpack then
    if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
        selectionParent.Parent = RobloxGui
    end
else
    selectionParent.Visible = false
    selectionParent.Parent = RobloxGui
end

var5 = NewGui("Frame", "Hotbar")
var5.Parent = selectionParent

for i = 1, num4 do
    local slot = MakeSlot(var5, i)
    slot.Frame.Visible = false

    var12 = var12 or slot
end

var6 = NewGui("ImageButton", "OpenInventory")

local uDim2 = UDim2.new(0, 30, 0, 30)
var6.Size = uDim2
var6.Image = "rbxasset://textures/ui/Backpack/ScrollUpArrow.png"
var6.MouseButton1Click:connect(function()
    module.OpenClose()
end)
var6.SelectionGained:connect(function()
    var6.ImageColor3 = cyan
end)
var6.SelectionLost:connect(function()
    var6.ImageColor3 = Color3.new(1, 1, 1)
end)
local SelectionImageObject = NewGui("Frame", "Selection")
SelectionImageObject.Visible = false
var6.SelectionImageObject = SelectionImageObject

local vRRoundButton = MakeVRRoundButton("CloseInventory", "rbxasset://textures/ui/Keyboard/close_button_icon.png")
vRRoundButton.Position = UDim2.new(0, 0, 0, -50)
vRRoundButton.MouseButton1Click:connect(function()
    if var7.Visible then
        module.OpenClose()
    end
end)

LeftBumperButton = NewGui("ImageLabel", "LeftBumper")
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2)

RightBumperButton = NewGui("ImageLabel", "RightBumper")
RightBumperButton.Size = UDim2.new(0, 40, 0, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2)

var7 = NewGui("Frame", "Inventory")
var7.BackgroundTransparency = var1
var7.BackgroundColor3 = black
var7.Active = true
var7.Visible = false
var7.Parent = selectionParent

var8 = NewGui("TextButton", "VRInventorySelector")
local uDim2_2 = UDim2.new(0, 0, 0, 0)
var8.Position = uDim2_2
local uDim2_3 = UDim2.new(1, 0, 1, 0)
var8.Size = uDim2_3
var8.BackgroundTransparency = 1
var8.Text = ""
var8.Parent = var7

local var17 = NewGui("ImageLabel", "Selector")
var17.Size = UDim2.new(1, 0, 1, 0)
var17.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
var17.ScaleType = Enum.ScaleType.Slice
var17.SliceCenter = Rect.new(12, 12, 52, 52)
var17.Visible = false
var8.SelectionImageObject = var17

var9 = NewGui("ScrollingFrame", "ScrollingFrame")
var9.Selectable = false
local uDim2_4 = UDim2.new(0, 0, 0, 0)
var9.CanvasSize = uDim2_4
var9.Parent = var7

var10 = NewGui("Frame", "UIGridFrame")
var10.Selectable = false
local uDim2_5 = UDim2.new(1, -10, 1, 0)
var10.Size = uDim2_5
local uDim2_6 = UDim2.new(0, 5, 0, 0)
var10.Position = uDim2_6
var10.Parent = var9

local uiGridLayout = Instance.new("UIGridLayout")
uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiGridLayout.CellSize = UDim2.new(0, num1, 0, num1)
uiGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
uiGridLayout.Parent = var10

local vRRoundButton2 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
vRRoundButton2.Size = UDim2.new(0, 34, 0, 34)
vRRoundButton2.Position = UDim2.new(0.5, -vRRoundButton2.Size.X.Offset / 2, 0, 43)
vRRoundButton2.Icon.Position = vRRoundButton2.Icon.Position - UDim2.new(0, 0, 0, 2)
vRRoundButton2.MouseButton1Click:connect(function()
    var9.CanvasPosition = Vector2.new(
        var9.CanvasPosition.X,
        (Clamp(0, var9.CanvasSize.Y.Offset - var9.AbsoluteWindowSize.Y, var9.CanvasPosition.Y - (num1 + 5)))
    )
end)
local vRRoundButton3 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
vRRoundButton3.Rotation = 180
vRRoundButton3.Icon.Position = vRRoundButton3.Icon.Position - UDim2.new(0, 0, 0, 2)
vRRoundButton3.Size = UDim2.new(0, 34, 0, 34)
vRRoundButton3.Position = UDim2.new(0.5, -vRRoundButton3.Size.X.Offset / 2, 1, -vRRoundButton3.Size.Y.Offset - 3)
vRRoundButton3.MouseButton1Click:connect(function()
    var9.CanvasPosition = Vector2.new(
        var9.CanvasPosition.X,
        (Clamp(0, var9.CanvasSize.Y.Offset - var9.AbsoluteWindowSize.Y, var9.CanvasPosition.Y + (num1 + 5)))
    )
end)
var9.Changed:connect(function(arg1)
    if arg1 == "AbsoluteWindowSize" or arg1 == "CanvasPosition" or arg1 == "CanvasSize" then
        local vRRoundButton2Visible = var9.CanvasPosition.Y ~= 0
        local vRRoundButton3Visible = var9.CanvasPosition.Y < var9.CanvasSize.Y.Offset - var9.AbsoluteWindowSize.Y

        vRRoundButton2.Visible = vRRoundButton2Visible
        vRRoundButton3.Visible = vRRoundButton3Visible
    end
end)

UpdateBackpackLayout()

local var19 = Create("Frame")({
    Name = "GamepadHintsFrame",
    Size = UDim2.new(0, var5.Size.X.Offset, 0, if var4 then 95 else 60),
    BackgroundTransparency = 1,
    Visible = false,
    Parent = selectionParent
})

local function addGamepadHint(image, str2: string, text: string)
    local var20 = Create("Frame")({
        Name = "HintFrame",
        Size = UDim2.new(1, 0, 1, -5),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Parent = var19
    })

    local var21 = Create("ImageLabel")
    local tbl8 = {
        Name = "HintImage",
        Size = var4 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60),
        BackgroundTransparency = 1,
        Image = 0,
        Parent = 0
    }
    if var4 then
        image = str2 or image
    end

    tbl8.Image = image
    tbl8.Parent = var20
    var21(tbl8)

    local parent = Create("TextLabel")({
        Name = "HintText",
        Position = UDim2.new(0, if var4 then 100 else 70, 0, 0),
        Size = UDim2.new(1, -(if var4 then 100 else 70), 1, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = var4 and Enum.FontSize.Size36 or Enum.FontSize.Size24,
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = var20
    })
    Instance.new("UITextSizeConstraint", parent).MaxTextSize = parent.TextSize
end

local function resizeGamepadHintsFrame()
    var19.Size = UDim2.new(var5.Size.X.Scale, var5.Size.X.Offset, 0, if var4 then 95 else 60)
    var19.Position = UDim2.new(
        var5.Position.X.Scale,
        var5.Position.X.Offset,
        var7.Position.Y.Scale,
        var7.Position.Y.Offset - var19.Size.Y.Offset
    )
    local num6 = 0

    local children = var19:GetChildren()

    for i = 1, #children do
        children[i].Size = UDim2.new(1, 0, 1, -5)
        children[i].Position = UDim2.new(0, 0, 0, 0)
        num6 += children[i].HintText.Position.X.Offset + children[i].HintText.TextBounds.X
    end

    local var20 = (var19.AbsoluteSize.X - num6) / (#children - 1)
    for i = 1, #children do
        children[i].Position = i == 1 and UDim2.new(0, 0, 0, 0)
            or UDim2.new(0, children[i - 1].Position.X.Offset + children[i - 1].Size.X.Offset + var20, 0, 0)
        children[i].Size = UDim2.new(0, children[i].HintText.Position.X.Offset + children[i].HintText.TextBounds.X, 1, -5)
    end
end

addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonX.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonX@2x.png",
    "Remove From Hotbar"
)
addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonA@2x.png",
    "Select/Swap"
)
addGamepadHint(
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png",
    "rbxasset://textures/ui/Controls/DesignSystem/ButtonB@2x.png",
    "Close Backpack"
)
local var20 = NewGui("Frame", "Search")

var20.BackgroundColor3 = darkStoneGrey
var20.BackgroundTransparency = var3
var20.Size = UDim2.new(0, 190, 0, 30)
var20.Position = UDim2.new(1, -var20.Size.X.Offset - 5, 0, 5)
var20.Parent = var7

local var21 = NewGui("TextBox", "TextBox")
var21.Text = str1
var21.ClearTextOnFocus = false
var21.FontSize = Enum.FontSize.Size24
var21.TextXAlignment = Enum.TextXAlignment.Left
var21.Size = var20.Size - UDim2.new(0, 0, 0, 0)
var21.Position = UDim2.new(0, 0, 0, 0)
var21.Parent = var20

local var22 = NewGui("TextButton", "X")
var22.Text = "x"
var22.TextColor3 = mediumBlue
var22.FontSize = Enum.FontSize.Size24
var22.TextYAlignment = Enum.TextYAlignment.Bottom
var22.BackgroundColor3 = darkStoneGrey
var22.BackgroundTransparency = 0
var22.Size = UDim2.new(0, var20.Size.Y.Offset - 10, 0, var20.Size.Y.Offset - 10)
var22.Position = UDim2.new(1, -var22.Size.X.Offset - 10, 0.5, -var22.Size.Y.Offset / 2)
var22.ZIndex = 0
var22.Visible = false
var22.BorderSizePixel = 0
var22.Parent = var20

local function search()
    local tbl8 = {}
    for value in var21.Text:gmatch("%S+") do
        tbl8[value:lower()] = true
    end

    local tbl9 = {}
    for i = num4 + 1, #tbl2 do
        local var23 = tbl2[i]
        table.insert(tbl9, { var23, (var23:CheckTerms(tbl8)) })
        var23.Frame.Visible = false
        var23.Frame.Parent = var7
    end

    table.sort(tbl9, function(arg1, arg2): boolean
        return arg1[2] > arg2[2]
    end)
    bool8 = true

    local num6 = 0
    for _, value in ipairs(tbl9) do
        local var23 = value[1]

        if value[2] > 0 then
            var23.Frame.Visible = true
            var23.Frame.Parent = var10
            var23.Frame.LayoutOrder = num4 + num6
            num6 += 1
        end
    end

    var9.CanvasPosition = Vector2.new(0, 0)
    UpdateScrollingFrameCanvasSize()

    var22.ZIndex = 3
end

local function clearResults()
    if var22.ZIndex > 0 then
        bool8 = false
        for i = num4 + 1, #tbl2 do
            local var23 = tbl2[i]
            var23.Frame.LayoutOrder = var23.Index
            var23.Frame.Parent = var10
            var23.Frame.Visible = true
        end
        var22.ZIndex = 0
    end
    UpdateScrollingFrameCanvasSize()
end

local function reset() -- Luacid: Inlined by compiler; 2 call sites recovered
    clearResults()
    var21.Text = str1
end

local function onChanged(arg1)
    if arg1 ~= "Text" then
        return
    end

    local text = var21.Text
    if text == "" then
        clearResults()
    elseif text ~= str1 then
        search()
    end
    local var23 = var22
    var23.Visible = not (text == "") and text ~= str1
end

local function focusLost(enterPressed: boolean)
    if enterPressed then
        search()
    elseif var21.Text == "" then
        var21.Text = str1
    end
end

var21.Focused:connect(function() -- name: onFocused
    if var21.Text == str1 then
        var21.Text = ""
    end
end)

var22.MouseButton1Click:connect(reset)
var21.Changed:connect(onChanged)
var21.FocusLost:connect(focusLost)

module.StateChanged.Event:connect(function(modal)
    var22.Modal = modal
    if not modal then
        reset()
    end
end)

tbl4[Enum.KeyCode.Escape.Value] = function(arg1)
    if arg1 then
        reset()
        return
    end
    if var7.Visible then
        module.OpenClose()
    end
end

UserInputService.LastInputTypeChanged:connect(function(lastInputType: Enum.UserInputType) -- name: detectGamepad
    if lastInputType == Enum.UserInputType.Gamepad1 and not VRService.VREnabled then
        var20.Visible = false
        return
    end
    var20.Visible = true
end)

local function func2(_: string, userInputState: Enum.UserInputState, _inputObject: InputObject)
    if userInputState ~= Enum.UserInputState.Begin or not GuiService.SelectedCoreObject then
        return
    end

    for i = 1, num4 do
        if tbl2[i].Frame == GuiService.SelectedCoreObject and tbl2[i].Tool then
            tbl2[i]:MoveToInventory()
            return
        end
    end
end

local function openClose()
    if not next(tbl5) then
        var7.Visible = not var7.Visible
        local visible = var7.Visible
        AdjustHotbarFrames()
        var5.Active = not var5.Active
        for i = 1, num4 do
            tbl2[i]:SetClickability(not visible)
        end
    end

    if var7.Visible then
        if bool9 then
            if tbl1[UserInputService:GetLastInputType()] then
                resizeGamepadHintsFrame()
                var19.Visible = true
            end
            enableGamepadInventoryControl()
        end
    else
        if bool9 then
            var19.Visible = false
        end
        disableGamepadInventoryControl()
    end

    if var7.Visible then
        ContextActionService:BindAction("RBXRemoveSlot", func2, false, Enum.KeyCode.ButtonX)
    else
        ContextActionService:UnbindAction("RBXRemoveSlot")
    end

    module.IsOpen = var7.Visible
    module.StateChanged:Fire(var7.Visible)
end

tbl4[BackquoteValue] = function()
    if GuiService.MenuIsOpen then
        return
    end

    openClose()
end
module.OpenClose = openClose

while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end

LocalPlayer.CharacterAdded:connect(OnCharacterAdded)
if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character)
end

for i = 0, 9 do
    table.insert(tbl6, tostring(i))
end
table.insert(tbl6, "`")

UserInputService.InputBegan:connect(OnInputBegan)

UserInputService.TextBoxFocused:connect(function()
    bool7 = true
end)

UserInputService.TextBoxFocusReleased:connect(function()
    bool7 = false
end)

tbl4[BackspaceValue] = function()
    if var13 then
        UnequipAllTools()
    end
end

UserInputService.Changed:connect(OnUISChanged)
OnUISChanged("VREnabled")

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected()
end
UserInputService.GamepadConnected:connect(function(gamepadNum: Enum.UserInputType)
    if gamepadNum == Enum.UserInputType.Gamepad1 then
        gamepadConnected()
    end
end)
UserInputService.GamepadDisconnected:connect(function(gamepadNum: Enum.UserInputType)
    if gamepadNum == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected()
    end
end)

function module.TopbarEnabledChanged(_, arg1)
    bool2 = arg1

    OnCoreGuiChanged(Enum.CoreGuiType.Backpack, StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack))
end

if FFlagTopBarSignalizeSetCores then
    module.disposeEffect = Signals.createEffect(function(arg1)
        local getTopBarStore = InExperienceTopBar.Stores.GetTopBarStore
        if getTopBarStore then
            module:TopbarEnabledChanged(getTopBarStore(arg1).getTopBarCoreGuiEnabled(arg1))
        end
    end)
end

StarterGui.CoreGuiChangedSignal:connect(OnCoreGuiChanged)
local Backpack2 = Enum.CoreGuiType.Backpack
local Health = Enum.CoreGuiType.Health
OnCoreGuiChanged(Backpack2, StarterGui:GetCoreGuiEnabled(Backpack2))
OnCoreGuiChanged(Health, StarterGui:GetCoreGuiEnabled(Health))

if bool1 then
    SettingsShowSignal:connect(function(arg1)
        if arg1 then
            if module.IsHotbarVisible then
                AdjustHotbarFrames(true)
            end
        else
            AdjustHotbarFrames(false)
        end
    end)
end

GuiService.MenuOpened:Connect(function()
    if module.IsOpen and (not isInExperienceUIVREnabled or InExperienceUIVRIXP:isMovePanelToCenter() or not VRService.VREnabled) then
        module.OpenClose()
    end
end)

InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
    if arg1 and module.IsOpen then
        module.OpenClose()
    end
end)

local function OnPreferredTransparencyChanged()
    local preferredTransparency = UserGameSettings.PreferredTransparency

    var1 = 0.5 * UserGameSettings.PreferredTransparency
    var7.BackgroundTransparency = var1

    var2 = 0.5 * preferredTransparency
    for _, value in ipairs(tbl2) do
        value.Frame.BackgroundTransparency = var2
    end

    var3 = 0.15 * UserGameSettings.PreferredTransparency
    var20.BackgroundTransparency = var3
end
UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):connect(OnPreferredTransparencyChanged)

return module
