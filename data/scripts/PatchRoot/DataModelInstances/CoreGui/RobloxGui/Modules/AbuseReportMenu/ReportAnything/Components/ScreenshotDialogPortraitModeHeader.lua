-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local React = require(CorePackages.Packages.React)

local HeaderBar = UIBlox.App.Bar.HeaderBar
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local withStyle = UIBlox.Style.withStyle

local function renderHeaderBarLeft(onActivated, _, _) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 30, 1, 0)
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            BackButton = React.createElement(
                IconButton,
                {
                    iconSize = IconSize.Medium,
                    icon = Images["icons/navigation/pushBack"],
                    layoutOrder = 1,
                    onActivated = onActivated
                }
            )
        })
    end
end

local function renderCenter(text) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return withStyle(function(arg1)
            local currentCamera = game.Workspace.CurrentCamera

            local xOffset = if currentCamera == nil then 300 else currentCamera.ViewportSize.X - 150

            local theme = arg1.Theme

            return React.createElement("TextLabel", {
                Text = text,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.TitleLarge.Font),
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                TextSize = 20,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                Size = UDim2.new(0, xOffset, 1, 0),
                BackgroundTransparency = 1
            })
        end)
    end
end

local function renderHeaderBarRight(_, onActivated, onActivated2, isUndoEnabled, isRedoEnabled) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        return React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 60, 1, 0)
        }, {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            UndoButton = React.createElement(IconButton, {
                iconSize = IconSize.Medium,
                icon = Images["icons/actions/edit/undo"],
                isDisabled = not isUndoEnabled,
                layoutOrder = 1,
                onActivated = onActivated
            }),
            RedoButton = React.createElement(IconButton, {
                iconSize = IconSize.Medium,
                icon = Images["icons/actions/edit/redo"],
                isDisabled = not isRedoEnabled,
                layoutOrder = 2,
                onActivated = onActivated2
            })
        })
    end
end

local function ScreenshotDialogPortraitModeHeader(tbl1)
    local var1 = tbl1.isRedoEnabled or tbl1.isUndoEnabled

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromHex("#4F545F"),
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 48),
        ZIndex = 2
    }
    local tbl3 = { Bar = 0 }
    local createElement2 = React.createElement
    local var2 = HeaderBar
    local tbl4 = {
        backgroundTransparency = 1,
        barHeight = 48,
        margin = 12,
        renderLeft = 0,
        renderRight = 0,
        renderCenter = 0,
        isSecondary = true
    }

    local backAction = tbl1.backAction
    local _isRedoEnabled = tbl1.isRedoEnabled
    local _isUndoEnabled = tbl1.isUndoEnabled
    tbl4.renderLeft = renderHeaderBarLeft(backAction, nil, nil)
    local var3

    if var1 then
        local _annotationPoints = tbl1.annotationPoints
        var3 = renderHeaderBarRight(nil, tbl1.undoAnnotationPoints, tbl1.redoAnnotationPoints, tbl1.isUndoEnabled, tbl1.isRedoEnabled)
    else
        var3 = function() end
    end

    tbl4.renderRight = var3

    tbl4.renderCenter = renderCenter(tbl1.titleText)
    tbl3.Bar = createElement2(var2, tbl4)
    return createElement(str1, tbl2, tbl3)
end

return ScreenshotDialogPortraitModeHeader
