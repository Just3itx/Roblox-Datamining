-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local _SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Utility = require(RobloxGui.Modules.Settings.Utility)

local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useStyle = UIBlox.Core.Style.useStyle

local FIntVoiceChatTooltipDelay = require(RobloxGui.Modules.Flags.FIntVoiceChatTooltipDelay)
local Constants = require(RobloxGui.Modules.TopBar.Constants)
local TopBarHeight = Constants.TopBarHeight

local function VoiceChatTooltip(tbl1)
    local var1 = useStyle()
    local var2 = React.useRef(nil)
    local onClose = tbl1.onClose

    React.useEffect(function()
        if tbl1.showPrompt then
            var2.current = GuiService.MenuOpened:Connect(function()
                if var2.current then
                    var2.current:Disconnect()
                    var2.current = nil
                    onClose()
                end
            end)
            task.delay(FIntVoiceChatTooltipDelay, function()
                if var2.current then
                    var2.current:Disconnect()
                    var2.current = nil
                end
                if tbl1.showPrompt then
                    onClose()
                end
            end)
        end

        return function()
            if var2.current then
                var2.current:Disconnect()
                var2.current = nil
            end
        end
    end, { tbl1.showPrompt })

    if Utility:IsSmallTouchScreen() then
    end

    local xOffset = 64
    local yOffset = Constants.useDisplayScaleState(TopBarHeight)

    local tbl2 = {
        headerText = tbl1.titleText,
        minContentWidth = 240,
        renderCustomComponents = function(_)
            return Roact.createElement(StyledTextLabel, {
                text = tbl1.subtitleText,
                textTruncate = Enum.TextTruncate.None,
                textXAlignment = Enum.TextXAlignment.Left,
                fontStyle = var1.Font.CaptionSmall,
                colorStyle = var1.Theme.TextDefault,
                layoutOrder = 0,
                automaticSize = Enum.AutomaticSize.XY
            })
        end,
        onClose = onClose,
        backgroundColor = var1.Theme.BackgroundUIDefault.Color,
        backgroundTransparency = var1.Theme.BackgroundUIDefault.Transparency
    }

    local tbl3 = {
        guiTarget = CoreGui,
        active = tbl1.showPrompt,
        DisplayOrder = 10,
        preferredOrientation = TooltipOrientation.Bottom
    }

    return withTooltip(tbl2, tbl3, function(arg1)
        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, xOffset, 0, yOffset),
            [React.Change.AbsoluteSize] = arg1,
            [React.Change.AbsolutePosition] = arg1
        })
    end)
end

return VoiceChatTooltip
