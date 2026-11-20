-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local _UserInputService = game:GetService("UserInputService")
local _GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local ContextActionService = game:GetService("ContextActionService")
local _Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TextService = game:GetService("TextService")
local CorePackages = game:GetService("CorePackages")

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local black = Color3.new(49 / 255, 49 / 255, 49 / 255)
local black2 = Color3.new(49 / 255, 49 / 255, 49 / 255)
local cyan = Color3.new(0, 54 / 85, 1)
local cyan2 = Color3.new(0, 54 / 85, 1)

local white = Color3.new(1, 1, 1)

local var1 = HttpService:JSONDecode(
    "[\n  [\n    {\n      \"a\": 7,\n      \"w\": 0.8\n    },\n    \"*\",\n    \"Q\",\n    \"W\",\n    \"E\",\n    \"R\",\n    \"T\",\n    \"Y\",\n    \"U\",\n    \"I\",\n    \"O\",\n    \"P\",\n    {\n      \"w\": 1.8\n    },\n    \"Delete\"\n  ],\n  [\n    {\n      \"w\": 1.6\n    },\n    \"Caps\",\n    \"A\",\n    \"S\",\n    \"D\",\n    \"F\",\n    \"G\",\n    \"H\",\n    \"J\",\n    \"K\",\n    \"L\",\n    \"?\",\n    {\n      \"h\": 2,\n      \"w2\": 2.4,\n      \"h2\": 1,\n      \"x2\": -1.4,\n      \"y2\": 1\n    },\n    \"Enter\"\n  ],\n  [\n    {\n      \"w\": 2.2\n    },\n    \"Shift\",\n    \"Z\",\n    \"X\",\n    \"C\",\n    \"V\",\n    \"B\",\n    \"N\",\n    \"M\",\n    \".\"\n  ],\n  [\n    {\n      \"w\": 2.2\n    },\n    \"123/sym\",\n    {\n      \"w\": 8\n    },\n    \"\",\n    {\n      \"w\": 2.4\n    },\n    \"<Speaker>\"\n  ]\n]\n"
)

local var2 = HttpService:JSONDecode(
    "[\n  [\n    {\n      \"a\": 7,\n      \"w\": 0.8\n    },\n    \"*\",\n    \"1\",\n    \"2\",\n    \"3\",\n    \"4\",\n    \"5\",\n    \"6\",\n    \"7\",\n    \"8\",\n    \"9\",\n    \"0\",\n    {\n      \"w\": 1.8\n    },\n    \"Delete\"\n  ],\n  [\n    {\n      \"w\": 1.6\n    },\n    \"!\",\n    \"@\",\n    \"#\",\n    \"$\",\n    \"%\",\n    \"^\",\n    \"&\",\n    \"(\",\n    \")\",\n    \"=\",\n    \"?\",\n    {\n      \"h\": 2,\n      \"w2\": 2.4,\n      \"h2\": 1,\n      \"x2\": -1.4,\n      \"y2\": 1\n    },\n    \"Enter\"\n  ],\n  [\n    {\n      \"w\": 1.2\n    },\n    \"/\",\n    \"-\",\n    \"+\",\n    \"_\",\n    \":\",\n    \";\",\n    \"'\",\n    \"\\\"\",\n    \",\",\n    \".\"\n  ],\n  [\n    {\n      \"w\": 2.2\n    },\n    \"abc\",\n    {\n      \"w\": 8\n    },\n    \"\",\n    {\n      \"w\": 2.4\n    },\n    \"<Speaker>\"\n  ]\n]\n"
)

local tbl1 = ({})

for k, value in pairs({
    "ASR_STATUS_OK",
    "ASR_STATUS_CANCELLED",
    "ASR_STATUS_UNKNOWN",
    "ASR_STATUS_INVALID_ARGUMENTS",
    "ASR_STATUS_DEADLINE_EXCEEDED",
    "ASR_STATUS_NOT_FOUND",
    "ASR_STATUS_ALREADY_EXISTS",
    "ASR_STATUS_PERMISSION_DENIED",
    "ASR_STATUS_UNAUTHENTICATED",
    "ASR_STATUS_RESOURCE_EXHAUSTED",
    "ASR_STATUS_FAILED_PRECONDITION",
    "ASR_STATUS_ABORTED",
    "ASR_STATUS_OUT_OF_RANGE",
    "ASR_STATUS_UNIMPLEMENTED",
    "ASR_STATUS_INTERNAL",
    "ASR_STATUS_UNAVAILABLE",
    "ASR_STATUS_DATA_LOSS",
    "ASR_STATUS_NOT_ENABLED",
    "ASR_STATUS_LOW_CONFIDENCE",
    "ASR_STATUS_INVALID_JSON"
}) do
    tbl1[value] = k - 1
end

local function tokenizeString(arg1, arg2) -- Luacid: unused: defined but never referenced
    local result = {}
    for value in string.gmatch(arg1, "([^" .. arg2 .. "]+)") do
        table.insert(result, value)
    end
    return result
end

