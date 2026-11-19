-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t
local Cryo = InGameMenuDependencies.Cryo

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParentParent = script.Parent.Parent.Parent
local Flags = scriptParentParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)
local FFlagIGMDialogButtonsUseUIBloxButton = require(Flags.FFlagIGMDialogButtonsUseUIBloxButton)

local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)

local Assets = require(scriptParentParentParent.Resources.Assets)
local CloseReportDialog = require(scriptParentParentParent.Actions.CloseReportDialog)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local TextEntryField = require(script.Parent.TextEntryField)
local DropDownSelection = require(scriptParentParentParent.Components.DropDownSelection)
local Constants = require(scriptParentParentParent.Resources.Constants)
local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)

local SendReport = require(scriptParentParentParent.Thunks.SendReport)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local var1 = Roact.PureComponent:extend("ReportDialog")

local tbl1 = {
    "Swearing",
    "Inappropriate Username",
    "Bullying",
    "Scamming",
    "Dating",
    "Cheating/Exploiting",
    "Personal Question",
    "Offsite Links"
}

local selections = {
    "CoreScripts.InGameMenu.Report.AbuseSwearing",
    "CoreScripts.InGameMenu.Report.AbuseUsername",
    "CoreScripts.InGameMenu.Report.AbuseBullying",
    "CoreScripts.InGameMenu.Report.AbuseScamming",
    "CoreScripts.InGameMenu.Report.AbuseDating",
    "CoreScripts.InGameMenu.Report.AbuseExploiting",
    "CoreScripts.InGameMenu.Report.AbusePersonalQuestion",
    "CoreScripts.InGameMenu.Report.AbuseOffsiteLink"
}

var1.validateProps = t.strictInterface({
    isOpen = t.boolean,
    userId = t.optional(t.integer),
    userName = t.optional(t.string),
    placeName = t.string,
    dispatchCloseReportDialog = t.callback,
    dispatchSendReport = t.callback,
    canCaptureFocus = t.optional(t.boolean),
    isGamepadLastInput = t.optional(t.boolean)
})

function var1.init(arg1)
    arg1.state = { abuseDescription = "", typeOfAbuseIndex = 0 }

    arg1.selectionGroupRef = Roact.createRef()
    arg1.reportTextEntryRef = Roact.createRef()
    arg1.reportDropDownRef = Roact.createRef()
end

function var1.renderReportTitle(_, arg1, arg2, text)
    arg2.Title = Roact.createElement(
        ThemedTextLabel,
        {
            fontKey = "Header1",
            themeKey = "TextEmphasis",
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 48),
            Text = text
        }
    )
    arg2.Divider = Roact.createElement("Frame", {
        BackgroundColor3 = arg1.Theme.Divider.Color,
        BackgroundTransparency = arg1.Theme.Divider.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = 2,
        Size = UDim2.new(0.8, 0, 0, 1)
    })
end

function var1.renderTextEntryField(arg1, arg2, arg3, size)
    arg3.ReportDescription = Roact.createElement(TextEntryField, {
        enabled = arg1.props.isOpen,
        text = arg1.state.abuseDescription,
        textChanged = function(abuseDescription)
            arg1:setState({ abuseDescription = abuseDescription })
        end,
        maxTextLength = 160,
        autoFocusOnEnabled = not arg1.props.isGamepadLastInput,
        PlaceholderText = arg2.textboxPlaceHolder,
        LayoutOrder = 5,
        Size = size,
        [Roact.Ref] = arg1.reportTextEntryRef
    })
end

