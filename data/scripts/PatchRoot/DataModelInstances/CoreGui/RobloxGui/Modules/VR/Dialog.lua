-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local Panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D

local _color3 = Color3.new(0.2, 0.2, 0.2)

local _Size36 = Enum.FontSize.Size36

local _color3_2 = Color3.new(1, 1, 1)

local localCF = CFrame.new(0, 0, -7) * CFrame.Angles(0, math.pi, 0)

Create("ImageLabel")({ Name = "EmptySelectionImage", Image = "", BackgroundTransparency = 1, ImageTransparency = 1 })

local var2 = Panel3D.Get("Dialog")
var2:SetType(Panel3D.Type.Fixed)
var2.localCF = localCF
var2:SetCanFade(true)

local currentRy = 0
local tbl1 = ({})
local bool1 = false
local num1 = 0

local function positionDialogPanel(ry: number) -- Luacid: Inlined by compiler; 1 call site recovered
    currentRy = ry
    local p = UserInputService:GetUserCFrame(Enum.UserCFrame.Head).p
    var2.localCF = CFrame.new(p) * CFrame.Angles(0, ry, 0) * localCF
end

function var2.CalculateTransparency(_): number
    local cFrame = UserInputService:GetUserCFrame(Enum.UserCFrame.Head)
    local var3 = cFrame.lookVector * Vector3.new(1, 0, 1)
    local num2 = math.asin(cFrame.lookVector.Y)
    local vec3 = Vector3.new(math.cos(num1 + currentRy + math.pi / 2), 0, -math.sin(num1 + currentRy + math.pi / 2))

    if math.abs(num2) > math.rad(44) then
        bool1 = true
    end

    return math.min(math.max(0, (math.acos((var3:Dot(vec3))) - math.pi * 5 / 24) / 0.11344640137963136), 1)
end

local function updatePanelPosition()
    local var3 = UserInputService:GetUserCFrame(Enum.UserCFrame.Head).lookVector * Vector3.new(1, 0, 1)
    local num2 = (math.atan2(-var3.Z, var3.X) - math.pi / 2) % (math.pi * 2)
    local ry = num1 + math.floor(num2 / (math.pi / 2) + 0.5) * (math.pi / 2)

    if bool1 then
        bool1 = false
        num1 = num2
    end

    positionDialogPanel(ry)
end

function dialogPanelRenderUpdate()
    if var2.transparency == 1 or bool1 then
        updatePanelPosition()
    end

    local var3 = 1 - var2.transparency
    for k, value in pairs(tbl1) do
        local var4 = 1 - value * var3
        if k:IsA("TextLabel") or k:IsA("TextButton") then
            k.TextTransparency = var4
        elseif k:IsA("ImageLabel") or k:IsA("ImageButton") then
            k.ImageTransparency = var4
        elseif k:IsA("Frame") then
            k.BackgroundTransparency = var4
        end
    end
end

local tbl2 = {}

local connection = nil
local var3 = nil
local function updatePanel()
    local var4 = tbl2[1]
    if var3 and var3.content then
        var3.content.Parent = nil
    end
    if not (var4 and var4.content) then
        var2:SetVisible(false)
        tbl1 = {}
        if connection then
            connection:disconnect()
            connection = nil
        end

        return
    end

    var4.content.Parent = var2:GetGUI()
    var3 = var4

    local absoluteSize = var4.content.AbsoluteSize
    var2:ResizePixels(absoluteSize.X, absoluteSize.Y, 100)

    bool1 = true
    updatePanelPosition()
    var2:SetVisible(true)

    tbl1 = {}
    local function search(arg1)
        if arg1:IsA("ImageLabel") or arg1:IsA("ImageButton") then
            tbl1[arg1] = 1 - arg1.ImageTransparency
        elseif arg1:IsA("TextLabel") or arg1:IsA("TextButton") then
            tbl1[arg1] = 1 - arg1.TextTransparency
        elseif arg1:IsA("Frame") then
            tbl1[arg1] = 1 - arg1.BackgroundTransparency
        end
        for _, child in pairs(arg1:GetChildren()) do
            search(child)
        end
    end
    search(var2:GetGUI())
    if connection then
        connection:disconnect()
        connection = nil
    end
    connection = var2:GetGUI().DescendantAdded:connect(function(descendant: Instance)
        search(descendant)
    end)
end

local module = {}
module.__index = module
function module.new(content)
    local self = setmetatable({}, module)
    self.content = content
    return self
end

function module:SetContent(content)
    if not content and self.content then
        self.content.Parent = nil
    end
    self.content = content
end

local bool2 = false
function module.Show(arg1, arg2)
    if not bool2 then
        bool2 = true
        RunService:BindToRenderStep("DialogPanel", Enum.RenderPriority.First.Value, dialogPanelRenderUpdate)
    end
    if arg2 then
        table.insert(tbl2, 1, arg1)
    else
        table.insert(tbl2, arg1)
    end
    updatePanel()
end

function module.Close(arg1)
    for k, value in pairs(tbl2) do
        if value == arg1 then
            table.remove(tbl2, k)
            break
        end
    end

    if bool2 and #tbl2 == 0 then
        bool2 = false
        RunService:UnbindFromRenderStep("DialogPanel")
    end
    updatePanel()
end

return module
