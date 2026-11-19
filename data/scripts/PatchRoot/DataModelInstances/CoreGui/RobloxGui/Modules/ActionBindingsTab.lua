-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local CorePackages = game:GetService("CorePackages")

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local reallyBlack = Color3.new(0.1, 0, 0)
local black = Color3.new(0, 0, 0)

local _tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local _tweenInfo2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true, 0)
local tweenInfo2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local instance = nil
local tbl1 = ({})
local tbl2 = ({})
local tbl3 = ({})
local tbl4 = ({})
local tbl5 = ({})
local tbl6 = ({})
local tbl7 = ({})
local tbl8 = ({})

local bool1 = true

local function sortInputTypeRows(arg1, arg2): boolean
    local var1 = tbl2[arg1]
    local var2 = tbl2[arg2]
    return tostring(var1) < tostring(var2)
end

local function sortActionRows(arg1, arg2): boolean
    local var1 = tbl4[arg1]
    local var2 = tbl4[arg2]
    if not (var1 and var2) then
        return true
    end

    local var3 = tbl5[arg1]
    local var4 = tbl5[arg2]
    if var3 ~= var4 then
        return tostring(var3) < tostring(var4)
    end
    if var1.isCore and not var2.isCore then
        return true
    end

    if not var1.isCore and var2.isCore then
        return false
    end
    local stackOrder = var1.stackOrder
    local stackOrder2 = var2.stackOrder
    return not (stackOrder and stackOrder2) or stackOrder2 < stackOrder
end

local function createEmptyRow(str1: string, num1: number)
    local var1 = Create("Frame")({ Name = str1, BackgroundTransparency = 1, ZIndex = 6, Size = UDim2.new(1, 0, 0, num1 or 0) })

    Create("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        Parent = var1
    })

    return var1
end

local function createButtonRow(str1: string, num1: number)
    local var1 = Create("TextButton")(
        {
            Name = str1,
            BackgroundTransparency = 1,
            ZIndex = 6,
            Text = "",
            Size = UDim2.new(1, 0, 0, num1 or 0)
        }
    )
    Create("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5),
        Parent = var1
    })

    return var1
end

local function createEmptyColumn(arg1, str1: string)
    return (Create("Frame")({
        Name = str1,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 6,
        ClipsDescendants = true,
        Parent = arg1
    }))
end