function var1.renderButtons(arg1, _, arg2, arg3)
    local var2 = utf8.len(utf8.nfcnormalize(arg1.state.abuseDescription))
    local bool1 = var2 >= 0 and var2 <= 160
    local bool2 = arg1.state.typeOfAbuseIndex > 0 or arg1.props.userId == nil

    local function onActivated()
        local var3 = if arg1.props.userId == nil then "Inappropriate Content" else tbl1[arg1.state.typeOfAbuseIndex]

        arg1.props.dispatchSendReport(var3, arg1.state.abuseDescription, arg1.props.userId)
        arg1.props.dispatchCloseReportDialog()
    end

    arg3.ButtonContainer = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 6,
            Size = UDim2.new(1, 0, 0, 60)
        },
        {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 12),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Bottom
            }),
            CancelButton = Roact.createElement(Button, {
                buttonType = ButtonType.Secondary,
                layoutOrder = 1,
                size = UDim2.fromOffset(144, 36),
                text = arg2.cancel,
                onActivated = arg1.props.dispatchCloseReportDialog,
                DO_NOT_USE_useUIBloxButton = if FFlagIGMDialogButtonsUseUIBloxButton then true else nil
            }),
            ConfirmButton = Roact.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                layoutOrder = 2,
                size = UDim2.fromOffset(144, 36),
                isDisabled = not (bool1 and bool2),
                text = arg2.report,
                onActivated = onActivated,
                DO_NOT_USE_useUIBloxButton = if FFlagIGMDialogButtonsUseUIBloxButton then true else nil
            })
        }
    )
end

function var1.renderReportPlayer(arg1, arg2, arg3, arg4)
    arg1:renderReportTitle(arg2, arg4, arg3.reportPlayerTitle)

    local tbl3 = {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0.5, -140, 0.5, 0),
        Size = UDim2.new(0, 44, 0, 44)
    }

    local userId = arg1.props.userId

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, 68)
    }
    local tbl5 = { PlayerCutout = 0, PlayerIcon = 0, PlayerBackground = 0, PlayerName = 0 }
    local element

    if FFlagCoreUiMigrateUIBloxToFoundation then
        element = Roact.createElement(Image, {
            AnchorPoint = tbl3.AnchorPoint,
            Position = tbl3.Position,
            Size = tbl3.Size,
            Image = Assets.Images.CircleCutout,
            imageStyle = {
                Color3 = arg2.Theme.BackgroundUIDefault.Color,
                Transparency = 0
            },
            ZIndex = 2
        })
    else
        element = Roact.createElement(
            ImageSetLabel,
            Cryo.Dictionary.join(tbl3, {
                BackgroundTransparency = 1,
                Image = Assets.Images.CircleCutout,
                ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
                ZIndex = 2
            })
        )
    end

    tbl5.PlayerCutout = element
    local element2

    if FFlagCoreUiMigrateUIBloxToFoundation then
        element2 = Roact.createElement(Image, {
            AnchorPoint = tbl3.AnchorPoint,
            Position = tbl3.Position,
            Size = tbl3.Size,
            Image = userId > 0 and "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=48&h=48" or ""
        })
    else
        element2 = Roact.createElement(
            ImageSetLabel,
            Cryo.Dictionary.join(tbl3, {
                BackgroundTransparency = 1,
                Image = userId > 0 and "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=48&h=48" or ""
            })
        )
    end

    tbl5.PlayerIcon = element2

    tbl5.PlayerBackground = Roact.createElement(
        "Frame",
        Cryo.Dictionary.join(
            tbl3,
            {
                BackgroundColor3 = arg2.Theme.UIDefault.Color,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                ZIndex = 0
            }
        )
    )

    tbl5.PlayerName = Roact.createElement(ThemedTextLabel, {
        fontKey = "Body",
        themeKey = "TextEmphasis",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0.5, -76, 0.5, 0),
        Size = UDim2.new(0.5, 76, 0, 44),
        Text = arg1.props.userName,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    arg4.ReportPlayerTextContainer = createElement(str1, tbl4, tbl5)

    arg4.AbuseTypeDropDown = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 4,
            Size = UDim2.new(1, 0, 0, 68)
        },
        {
            DropDown = Roact.createElement(DropDownSelection, {
                Size = UDim2.new(1, 0, 0, 44),
                placeHolderText = arg3.selectTypeOfAbuse,
                selections = selections,
                localize = true,
                selectedIndex = arg1.state.typeOfAbuseIndex,
                enabled = true,
                selectionParentName = "abuseTypeDropDown",
                canOpen = arg1.props.canCaptureFocus,
                canCaptureFocus = arg1.props.isGamepadLastInput,
                selectionChanged = function(typeOfAbuseIndex)
                    arg1:setState({ typeOfAbuseIndex = typeOfAbuseIndex })
                end,
                ButtonRef = arg1.reportDropDownRef
            })
        }
    )
    arg1:renderTextEntryField(arg3, arg4, UDim2.new(1, 0, 0, 180))
    arg1:renderButtons(arg2, arg3, arg4)
