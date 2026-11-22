-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local React = require(ServerTriggeredModalsParent.React)
local SduiFeatureEntryPoint = require(ServerTriggeredModalsParent.SduiSharedUtilities).SduiFeatureEntryPoint

local PromptStyle = require(script.Parent.SduiV2.PromptStyle)
local usePromptEntries = require(script.Parent.SduiV2.usePromptEntries)
local FFlagPromptsActionEventLogging = require(ServerTriggeredModals.Flags.FFlagPromptsActionEventLogging)

local function PromptsSystemBanner(tbl1)
    local var1 = usePromptEntries(tbl1.configKey, PromptStyle.SystemBanner)[1]

    if not var1 then
        return tbl1.contentSlot
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        SystemBanner = 0,
        ContentContainer = 0
    }
    local createElement2 = React.createElement
    local var2 = SduiFeatureEntryPoint
    local tbl4 = {
        configKey = tbl1.configKey,
        identifier = var1.identifier,
        appPage = tbl1.appPage,
        additionalAnalyticsData = if FFlagPromptsActionEventLogging then {
            promptInstanceId = if var1.identifier then var1.identifier else nil
        } else nil,
        shouldDisplayLoading = false,
        shouldDisplayError = false,
        LayoutOrder = 1
    }
    tbl3.SystemBanner = createElement2(var2, tbl4)

    tbl3.ContentContainer = React.createElement(
        "Frame",
        {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1
        },
        {
            UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
            Content = tbl1.contentSlot
        }
    )
    return createElement(str1, tbl2, tbl3)
end

return PromptsSystemBanner
