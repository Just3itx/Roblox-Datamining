-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BackpackParent = script:FindFirstAncestor("Backpack").Parent

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Modules = RobloxGui.Modules
local Signals = require(BackpackParent.Signals)
local InExperienceTopBar = require(BackpackParent.InExperienceTopBar)
local SettingsShowSignal = require(BackpackParent.CoreScriptsCommon).SettingsShowSignal

local InExperienceAppChatModal = require(BackpackParent.AppChat.InExperienceAppChatModal)
local FFlagMountCoreGuiBackpack = require(Modules.Flags.FFlagMountCoreGuiBackpack)
local isInExperienceUIVREnabled = require(BackpackParent.SharedExperimentDefinition).isInExperienceUIVREnabled
local InExperienceUIVRIXP = require(BackpackParent.SharedExperimentDefinition).InExperienceUIVRIXP

local FFlagTopBarSignalizeSetCores = InExperienceTopBar.Flags.FFlagTopBarSignalizeSetCores

local RobloxTranslator = require(BackpackParent.RobloxTranslator)
local Responsive = require(BackpackParent.Responsive)
local FFlagBackpackResponsiveUnits = require(BackpackParent.SharedFlags).FFlagBackpackResponsiveUnits
local System = require(BackpackParent.System)
local bool1 = game:DefineFastFlag("EnableHotbarHide", false)
local FFlagStudioDeviceSimVRSwitchFixes = require(BackpackParent.SharedFlags).FFlagStudioDeviceSimVRSwitchFixes

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
local FFlagResponsiveUnitsDeprecateTenFoot = require(BackpackParent.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local var4 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local Create = require(BackpackParent.AppCommonLib).Create
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
local var11 = nil
local uiGridLayout = nil
local var12 = nil
local var13 = nil

local currentCharacter = nil
local var14 = nil
local Backpack = nil

local tbl2 = ({})
local var15 = nil
local tbl3 = ({})
local tbl4 = ({})
local tbl5 = ({})
local num2 = 0
local var16 = nil
local bool5 = false
local bool6 = false
local bool7 = false
local bool8 = false
local tbl6 = {}
local tbl7 = {}
local tbl8 = {}
local bool9 = false
local num3 = 0

local num4 = if bool4 then 3 else 10
local num5 = if bool4 then 2 else 4

local var17 = nil
local functionToBind = nil

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
        local var18 = tbl2[i]
        if not var18.Tool then
            return var18
        end
    end
    return nil
end

local function isInventoryEmpty() -- Luacid: Inlined by compiler; 2 call sites recovered
    for i = num4 + 1, #tbl2 do
        local var18 = tbl2[i]
        if var18 and var18.Tool then
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
    if not var8 then
        return
    end
    local visible = var8.Visible
    local num6 = visible and num4 or num2
    local num7 = 0
    local isHotbarVisible = if bool1 then num6 >= 1 and not arg1 else num6 >= 1

    for i = 1, num4 do
        local var18 = tbl2[i]
        local var19 = if bool1 then var18.Tool and not arg1 else var18.Tool

        if var19 or visible then
            num7 += 1
            var18:Readjust(num7, num6)
            var18.Frame.Visible = true
        else
            var18.Frame.Visible = false
        end
    end

    if var6 then
        local var18 = var6
        local bool11 = not visible

        if bool11 then
            if isHotbarVisible then
                bool11 = isHotbarVisible
            else
                bool11 = not isInventoryEmpty()
            end
        end

        var18.Visible = bool11
        var6.Position = UDim2.new(0.5, -15, 1, if isHotbarVisible then -110 else -50)
    end
    module.IsHotbarVisible = isHotbarVisible
end

local function UpdateScrollingFrameCanvasSize()
    if not (var10 and var11) then
        return
    end
    local num6 = math.floor(var10.AbsoluteSize.X / (num1 + 5))
    local yOffset = math.ceil((#var11:GetChildren() - 1) / num6) * (num1 + 5) + 5
    var10.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local function AdjustInventoryFrames()
    for i = num4 + 1, #tbl2 do
        local var18 = tbl2[i]
        var18.Frame.LayoutOrder = var18.Index
        var18.Frame.Visible = var18.Tool ~= nil
    end
    UpdateScrollingFrameCanvasSize()
end

local function UpdateBackpackLayout()
    if not (var5 and var8) then
        return
    end
    var5.Size = UDim2.new(0, 5 + num4 * (num1 + 5), 0, num1 + 5 + 5)

    var5.Position = UDim2.new(0.5, -var5.Size.X.Offset / 2, 1, -var5.Size.Y.Offset)
    var8.Size = UDim2.new(0, var5.Size.X.Offset, 0, var5.Size.Y.Offset * num5 + 40)

    var8.Position = UDim2.new(0.5, -var8.Size.X.Offset / 2, 1, var5.Position.Y.Offset - var8.Size.Y.Offset)

    if var10 then
        var10.Size = UDim2.new(1, var10.ScrollBarThickness + 1, 1, -40)
        var10.Position = UDim2.new(0, 0, 0, 40)
    end
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

local function DisableActiveHopper() -- Luacid: Inlined by compiler; 12 call sites recovered
    var16:ToggleSelect()
    tbl3[var16]:UpdateEquipView()
    var16 = nil
end

local function UnequipAllTools() -- Luacid: Inlined by compiler; 10 call sites recovered
    if not var14 then
        return
    end

    var14:UnequipTools()
    if var16 then
        DisableActiveHopper()
    end
end

local function EquipNewTool(tool) -- Luacid: Inlined by compiler; 1 call site recovered
    UnequipAllTools()

    if tool:IsA("HopperBin") then
        tool:ToggleSelect()
        tbl3[tool]:UpdateEquipView()
        var16 = tool
        return
    end

    tool.Parent = currentCharacter
end

local function IsEquipped(tool) -- Luacid: Inlined by compiler; 5 call sites recovered
    return tool and (tool:IsA("HopperBin") and tool.Active or tool.Parent == currentCharacter)
end

local function MakeSlot(arg1, index)
    index = index or #tbl2 + 1

    local module2 = { Tool = nil, Index = index, Frame = nil }

    local var18 = nil
    local var19 = nil
    local var20 = nil
    local var21 = nil
    local connection = nil
    local var22 = nil

    local var23 = nil
    local var24 = nil

    local function UpdateSlotFading() -- Luacid: Inlined by compiler; 2 call sites recovered
        var18.SelectionImageObject = nil
        var18.BackgroundTransparency = if var18.Draggable then 0 else var2
        var18.BackgroundColor3 = var18.Draggable and black2 or black
    end

    function module2.Readjust(_, arg3, arg4)
        local var25 = var5.Size.X.Offset / 2
        local num6 = num1 + 5
        local var26 = arg3 - (arg4 / 2 + 0.5)
        var18.Position = UDim2.new(0, var25 - num1 / 2 + num6 * var26, 0, 5)
    end

    function module2.Fill(arg3, tool)
        if not tool then
            return arg3:Clear()
        end

        arg3.Tool = tool

        local function assignToolData()
            local textureId = tool.TextureId
            var20.Image = textureId

            if textureId ~= "" then
                var21.Visible = false
            else
                var21.Visible = true
            end

            GameTranslator:TranslateAndRegister(var21, tool, tool.Name)

            if var23 and tool:IsA("Tool") then
                GameTranslator:TranslateAndRegister(var23, tool, tool.ToolTip)
                local xOffset = var23.TextBounds.X + 6
                var23.Size = UDim2.new(0, xOffset, 0, 16)
                var23.Position = UDim2.new(0.5, -xOffset / 2, 0, -25)
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
        local visible = var8.Visible

        if not bool10 or visible then
            var18.Draggable = true
        end

        arg3:UpdateEquipView()

        if bool10 then
            num2 += 1

            if bool6 and num2 >= 1 and not bool3 then
                bool3 = true
                ContextActionService:BindAction("RBXHotbarEquip", functionToBind, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
            end
        end

        tbl3[tool] = arg3
        var15 = FindLowestEmpty()
    end

    function module2.Clear(arg3)
        if not arg3.Tool then
            return
        end

        if connection then
            connection:disconnect()
            connection = nil
        end

        var20.Image = ""
        var21.Text = ""
        if var23 then
            var23.Text = ""
            var23.Visible = false
        end
        var18.Draggable = false

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
        var15 = FindLowestEmpty()
    end

    function module2.UpdateEquipView(arg3, arg4)
        if not arg4 and IsEquipped(arg3.Tool) then
            var17 = module2
            if not var22 then
                var22 = NewGui("Frame", "Equipped")
                var22.ZIndex = var18.ZIndex

                for _, value in pairs({ { 0.1, 1, 0, 0 }, { 0.8, 0.1, 0.1, 0 }, { 0.1, 1, 0.9, 0 }, { 0.8, 0.1, 0.1, 0.9 } }) do
                    local var25 = NewGui("Frame", "Edge")
                    var25.BackgroundTransparency = 0
                    var25.BackgroundColor3 = mediumBlue
                    var25.Size = UDim2.new(value[1], 0, value[2], 0)
                    var25.Position = UDim2.new(value[3], 0, value[4], 0)
                    var25.ZIndex = var22.ZIndex
                    var25.Parent = var22
                end
            end
            var22.Parent = var18
        elseif var22 then
            var22.Parent = nil
        end

        UpdateSlotFading()
    end

    function module2.IsEquipped(arg3)
        return (IsEquipped(arg3.Tool))
    end

    function module2.Delete(arg3)
        tbl5[var18] = nil
        var18:Destroy()
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
        var18.Name = arg3.Index
        var18.LayoutOrder = arg3.Index
    end

    function module2.TurnNumber(_, visible)
        if var24 then
            var24.Visible = visible
        end
    end

    function module2.SetClickability(arg3, arg4)
        if arg3.Tool then
            var18.Draggable = not arg4
            UpdateSlotFading()
        end
    end

    function module2.CheckTerms(arg3, arg4): number
        local num6 = 0
        local function checkEm(text, arg5) -- Luacid: Inlined by compiler; 2 call sites recovered
            local _, var25 = text:lower():gsub(arg5, "")
            num6 += var25
        end
        local tool = arg3.Tool
        if tool then
            for k in pairs(arg4) do
                checkEm(var21.Text, k)
                if tool:IsA("Tool") then
                    checkEm(var23 and var23.Text or "", k)
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
            UnequipAllTools()
            return
        end

        if tool.Parent == Backpack then
            EquipNewTool(tool)
        end
    end

    var18 = NewGui("TextButton", index)
    var18.BackgroundColor3 = black
    var18.BorderColor3 = white
    var18.Text = ""
    var18.AutoButtonColor = false
    var18.BorderSizePixel = 0
    local uDim2 = UDim2.new(0, num1, 0, num1)
    var18.Size = uDim2
    var18.Active = true
    var18.Draggable = false
    var18.BackgroundTransparency = var2
    var18.MouseButton1Click:connect(function()
        changeSlot(module2)
    end)
    module2.Frame = var18

    local var25 = NewGui("Frame", "SelectionObjectClipper")
    var25.Visible = false
    var25.Parent = var18

    local var26 = NewGui("ImageLabel", "Selector")
    var26.Size = UDim2.new(1, 0, 1, 0)
    var26.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
    var26.ScaleType = Enum.ScaleType.Slice
    var26.SliceCenter = Rect.new(12, 12, 52, 52)
    var26.Parent = var25

    var20 = NewGui("ImageLabel", "Icon")
    local uDim2_2 = UDim2.new(0.8, 0, 0.8, 0)
    var20.Size = uDim2_2
    local uDim2_3 = UDim2.new(0.1, 0, 0.1, 0)
    var20.Position = uDim2_3
    var20.Parent = var18

    var21 = NewGui("TextLabel", "ToolName")
    local uDim2_4 = UDim2.new(1, -2, 1, -2)
    var21.Size = uDim2_4
    local uDim2_5 = UDim2.new(0, 1, 0, 1)
    var21.Position = uDim2_5
    var21.Parent = var18

    module2.Frame.LayoutOrder = module2.Index

    if index <= num4 then
        var23 = NewGui("TextLabel", "ToolTip")
        var23.TextWrapped = false
        local top = Enum.TextYAlignment.Top
        var23.TextYAlignment = top
        local flint = Color3.new(0.4, 0.4, 0.4)
        var23.BackgroundColor3 = flint
        var23.BackgroundTransparency = 0
        var23.Visible = false
        var23.Parent = var18
        var18.MouseEnter:connect(function()
            if var23.Text ~= "" then
                var23.Visible = true
            end
        end)
        var18.MouseLeave:connect(function()
            var23.Visible = false
        end)

        function module2.MoveToInventory(arg3)
            if not (module2.Index <= num4) then
                return
            end

            local tool = module2.Tool
            arg3:Clear()
            local slot = MakeSlot(var11)
            slot:Fill(tool)

            if IsEquipped(tool) then
                UnequipAllTools()
            end

            if bool8 then
                slot.Frame.Visible = false
                slot.Parent = var8
            end
        end

        if index < 10 or index == num4 then
            local var27 = index < 10 and index or 0
            var24 = NewGui("TextLabel", "Number")
            var24.Text = var27
            local uDim2_6 = UDim2.new(0.15, 0, 0.15, 0)
            var24.Size = uDim2_6
            var24.Visible = false
            var24.Parent = var18

            tbl4[ZeroValue + var27] = function(arg3)
                module2:Select(arg3)
            end
        end
    end

    local position = var18.Position
    local num6 = 0
    local parent = nil

    var18.DragBegin:connect(function(initialPosition: UDim2)
        tbl5[var18] = true
        position = initialPosition

        var18.BorderSizePixel = 2

        var18.ZIndex = 2
        var20.ZIndex = 2
        var21.ZIndex = 2
        var18.Parent.ZIndex = 2
        if var24 then
            var24.ZIndex = 2
        end
        if var22 then
            var22.ZIndex = 2
            for _, child in pairs(var22:GetChildren()) do
                child.ZIndex = 2
            end
        end

        parent = var18.Parent
        if parent ~= var11 then
            return
        end

        local _absolutePosition = var18.AbsolutePosition
        local uDim2_6 = UDim2.new(0, var18.AbsolutePosition.X - var8.AbsolutePosition.X, 0, var18.AbsolutePosition.Y - var8.AbsolutePosition.Y)

        var18.Parent = var8
        var18.Position = uDim2_6

        var19 = NewGui("Frame", "FakeSlot")
        var19.LayoutOrder = var18.LayoutOrder
        var19.Size = var18.Size
        var19.BackgroundTransparency = 1
        var19.Parent = var11
    end)

    var18.DragStopped:connect(function(x: number, y: number)
        if var19 then
            var19:Destroy()
        end

        local var27 = tick()
        var18.Position = position
        var18.Parent = parent

        var18.BorderSizePixel = 0

        var18.ZIndex = 1
        var20.ZIndex = 1
        var21.ZIndex = 1
        parent.ZIndex = 1
        if var24 then
            var24.ZIndex = 1
        end
        if var22 then
            var22.ZIndex = 1
            for _, child in pairs(var22:GetChildren()) do
                child.ZIndex = 1
            end
        end

        tbl5[var18] = nil

        if not module2.Tool then
            return
        end

        if CheckBounds(var8, x, y) then
            if module2.Index <= num4 then
                module2:MoveToInventory()
            end

            local index = module2.Index

            if num4 < index and var27 - num6 < 0.5 then
                if var15 then
                    local tool = module2.Tool
                    module2:Clear()
                    var15:Fill(tool)
                    module2:Delete()
                    var27 = 0
                else
                    var27 = 0
                end
            end
        elseif CheckBounds(var5, x, y) then
            local tbl9 = { math.huge, nil }
            for i = 1, num4 do
                local var28 = tbl2[i]
                local offset = GetOffset(var28.Frame, Vector2.new(x, y))
                if offset < tbl9[1] then
                    tbl9 = { offset, var28 }
                end
            end

            local var28 = tbl9[2]
            if var28 ~= module2 then
                module2:Swap(var28)
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
                            module2.Frame.Parent = var8
                        end
                    end
                end
            end
        elseif module2.Index <= num4 then
            module2:MoveToInventory()
        end

        num6 = var27
    end)

    var18.Parent = arg1
    tbl2[index] = module2

    if num4 < index then
        UpdateScrollingFrameCanvasSize()

        if var10 and var8.Visible and not bool8 then
            local var27 = var10.CanvasSize.Y.Offset - var10.AbsoluteSize.Y
            var10.CanvasPosition = Vector2.new(0, math.max(0, var27))
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
            local var18 = tbl2[i]
            if var18 then
                var18:MoveToInventory()
                var18:Delete()
            end
        end

        for i = num6, arg1 + 1, -1 do
            local var18 = tbl2[i]
            if not var18.Tool then
                var18:Delete()
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
                    var15 = var15 or slot
                end
            else
                local slot = MakeSlot(var5, i)

                slot.Frame.Visible = false

                var15 = var15 or slot
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
    if not selectionParent then
        return
    end

    if not (arg1:IsA("Tool") or arg1:IsA("HopperBin")) then
        if arg1:IsA("Humanoid") and arg1.Parent == currentCharacter then
            var14 = arg1
        end

        return
    end

    if arg1.Parent == currentCharacter then
        num3 = tick()
    end

    if var16 and arg1.Parent == currentCharacter then
        DisableActiveHopper()
    end

    if not bool5 and arg1.Parent == currentCharacter and not tbl3[arg1] then
        local starterGear = LocalPlayer:FindFirstChild("StarterGear")
        if starterGear and starterGear:FindFirstChild(arg1.Name) then
            bool5 = true
            for i = (var15 or MakeSlot(var11)).Index, 1, -1 do
                local var18 = tbl2[i]
                local num6 = i - 1
                if num6 > 0 then
                    tbl2[num6]:Swap(var18)
                else
                    var18:Fill(arg1)
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

    local var18 = tbl3[arg1]
    if var18 then
        var18:UpdateEquipView()
    else
        local var19 = var15 or MakeSlot(var11)
        var19:Fill(arg1)
        if var19.Index <= num4 and not var8.Visible then
            AdjustHotbarFrames()
        end
        if arg1:IsA("HopperBin") and arg1.Active then
            UnequipAllTools()
            var16 = arg1
        end
    end

    module.BackpackItemAdded:Fire()
end

local function OnChildRemoved(child: Instance)
    if not selectionParent or not child:IsA("Tool") and not child:IsA("HopperBin") then
        return
    end

    num3 = tick()

    local childParent = child.Parent
    if childParent == currentCharacter or childParent == Backpack then
        return
    end

    local var18 = tbl3[child]
    if var18 then
        var18:Clear()
        if var18.Index > num4 then
            var18:Delete()
        elseif not var8.Visible then
            AdjustHotbarFrames()
        end
    end

    if child == var16 then
        var16 = nil
    end

    module.BackpackItemRemoved:Fire()

    if isInventoryEmpty() then
        module.BackpackEmpty:Fire()
    end
end

local function OnCharacterAdded(character: Model)
    for i = #tbl2, 1, -1 do
        local var18 = tbl2[i]
        if var18.Tool then
            var18:Clear()
        end
        if num4 < i then
            var18:Delete()
        end
    end
    var16 = nil

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
        local var18 = tbl4[input.KeyCode.Value]
        if var18 then
            var18(gameProcessedEvent)
        end
    end

    local userInputType = input.UserInputType
    if not gameProcessedEvent
        and (userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch)
        and var8
        and var8.Visible
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

local var18 = nil
local var19 = nil

local function func1() end
local vector2 = Vector2.new(0, 0)

function unbindAllGamepadEquipActions()
    ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
    ContextActionService:UnbindAction("RBXCloseInventory")
end

local function setHotbarVisibility(visible, arg1) -- Luacid: unused: defined but never referenced
    for i = 1, num4 do
        local var20 = tbl2[i]
        if var20 and var20.Frame and (arg1 or var20.Tool) then
            var20.Frame.Visible = visible
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

    local var20 = tbl2[num8]
    if var20 and var20.Tool and not var20:IsEquipped() then
        var20:Select()
    end
end

functionToBind = function(_: string, userInputState: Enum.UserInputState, inputObject: InputObject)
    if userInputState ~= Enum.UserInputState.Begin then
        return
    end

    if var18
        and (var18.KeyCode == Enum.KeyCode.ButtonR1 and inputObject.KeyCode == Enum.KeyCode.ButtonL1
            or var18.KeyCode == Enum.KeyCode.ButtonL1 and inputObject.KeyCode == Enum.KeyCode.ButtonR1)
        and tick() - var19 <= 0.06
    then
        UnequipAllTools()
        var18 = inputObject
        var19 = tick()
        return
    end

    var18 = inputObject
    var19 = tick()

    delay(0.06, function()
        if var18 ~= inputObject then
            return
        end

        local num6 = if inputObject.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

        for i = 1, num4 do
            local var20 = tbl2[i]
            if not var20 then
                return
            end
            if not var20:IsEquipped() then
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
                var17 = nil
                return
            end
            tbl2[num7]:Select()

            return
        end

        if var17 and var17.Tool then
            var17:Select()
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
        if var9 and var9.SelectionImageObject then
            var9.SelectionImageObject.Visible = false
        end

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
        if var9 and var9.SelectionImageObject then
            var9.SelectionImageObject.Visible = true
        end

        return
    end

    gamepadSwapSlot.Frame.BorderSizePixel = 0
    if gamepadSwapSlot == arg1 then
        return
    end

    arg1:Swap(gamepadSwapSlot)
    if var9 and var9.SelectionImageObject then
        var9.SelectionImageObject.Visible = false
    end

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
        elseif var8 and var8.Visible then
            module.OpenClose()
        end
    end

    ContextActionService:BindAction("RBXBackpackHasGamepadFocus", func1, false, Enum.UserInputType.Gamepad1)
    ContextActionService:BindAction("RBXCloseInventory", func2, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

    if not UseGazeSelection() and var5 then
        GuiService.SelectedCoreObject = var5:FindFirstChild("1")
    end
end

function disableGamepadInventoryControl()
    unbindAllGamepadEquipActions()

    for i = 1, num4 do
        local var20 = tbl2[i]
        if var20 and var20.Frame then
            var20.Frame.BorderSizePixel = 0
        end
    end

    if selectionParent and GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(selectionParent) then
        GuiService.SelectedCoreObject = nil
    end
end

local function bindBackpackHotbarAction() -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool6 and not bool3 then
        bool3 = true
        ContextActionService:BindAction("RBXHotbarEquip", functionToBind, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
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
    if selectionParent then
        if FFlagStudioDeviceSimVRSwitchFixes then
            GuiService:RemoveSelectionGroup("RBXBackpackSelection")
        end
        GuiService:AddSelectionParent("RBXBackpackSelection", selectionParent)
    end

    if num2 >= 1 then
        bindBackpackHotbarAction()
    end

    if var8 and var8.Visible then
        enableGamepadInventoryControl()
    end
end

local function setBackpackEnabled(arg1)
    arg1 = arg1 and bool2
    bool6 = arg1
    if selectionParent then
        if FFlagMountCoreGuiBackpack then
            if arg1 then
                selectionParent.Parent = RobloxGui
            else
                selectionParent.Parent = nil
            end
        else
            selectionParent.Visible = arg1
        end
    end

    for _, value in pairs(tbl6) do
        if arg1 then
            GuiService:AddKey(value)
        else
            GuiService:RemoveKey(value)
        end
    end

    if not arg1 then
        unbindBackpackHotbarAction()
        return
    end

    if num2 >= 1 then
        bindBackpackHotbarAction()
    end
end

local function MakeVRRoundButton(name: string, image: string)
    local var20 = NewGui("ImageButton", name)
    var20.Size = UDim2.new(0, 40, 0, 40)
    var20.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"

    local var21 = NewGui("ImageLabel", "Icon")
    var21.Size = UDim2.new(0.5, 0, 0.5, 0)
    var21.Position = UDim2.new(0.25, 0, 0.25, 0)
    var21.Image = image
    var21.Parent = var20

    local selectionImageObject = NewGui("ImageLabel", "Selection")
    selectionImageObject.Size = UDim2.new(0.9, 0, 0.9, 0)
    selectionImageObject.Position = UDim2.new(0.05, 0, 0.05, 0)
    selectionImageObject.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
    var20.SelectionImageObject = selectionImageObject

    return var20, var21, selectionImageObject
end

function module.createGui()
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

        var15 = var15 or slot
    end

    var6 = NewGui("ImageButton", "OpenInventory")

    var6.Size = UDim2.new(0, 30, 0, 30)
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
    local selectionImageObject = NewGui("Frame", "Selection")
    selectionImageObject.Visible = false
    var6.SelectionImageObject = selectionImageObject

    var7 = MakeVRRoundButton("CloseInventory", "rbxasset://textures/ui/Keyboard/close_button_icon.png")
    var7.Position = UDim2.new(0, 0, 0, -50)
    var7.MouseButton1Click:connect(function()
        if var8.Visible then
            module.OpenClose()
        end
    end)

    local var21 = NewGui("ImageLabel", "LeftBumper")
    var21.Size = UDim2.new(0, 40, 0, 40)
    var21.Position = UDim2.new(0, -var21.Size.X.Offset, 0.5, -var21.Size.Y.Offset / 2)

    local var22 = NewGui("ImageLabel", "RightBumper")
    var22.Size = UDim2.new(0, 40, 0, 40)
    var22.Position = UDim2.new(1, 0, 0.5, -var22.Size.Y.Offset / 2)

    var8 = NewGui("Frame", "Inventory")
    var8.BackgroundTransparency = var1
    var8.BackgroundColor3 = black
    var8.Active = true
    var8.Visible = false
    var8.Parent = selectionParent

    var9 = NewGui("TextButton", "VRInventorySelector")
    var9.Position = UDim2.new(0, 0, 0, 0)
    var9.Size = UDim2.new(1, 0, 1, 0)
    var9.BackgroundTransparency = 1
    var9.Text = ""
    var9.Parent = var8

    local var20 = NewGui("ImageLabel", "Selector")
    var20.Size = UDim2.new(1, 0, 1, 0)
    var20.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
    var20.ScaleType = Enum.ScaleType.Slice
    var20.SliceCenter = Rect.new(12, 12, 52, 52)
    var20.Visible = false
    var9.SelectionImageObject = var20

    var10 = NewGui("ScrollingFrame", "ScrollingFrame")
    var10.Selectable = false
    var10.CanvasSize = UDim2.new(0, 0, 0, 0)
    var10.Parent = var8

    var11 = NewGui("Frame", "UIGridFrame")
    var11.Selectable = false
    var11.Size = UDim2.new(1, -10, 1, 0)
    var11.Position = UDim2.new(0, 5, 0, 0)
    var11.Parent = var10

    uiGridLayout = Instance.new("UIGridLayout")
    uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiGridLayout.CellSize = UDim2.new(0, num1, 0, num1)
    uiGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
    uiGridLayout.Parent = var11

    var12 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
    var12.Size = UDim2.new(0, 34, 0, 34)
    var12.Position = UDim2.new(0.5, -var12.Size.X.Offset / 2, 0, 43)
    var12.Icon.Position = var12.Icon.Position - UDim2.new(0, 0, 0, 2)
    var12.MouseButton1Click:connect(function()
        if not var10 then
            return
        end
        var10.CanvasPosition = Vector2.new(
            var10.CanvasPosition.X,
            (Clamp(0, var10.CanvasSize.Y.Offset - var10.AbsoluteWindowSize.Y, var10.CanvasPosition.Y - (num1 + 5)))
        )
    end)

    var13 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
    var13.Rotation = 180
    var13.Icon.Position = var13.Icon.Position - UDim2.new(0, 0, 0, 2)
    var13.Size = UDim2.new(0, 34, 0, 34)
    var13.Position = UDim2.new(0.5, -var13.Size.X.Offset / 2, 1, -var13.Size.Y.Offset - 3)
    var13.MouseButton1Click:connect(function()
        if not var10 then
            return
        end
        var10.CanvasPosition = Vector2.new(
            var10.CanvasPosition.X,
            (Clamp(0, var10.CanvasSize.Y.Offset - var10.AbsoluteWindowSize.Y, var10.CanvasPosition.Y + (num1 + 5)))
        )
    end)

    var10.Changed:connect(function(arg1)
        if not var10 then
            return
        end
        if arg1 == "AbsoluteWindowSize" or arg1 == "CanvasPosition" or arg1 == "CanvasSize" then
            local bool10 = var10.CanvasPosition.Y ~= 0
            local bool11 = var10.CanvasPosition.Y < var10.CanvasSize.Y.Offset - var10.AbsoluteWindowSize.Y

            var12.Visible = bool10
            var13.Visible = bool11
        end
    end)

    UpdateBackpackLayout()

    local var24 = Create("Frame")({
        Name = "GamepadHintsFrame",
        Size = UDim2.new(0, var5.Size.X.Offset, 0, if var4 then 95 else 60),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = selectionParent
    })

    local function addGamepadHint(image: string, str3: string, text: string)
        local var25 = Create("Frame")({
            Name = "HintFrame",
            Size = UDim2.new(1, 0, 1, -5),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Parent = var24
        })

        local var26 = Create("ImageLabel")
        local tbl9 = {
            Name = "HintImage",
            Size = var4 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60),
            BackgroundTransparency = 1,
            Image = 0,
            Parent = 0
        }
        if var4 then
            image = str3 or image
        end

        tbl9.Image = image
        tbl9.Parent = var25
        var26(tbl9)

        local var27 = Create("TextLabel")({
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
            Parent = var25
        })
        local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")
        uiTextSizeConstraint.Parent = var27
        uiTextSizeConstraint.MaxTextSize = var27.TextSize
    end

    local function resizeGamepadHintsFrame()
        if not (var5 and var8) then
            return
        end
        var24.Size = UDim2.new(var5.Size.X.Scale, var5.Size.X.Offset, 0, if var4 then 95 else 60)
        var24.Position = UDim2.new(
            var5.Position.X.Scale,
            var5.Position.X.Offset,
            var8.Position.Y.Scale,
            var8.Position.Y.Offset - var24.Size.Y.Offset
        )

        local num6 = 0

        local children = var24:GetChildren()

        for i = 1, #children do
            children[i].Size = UDim2.new(1, 0, 1, -5)
            children[i].Position = UDim2.new(0, 0, 0, 0)

            num6 += children[i].HintText.Position.X.Offset + children[i].HintText.TextBounds.X
        end

        local var25 = (var24.AbsoluteSize.X - num6) / (#children - 1)
        for i = 1, #children do
            children[i].Position = i == 1 and UDim2.new(0, 0, 0, 0)
                or UDim2.new(0, children[i - 1].Position.X.Offset + children[i - 1].Size.X.Offset + var25, 0, 0)

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

    local var25 = NewGui("Frame", "Search")

    var25.BackgroundColor3 = darkStoneGrey
    var25.BackgroundTransparency = var3
    var25.Size = UDim2.new(0, 190, 0, 30)
    var25.Position = UDim2.new(1, -var25.Size.X.Offset - 5, 0, 5)
    var25.Parent = var8

    local var26 = NewGui("TextBox", "TextBox")
    var26.Text = str1
    var26.ClearTextOnFocus = false
    var26.FontSize = Enum.FontSize.Size24
    var26.TextXAlignment = Enum.TextXAlignment.Left
    var26.Size = var25.Size - UDim2.new(0, 0, 0, 0)
    var26.Position = UDim2.new(0, 0, 0, 0)
    var26.Parent = var25

    local var27 = NewGui("TextButton", "X")
    var27.Text = "x"
    var27.TextColor3 = mediumBlue
    var27.FontSize = Enum.FontSize.Size24
    var27.TextYAlignment = Enum.TextYAlignment.Bottom
    var27.BackgroundColor3 = darkStoneGrey
    var27.BackgroundTransparency = 0
    var27.Size = UDim2.new(0, var25.Size.Y.Offset - 10, 0, var25.Size.Y.Offset - 10)

    var27.Position = UDim2.new(1, -var27.Size.X.Offset - 10, 0.5, -var27.Size.Y.Offset / 2)
    var27.ZIndex = 0
    var27.Visible = false
    var27.BorderSizePixel = 0
    var27.Parent = var25

    local function search()
        local tbl9 = {}
        for value in var26.Text:gmatch("%S+") do
            tbl9[value:lower()] = true
        end

        local tbl10 = {}
        for i = num4 + 1, #tbl2 do
            local var28 = tbl2[i]
            table.insert(tbl10, { var28, (var28:CheckTerms(tbl9)) })
            var28.Frame.Visible = false
            var28.Frame.Parent = var8
        end

        table.sort(tbl10, function(arg1, arg2): boolean
            return arg1[2] > arg2[2]
        end)
        bool8 = true

        local num6 = 0
        for _, value in ipairs(tbl10) do
            local var28 = value[1]

            if value[2] > 0 then
                var28.Frame.Visible = true
                var28.Frame.Parent = var11
                var28.Frame.LayoutOrder = num4 + num6
                num6 += 1
            end
        end

        if var10 then
            var10.CanvasPosition = Vector2.new(0, 0)
        end
        UpdateScrollingFrameCanvasSize()

        var27.ZIndex = 3
    end

    local function clearResults()
        if var27.ZIndex > 0 then
            bool8 = false
            for i = num4 + 1, #tbl2 do
                local var28 = tbl2[i]
                var28.Frame.LayoutOrder = var28.Index
                var28.Frame.Parent = var11
                var28.Frame.Visible = true
            end
            var27.ZIndex = 0
        end
        UpdateScrollingFrameCanvasSize()
    end

    local function reset() -- Luacid: Inlined by compiler; 2 call sites recovered
        clearResults()
        var26.Text = str1
    end

    local function onChanged(arg1)
        if arg1 ~= "Text" then
            return
        end

        local text = var26.Text
        if text == "" then
            clearResults()
        elseif text ~= str1 then
            search()
        end
        local var28 = var27
        var28.Visible = not (text == "") and text ~= str1
    end

    local function focusLost(enterPressed: boolean)
        if enterPressed then
            search()
        elseif var26.Text == "" then
            var26.Text = str1
        end
    end

    var26.Focused:connect(function() -- name: onFocused
        if var26.Text == str1 then
            var26.Text = ""
        end
    end)

    var27.MouseButton1Click:connect(reset)
    var26.Changed:connect(onChanged)
    var26.FocusLost:connect(focusLost)

    local tbl9 = tbl8
    local event = module.StateChanged.Event

    table.insert(tbl9, event:connect(function(modal)
        var27.Modal = modal
        if not modal then
            reset()
        end
    end))

    tbl4[Enum.KeyCode.Escape.Value] = function(arg1)
        if arg1 then
            reset()
            return
        end
        if var8 and var8.Visible then
            module.OpenClose()
        end
    end

    local function detectGamepad(lastInputType: Enum.UserInputType)
        if lastInputType == Enum.UserInputType.Gamepad1 and not VRService.VREnabled then
            var25.Visible = false
            return
        end
        var25.Visible = true
    end

    table.insert(tbl8, UserInputService.LastInputTypeChanged:connect(detectGamepad))

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
        if not var8 then
            return
        end
        if not next(tbl5) then
            var8.Visible = not var8.Visible
            local visible = var8.Visible
            AdjustHotbarFrames()
            var5.Active = not var5.Active
            for i = 1, num4 do
                tbl2[i]:SetClickability(not visible)
            end
        end

        if var8.Visible then
            if bool9 then
                if tbl1[UserInputService:GetLastInputType()] then
                    resizeGamepadHintsFrame()
                    var24.Visible = true
                end
                enableGamepadInventoryControl()
            end
        else
            if bool9 then
                var24.Visible = false
            end
            disableGamepadInventoryControl()
        end

        if var8.Visible then
            ContextActionService:BindAction("RBXRemoveSlot", func2, false, Enum.KeyCode.ButtonX)
        else
            ContextActionService:UnbindAction("RBXRemoveSlot")
        end

        module.IsOpen = var8.Visible
        module.StateChanged:Fire(var8.Visible)
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

    table.insert(tbl8, LocalPlayer.CharacterAdded:connect(OnCharacterAdded))
    if LocalPlayer.Character then
        OnCharacterAdded(LocalPlayer.Character)
    end

    for i = 0, 9 do
        table.insert(tbl6, tostring(i))
    end
    table.insert(tbl6, "`")

    table.insert(tbl8, UserInputService.InputBegan:connect(OnInputBegan))

    local tbl10 = tbl8
    local textBoxFocused = UserInputService.TextBoxFocused

    table.insert(tbl10, textBoxFocused:connect(function()
        bool7 = true
    end))

    local tbl11 = tbl8
    local textBoxFocusReleased = UserInputService.TextBoxFocusReleased

    table.insert(tbl11, textBoxFocusReleased:connect(function()
        bool7 = false
    end))

    tbl4[BackspaceValue] = function()
        if var16 then
            UnequipAllTools()
        end
    end

    table.insert(tbl8, UserInputService.Changed:connect(OnUISChanged))
    OnUISChanged("VREnabled")

    if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
        gamepadConnected()
    end

    local tbl12 = tbl8
    local gamepadConnected2 = UserInputService.GamepadConnected

    table.insert(tbl12, gamepadConnected2:connect(function(gamepadNum: Enum.UserInputType)
        if gamepadNum == Enum.UserInputType.Gamepad1 then
            gamepadConnected()
        end
    end))

    local tbl13 = tbl8
    local gamepadDisconnected2 = UserInputService.GamepadDisconnected

    table.insert(tbl13, gamepadDisconnected2:connect(function(gamepadNum: Enum.UserInputType)
        if gamepadNum == Enum.UserInputType.Gamepad1 then
            gamepadDisconnected()
        end
    end))

    if bool1 then
        table.insert(tbl8, SettingsShowSignal:connect(function(arg1)
            if arg1 then
                if module.IsHotbarVisible then
                    AdjustHotbarFrames(true)
                end
            else
                AdjustHotbarFrames(false)
            end
        end))
    end

    local tbl14 = tbl8
    local menuOpened = GuiService.MenuOpened

    table.insert(tbl14, menuOpened:Connect(function()
        if module.IsOpen and (not isInExperienceUIVREnabled or InExperienceUIVRIXP:isMovePanelToCenter() or not VRService.VREnabled) then
            module.OpenClose()
        end
    end))

    local tbl15 = tbl8
    local event2 = InExperienceAppChatModal.default.visibilitySignal.Event

    table.insert(tbl15, event2:Connect(function(arg1)
        if arg1 and module.IsOpen then
            module.OpenClose()
        end
    end))

    local function OnPreferredTransparencyChanged()
        local preferredTransparency = UserGameSettings.PreferredTransparency

        var1 = 0.5 * UserGameSettings.PreferredTransparency
        if var8 then
            var8.BackgroundTransparency = var1
        end

        var2 = 0.5 * preferredTransparency
        for _, value in ipairs(tbl2) do
            value.Frame.BackgroundTransparency = var2
        end

        var3 = 0.15 * UserGameSettings.PreferredTransparency
        var25.BackgroundTransparency = var3
    end
    table.insert(
        tbl8,
        UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):connect(OnPreferredTransparencyChanged)
    )
end

function module.destroyGui()
    for _, value in pairs(tbl8) do
        value:disconnect()
    end
    table.clear(tbl8)

    for _, value in pairs(tbl7) do
        value:disconnect()
    end
    table.clear(tbl7)

    ContextActionService:UnbindAction("RBXHotbarEquip")
    ContextActionService:UnbindAction("RBXRemoveSlot")
    unbindAllGamepadEquipActions()

    for i = #tbl2, 1, -1 do
        local var20 = tbl2[i]
        if var20.Tool then
            var20:Clear()
        end
    end
    table.clear(tbl2)
    table.clear(tbl3)
    table.clear(tbl4)
    table.clear(tbl5)
    table.clear(tbl6)

    if selectionParent then
        selectionParent:Destroy()
        selectionParent = nil
    end

    var5 = nil
    var6 = nil
    var7 = nil
    var8 = nil
    var9 = nil
    var10 = nil
    var11 = nil
    uiGridLayout = nil
    var12 = nil
    var13 = nil

    currentCharacter = nil
    var14 = nil
    Backpack = nil
    var15 = nil
    num2 = 0
    var16 = nil
    bool5 = false
    bool6 = false
    bool7 = false
    bool8 = false
    bool9 = false
    bool3 = false
    num3 = 0
    var17 = nil
    module.OpenClose = nil
    module.IsOpen = false
    module.IsHotbarVisible = false
end

function module.TopbarEnabledChanged(_, arg1)
    bool2 = arg1
    setBackpackEnabled(StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack))
end

if FFlagTopBarSignalizeSetCores then
    module.disposeEffect = Signals.createEffect(function(arg1)
        local getTopBarStore = InExperienceTopBar.Stores.GetTopBarStore
        if getTopBarStore then
            module:TopbarEnabledChanged(getTopBarStore(arg1).getTopBarCoreGuiEnabled(arg1))
        end
    end)
end

local Features = System.Features
local lifecycle = Features.registerLifecycle(
    Features.FeatureName.Backpack,
    {
        defaultVisible = false,
        coreGuiType = Enum.CoreGuiType.Backpack
    }
).lifecycle

lifecycle:onEnabledChanged(function(arg1)
    if arg1 then
        module.createGui()
    else
        module.destroyGui()
    end
    setBackpackEnabled(arg1)
end)

lifecycle:onVisibilityChanged(function(isOpen): boolean
    if module.OpenClose and module.IsOpen ~= isOpen then
        module.OpenClose()
    end

    return module.IsOpen
end)

module.StateChanged.Event:connect(function(arg1)
    if lifecycle then
        lifecycle.setVisible(arg1)
    end
end)

return module
