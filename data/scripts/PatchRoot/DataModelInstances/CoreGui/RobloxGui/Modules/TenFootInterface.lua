-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local teal = Color3.new(9 / 85, 84 / 85, 107 / 255)

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")

local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local IsEnabled = require(CorePackages.Workspace.Packages.AppCommonLib).isTenFootInterface()

local module = {}

local function CreateModule()
    local module2 = { Container = nil }

    local tbl1 = {}
    local bindableEvent = Instance.new("BindableEvent")
    local bindableEvent2 = Instance.new("BindableEvent")

    local function createContainer()
        if module2.Container then
            return
        end

        module2.Container = Create("ImageButton")({
            Name = "TopRightContainer",
            Size = UDim2.new(0, 350, 0, 100),
            Position = UDim2.new(1, -415, 0, 10),
            AutoButtonColor = false,
            Image = "",
            Active = false,
            BackgroundTransparency = 1,
            Parent = RobloxGui
        })
    end

    function removeFromDisplayStack(arg1)
        local var2 = nil

        for i = 1, #tbl1 do
            if tbl1[i] == arg1 then
                var2 = i + 1
                break
            end
        end

        for i = var2, #tbl1 do
            local var3 = tbl1[i]
            var3.Position = UDim2.new(var3.Position.X.Scale, var3.Position.X.Offset, var3.Position.Y.Scale, arg1.AbsolutePosition.Y)
            arg1 = var3
        end

        bindableEvent:Fire()
    end

    function addBackToDisplayStack(arg1)
        local num1 = 0

        for i = 1, #tbl1 do
            if tbl1[i] == arg1 then
                num1 = i + 1
                break
            end
        end

        for i = num1, #tbl1 do
            local var2 = tbl1[i]
            local yOffset = arg1.AbsolutePosition.Y + arg1.AbsoluteSize.Y + 4
            var2.Position = UDim2.new(var2.Position.X.Scale, var2.Position.X.Offset, var2.Position.Y.Scale, yOffset)
            arg1 = var2
        end

        bindableEvent:Fire()
    end

    function addToDisplayStack(arg1)
        local var2 = if #tbl1 > 0 then tbl1[#tbl1] else nil
        tbl1[#tbl1 + 1] = arg1

        local yOffset = if var2 then var2.AbsolutePosition.Y + var2.AbsoluteSize.Y + 4 else 0

        arg1.Position = UDim2.new(arg1.Position.X.Scale, arg1.Position.X.Offset, arg1.Position.Y.Scale, yOffset)

        createContainer()
        arg1.Parent = module2.Container

        arg1.Changed:connect(function(arg2)
            if arg2 ~= "Visible" then
                return
            end

            if not arg1.Visible then
                removeFromDisplayStack(arg1)
                return
            end
            addBackToDisplayStack(arg1)
        end)

        bindableEvent:Fire()
    end

    function module2.CreateHealthBar(_)
        module2.HealthContainer = Create("Frame")({
            Name = "HealthContainer",
            Size = UDim2.new(1, -86, 0, 50),
            Position = UDim2.new(0, 92, 0, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 0.5
        })

        local var2 = Create("Frame")({
            Name = "HealthFillHolder",
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
            Parent = module2.HealthContainer
        })

        local var3 = Create("Frame")({
            Name = "HealthFill",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 0,
            BackgroundColor3 = teal,
            Parent = var2
        })

        Create("TextLabel")({
            Name = "HealthText",
            Size = UDim2.new(0, 98, 0, 50),
            Position = UDim2.new(0, -100, 0, 0),
            BackgroundTransparency = 0.5,
            BackgroundColor3 = Color3.new(0, 0, 0),
            Font = Enum.Font.SourceSans,
            FontSize = Enum.FontSize.Size36,
            Text = "Health",
            TextColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
            Parent = module2.HealthContainer
        })

        local var4 = Create("TextLabel")({ Visible = false })

        local var5 = Create("TextLabel")({ Visible = false })

        addToDisplayStack(module2.HealthContainer)
        createContainer()

        module2.HealthContainer.Changed:connect(function()
            bindableEvent2:Fire()
        end)

        return module2.Container, var4, module2.HealthContainer, var3, var5
    end

    function module2.CreateAccountType(_, text)
        module2.AccountTypeContainer = Create("Frame")({
            Name = "AccountTypeContainer",
            Size = UDim2.new(0, 50, 0, 50),
            Position = UDim2.new(1, -55, 0, 10),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 0.5,
            Parent = RobloxGui
        })

        Create("TextLabel")({
            Name = "AccountTypeText",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.new(0, 0, 0),
            Font = Enum.Font.SourceSans,
            FontSize = Enum.FontSize.Size36,
            Text = text,
            TextColor3 = Color3.new(1, 1, 1),
            BorderSizePixel = 0,
            Parent = module2.AccountTypeContainer,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        })
    end

    function module2.SetupTopStat(_)
        local bool1 = true
        local var2 = nil
        local connection = nil
        local connection2 = nil
        local connection3 = nil
        local var3 = nil

        local function makeTenFootInterfaceStat()
            if var3 then
                return
            end
            var3 = Create("Frame")({
                Name = "OneStatFrame",
                Size = UDim2.new(1, 0, 0, 36),
                Position = UDim2.new(0, 0, 0, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            })

            local clone = Create("TextLabel")({
                Name = "StatName",
                Size = UDim2.new(0.5, 0, 0, 36),
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSans,
                FontSize = Enum.FontSize.Size36,
                TextStrokeColor3 = Color3.new(104 / 255, 104 / 255, 104 / 255),
                TextStrokeTransparency = 0,
                Text = " StatName:",
                TextColor3 = Color3.new(1, 1, 1),
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Parent = var3
            }):clone()
            clone.Position = UDim2.new(0.5, 0, 0, 0)
            clone.Name = "StatValue"
            clone.Text = "123,643,231"
            clone.TextXAlignment = Enum.TextXAlignment.Right
            clone.Parent = var3

            addToDisplayStack(var3)
        end

        local updateTenFootStat = nil

        local function setDisplayedStat(arg1: Instance)
            if connection then
                connection:disconnect()
                connection = nil
            end
            if connection2 then
                connection2:disconnect()
                connection2 = nil
            end

            var2 = arg1

            if not var2 then
                return
            end

            makeTenFootInterfaceStat()
            updateTenFootStat(var2)
            connection2 = var2.AncestryChanged:connect(function()
                updateTenFootStat(var2, "Parent")
            end)

            connection = var2.Changed:connect(function(arg2)
                updateTenFootStat(var2, arg2)
            end)
        end

        updateTenFootStat = function(arg1, arg2)
            if arg2 and arg2 == "Parent" then
                var3.StatName.Text = ""
                var3.StatValue.Text = ""
                setDisplayedStat(nil)

                tenFootInterfaceChanged()
            elseif bool1 then
                local statName = var3.StatName
                statName.Text = " " .. tostring(arg1.Name) .. ":"
                local statValue = var3.StatValue
                statValue.Text = tostring(arg1.Value)
            else
                var3.StatName.Text = ""
                var3.StatValue.Text = ""
            end
        end

        local function isValidStat(arg1: Instance)
            return arg1:IsA("StringValue")
                or arg1:IsA("IntValue")
                or arg1:IsA("BoolValue")
                or arg1:IsA("NumberValue")
                or arg1:IsA("DoubleConstrainedValue")
                or arg1:IsA("IntConstrainedValue")
        end

        local function tenFootInterfaceNewStat(arg1: Instance) -- Luacid: Inlined by compiler; 2 call sites recovered
            if not var2 and isValidStat(arg1) then
                setDisplayedStat(arg1)
            end
        end

        local localPlayer = Players.LocalPlayer
        while not localPlayer do
            Players.PlayerAdded:wait()
            localPlayer = Players.LocalPlayer
        end

        function tenFootInterfaceChanged()
            local leaderstats = localPlayer:FindFirstChild("leaderstats")
            if not leaderstats then
                return
            end

            local children = leaderstats:GetChildren()
            for i = 1, #children do
                tenFootInterfaceNewStat(children[i])
            end
            if connection3 then
                connection3:disconnect()
            end

            connection3 = leaderstats.ChildAdded:connect(function(child: Instance)
                tenFootInterfaceNewStat(child)
            end)
        end

        if localPlayer:FindFirstChild("leaderstats") then
            tenFootInterfaceChanged()
        else
            localPlayer.ChildAdded:connect(tenFootInterfaceChanged)
        end

        return {
            SetTopStatEnabled = function(_, arg1)
                bool1 = arg1
                if var2 then
                    updateTenFootStat(var2, "")
                end
            end
        }
    end

    return module2
end

local module2 = CreateModule()

function module.IsEnabled(_)
    return IsEnabled
end

function module.CreateHealthBar(_)
    return module2:CreateHealthBar()
end

function module.CreateAccountType(_, arg1)
    return module2:CreateAccountType(arg1)
end

function module.SetupTopStat(_)
    return module2:SetupTopStat()
end

return module
