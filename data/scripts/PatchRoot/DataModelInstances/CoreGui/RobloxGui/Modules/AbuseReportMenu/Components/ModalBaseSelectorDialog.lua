-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")

local useTokens = require(CorePackages.Packages.Foundation).Hooks.useTokens
local UIBlox = require(CorePackages.Packages.UIBlox)
local React = require(CorePackages.Packages.React)
local ScrollingListTable = UIBlox.App.Table.ScrollingListTable
local CellHeadDetail = UIBlox.App.Table.CellHeadDetail
local Cell = UIBlox.App.Table.Cell
local CellTailDescription = UIBlox.App.Table.CellTailDescription
local ModalWindow = UIBlox.App.Dialog.Modal.ModalWindow
local Dash = require(CorePackages.Packages.Dash)
local Cryo = require(CorePackages.Packages.Cryo)
local useStyle = UIBlox.Core.Style.useStyle
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local Images = UIBlox.App.ImageSet.Images

local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(CorePackages.Workspace.Packages.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local GetFFlagModalSelectorCloseButton = require(AbuseReportMenu.Flags.GetFFlagModalSelectorCloseButton)
local GetFFlagLuaAppEnableOpenTypeSupport = SharedFlags.GetFFlagLuaAppEnableOpenTypeSupport

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled

local Responsive = nil
local UIManager = nil
local PanelType = nil
if isInExperienceUIVREnabled then
    Responsive = require(CorePackages.Workspace.Packages.Responsive)
    local vrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
    UIManager = vrSpatialUi.UIManager
    PanelType = vrSpatialUi.Constants.PanelType
end

local function ModalBaseSelectorDialog(tbl1)
    local var1 = useTokens()
    local var2 = useStyle()
    local theme = var2.Theme

    local size1000 = var2.Tokens.Size.Size_1000
    local var3

    if isInExperienceUIVREnabled then
        local var4 = Responsive.useIsSpatial()
        local viewportHeight = tbl1.viewportHeight
        if var4 then
            viewportHeight = UIManager.getInstance():getPanelObject(PanelType.MoreMenu).AbsoluteSize.Y
        end
        var3 = math.min(#tbl1.cellData * var1.Size.Size_1000, viewportHeight - 80 - 24)
    else
        var3 = math.min(#tbl1.cellData * var1.Size.Size_1000, tbl1.viewportHeight - 80 - 24)
    end

    local yOffset = var3 + 24

    local tbl2 = {
        Paddings = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12)
        })
    }
    local yOffset2, offset

    if GetFFlagModalSelectorCloseButton() then
        yOffset = var3 + 48 + size1000

        tbl2 = Cryo.Dictionary.join(tbl2, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = 0
                }
            ),
            Header = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, size1000),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1
                },
                {
                    Layout = React.createElement(
                        "UIListLayout",
                        {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right
                        }
                    ),
                    CloseButton = React.createElement(IconButton, {
                        size = UDim2.fromOffset(0, 0),
                        iconSize = IconSize.Medium,
                        icon = Images["icons/navigation/close"],
                        onActivated = function()
                            tbl1.onClose()
                        end
                    })
                }
            ),
            Divider = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundTransparency = var2.Theme.Divider.Transparency,
                BackgroundColor3 = var2.Theme.Divider.Color,
                BorderSizePixel = 0,
                LayoutOrder = 2
            })
        })

        yOffset2 = -36
        offset = 12
    else
        yOffset2 = 0
        offset = 0
    end

    local var4 = Cryo.Dictionary.join(tbl2, {
        SelectorFrame = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, yOffset2),
                BackgroundTransparency = 1,
                LayoutOrder = 3
            },
            {
                Paddings = React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }),
                ModalSelector = React.createElement(ScrollingListTable, {
                    selectable = false,
                    size = UDim2.new(1, 0, 1, 0),
                    cells = Dash.map(tbl1.cellData, function(arg1)
                        local createElement = React.createElement
                        local var4 = Cell
                        local tbl3 = {
                            head = React.createElement(CellHeadDetail, {
                                labelText = arg1.label,
                                subLabelText = arg1.subLabel,
                                openTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
                            }),
                            tail = React.createElement(CellTailDescription, { text = "", showArrow = false }),
                            background = React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }),
                            size = UDim2.new(1, 0, 0, var1.Size.Size_1000),
                            userInteractionEnabled = true,
                            onActivated = 0
                        }
                        function tbl3.onActivated()
                            tbl1.onSelect(arg1.label, arg1.subLabel, arg1.identifier)
                            tbl1.onClose()
                        end

                        return createElement(var4, tbl3)
                    end)
                })
            }
        )
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0)
    }
    local tbl4 = { Overlay = 0 }
    local var5

    if tbl1.isShown then
        local createElement2 = React.createElement
        local tbl5 = {
            Selectable = false,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            BackgroundColor3 = theme.Overlay.Color,
            BackgroundTransparency = theme.Overlay.Transparency,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ZIndex = 10,
            Text = ""
        }

        tbl5[React.Event.Activated] = function()
            tbl1.onClose()
        end

        var5 = createElement2("TextButton", tbl5, {
            Modal = React.createElement(
                ModalWindow,
                {
                    isFullHeight = false,
                    screenSize = Vector2.new(tbl1.viewportWidth, tbl1.viewportHeight)
                },
                {
                    ModalContent = React.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, yOffset),
                        BackgroundTransparency = 0,
                        BackgroundColor3 = theme.BackgroundDefault.Color,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 20)
                    }, var4)
                }
            )
        })
    else
        var5 = nil
    end

    tbl4.Overlay = var5
    return createElement(str1, tbl3, tbl4)
end

function DialogWrapper(arg1)
    return React.createElement(CoreScriptsRootProvider, {}, {
        FocusNavigationCoreScriptsWrapper = React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            {
                DialogContainer = React.createElement(ModalBaseSelectorDialog, arg1)
            }
        )
    })
end
return DialogWrapper