local function createImageColumn(buttonRow, str1: string, image: string, aspectRatio: number, num1: number)
    local emptyColumn = createEmptyColumn(buttonRow, str1)

    Create("UIAspectRatioConstraint")({ AspectRatio = aspectRatio or 1, Parent = emptyColumn })

    Create("ImageLabel")({
        Name = "ColumnImage",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(num1 or 1, 0, num1 or 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 6,
        Image = image,
        Parent = emptyColumn
    })

    return emptyColumn
end

local function createTextColumn(arg1, str1: string, text: string)
    local emptyColumn = createEmptyColumn(arg1, str1)

    Create("TextLabel")({
        Name = "ColumnText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -10, 1, -10),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 6,
        Text = text,
        TextSize = 18,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.SourceSans,
        Parent = emptyColumn
    })

    return emptyColumn
end

local function createActionColumns(emptyRow, backgroundColor3: Color3)
    local emptyColumn = createEmptyColumn(emptyRow, "Inset")
    emptyColumn.LayoutOrder = 0
    emptyColumn.BackgroundTransparency = 1
    emptyColumn.Size = UDim2.new(0, 30, 1, 0)
    local num1 = 0 + 30 + 5

    local textColumn = createTextColumn(emptyRow, "Priority", "Priority")
    textColumn.LayoutOrder = 1
    textColumn.BackgroundColor3 = backgroundColor3
    textColumn.Size = UDim2.new(0, 80, 1, 0)
    local num2 = num1 + 80 + 5

    local textColumn2 = createTextColumn(emptyRow, "Security", "Security")
    textColumn2.LayoutOrder = 2
    textColumn2.BackgroundColor3 = backgroundColor3
    textColumn2.Size = UDim2.new(0, 80, 1, 0)
    local num3 = num2 + 80 + 5

    local textColumn3 = createTextColumn(emptyRow, "ActionName", "Action Name")
    textColumn3.LayoutOrder = 3
    textColumn3.BackgroundColor3 = backgroundColor3
    textColumn3.Size = UDim2.new(0.25, 0, 1, 0)

    local textColumn4 = createTextColumn(emptyRow, "InputTypes", "Input Types")
    textColumn4.LayoutOrder = 4
    textColumn4.BackgroundColor3 = backgroundColor3
    textColumn4.Size = UDim2.new(0.75, -num3 - 5, 1, 0)

    return emptyColumn, textColumn, textColumn2, textColumn3, textColumn4
end

local function updateContainerCanvas()
    debug.profilebegin("updateContainerCanvas")

    if bool1 then
        bool1 = false
        local num1 = 1

        local tbl9 = {}

        for _, value in pairs(tbl1) do
            table.insert(tbl9, value)
        end

        table.sort(tbl9, sortInputTypeRows)

        for _, value in pairs(tbl9) do
            local var1 = tbl2[value]
            value.LayoutOrder = num1
            num1 += 1
            local var2 = tbl7[var1]
            if var2 then
                var2.LayoutOrder = num1
                num1 += 1
            end

            local var3 = tbl3[var1]
            if not var3 then
                continue
            end

            local tbl10 = {}
            for _, value2 in pairs(var3) do
                table.insert(tbl10, value2)
            end

            table.sort(tbl10, sortActionRows)

            for _, value2 in pairs(tbl10) do
                value2.LayoutOrder = num1
                num1 += 1
            end
        end
    end

    debug.profileend()
end

local function scrollContainerToRow(buttonRow)
    local y = buttonRow.AbsolutePosition.Y - instance.AbsolutePosition.Y
    local canvasPosition = instance.CanvasPosition + Vector2.new(0, y)
    TweenService:Create(instance, tweenInfo2, { CanvasPosition = canvasPosition }):Play()
end

local module = {}

function module.initializeGui(arg1)
    local var1 = Create("ScrollingFrame")({
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -10, 1, -10),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        BackgroundTransparency = 1,
        ZIndex = 6,
        Parent = arg1
    })
    instance = var1

    local var2 = Create("UIListLayout")({ Padding = UDim.new(0, 5), Parent = var1 })

    var2.SortOrder = Enum.SortOrder.LayoutOrder
    var2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        instance.CanvasSize = UDim2.new(0, 0, 0, var2.AbsoluteContentSize.Y)
    end)
    module.updateGuis()

    ContextActionService.BoundActionAdded:connect(function(actionAdded: string, _: boolean, functionInfoTable, isCore: boolean)
        functionInfoTable.isCore = isCore
        module.updateActionRows(actionAdded, functionInfoTable)

        bool1 = true
        updateContainerCanvas()
    end)
    ContextActionService.BoundActionRemoved:connect(function(actionRemoved: string, functionInfoTable, isCore: boolean)
        functionInfoTable.isCore = isCore
        module.removeActionRows(actionRemoved, functionInfoTable)

        bool1 = true
        updateContainerCanvas()
    end)
end

function module.updateBoundInputTypeRow(arg1)
    if tbl1[arg1] then
        return
    end

    local buttonRow = createButtonRow("BoundInputType", 30)

    local imageColumn = createImageColumn(buttonRow, "ExpandImage", "rbxasset://textures/ui/ExpandArrowSheet.png", 1, 0.35)
    imageColumn.ColumnImage.ImageRectSize = Vector2.new(21, 21)
    imageColumn.ColumnImage.ImageRectOffset = Vector2.new(0, 0)

    local textColumn = createTextColumn(buttonRow, "InputType", tostring(arg1))
    textColumn.Size = UDim2.new(1, -35, 1, 0)
    textColumn.ColumnText.Font = Enum.Font.SourceSansBold

    local emptyRow = createEmptyRow("TableHeader", 20)
    emptyRow.Visible = false
    local _, var1, var2, var3, var4 = createActionColumns(emptyRow, black)
    var1.ColumnText.Font = Enum.Font.SourceSansBold
    var2.ColumnText.Font = Enum.Font.SourceSansBold
    var3.ColumnText.Font = Enum.Font.SourceSansBold
    var4.ColumnText.Font = Enum.Font.SourceSansBold

    tbl1[arg1] = buttonRow
    tbl2[buttonRow] = arg1
    tbl6[emptyRow] = arg1
    tbl7[arg1] = emptyRow

    emptyRow.Parent = instance
    buttonRow.Parent = instance

    TweenService:Create(textColumn, tweenInfo, { BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) }):Play()

    tbl8[arg1] = false
    buttonRow.MouseButton1Click:connect(function()
        tbl8[arg1] = not tbl8[arg1]

        local var5 = tbl3[arg1]
        if not tbl8[arg1] then
            imageColumn.ColumnImage.ImageRectOffset = Vector2.new(0, 0)
            emptyRow.Visible = false
            if var5 then
                for _, value in pairs(var5) do
                    value.Visible = false
                end
            end
        else
            imageColumn.ColumnImage.ImageRectOffset = Vector2.new(21, 0)
            emptyRow.Visible = true
            if var5 then
                for _, value in pairs(var5) do
                    value.Visible = true
                end
            end
        end

        updateContainerCanvas()
        if tbl8[arg1] then
            TweenService:Create(textColumn, tweenInfo, { BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) }):Play()
            scrollContainerToRow(buttonRow)
        end
    end)