local function ConvertFontSizeEnumToInt(fontSize): number | string -- Luacid: Inlined by compiler; 2 call sites recovered
    local var3 = string.match(fontSize.Name, "%d+")
    return var3 and tostring(var3) or 12
end

local function RayPlaneIntersection(ray, arg1, arg2) -- Luacid: unused: defined but never referenced
    arg1 = arg1.unit
    ray = ray.Unit

    local var3 = arg1:Dot(ray.Direction)

    if var3 == 0 then
        return nil
    end

    local var4 = arg1:Dot(arg2 - ray.Origin) / var3

    if var4 < 0 then
        return nil
    end

    return ray.Origin + ray.Direction * var4
end

function Clamp(arg1, arg2, arg3): number
    return math.max(arg1, math.min(arg2, arg3))
end

local function PointInGuiObject(arg1, arg2, arg3): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local absolutePosition = arg1.AbsolutePosition
    local var3 = arg1.AbsolutePosition + arg1.AbsoluteSize
    return absolutePosition.X <= arg2 and arg2 <= var3.X and absolutePosition.Y <= arg3 and arg3 <= var3.Y
end

local function FindAncestorOfType(arg1, arg2)
    if not arg1 then
        return nil
    end
    local parent = arg1.Parent
    if parent and parent:IsA(arg2) then
        return parent
    end

    return FindAncestorOfType(parent, arg2)
end

local function ExtendedInstance(arg1)
    local result = {}

    setmetatable(result, {
        __index = function(_, arg2)
            return arg1[arg2]
        end,
        __newindex = function(_, arg2, arg3)
            arg1[arg2] = arg3
        end
    })

    return result
end

local function CreateVRButton(arg1)
    local tbl2 = ExtendedInstance(arg1)

    rawset(tbl2, "OnEnter", function(_) end)

    rawset(tbl2, "OnLeave", function(_) end)

    rawset(tbl2, "OnDown", function(_) end)

    rawset(tbl2, "OnUp", function(_) end)

    rawset(tbl2, "ContainsPoint", function(_, arg2, arg3): boolean
        return PointInGuiObject(arg1, arg2, arg3)
    end)
    rawset(tbl2, "Update", function(_) end)

    return tbl2
end

Create("ImageLabel")({
    Name = "SelectionRing",
    Size = UDim2.new(1, -6, 1, -6),
    Position = UDim2.new(0, 4, 0, 3),
    Image = "rbxasset://textures/ui/menu/buttonHover.png",
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(47, 47, 47, 47),
    BackgroundTransparency = 1
})

local tbl2 = {
    ["<Speaker>"] = { Asset = "rbxasset://textures/ui/Keyboard/mic_icon.png", AspectRatio = 0.615 }
}

