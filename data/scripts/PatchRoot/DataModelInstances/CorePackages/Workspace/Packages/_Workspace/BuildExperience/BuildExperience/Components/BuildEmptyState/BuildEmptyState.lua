-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Players = game:GetService("Players")

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens

local function BuildEmptyState(tbl1)
    local localPlayer = Players.LocalPlayer
    local displayName = if localPlayer then localPlayer.DisplayName else ""
    local var1 = useLocalization({
        subline = LocalizationStrings.BUILD_SUBLINE,
        title = displayName ~= "" and {
            LocalizationStrings.BUILD_GREETING_WITH_NAME,
            DISPLAY_NAME = displayName
        }
            or LocalizationStrings.BUILD_GREETING
    })
    local var2 = useTokens()
    local size1400 = var2.Size.Size_1400

    local subline = var1.subline
    local var3 = tbl1.message or var1.title

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col align-x-center gap-small auto-xy",
        testId = tbl1.testId or "BuildEmptyState"
    }
    local tbl3 = {
        Nebula = React.createElement(
            Icon,
            {
                LayoutOrder = 1,
                name = IconName.Nebula,
                size = size1400,
                style = var2.Color.Content.Emphasis
            }
        ),
        Headings = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col align-x-center gap-xxsmall auto-xy"
        }, {
            Title = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    Text = var3,
                    tag = "auto-xy text-heading-small content-emphasis"
                }
            ),
            Subline = if tbl1.message == nil then React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = subline,
                    tag = "auto-xy text-body-medium content-default"
                }
            ) else nil
        })
    }
    return createElement(var4, tbl2, tbl3)
end

return BuildEmptyState