end

function module.updateActionRowForInputType(text, arg1, arg2)
    local tbl9 = tbl3[arg2]
    if not tbl9 then
        tbl9 = {}
        tbl3[arg2] = tbl9
    end

    if tbl9[text] then
        return
    end

    local emptyRow = createEmptyRow("BoundAction", 20)
    emptyRow.Visible = tbl8[arg2]

    local tbl10 = ({})
    for k, value in pairs(arg1.inputTypes) do
        tbl10[k] = tostring(value)
    end

    local _, var1, var2, instance2, var3 = createActionColumns(emptyRow, arg1.isCore and reallyBlack or black)
    var1.ColumnText.Text = arg1.priorityLevel or "Default"
    var2.ColumnText.Text = if arg1.isCore then "Core" else "Developer"
    instance2.ColumnText.Text = text
    var3.ColumnText.Text = table.concat(tbl10, ", ")

    if arg1.isCore then
        var1.ColumnText.Font = Enum.Font.SourceSansItalic
        var2.ColumnText.Font = Enum.Font.SourceSansItalic
        instance2.ColumnText.Font = Enum.Font.SourceSansItalic
        var3.ColumnText.Font = Enum.Font.SourceSansItalic
    end

    tbl9[text] = emptyRow
    tbl5[emptyRow] = arg2
    tbl4[emptyRow] = arg1
    emptyRow.Parent = instance

    if emptyRow.Visible then
        TweenService:Create(instance2, tweenInfo, { BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) }):Play()
        return
    end
    local var4 = tbl1[arg2]
    if var4 then
        TweenService:Create(var4.InputType, tweenInfo, { BackgroundColor3 = Color3.new(0.5, 0.5, 0.5) }):Play()
    end
end

function module.updateActionRows(text, arg1)
    for _, value in pairs(arg1.inputTypes) do
        module.updateBoundInputTypeRow(value)
        module.updateActionRowForInputType(text, arg1, value)
    end
end

function module.removeActionRows(actionRemoved, functionInfoTable)
    for _, value in pairs(functionInfoTable.inputTypes) do
        local var1 = tbl3[value]
        if not var1 then
            continue
        end

        var1[actionRemoved]:Destroy()
        var1[actionRemoved] = nil
        local bool2 = false

        for k, value2 in pairs(var1) do
            local _, _ = k, value2
            bool2 = true
            break
        end

        if bool2 then
            continue
        end

        local var2 = tbl1[value]
        if var2 then
            var2:Destroy()
            tbl1[value] = nil
        end
        local var3 = tbl7[value]
        if var3 then
            tbl7[var3] = nil
            var3:Destroy()
            tbl7[value] = nil
        end
    end

    updateContainerCanvas()
    instance.UIListLayout:ApplyLayout()
end

function module.updateGuis()
    local allBoundCoreActionInfo = ContextActionService:GetAllBoundCoreActionInfo()
    for k, value in pairs(allBoundCoreActionInfo) do
        value.isCore = true
        module.updateActionRows(k, value)
    end
    local allBoundActionInfo = ContextActionService:GetAllBoundActionInfo()
    for k, value in pairs(allBoundActionInfo) do
        value.isCore = false
        module.updateActionRows(k, value)
    end

    bool1 = true
    updateContainerCanvas()
end

return module
