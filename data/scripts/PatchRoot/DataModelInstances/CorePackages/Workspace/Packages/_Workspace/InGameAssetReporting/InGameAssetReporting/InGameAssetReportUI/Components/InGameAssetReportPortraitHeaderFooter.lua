-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local normalizeFontFace = require(InGameAssetReportingParent.Foundation).Utility.normalizeFontFace

local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
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

local function renderHeaderBarCenter(text) -- Luacid: Inlined by compiler; 1 call site recovered
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

return {
    PortraitModeHeader = function(tbl1)
        local var1 = tbl1.isRedoEnabled or tbl1.isUndoEnabled

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl2 = {
            BorderSizePixel = 0,
            BackgroundTransparency = 0.1,
            BackgroundColor3 = Color3.fromHex("#000000"),
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 72),
            ZIndex = 2
        }
        local tbl3 = { Bar = 0 }
        local createElement2 = React.createElement
        local var2 = HeaderBar
        local tbl4 = {
            backgroundTransparency = 1,
            barHeight = 72,
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

        tbl4.renderCenter = renderHeaderBarCenter(tbl1.titleText)
        tbl3.Bar = createElement2(var2, tbl4)
        return createElement(str1, tbl2, tbl3)
    end,
    PortraitModeFooter = function(tbl1)
        return React.createElement("Frame", {
            BorderSizePixel = 0,
            BackgroundTransparency = 0.1,
            Size = UDim2.new(1, 0, 0, 60),
            BackgroundColor3 = Color3.fromHex("#000000"),
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            LayoutOrder = 4
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }
            ),
            Container = React.createElement("Frame", {
                Size = UDim2.new(0, 400, 1, 0),
                BackgroundTransparency = 1
            }, {
                Padding = React.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, 12),
                    PaddingBottom = UDim.new(0, 12),
                    PaddingLeft = UDim.new(0, 32),
                    PaddingRight = UDim.new(0, 32)
                }),
                ActionButtons = React.createElement(ButtonStack, {
                    marginBetween = 8,
                    buttons = {{
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = tbl1.nextAction,
                            text = tbl1.nextText
                        }
                    }}
                })
            })
        })
    end
}
