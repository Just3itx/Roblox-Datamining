-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local includeProfileFrame = game:DefineFastFlag("AbuseReportingUseProfileFrameThumbnail", false)
    and require(GenericAbuseReportingParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled()

local Avatar = Foundation.Avatar
local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View

local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local useExperienceDetails = require(GenericAbuseReporting.BeduiV2.Hooks.Enrichment.useExperienceDetails)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)

local function UserPreview(tbl1)
    local preview = tbl1.preview
    if not preview then
        return nil
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-medium radius-medium bg-surface-200",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        Avatar = not (preview.id == nil)
            and React.createElement(
                Avatar,
                {
                    userId = tonumber(preview.id),
                    includeProfileFrame = includeProfileFrame,
                    LayoutOrder = 1
                }
            ),
        TextContainer = (preview.displayName or preview.username)
            and React.createElement(View, { tag = "col fill auto-xy", LayoutOrder = 2 }, {
                DisplayName = preview.displayName
                    and React.createElement(FoundationText, {
                        Text = preview.displayName,
                        RichText = true,
                        tag = "auto-xy text-wrap text-align-x-left content-emphasis",
                        LayoutOrder = 1
                    }),
                Username = preview.username
                    and React.createElement(
                        FoundationText,
                        {
                            Text = "@" .. preview.username,
                            RichText = true,
                            tag = "auto-xy text-wrap text-align-x-left",
                            LayoutOrder = 2
                        }
                    )
            })
    }
    return createElement(var2, tbl2, tbl3)
end

local function ChatPreview(tbl1)
    local preview = tbl1.preview
    if not preview then
        return nil
    end

    return React.createElement(
        View,
        {
            tag = "gap-xsmall size-full-0 auto-y padding-medium radius-medium bg-surface-200",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            Message = React.createElement(TextWithTranslation, { input = preview.text, tag = "auto-xy text-wrap text-align-x-left" })
        }
    )
end

local function ExperiencePreview(tbl1)
    local preview = tbl1.preview
    local var2 = useExperienceDetails(preview.id)
    if not preview then
        return nil
    end

    return React.createElement(View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-medium radius-medium bg-surface-200",
        LayoutOrder = tbl1.layoutOrder
    }, {
        ExperienceIcon = React.createElement(Image, {
            Image = `rbxthumb://type=GameIcon&id={preview.id}&w=50&h=50`,
            Size = UDim2.fromOffset(40, 40),
            tag = "radius-medium"
        }),
        Name = React.createElement(
            FoundationText,
            {
                Text = var2 and var2.name or preview.title or "",
                RichText = true,
                tag = "auto-xy text-wrap text-align-x-left"
            }
        )
    })
end

return React.memo(function(tbl1) -- name: PreviewBox
    local preview = tbl1.preview

    if preview.type == "user" then
        return React.createElement(UserPreview, { preview = preview, layoutOrder = tbl1.layoutOrder })
    elseif preview.type == "chat" then
        return React.createElement(ChatPreview, { preview = preview, layoutOrder = tbl1.layoutOrder })
    elseif preview.type == "experience" then
        return React.createElement(ExperiencePreview, { preview = preview, layoutOrder = tbl1.layoutOrder })
    end

    return nil
end)
