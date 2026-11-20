-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStartupParent = script:FindFirstAncestor("AppStartup").Parent
local Dash = require(AppStartupParent.Dash)
local React = require(AppStartupParent.React)
local UIBlox = require(AppStartupParent.UIBlox)
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local LinkButton = UIBlox.App.Button.LinkButton

local engineFeature = game:GetEngineFeature("StartupMessageActionButtonEnabled")

local function StartupMessage(tbl1)
    local localizedStrings = tbl1.localizedStrings
    local message = tbl1.message
    local overlayColor = tbl1.overlayColor
    local onDismissed = tbl1.onDismissed
    local onActionButtonActivated = tbl1.onActionButtonActivated
    local screenSize = tbl1.screenSize
    local actionButtonText = if engineFeature then localizedStrings.actionButtonText else nil
    local var1

    if engineFeature then
        local buttons = {}
        if actionButtonText then
            table.insert(buttons, {
                buttonType = ButtonType.PrimaryContextual,
                props = { onActivated = onActionButtonActivated, text = actionButtonText }
            })
        end

        if not message.isBlocking then
            table.insert(buttons, {
                buttonType = if actionButtonText then ButtonType.Secondary else ButtonType.PrimarySystem,
                props = {
                    onActivated = onDismissed,
                    text = localizedStrings.buttonText
                }
            })
        end

        var1 = #buttons > 0 and { buttons = buttons } or nil
    else
        var1 = nil
    end

    local var2 = Dash.map(tbl1.localizedLinks, function(arg1)
        return React.createElement(LinkButton, {
            text = arg1.label,
            onActivated = function()
                tbl1.onOpenUrl(arg1.url, arg1.label)
            end
        })
    end)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = if message.isBlocking then 0 else overlayColor.Transparency,
        BackgroundColor3 = overlayColor.Color3,
        Active = true,
        ref = tbl1.focusNavRef,
        SelectionGroup = true,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
        SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    }
    local tbl3 = { InteractiveAlert = 0 }
    local createElement2 = React.createElement
    local var3 = InteractiveAlert

    local tbl4 = {
        screenSize = screenSize,
        title = localizedStrings.titleText or "",
        bodyText = localizedStrings.bodyText or "",
        titleIcon = Images["icons/status/error_large"],
        middleContent = function()
            return React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1
                },
                Dash.append({
                    UIListLayout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    })
                }, var2)
            )
        end,
        buttonStackInfo = 0
    }

    if not engineFeature then
        var1 = not message.isBlocking
            and {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onDismissed,
                        text = localizedStrings.buttonText
                    }
                }}
            }
            or nil
    end

    tbl4.buttonStackInfo = var1
    tbl3.InteractiveAlert = createElement2(var3, tbl4)
    return createElement(str1, tbl2, tbl3)
end

return StartupMessage
