-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent
local UIBlox = require(ChatLineReportingParent.UIBlox)
local Otter = require(ChatLineReportingParent.Otter)
local useLocalization = require(ChatLineReportingParent.Localization).Hooks.useLocalization
local CurrentCamera = game.Workspace.CurrentCamera
local Constants = require(ChatLineReporting.Common.Constants)
local React = require(ChatLineReportingParent.React)

local Images = UIBlox.App.ImageSet.Images
local ContextualMenu = UIBlox.App.Menu.ContextualMenu
local MenuDirection = UIBlox.App.Menu.MenuDirection

local ChatLineReportRoot = require(ChatLineReporting.Components.ChatLineReportRoot)
local GetFFlagMemoizeChatReportingMenu = require(ChatLineReportingParent.SharedFlags).GetFFlagMemoizeChatReportingMenu

local motorOverrideOptions = {
    motorCallback = Otter.instant,
    open = { targetValue = 1 },
    close = { targetValue = 0 }
}

local tbl2 = { reportAbuse = "Feature.ReportAbuse.Action.EnterChatLineReporting" }

return function(arg1)
    local var1 = useLocalization(tbl2)
    local vector2 = if CurrentCamera then CurrentCamera.ViewportSize else Vector2.new(Constants.ViewportSize, Constants.ViewportSize)
    local ref = React.useRef(nil)

    React.useEffect(function()
        if ref.current and ref.current.AbsolutePosition.X + ref.current.AbsoluteSize.X > vector2.X then
            ref.current.AnchorPoint = Vector2.new(1, 0)
            ref.current.Position = UDim2.new(1, Constants.FramePositionXOffsetLeft, 0, Constants.FramePositionYOffset)
        end
    end, { ref, vector2 })

    local function onDismiss() -- Luacid: Inlined by compiler; 1 call site recovered
        arg1.setContextMenuOpen(false)
    end

    return React.createElement("Frame", {
        Size = UDim2.new(Constants.FrameSizeXScale, Constants.FrameSizeXOffset, 1, 0),
        Position = UDim2.new(1, Constants.FramePositionXOffset, 0, Constants.FramePositionYOffset),
        BackgroundTransparency = 1,
        ref = ref
    }, {
        ContextualMenu = React.createElement(ContextualMenu, {
            buttonProps = {{
                icon = Images["icons/actions/feedback"],
                text = var1.reportAbuse,
                onActivated = function()
                    if GuiService.MenuIsOpen then
                        local connection = nil
                        connection = GuiService.MenuClosed:Connect(function()
                            ChatLineReportRoot.initialize(if GetFFlagMemoizeChatReportingMenu() then arg1.getMessages() else arg1.messages)

                            connection:Disconnect()
                        end)
                    else
                        ChatLineReportRoot.initialize(if GetFFlagMemoizeChatReportingMenu() then arg1.getMessages() else arg1.messages)
                    end

                    onDismiss()
                end
            }},
            elementHeight = Constants.TopBannerSize,
            closeBackgroundVisible = false,
            open = true,
            menuDirection = MenuDirection.Down,
            horizontalAlignment = Enum.HorizontalAlignment.Left,
            openPositionX = UDim.new(0, 0),
            openPositionY = UDim.new(0, 0),
            borderCornerRadius = Constants.ContextualMenuBorderRadius,
            motorOverrideOptions = motorOverrideOptions,
            background = {
                Transparency = arg1.backgroundTransparency,
                Color = arg1.backgroundColor3
            },
            screenSize = vector2,
            onDismiss = onDismiss
        })
    })
end