local function CreateKeyboardKey(arg1, arg2, arg3)
    local y2 = arg2.width2 and arg2.height2 and arg2.x2 and arg2.y2

    local var3 = Create("ImageButton")({
        Name = arg3[1],
        Position = UDim2.new(arg2.x, 0, arg2.y, 0),
        Size = UDim2.new(arg2.width, 0, arg2.height, 0),
        BorderSizePixel = 0,
        Image = "",
        BackgroundTransparency = 1,
        ZIndex = 1
    })

    local var4 = Create("TextLabel")({
        Name = "KeyText",
        Text = arg3[#arg3],
        Position = UDim2.new(0, -10, 0, -10),
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size96,
        TextColor3 = white,
        BackgroundTransparency = 1,
        Selectable = true,
        ZIndex = 2,
        Parent = var3
    })
    local var5 = Create("Frame")({
        Name = "KeyBackground",
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, -5, 0, -5),
        BackgroundColor3 = black,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = var3
    })

    local var6 = Create("ImageLabel")({
        Name = "SelectionObject",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png",
        ImageTransparency = 0,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(12, 12, 52, 52),
        BorderSizePixel = 0
    })

    var3.SelectionImageObject = Create("ImageLabel")({ Visible = false })

    local var7 = nil
    local var8 = nil
    local clone = nil
    local clone2 = nil
    if y2 then
        var7 = Create("ImageButton")({
            Name = "KeyBackground",
            Position = UDim2.new(arg2.x2 / arg2.width, -5, arg2.y2 / arg2.height, -5),
            Size = UDim2.new(arg2.width2 / arg2.width, 0, arg2.height2 / arg2.height, -10),
            BackgroundColor3 = black,
            BackgroundTransparency = 0.3,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            SelectionImageObject = var3.SelectionImageObject,
            Parent = var3
        })
        if arg2.x2 <= 0 then
            var4.Size = var7.Size - UDim2.new(0, 10, 0, 0)
            var4.Position = var7.Position
            local var9 = var7.Size - UDim2.new(1, 0, 0, 0)
            var7.Size = var9
        end

        var8 = Create("Frame")({
            Name = "SpecialSelectionObject",
            Size = UDim2.new(1, 0, 0.5, 0),
            Position = UDim2.new(0, 0, 0.5, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Create("ImageLabel")({
                Name = "Borders",
                Position = UDim2.new(-1, 0, -1, 0),
                Size = UDim2.new(2, 0, 2, 0),
                BackgroundTransparency = 1,
                Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png",
                ImageTransparency = 0,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 52, 52)
            })
        })

        clone = var8:Clone()
        local uDim2 = UDim2.new(1, 0, 0.5, 5)
        clone.Size = uDim2
        local uDim2_2 = UDim2.new(0, 0, 0, 0)
        clone.Position = uDim2_2
        clone.Borders.Size = UDim2.new(1, 0, 1, 30)
        clone.Borders.Position = UDim2.new(0, 0, 0, 0)

        clone2 = var8:Clone()
        local uDim2_3 = UDim2.new(1, 5, 1, 0)
        clone2.Size = uDim2_3
        local uDim2_4 = UDim2.new(0, 0, 0, 0)
        clone2.Position = uDim2_4
        clone2.Borders.Size = UDim2.new(1, 30, 1, 0)
        clone2.Borders.Position = UDim2.new(0, 0, 0, 0)
    end

    local vRButton = CreateVRButton(var3)

    local bool1 = false
    local bool2 = false
    local bool3 = #arg3 == 1
        and type(arg3[1]) == "string"
        and #arg3[1] == 1
        and string.byte(arg3[1]) >= 65
        and string.byte(arg3[1]) <= 122
    local var9 = nil
    if arg3[1] and tbl2[arg3[1]] then
        var4.Visible = false
        var9 = Create("ImageLabel")({
            Name = "KeyIcon",
            Size = UDim2.new(tbl2[arg3[1]].AspectRatio, -20, 1, -20),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            BackgroundTransparency = 1,
            Image = tbl2[arg3[1]].Asset,
            Parent = var5
        })

        var9.Changed:connect(function(arg4) -- name: onChanged
            if arg4 == "AbsoluteSize" then
                var9.Position = UDim2.new(0.5, -var9.AbsoluteSize.X / 2, 0.5, -var9.AbsoluteSize.Y / 2)
            end
        end)

        local uDim2 = UDim2.new(0.5, -var9.AbsoluteSize.X / 2, 0.5, -var9.AbsoluteSize.Y / 2)
        var9.Position = uDim2
    end

    local function onClicked()
        local var10 = nil
        local currentKeyValue = vRButton:GetCurrentKeyValue()

        if currentKeyValue == "Shift" then
            arg1:SetShift(not arg1:GetShift())
        elseif currentKeyValue == "Caps" then
            arg1:SetCaps(not arg1:GetCaps())
        elseif currentKeyValue == "Enter" then
            arg1:SubmitText(true, true)
        elseif currentKeyValue == "Delete" then
            arg1:BackspaceAtCursor()
        elseif currentKeyValue == "123/sym" then
            arg1:SetCurrentKeyset(2)
        elseif currentKeyValue == "abc" then
            arg1:SetCurrentKeyset(1)
        elseif currentKeyValue == "<Speaker>" then
            arg1:SetVoiceMode(true)
        else
            var10 = if currentKeyValue == "Tab" then "\t" else currentKeyValue
        end

        if var10 ~= nil then
            arg1:SubmitCharacter(var10, bool3)
        end
    end

    local function setKeyColor(backgroundColor3: Color3, bool4: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        var5.BackgroundColor3 = backgroundColor3
        if var7 then
            var7.BackgroundColor3 = backgroundColor3
        end
        if y2 then
            var8.Parent = bool4 and var5 or nil
            clone.Parent = bool4 and var5 or nil
            clone2.Parent = bool4 and var7 or nil
            return
        end
        var6.Parent = bool4 and var5 or nil
    end

    local function update()
        local currentKeyValue = vRButton:GetCurrentKeyValue()

        if bool2 then
            local color3 = cyan
            var5.BackgroundColor3 = color3
            if var7 then
                var7.BackgroundColor3 = color3
            end
            if y2 then
                var8.Parent = nil
                clone.Parent = nil
                clone2.Parent = nil
            else
                var6.Parent = nil
            end
        elseif bool1 then
            setKeyColor(black2, true)
        elseif currentKeyValue == "Caps" and arg1:GetCaps() then
            local color3 = cyan2
            var5.BackgroundColor3 = color3
            if var7 then
                var7.BackgroundColor3 = color3
            end
            if y2 then
                var8.Parent = nil
                clone.Parent = nil
                clone2.Parent = nil
            else
                var6.Parent = nil
            end
        elseif currentKeyValue == "Shift" and arg1:GetShift() then
            local color3 = cyan2
            var5.BackgroundColor3 = color3
            if var7 then
                var7.BackgroundColor3 = color3
            end
            if y2 then
                var8.Parent = nil
                clone.Parent = nil
                clone2.Parent = nil
            else
                var6.Parent = nil
            end
        elseif currentKeyValue == "abc" then
            local color3 = cyan2
            var5.BackgroundColor3 = color3
            if var7 then
                var7.BackgroundColor3 = color3
            end
            if y2 then
                var8.Parent = nil
                clone.Parent = nil
                clone2.Parent = nil
            else
                var6.Parent = nil
            end
        else
            local color3 = black
            var5.BackgroundColor3 = color3
            if var7 then
                var7.BackgroundColor3 = color3
            end
            if y2 then
                var8.Parent = nil
                clone.Parent = nil
                clone2.Parent = nil
            else
                var6.Parent = nil
            end
        end
        if var9 then
            var9.ImageTransparency = 0.5
        end

        var4.Text = vRButton:GetCurrentKeyValue()
    end

    local tbl3 = ({})

    rawset(vRButton, "OnEnter", function(_)
        bool1 = true
        update()
    end)
    rawset(vRButton, "OnLeave", function(_)
        if not next(tbl3) then
            bool1 = false
            bool2 = false
            update()
        end
    end)
    rawset(vRButton, "OnDown", function(_)
        bool2 = true
        update()

        onClicked()
    end)
    rawset(vRButton, "OnUp", function(_)
        bool2 = false
        update()
    end)
    rawset(vRButton, "GetCurrentKeyValue", function(_)
        local shift = arg1:GetShift()
        local caps = arg1:GetCaps()

        if not bool3 then
            return if shift then arg3[1] else arg3[#arg3]
        end

        if caps and shift then
            return string.lower(arg3[#arg3])
        elseif caps or shift then
            return arg3[1]
        end
        return string.lower(arg3[#arg3])
    end)
    rawset(vRButton, "ContainsPoint", function(_, arg4, arg5)
        local bool4 = PointInGuiObject(var5, arg4, arg5)

        if not bool4 then
            bool4 = var7

            if bool4 then
                local var10 = var7
                local absolutePosition = var10.AbsolutePosition
                local var11 = var10.AbsolutePosition + var10.AbsoluteSize
                if absolutePosition.X <= arg4 and arg4 <= var11.X and absolutePosition.Y <= arg5 and arg5 <= var11.Y then
                    return true
                end

                bool4 = false
            end
        end

        return bool4
    end)
    rawset(vRButton, "Update", function(_)
        update()
    end)
    rawset(vRButton, "GetInstance", function(_)
        return var3
    end)

    var3.MouseButton1Down:connect(function()
        vRButton:OnDown()
    end)

    var3.MouseButton1Up:connect(function()
        vRButton:OnUp()
    end)

    var3.SelectionGained:connect(function()
        tbl3[var3] = true
        vRButton:OnEnter()
    end)

    var3.SelectionLost:connect(function()
        tbl3[var3] = nil
        vRButton:OnLeave()
    end)

    if var7 then
        var7.MouseButton1Down:connect(function()
            vRButton:OnDown()
        end)

        var7.MouseButton1Up:connect(function()
            vRButton:OnUp()
        end)

        var7.SelectionGained:connect(function()
            tbl3[var7] = true
            vRButton:OnEnter()
        end)
        var7.SelectionLost:connect(function()
            tbl3[var7] = nil
            vRButton:OnLeave()
        end)
    end

    update()

    return vRButton
end

local function CreateBaseVoiceState()
    return {
        Name = "Base",
        TransitionFrom = function(_) end,
        TransitionTo = function(_) end
    }
end

local function CreateListeningVoiceState() -- Luacid: Inlined by compiler; 1 call site recovered
    local baseVoiceState = CreateBaseVoiceState()

    baseVoiceState.Name = "Listening"

    function baseVoiceState.TransitionTo(_)
        pcall(function()
            SoundService:BeginRecording()
        end)
    end
    return baseVoiceState
end

local function CreateProcessingVoiceState() -- Luacid: Inlined by compiler; 1 call site recovered
    local baseVoiceState = CreateBaseVoiceState()

    baseVoiceState.Name = "Processing"

    local bool1 = false
    local var3 = nil

    function baseVoiceState.TransitionTo(_)
        coroutine.wrap(function()
            pcall(function()
                var3 = SoundService:EndRecording()
            end)

            bool1 = true
        end)()
    end

    function baseVoiceState.GetResultAsync(_)
        while not bool1 do
            wait()
        end
        return var3
    end

    return baseVoiceState
end

local function CreateWaitingVoiceState() -- Luacid: Inlined by compiler; 2 call sites recovered
    local baseVoiceState = CreateBaseVoiceState()

    baseVoiceState.Name = "Waiting"

    return baseVoiceState
end

local tbl3 = {
    Listening = { Processing = true },
    Processing = { Waiting = true },
    Waiting = { Listening = true }
}
local tbl4 = {
    CurrentState = CreateWaitingVoiceState()
}
local bindableEvent = Instance.new("BindableEvent")

function tbl4:TransitionState(currentState): boolean
    if not tbl3[self.CurrentState.Name][currentState.Name] then
        return false
    end

    self.CurrentState:TransitionFrom()
    self.CurrentState = currentState
    self.CurrentState:TransitionTo()
    bindableEvent:Fire(self.CurrentState)
    return true
end

function tbl4:GetCurrentState()
    return self.CurrentState
end

tbl4.StateTransitionedEvent = bindableEvent.Event

local function ConstructKeyboardUI(arg1): {[string]: RBXScriptSignal}
    local panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D
    local var3 = panel3D.Get("Keyboard")
    var3:SetVisible(false)

    local tbl5 = {}

    local var4 = Create("Frame")({
        Name = "VirtualKeyboard",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Active = true,
        Visible = false
    })

    local var5 = Create("ImageLabel")({
        Name = "TextEntryBackground",
        Size = UDim2.new(0.5, 0, 0.125, 0),
        Position = UDim2.new(0.25, 0, 0, 0),
        Image = "",
        BackgroundTransparency = 0.5,
        BackgroundColor3 = Color3.new(31 / 255, 31 / 255, 31 / 255),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = var4
    })
    local var6 = Create("Frame")({
        Name = "TextfieldBackground",
        Position = UDim2.new(0, 2, 0, 2),
        Size = UDim2.new(1, -4, 1, -4),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(209 / 255, 72 / 85, 13 / 15),
        BorderSizePixel = 0,
        Visible = true,
        Parent = var5
    })
    local var7 = Create("TextButton")({
        Name = "TextEntryField",
        Text = "",
        Position = UDim2.new(0, 4, 0, 4),
        Size = UDim2.new(1, -8, 1, -8),
        Font = Enum.Font.SourceSans,
        FontSize = Enum.FontSize.Size60,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = var6
    })
    local var8 = Create("Frame")({
        Name = "TextfieldCursor",
        Size = UDim2.new(0, 5, 0.9, 0),
        Position = UDim2.new(0, 0, 0.05, 0),
        BackgroundTransparency = 0,
        BackgroundColor3 = cyan2,
        BorderSizePixel = 0,
        Visible = true,
        ZIndex = 2,
        Parent = var7
    })

    local var9 = Create("ImageButton")({
        Name = "CloseButton",
        Size = UDim2.new(0.075, -10, 0.198, -10),
        Position = UDim2.new(0, -5, 0, -35),
        Image = "rbxasset://textures/ui/Keyboard/close_button_background.png",
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Parent = var4
    })

    var9.SelectionImageObject = Create("ImageLabel")({
        Name = "Selection",
        Size = UDim2.new(0.9, 0, 0.9, 0),
        Position = UDim2.new(0.05, 0, 0.05, 0),
        Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png",
        BackgroundTransparency = 1
    })

    Create("ImageLabel")({
        Name = "Icon",
        Size = UDim2.new(0.5, 0, 0.5, 0),
        Position = UDim2.new(0.25, 0, 0.25, 0),
        Image = "rbxasset://textures/ui/Keyboard/close_button_icon.png",
        BackgroundTransparency = 1,
        Parent = var9
    })

    local vRButton = CreateVRButton(var9)
    table.insert(tbl5, vRButton)

    local var10 = Create("Frame")({
        Name = "VoiceRecognitionContainer",
        Size = UDim2.new(1, 0, 0.85, 0),
        Position = UDim2.new(0, 0, 0.15, 0),
        BackgroundTransparency = 1,
        Active = true,
        Visible = false,
        Parent = var4
    })

    local clone = Create("Frame")({
        Name = "voiceRecognitionBackground1",
        Size = UDim2.new(1, 0, 0.75, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = black,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Active = true,
        Parent = var10
    }):Clone()
    clone.Size = UDim2.new(0.8, 0, 0.25, 0)
    clone.Position = UDim2.new(0, 0, 0.75, 0)
    clone.Parent = var10

    local vRButton2 = CreateVRButton(
        Create("TextButton")({
            Name = "DoneButton",
            Size = UDim2.new(0.2, -5, 0.25, -5),
            Position = UDim2.new(0.8, 5, 0.75, 5),
            Text = "Done",
            BackgroundColor3 = cyan2,
            Font = Enum.Font.SourceSansBold,
            FontSize = Enum.FontSize.Size96,
            TextColor3 = white,
            BackgroundTransparency = 0,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Parent = var10
        })
    )
    table.insert(tbl5, vRButton2)

    local var11 = Create("TextLabel")({
        Name = "VoiceProcessingStatus",
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.33, 0),
        Text = "",
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size96,
        TextColor3 = white,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = var10
    })

    local function CreateVoiceVisualizerWidget()
        local module = {}

        local tbl6 = {}

        local container = Create("Frame")({ Name = "VoiceVisualizerContainer", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 })

        module.Container = container

        for i = 1, 50 do
            local var13 = Create("Frame")({
                Name = "Bar",
                Size = UDim2.new(0.02, -4, 1, 0),
                Position = UDim2.new(i / 50, 0, 0, 0),
                BackgroundTransparency = 0,
                BackgroundColor3 = white,
                Parent = container
            })
            table.insert(tbl6, var13)
        end

        function module.StartAnimation(_)
            RunService:UnbindFromRenderStep("VoiceVisualizerWidget")
            RunService:BindToRenderStep("VoiceVisualizerWidget", Enum.RenderPriority.First.Value, function()
                for k, value in pairs(tbl6) do
                    local yScale = ((math.abs(math.sin(tick() * 2.5 + k * (math.pi * 4 / 25))) + math.abs(math.cos(tick() * 2.5 + k * (math.pi * 4 / 25)))) / 2 - 0.3) * (10 / 7)
                    value.Size = UDim2.new(0.02, -4, yScale, 0)
                    value.Position = UDim2.new(k / 50, 0, (1 - yScale) / 2, 0)
                end
            end)
        end

        function module.StopAnimation(_)
            RunService:UnbindFromRenderStep("VoiceVisualizerWidget")
        end

        return module
    end

    local voiceVisualizerWidget = CreateVoiceVisualizerWidget()
    voiceVisualizerWidget.Container.Parent = var10
    voiceVisualizerWidget.Container.Size = UDim2.new(0.5, 0, 0.4, 0)
    voiceVisualizerWidget.Container.Position = UDim2.new(0.25, 0, 0.4, 0)

    local tbl6 = ExtendedInstance(var4)

    local var12 = nil
    local tbl7 = {}

    local bool1 = false
    local bool2 = false

    local num1 = 0

    local bindableEvent2 = Instance.new("BindableEvent")
    local bindableEvent3 = Instance.new("BindableEvent")
    local bool3 = false

    local function SetTextFieldCursorPosition(arg2)
        num1 = Clamp(0, #var7.Text, arg2)
        if not var7.TextFits then
            num1 = #var7.Text
        end

        local vector2 = TextService:GetTextSize(
            string.sub(var7.Text, 1, num1),
            ConvertFontSizeEnumToInt(var7.FontSize),
            var7.Font,
            var7.AbsoluteSize
        )
        var8.Position = UDim2.new(0, vector2.x, var8.Position.Y.Scale, var8.Position.Y.Offset)
    end

    local function UpdateTextEntryFieldText(arg2) -- Luacid: Inlined by compiler; 8 call sites recovered
        var7:SetTextFromInput(arg2)
        SetTextFieldCursorPosition(num1)
    end

    local str1 = ""
    local function getBufferText() -- Luacid: Inlined by compiler; 3 call sites recovered
        return if var12 and var12.TextBox then var12.TextBox.Text else str1
    end
    local function setBufferText(text) -- Luacid: Inlined by compiler; 5 call sites recovered
        if var12 and var12.TextBox then
            var12.TextBox.Text = text
        elseif str1 ~= text then
            str1 = text
            UpdateTextEntryFieldText(str1)
        end
    end

    local function calculateTextCursorPosition(arg2, arg3)
        arg2 -= var7.AbsolutePosition.x
        arg3 -= var7.AbsolutePosition.y

        for i = 1, #var7.Text do
            local textService = TextService
            local text = var7.Text

            if arg2 < textService:GetTextSize(string.sub(text, 1, i), ConvertFontSizeEnumToInt(var7.FontSize), var7.Font, var7.AbsoluteSize).x then
                return i - 1
            end
        end

        return #var7.Text
    end

    local var13 = nil

    rawset(tbl6, "OpenedEvent", bindableEvent2.Event)
    rawset(tbl6, "ClosedEvent", bindableEvent3.Event)

    rawset(tbl6, "GetCurrentKeyset", function(_)
        return tbl7[var13]
    end)

    rawset(tbl6, "SetCurrentKeyset", function(_, arg2)
        if arg2 == var13 or tbl7[arg2] == nil then
            return
        end

        if tbl7[var13] and tbl7[var13].container then
            tbl7[var13].container.Visible = false
        end

        var13 = arg2

        if tbl7[var13] and tbl7[var13].container then
            tbl7[var13].container.Visible = true
        end
    end)

    rawset(tbl6, "SetVoiceMode", function(arg2, arg3)
        arg3 = false

        local currentKeyset = arg2:GetCurrentKeyset()
        if currentKeyset and currentKeyset.container then
            currentKeyset.container.Visible = not arg3
        end

        var10.Visible = arg3

        if arg3 then
            tbl4:TransitionState((CreateListeningVoiceState()))
        end
    end)

    rawset(tbl6, "GetCaps", function(_)
        return bool1
    end)

    rawset(tbl6, "SetCaps", function(arg2, arg3)
        bool1 = arg3
        for _, key in pairs(arg2:GetCurrentKeyset().keys) do
            key:Update()
        end
    end)

    rawset(tbl6, "GetShift", function(_)
        return bool2
    end)

    rawset(tbl6, "SetShift", function(arg2, arg3)
        bool2 = arg3
        for _, key in pairs(arg2:GetCurrentKeyset().keys) do
            key:Update()
        end
    end)

    local bool4 = false

    local connection = nil
    local connection2 = nil
    local connection3 = nil

    local function disconnectKeyboardEvents() -- Luacid: Inlined by compiler; 2 call sites recovered
        if connection then
            connection:disconnect()
        end

        connection = nil
        if connection2 then
            connection2:disconnect()
        end

        connection2 = nil
        if connection3 then
            connection3:disconnect()
        end

        connection3 = nil
    end

    rawset(tbl6, "Open", function(arg2, arg3)
        if bool3 then
            return
        end

        bool3 = true

        var12 = arg3

        arg2:SetCurrentKeyset(1)
        arg2:SetVoiceMode(false)
        var4.Visible = true

        var3:ResizeStuds(5.9, 2.25, 320)

        local cFrame = CFrame.new()
        disconnectKeyboardEvents()

        if arg3.TextBox then
            connection = arg3.TextBox.Changed:connect(function(arg4)
                if arg4 == "Text" then
                    UpdateTextEntryFieldText(arg3.TextBox.Text)
                end
            end)
            connection2 = arg3.TextBox.FocusLost:connect(function(enterPressed: boolean)
                if not bool4 then
                    arg2:Close(enterPressed)
                end
            end)
            if arg3.TextBox.ClearTextOnFocus then
                setBufferText("")
            else
                UpdateTextEntryFieldText(arg3.TextBox.Text)
            end

            local containerOf = panel3D.FindContainerOf(arg3.TextBox)
            if containerOf then
                connection3 = panel3D.OnPanelClosed.Event:connect(function(name)
                    if name == containerOf.name then
                        arg2:Close(false)
                    end
                end)

                local var14 = arg3.TextBox.AbsolutePosition + Vector2.new(0.5, 1) * arg3.TextBox.AbsoluteSize
                cFrame = containerOf:GetCFrameInCameraSpace() * CFrame.new(containerOf:GetGuiPositionInPanelSpace(var14)) * CFrame.new(0, -var3.height * 0.65, 0.5) * CFrame.Angles(-(math.pi / 8), 0, 0)
            else
                cFrame = panel3D.GetHeadLookXZ(true) * CFrame.Angles(math.pi / 8, 0, 0) * CFrame.new(0, -1, -5)
            end
        else
            setBufferText("")
        end

        ContextActionService:BindCoreAction("VirtualKeyboardControllerInput", function(_, userInputState, arg4)
            if userInputState ~= Enum.UserInputState.End then
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonL1 then
                SetTextFieldCursorPosition(num1 - 1)
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonR1 then
                SetTextFieldCursorPosition(num1 + 1)
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonX then
                arg2:BackspaceAtCursor()
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonY then
                arg2:SubmitCharacter(" ", false)
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonL2 then
                if var13 then
                    arg2:SetCurrentKeyset(var13 % #tbl7 + 1)
                end

                return
            end
            if arg4.KeyCode == Enum.KeyCode.ButtonL3 then
                arg2:SetCaps(not arg2:GetCaps())
                return
            end

            if arg4.KeyCode == Enum.KeyCode.ButtonB then
                arg2:Close(false)
            end
        end, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonL3, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonB)

        arg2.Parent = var3:GetGUI()

        var3:SetType(panel3D.Type.Fixed, { CFrame = cFrame })
        var3:SetCanFade(false)
        var3:SetVisible(true, true)
        var3:ForceShowUntilLookedAt()

        function var3.OnUpdate(_) end

        bindableEvent2:Fire()
    end)

    rawset(tbl6, "Close", function(arg2, arg3)
        arg3 = arg3 == true

        if not bool3 then
            return
        end

        bool3 = false
        disconnectKeyboardEvents()
        ContextActionService:UnbindCoreAction("VirtualKeyboardControllerInput")

        var3:OnMouseLeave()
        var3:SetVisible(false, true)
        var4.Visible = false

        panel3D.Get("Topbar3D"):SetVisible(true)

        arg2:SubmitText(arg3, false)
        bindableEvent3:Fire()
    end)

    rawset(tbl6, "SubmitText", function(_, arg2, arg3)
        local textBox = var12 and var12.TextBox
        if not textBox then
            return
        end

        if arg2 then
            textBox.Text = getBufferText()
        end

        local containerOf = panel3D.FindContainerOf(textBox)
        local var14 = arg3 and containerOf and containerOf.linkedTo == var3

        if var14 then
            bool4 = true
        end

        textBox:ReleaseFocus(arg2)

        if var14 then
            textBox:CaptureFocus()
            bool4 = false
        end
    end)

    rawset(tbl6, "GetCurrentOptions", function(_)
        return var12
    end)

    rawset(tbl6, "BackspaceAtCursor", function(_)
        if not (num1 >= 1) then
            return
        end

        local bufferText = getBufferText()
        local str2 = string.sub(bufferText, 1, num1 - 1) .. string.sub(bufferText, num1 + 1, #bufferText)
        local var14 = num1 - 1
        setBufferText(str2)
        SetTextFieldCursorPosition(var14)
    end)

    rawset(tbl6, "SubmitCharacter", function(arg2, arg3, arg4)
        local bufferText = getBufferText()
        setBufferText(string.sub(bufferText, 1, num1) .. arg3 .. string.sub(bufferText, num1 + 1, #bufferText))
        SetTextFieldCursorPosition(num1 + #arg3)

        if arg4 and arg2:GetShift() then
            arg2:SetShift(false)
        end
    end)

    for _, value in pairs(arg1) do
        local keys = {}
        local container = Create("Frame")({
            Name = "KeyboardSizeConstrainer",
            Size = UDim2.new(1, 0, 1, -20),
            Position = UDim2.new(0, 0, 0, 20),
            BackgroundTransparency = 1,
            Parent = var4
        })

        local num2 = 0
        local num3 = 0
        local num4 = 0
        for _, value2 in pairs(value) do
            local num5 = 0
            local num6 = 1
            local num7 = 1
            local w2 = nil
            local h2 = nil
            local x2 = nil
            local y2 = nil
            for _, value3 in pairs(value2) do
                if type(value3) == "table" then
                    if value3.w then
                        num6 = value3.w
                    end

                    if value3.h then
                        num7 = value3.h
                    end

                    if value3.x then
                        num5 += value3.x
                    end

                    if value3.y then
                        num4 += value3.y
                    end

                    if value3.x2 then
                        x2 = value3.x2
                    end

                    if value3.y2 then
                        y2 = value3.y2
                    end

                    if value3.w2 then
                        w2 = value3.w2
                    end

                    if value3.h2 then
                        h2 = value3.h2
                    end
                elseif type(value3) == "string" then
                    local func1 = CreateKeyboardKey

                    local tbl9 = {
                        x = num5,
                        y = num4,
                        width = num6,
                        height = num7,
                        x2 = x2,
                        y2 = y2,
                        width2 = w2,
                        height2 = h2
                    }
                    local tbl10 = {}
                    for value4 in string.gmatch(if value3 == "" then " " else value3, "([^\n]+)") do
                        table.insert(tbl10, value4)
                    end

                    table.insert(keys, (func1(tbl6, tbl9, tbl10)))

                    num5 += num6
                    num2 = math.max(num2, num5)
                    num3 = math.max(num3, num4 + num7)
                    num6 = 1
                    num7 = 1
                    x2 = nil
                    y2 = nil
                    w2 = nil
                    h2 = nil
                end
            end

            num4 += 1
        end

        for _, value2 in pairs(keys) do
            value2.Position = UDim2.new(value2.Position.X.Scale / num2, 0, value2.Position.Y.Scale / num3, 0)
            value2.Size = UDim2.new(value2.Size.X.Scale / num2, 0, value2.Size.Y.Scale / num3, 0)
            value2.Parent = container
        end

        container.SizeConstraint = Enum.SizeConstraint.RelativeXX
        container.Size = UDim2.new(1, 0, -num3 / num2, 0)
        container.Position = UDim2.new(0, 0, 1, 0)
        container.Visible = false

        table.insert(tbl7, { keys = keys, container = container })
    end
    tbl6:SetCurrentKeyset(1)

    var7.MouseButton1Click:connect(function()
        SetTextFieldCursorPosition((calculateTextCursorPosition(var3.lookAtPixel.X, var3.lookAtPixel.Y)))
    end)

    vRButton.MouseButton1Click:connect(function()
        tbl6:Close(false)
    end)

    vRButton2.MouseButton1Click:connect(function()
        if tbl4:GetCurrentState().Name == "Listening" then
            tbl4:TransitionState((CreateProcessingVoiceState()))
        end
    end)

    local function onVoiceProcessingStateChanged(arg2)
        if arg2.Name == "Listening" then
            var11.Text = "Listening..."
        elseif arg2.Name == "Processing" then
            var11.Text = "Processing..."
        elseif arg2.Name == "Waiting" then
            var11.Text = "Done"
        end

        if arg2.Name ~= "Processing" then
            if arg2.Name == "Listening" then
                voiceVisualizerWidget:StartAnimation()
            elseif arg2.Name == "Waiting" then
                tbl6:SetVoiceMode(false)
            end

            return
        end

        coroutine.wrap(function()
            voiceVisualizerWidget:StopAnimation()
            local resultAsync = arg2:GetResultAsync()
            if resultAsync and resultAsync.Status == tbl1.ASR_STATUS_OK then
                setBufferText(resultAsync.Response)
            else
                var11.Text = "An error occurred, please try again."
                wait(2)
            end
            tbl4:TransitionState((CreateWaitingVoiceState()))
        end)()
    end

    tbl4.StateTransitionedEvent:connect(onVoiceProcessingStateChanged)
    onVoiceProcessingStateChanged(tbl4:GetCurrentState())

    return tbl6
end

local var3 = nil
local function GetKeyboard() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var3 == nil then
        var3 = ConstructKeyboardUI({ var1, var2 })
    end
    return var3
end

local module = {}

function module.CreateVirtualKeyboardOptions(_, textBox)
    return { TextBox = textBox }
end

function module.ShowVirtualKeyboard(_, _) end

function module.CloseVirtualKeyboard(_) end

GetKeyboard()
module.OpenedEvent = var3.OpenedEvent
GetKeyboard()
module.ClosedEvent = var3.ClosedEvent

return module