end

function var1.renderReportGame(arg1, arg2, arg3, arg4)
    arg1:renderReportTitle(arg2, arg4, "Report " .. arg1.props.placeName)

    local placeholderGameIcon = Assets.Images.PlaceholderGameIcon
    if game.GameId > 0 then
        placeholderGameIcon = "rbxthumb://type=GameIcon&id=" .. game.GameId .. "&w=150&h=150"
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, 126)
    }
    local tbl4 = { GameIcon = 0, GameName = 0 }
    local element

    if FFlagCoreUiMigrateUIBloxToFoundation then
        element = Roact.createElement(Image, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 17, 0.5, 0),
            Size = UDim2.new(0, 64, 0, 64),
            Image = placeholderGameIcon
        })
    else
        element = Roact.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 17, 0.5, 0),
            Size = UDim2.new(0, 64, 0, 64),
            BackgroundTransparency = 1,
            Image = placeholderGameIcon
        })
    end

    tbl4.GameIcon = element

    tbl4.GameName = Roact.createElement(ThemedTextLabel, {
        fontKey = "Body",
        themeKey = "TextEmphasis",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 104, 0.5, 0),
        Size = UDim2.new(1, -104, 0, 44),
        Text = arg3.flagingGame,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    arg4.ReportGameTextContainer = createElement(str1, tbl3, tbl4)

    arg1:renderTextEntryField(arg3, arg4, UDim2.new(1, 0, 0, 191))
    arg1:renderButtons(arg2, arg3, arg4)
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                Overlay = {
                    Color = arg2.Color.Common.Scrim.Color3,
                    Transparency = arg2.Color.Common.Scrim.Transparency
                },
                BackgroundUIDefault = {
                    Color = arg2.Color.Surface.Surface_300.Color3,
                    Transparency = arg2.Color.Surface.Surface_300.Transparency
                },
                UIDefault = {
                    Color = arg2.Color.Shift.Shift_200.Color3,
                    Transparency = arg2.Color.Shift.Shift_200.Transparency
                },
                Divider = {
                    Color = arg2.Color.Stroke.Emphasis.Color3,
                    Transparency = arg2.Color.Stroke.Emphasis.Transparency
                }
            }
        }
    end, function(arg2)
        return withLocalization({
            flagingGame = {
                "CoreScripts.InGameMenu.Report.FlagingGame",
                RBX_NAME = arg1.props.placeName
            },
            reportGameTitle = {
                "CoreScripts.InGameMenu.Report.ReportGameTitle",
                RBX_NAME = arg1.props.placeName
            },
            reportPlayerTitle = "CoreScripts.InGameMenu.Report.ReportPlayerTitle",
            selectTypeOfAbuse = "CoreScripts.InGameMenu.Report.SelectAbuseType",
            cancel = "CoreScripts.InGameMenu.Cancel",
            report = "CoreScripts.InGameMenu.Report.SendReport",
            textboxPlaceHolder = "CoreScripts.InGameMenu.Report.AdditionalDetails"
        })(
            function(arg3)
                local tbl3 = {
                    Padding = Roact.createElement(
                        "UIPadding",
                        {
                            PaddingBottom = UDim.new(0, 24),
                            PaddingLeft = UDim.new(0, 24),
                            PaddingRight = UDim.new(0, 24)
                        }
                    ),
                    Layout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                }
                if arg1.props.userId == nil then
                    arg1:renderReportGame(arg2, arg3, tbl3)
                else
                    arg1:renderReportPlayer(arg2, arg3, tbl3)
                end

                local createElement = Roact.createElement
                local str1 = "Frame"
                local tbl4 = {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 8,
                    Visible = arg1.props.isOpen,
                    [Roact.Ref] = arg1.selectionGroupRef
                }
                local tbl5 = {
                    Overlay = Roact.createElement("TextButton", {
                        AutoButtonColor = false,
                        BackgroundColor3 = arg2.Theme.Overlay.Color,
                        BackgroundTransparency = arg2.Theme.Overlay.Transparency,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        Text = "",
                        Selectable = false
                    }),
                    DialogMainFrame = 0,
                    FocusHandler = 0
                }
                local element

                if FFlagCoreUiMigrateUIBloxToFoundation then
                    element = Roact.createElement(Image, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = Assets.Images.RoundedRectImageKey,
                        imageStyle = {
                            Color3 = arg2.Theme.BackgroundUIDefault.Color,
                            Transparency = arg2.Theme.BackgroundUIDefault.Transparency
                        },
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 600, 0, 450),
                        slice = {
                            center = Rect.new(8, 8, 9, 9)
                        }
                    }, tbl3)
                else
                    element = Roact.createElement(ImageSetLabel, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        Image = Assets.Images.RoundedRect.Image,
                        ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
                        ImageTransparency = arg2.Theme.BackgroundUIDefault.Transparency,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        ScaleType = Assets.Images.RoundedRect.ScaleType,
                        Size = UDim2.new(0, 600, 0, 450),
                        SliceCenter = Assets.Images.RoundedRect.SliceCenter
                    }, tbl3)
                end

                tbl5.DialogMainFrame = element

                tbl5.FocusHandler = if GetFFlagIGMGamepadSelectionHistory() then Roact.createElement(FocusHandler, {
                    isFocused = arg1.props.canCaptureFocus and arg1.props.isGamepadLastInput,
                    shouldForgetPreviousSelection = not arg1.props.isOpen,
                    didFocus = function(selectedCoreObject)
                        local value = if arg1.props.userId then arg1.reportDropDownRef:getValue() else arg1.reportTextEntryRef:getValue()
                        GuiService.SelectedCoreObject = selectedCoreObject or value
                    end
                })
                    or nil else nil

                return createElement(str1, tbl4, tbl5)
            end
        )
    end)
