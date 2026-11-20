-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ContextActionService = game:GetService("ContextActionService")
local CorePackages = game:GetService("CorePackages")
local _GuiService = game:GetService("GuiService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)
local Cryo = require(CorePackages.Packages.Cryo)
local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local scriptParentParent = script.Parent.Parent
local Dependencies = require(scriptParentParent.Dependencies)
local _FocusHandler = require(Dependencies.FocusHandler)
local playerInterface = require(Dependencies.playerInterface)
local ThemedTextLabel = require(Dependencies.ThemedTextLabel)
local withLocalization = require(Dependencies.withLocalization)

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local withVoiceState = require(RobloxGui.Modules.VoiceChat.VoiceStateContext).withVoiceState
local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GameIcon = require(Dependencies.GameIcon)
local _BlockPlayerItem = require(scriptParentParent.Components.BlockPlayerItem)
local EndReportFlow = require(scriptParentParent.Actions.EndReportFlow)
local _OpenBlockPlayerDialog = require(scriptParentParent.Actions.OpenBlockPlayerDialog)
local SelectReportCategory = require(scriptParentParent.Actions.SelectReportCategory)
local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local SessionUtility = require(scriptParentParent.Utility.SessionUtility)

local Constants = require(scriptParentParent.Resources.Constants)
local ModalDialog = require(scriptParentParent.Components.ModalDialog)
local Assets = require(scriptParentParent.Resources.Assets)
local _GameCell = require(scriptParentParent.Components.GameCell)
local BarOnTopScrollingFrame = require(Dependencies.BarOnTopScrollingFrame)
local Cell = UIBlox.App.Table.Cell
local Provider = UIBlox.Core.Style.Provider
local withStyle = UIBlox.Core.Style.withStyle
local Colors = UIBlox.App.Style.Colors

local FFlagTopBarSignalizeScreenSize = require(CorePackages.Workspace.Packages.CoreGuiCommon).Flags.FFlagTopBarSignalizeScreenSize

local tbl1 = {
    BackgroundDefault = {
        Color = Colors.Flint,
        Transparency = 1
    },
    BackgroundOnHover = {
        Color = Colors.Graphite,
        Transparency = 0.666
    },
    BackgroundOnPress = {
        Color = Colors.Graphite,
        Transparency = 0
    }
}

local function Divider(arg1)
    return Roact.createElement(
        "Frame",
        Cryo.Dictionary.join(
            {
                Size = UDim2.new(1, 0, 0, 1)
            },
            arg1,
            {
                BorderSizePixel = 0,
                BackgroundColor3 = Colors.Graphite,
                BackgroundTransparency = 0.5,
                theme = Cryo.None
            }
        )
    )
end

local function CategoryCellContent(arg1)
    return Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 72),
            AutomaticSize = Enum.AutomaticSize.XY
        },
        {
            ListLayout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            IconFrame = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 68, 1, 0),
                    LayoutOrder = 1
                },
                {
                    Layout = Roact.createElement(
                        "UIListLayout",
                        {
                            HorizontalAlignment = Enum.HorizontalAlignment.Left,
                            VerticalAlignment = Enum.VerticalAlignment.Center
                        }
                    ),
                    CustomIcon = arg1.iconComponent or nil,
                    Icon = arg1.icon
                        and Roact.createElement(ImageSetLabel, { BackgroundTransparency = 1, Image = arg1.icon.Image, Size = arg1.icon.Size })
                }
            ),
            TextFrame = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -68, 1, 0),
                    LayoutOrder = 2
                },
                {
                    ListLayout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 2)
                    }),
                    Text = Roact.createElement(ThemedTextLabel, {
                        AnchorPoint = Vector2.new(0, 0.5),
                        themeKey = "TextEmphasis",
                        fontKey = "Header2",
                        Size = UDim2.new(1, 0, 0, 20),
                        Text = arg1.text,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    SubText = Roact.createElement(ThemedTextLabel, {
                        AnchorPoint = Vector2.new(0, 0.5),
                        fontKey = "CaptionBody",
                        themeKey = "TextMuted",
                        Size = UDim2.new(1, 0, 0, 14),
                        Text = arg1.subtext,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                }
            )
        }
    )
end

local function CategoryCell(arg1)
    return Roact.createElement(Cell, {
        userInteractionEnabled = true,
        onActivated = arg1.onActivated,
        layoutOrder = arg1.layoutOrder,
        size = UDim2.new(1, 0, 0, 72),
        head = CategoryCellContent(arg1),
        tail = Roact.createElement("Frame")
    })
end

local var1 = Roact.PureComponent:extend("ReportCategoryDialog")

var1.validateProps = t.strictInterface({
    isReportCategoryMenuOpen = t.boolean,
    screenSize = if FFlagTopBarSignalizeScreenSize then nil else t.Vector2,
    inputType = t.optional(t.string),
    reportType = t.optional(t.valueOf(Constants.ReportType)),
    targetPlayer = t.optional(playerInterface),
    closeDialog = t.callback,
    selectReportCategory = t.optional(t.callback),
    playerFocusedFlow = t.boolean
})

function var1.init(arg1)
    arg1.buttonRef = Roact.createRef()

    function arg1.onCancel()
        arg1.props.closeDialog()
    end

    if not FFlagTopBarSignalizeScreenSize then
        return
    end

    local getViewportSize = Display.GetDisplayStore(false).getViewportSize

    arg1.disposeScreenSize = Signals.createEffect(function(arg2)
        arg1:setState({ screenSize = getViewportSize(arg2) })
    end)
end

function var1.willUnmount(arg1)
    if FFlagTopBarSignalizeScreenSize then
        arg1.disposeScreenSize()
    end