end

function var1.bindActions(arg1)
    ContextActionService:BindCoreAction("InGameMenuReportModalClose", function(_, userInputState, _) -- name: closeReportFunc
        if userInputState == Enum.UserInputState.Begin then
            arg1.props.dispatchCloseReportDialog()
        end
    end, false, Enum.KeyCode.Escape)
end

function var1.unbindActions(_)
    ContextActionService:UnbindCoreAction("InGameMenuReportModalClose")
end

function var1.didMount(arg1)
    GuiService:RemoveSelectionGroup("ReportDialogGroup")
    GuiService:AddSelectionParent("ReportDialogGroup", arg1.selectionGroupRef:getValue())

    if arg1.props.isOpen then
        arg1:bindActions()
    end
end

function var1.didUpdate(arg1, arg2)
    if arg2.isOpen and not arg1.props.isOpen then
        arg1:setState({ typeOfAbuseIndex = 0, abuseDescription = "" })
    end

    if not (GetFFlagIGMGamepadSelectionHistory() or arg2.canCaptureFocus and arg2.isGamepadLastInput)
        and arg1.props.canCaptureFocus
        and arg1.props.isGamepadLastInput
    then
        GuiService.SelectedCoreObject = if arg1.props.userId then arg1.reportDropDownRef:getValue() else arg1.reportTextEntryRef:getValue()
    end

    if arg1.props.isOpen then
        arg1:bindActions()
        return
    end
    arg1:unbindActions()
end

function var1.willUnmount(arg1)
    arg1:unbindActions()
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isOpen = arg1.report.dialogOpen,
        userId = arg1.report.userId,
        userName = arg1.report.userName,
        placeName = arg1.gameInfo.name,
        canCaptureFocus = arg1.report.dialogOpen and not arg1.respawn.dialogOpen,
        isGamepadLastInput = arg1.displayOptions.inputType == Constants.InputType.Gamepad
    }
end, function(callback)
    return {
        dispatchCloseReportDialog = function()
            callback(CloseReportDialog())
        end,
        dispatchSendReport = function(arg1, arg2, arg3)
            callback(SendReport(arg1, arg2, arg3))

            local tbl3 = {}
            if arg1 == "Inappropriate Content" then
                table.insert(tbl3, "report_type=game")
                table.insert(tbl3, "reported_entity_id=" .. tostring(game.GameId))
            else
                table.insert(tbl3, "report_type=user")
                table.insert(tbl3, "reported_entity_id=" .. tostring(arg3))
            end

            table.insert(tbl3, "report_source=ingame")
            local str1 = table.concat(tbl3, "&")

            SendAnalytics(Constants.AnalyticsReportSubmittedName, str1, {})
        end
    }
end)(var1)