end

function var1.renderContents(arg1, arg2, arg3)
    local _props = arg1.props
    local tbl2 = {
        ListLayout = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
    }

    if arg2 then
        local recentUsersInteractionData = default:getRecentUsersInteractionData()
        if not recentUsersInteractionData or Cryo.isEmpty(recentUsersInteractionData) then
            arg2 = false
        elseif arg1.props.playerFocusedFlow then
            arg2 = arg1.props.targetPlayer
            arg2 = arg2 and recentUsersInteractionData[tostring(arg1.props.targetPlayer.UserId)] ~= nil
        end
    end

    if arg2 then
        table.insert(
            tbl2,
            Roact.createElement(CategoryCell, {
                text = arg3.voiceHeader,
                subtext = arg3.voiceDescription,
                icon = Assets.Images.VoiceChatIcon,
                layoutOrder = #tbl2 + 1,
                onActivated = function()
                    arg1.props.selectReportCategory(Constants.Category.Voice)
                end
            })
        )
        table.insert(tbl2, Roact.createElement(Divider, { LayoutOrder = #tbl2 + 1 }))
    end

    table.insert(
        tbl2,
        Roact.createElement(CategoryCell, {
            text = arg3.textHeader,
            subtext = arg3.textDescription,
            icon = Assets.Images.TextChatIcon,
            layoutOrder = #tbl2 + 1,
            onActivated = function()
                arg1.props.selectReportCategory(Constants.Category.Text)
            end
        })
    )
    table.insert(tbl2, Roact.createElement(Divider, { LayoutOrder = #tbl2 + 1 }))

    if not arg1.props.playerFocusedFlow then
        table.insert(
            tbl2,
            Roact.createElement(CategoryCell, {
                iconComponent = Roact.createElement(GameIcon, { gameId = game.GameId, iconSize = 33, cornerRadius = UDim.new(0, 8) }),
                text = arg3.experienceHeader,
                subtext = arg3.experienceDescription,
                layoutOrder = #tbl2 + 1,
                onActivated = function()
                    arg1.props.selectReportCategory(Constants.Category.Experience)
                end
            })
        )
        table.insert(tbl2, Roact.createElement(Divider, { LayoutOrder = #tbl2 + 1 }))
    end

    table.insert(
        tbl2,
        Roact.createElement(CategoryCell, {
            text = arg3.otherHeader,
            subtext = arg3.otherDescription,
            icon = Assets.Images.OtherIcon,
            layoutOrder = #tbl2 + 1,
            onActivated = function()
                arg1.props.selectReportCategory(Constants.Category.Other)
            end
        })
    )
    table.insert(tbl2, Roact.createElement(Divider, { LayoutOrder = #tbl2 + 1 }))

    return withStyle(function(arg4)
        local theme = Cryo.Dictionary.join(arg4.Theme, tbl1)
        local style = Cryo.Dictionary.join(arg4, { Theme = theme })

        return Roact.createElement(Provider, { style = style }, { Roact.createElement(
                BarOnTopScrollingFrame,
                {
                    Size = UDim2.fromScale(1, 1),
                    CanvasSize = UDim2.new(1, 0, 0, 72),
                    scrollingFrameRef = arg1.scrollingFrameRef
                },
                tbl2
            ) })
    end)
end

function var1.render(arg1)
    return withVoiceState(function(arg2)
        return withLocalization({
            titleText = "CoreScripts.InGameMenu.Report.MenuTitle",
            dismissText = "CoreScripts.InGameMenu.Report.Done",
            voiceHeader = "CoreScripts.InGameMenu.Report.Category.Header.Voice",
            voiceDescription = "CoreScripts.InGameMenu.Report.Category.Description.Voice",
            textHeader = "CoreScripts.InGameMenu.Report.Category.Header.Text",
            textDescription = "CoreScripts.InGameMenu.Report.Category.Description.Text",
            experienceHeader = "CoreScripts.InGameMenu.Report.Category.Header.Experience",
            experienceDescription = "CoreScripts.InGameMenu.Report.Category.Description.Experience",
            otherHeader = "CoreScripts.InGameMenu.Report.Category.Header.Other",
            otherDescription = "CoreScripts.InGameMenu.Report.Category.Description.Other"
        })(
            function(arg3)
                local createFragment = Roact.createFragment
                local tbl2 = {
                    ModalDialog = Roact.createElement(ModalDialog, {
                        visible = arg1.props.isReportCategoryMenuOpen,
                        screenSize = if FFlagTopBarSignalizeScreenSize then arg1.state.screenSize else arg1.props.screenSize,
                        titleText = arg3.titleText,
                        contents = arg1:renderContents(arg2.voiceEnabled, arg3),
                        showCloseButton = true,
                        onDismiss = arg1.onCancel
                    })
                }
                return createFragment(tbl2)
            end
        )
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isReportCategoryMenuOpen = arg1.report.currentPage == Constants.Page.Category,
        reportType = arg1.report.reportType,
        targetPlayer = arg1.report.targetPlayer,
        screenSize = if FFlagTopBarSignalizeScreenSize then nil else arg1.displayOptions.screenSize,
        playerFocusedFlow = arg1.report.beginningReportType == Constants.ReportType.Player
    }
end, function(callback)
    return {
        selectReportCategory = function(arg1)
            callback(SelectReportCategory(arg1))
        end,
        closeDialog = function()
            callback(EndReportFlow())
            SendAnalytics(
                Constants.Analytics.ReportType,
                Constants.Analytics.ReportFlowAbandoned,
                {
                    source = Constants.Analytics.ReportType
                }
            )
            SessionUtility.endAbuseReportSession()
        end
    }
end)(var1)
